# Introduction: 
The purpose of creating this project was to learn more about how to use my data analytics skills using Excel. The goal was to learn the capabilites of Excel, its' strengths and weaknesses, and to understand processes like PivotTables, Charts and Excel Functions. I wanted the project to be interesting and luckily was able to find the GameStudy dataset on Kaggle. We always see the news and media talk about gaming and it's negative influence on mental health and I feel like this dataset would be a great start to testing the validity of these statements. 

## Dataset Overview:
With over 13000 participants, this is the biggest openly available international dataset connecting gaming habits, various socio-economic factors and measures of anxiety, social phobia, life satisfaction and narcissism. This datset surveryed 12699 males, 713 females, and 52 other genders mostly coming from the Americas, Europe, and parts of Asia as seen from the Survey Residence Representation chart. The main indication of regarding the surveyee's mental health are the GAD, SWL, and SPIN cores. 

- **The GAD or Generalized Anxiety Disorder score:** measures the severity of anxiety using 7 questions with answers from 0-3 with 0 showing no signs of anxiety. The sum of these 7 questions are then taken to identify anxiety in people. GAD-7 scores of 0–4 show no anxiety , 5–9 (mild), 10–14 (moderate), and 15–21 (severe). [1]
  
- **The SWL or the Satisfaction with Life score:** is a 7-point scale with 5 questions gauging someone's perceived satisfaction with life. The possible range of scores is 5-35, with a score of 20 representing a neutral point on the scale. Scores between 5-9 indicate the respondent is extremely dissatisfied with life, whereas scores between 31-35 indicate the respondent is extremely satisfied. [2]
  
- **The SPIN or Social Phobia Inventory Number:** is the sum of a 17-item questionare withs answers from 0-4. 0-20 shows no social phobia, 21-30 (mild), 31-40 (moderate), 41-50 (Severe), 51-68 (very severe). [3]

### Sources:
- [1] - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9149533/
- [2] - http://labs.psychology.illinois.edu/~ediener/SWLS.html
- [3] - https://greenspacehealth.com/en-us/social-anxiety-spin/#:~:text=Scoring,is%20between%200%20and%2068.

## Questions to Answer
After reviewing the available data, I set out to answer these questions. 
- **How do the different genders differ?**
- **Does the game effect people's mental scores?**
- **What are the top 10 countries?**

# Process:
Like any other data analytics project, the dataset given was dirty and had many inaccuracies, therefore, before I was able to do anything I explored, manipulated, and cleaned the data. Exploring the dataset I found many answers that made no sense or just troll answers. I documented this process and all the inaccuracies within the excel file to reference. For example, the hours and streams column asked for the average number of hours within a week, which should mean a maximum value of 168hrs. It wasn't surprising to see 420hrs in these columns nor just across the whole questionarre. With these values I either replaced them with the max or removed the entry if all their responsed felt inconsistent or if it was just a troll. It was surprising to see that some people didn't answer all 17 SPIN questions. Because they didn't answer the value was 'NA' where it was much harder to average out their sums. I imputated these NA values with their respective means and was then able to get an accurate SPIN value for each surveyee. Once all of it was cleaned and I pulled all necessary data, I was finally able to visualize it and draw insights. 

Since there was no time data and more data regarding comparisons betweeen catergories, I felt that simple bar charts would help answer the first 2 questions. Additionally, since I am also exploring Excel I wanted to see it's capabilites with charts and maps. This really didn't help answer the questions but it does help provide more information about the dataset used. 

# Results:
- **How do the different genders differ?**
  - From the Avg. Mental Health Scores - Gender bar graph, You can see that on average both males and females have mild anxiety but females are 1.5x more anxious than the males. For the SWL scores, both males and females are neutral but the males have a slightly higher satisfaction with life. Additionally, the largest gap between the two is with the social phobia. Males show no social phobia but females have mild social phobia.
 
- **Does the game effect people's mental scores?**
  - There was a lot of different types of games and each of them had similar mental health averages. There was no outlier that consistently stood out on all three scales so I believe with this data it is difficult to say whether a specific game had more of a negative impact. Additionally, with no data on a control group  (scores of people who didn't game) drawing a conclusion can not be reliably done now.   

- **What are the top 10 countries?**
  - The three list of top 10 countries with the worst anxiety, satisfaction with life, and social phobia across gamers can be seen on the dashboard. It was surprising that the top 10 countries were not the same countries across the three scores. I feel like this makes it much more difficult to understand why the gamers residing in these countries scored worst than other locations.   

# Improvements:
- **Text cleaning and catergorizing:** I feel like the dataset had a lot of textual data such as the reason for playing and gameplay types. If I can sort out all the text into categories it would help see what types of games or players had better mental health. After some intial research, I believing this in itself is a ML problem where I could use ChatGPT 5 to find patterns in text data.
- **SQL:** Instead of building tables of counts for the demographics who took the survery I could use advanced queries to meeting many specific criterias.
- **Tableau or R:** I found that Excel used Bing to create their maps which is pretty slow and does not allow for a lot of customization especially with the views. The map on the dashboard is pretty zoomed out and does not really show the representation really well. I would rather have used R or Tableau to create maps as they have a lot more power and customization options.

# Conclusion:
In conclusion, I've learned quite a lot with the analysis using this dataset but I can not tie my findings back to video games having a negative impact on mental health as there is no control group to compare with. Either way, this was a fun dataset to clean and work with as it did allow me to further explore excel and it's abilities. 
