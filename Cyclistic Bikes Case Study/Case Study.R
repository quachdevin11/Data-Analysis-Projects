### Processing Data into 1 clean data_set ------------------------------------------------------------------
# Install necessary packages for analysis
install.packages(tidyverse)   
install.packages(lubridate)
install.packages(ggplot2)
install.packages("gridExtra")

library(tidyverse)
library(lubridate)
library(ggplot2)
library(gridExtra)

# Changing directory to pull csv files into R
getwd()
setwd("C:/Users/Devin Quach/Documents/Data Analytics/Cyclistic Bikes Data/.csv/2022")
jan_2022 <- read_csv("2022_01-divvy-tripdata.csv")
feb_2022 <- read_csv("2022_02-divvy-tripdata.csv")
mar_2022 <- read_csv("2022_03-divvy-tripdata.csv")
apr_2022 <- read_csv("2022_04-divvy-tripdata.csv")
may_2022 <- read_csv("2022_05-divvy-tripdata.csv")
jun_2022 <- read_csv("2022_06-divvy-tripdata.csv")
jul_2022 <- read_csv("2022_07-divvy-tripdata.csv")
aug_2022 <- read_csv("2022_08-divvy-tripdata.csv")
sep_2022 <- read_csv("2022_09-divvy-publictripdata.csv")
oct_2022 <- read_csv("2022_10-divvy-tripdata.csv")
nov_2022 <- read_csv("2022_11-divvy-tripdata.csv")
dec_2022 <- read_csv("2022_12-divvy-tripdata.csv")

# Viewing and changing col names to ensure they match to combine
colnames(jan_2022)
colnames(dec_2022)

# viewing structure of tables to ensure same data types are used
str(jan_2022)
str(feb_2022)
str(dec_2022)

# Combine data into one big year table
year_2022 <- bind_rows(jan_2022,feb_2022,mar_2022,apr_2022,may_2022,jun_2022,jul_2022,aug_2022,sep_2022,oct_2022,nov_2022,dec_2022)

# Remove unused columns
year_2022 <- year_2022 %>% 
  select(-c(start_lat,start_lng,end_lat,end_lng))

# Add columns for date,month, day, year, ride_duration, and day_of_week  
year_2022 <- year_2022 %>% add_column(date = as.Date(year_2022$started_at),.after = "ended_at")
year_2022 <- year_2022 %>% add_column(year = format(year_2022$date, "%Y"), .after = "date")
year_2022 <- year_2022 %>% add_column(day = format(year_2022$date, "%d"), .after = "date")
year_2022 <- year_2022 %>% add_column(month = format(year_2022$date, "%m"), .after = "date")
year_2022 <- year_2022 %>% add_column(duration = difftime(year_2022$ended_at,year_2022$started_at), .after = "ended_at")
year_2022 <- year_2022 %>% add_column(day_of_week = wday(year_2022$date), .after="year")
year_2022 <- year_2022 %>% add_column(hour = format(as.POSIXct(year_2022$started_at), format = "%H"), .after = "year")


# Removes ride that started from HQ QR & rides that have negative duration
year_2022v2 <- year_2022[!(year_2022$start_station_name == "HQ QR" | year_2022$duration <= 0),]

# Removes rides that have no duration data
year_2022v2 <- year_2022v2[complete.cases(year_2022v2[, c('duration')]),]

# year_2022v2 -> CLEAN DATASET TO USE FOR ANALYSIS

### NUMERICAL ANALSIS ------------------------------------------------------------------
# Provide statistical insights of the numerical columns 
summary(year_2022v2)

# Comparing casual and member's ride duration
aggregate(year_2022v2$duration ~ year_2022v2$member_casual, FUN=mean)  # Casuals rider's duration are more than members: c:1901.1018s vs. m:770.2833s 
aggregate(year_2022v2$duration ~ year_2022v2$member_casual, FUN=median) # c:814s vs. m:536s
aggregate(year_2022v2$duration ~ year_2022v2$member_casual, FUN=max) # c:2483235s vs. m:93594s

aggregate(year_2022v2$duration ~ year_2022v2$member_casual + year_2022v2$day_of_week, FUN = mean) # everyday of the week casual riders ride for longer than members

### HOW ANALYSIS ------------------------------------------------------------------
## Casuals generally have less rides then the members, but their rides are much longer. 
# Let's visualize the number of rides by rider type - Members had more number_of_rides than casual
rides_v_days <- year_2022v2 %>% 
  group_by(member_casual, day_of_week) %>%  #groups by user_type and day_of_week
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(duration)) %>% 		# calculates the average duration
  arrange(member_casual, day_of_week)	%>% 
  ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = "Day of the Week", y = "Number of Rides", title = "Number of Rides Vs. Days of the Week Per Member Types", fill='Member Type')

# Let's visualize the duration of rides by rider type - Casuals rode for longer than members
duration_v_days <- year_2022v2 %>% 
  group_by(member_casual, day_of_week) %>%  #groups by user_type and day_of_week
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(duration)) %>% 		# calculates the average duration
  arrange(member_casual, day_of_week)	%>% 
  ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = "Day of the Week", y = "Average Duration (secs)", title = "Avg. Duration Vs. Days of the Week Per Member Types", fill='Member Type')

grid.arrange(rides_v_days, duration_v_days, nrow=2)

### WHAT ANALYSIS ------------------------------------------------------------------
# Visualize the number of rides by rider type by rideable_type - Casuals ride all three, Members only ride classic and electric
year_2022v2 %>% 
  group_by(member_casual, rideable_type) %>%  #groups by user_type and ride_type
  summarise(number_of_rides = n()) %>%					#calculates the number of rides 
  arrange(member_casual, rideable_type)	%>% 
  ggplot(aes(x = rideable_type, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + 
  labs(x = "Type of Ride", y = "Number of Rides", title = "Number of Rides Per Ride & Member Types", fill='Member Type')

### WHEN ANALYSIS -----------------------------------------------------------------
# Visualize the number of rides by rider type by time of day - Casuals peak coming home from work, Members ride to work and from work
year_2022v2 %>% 
  group_by(member_casual, hour) %>%  #groups by user_type and time of day
  summarise(number_of_rides = n()) %>%					#calculates the number of rides 
  arrange(member_casual, hour)	%>% 
  ggplot(aes(x = hour, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = "Time of Day", y = "Number of Rides", title = "Number of Rides Vs. Time of Day Per Member Types", fill='Member Type')
