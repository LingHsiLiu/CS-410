# Sentiment Analysis of Public Figure

We are using Amazon Comprehend to perform sentiment
analysis on a political figure popularity based on the data
gathered from tweets, showing the results on a dashboard within Amazon QuickSight. This
tool can be easily extended to any entity based on the tweeter
feed for the same analysis.


### Amazon Services Used for implementing the solution

- Amazon Comprehend (NLP)
- Athena (database)
- Lambda functions
- Amazon QuickSight (DashBoard)
- Amazon Kinesis
 
### Architecture Diagram
![alt Architecture](https://github.com/nish18071985/CS-410/blob/master/sentiment-analysis/twitter-dashboard-sentimentAnalysis.gif)


### Building the architecture
The project contains a deploy.yaml (AWS Cloudformation template) which will create most of the architecture
shared in the previous 