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
![alt Architecture](https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/SocialAnalyticsReader/images/Architecture_diagram.png)


### Building the architecture

The project contains a deploy.yaml (AWS Cloudformation template) which will create most of the architecture
shared in the architecture diagram.

#### Pre-requisite :
- Create your own AWS account
- Create your own developer account in twitter to access the twitter apis [twitter account creation](https://apps.twitter.com/)




1. **Creating the services :** 
    - Create a key pair (you can go to EC2 service and then on the left hand panel should be a link to create a key pair).
    - In the AWS management console, [launch the cloudformation template](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new). Go to "Choose a Template" and select "Upload a template to S3 option" and upload the deploy.yaml file there.
    - In the next step of the Cloudformation stack creation you need to specify the following parameter values :
    
    | Parameter | Description  |
    | ------- | --- |
    | InstanceKeyName | KeyPair created in the previous step |
    | TwitterAuthAccessToken | Twitter Account Access token|
    | TwitterAuthAccessTokenSecret | Twitter Account Access token secret|
    | TwitterConsumerKey | Twitter Account consumer key (API key) |
    | TwitterConsumerKeySecret | Twitter Account consumer secret (API secret)|| 
    
    - We have implemented our twitter search based on "Donald trump" but it can be implemented on any entity.
    In order to change the entity or language of search please change the following values:
    
    | Parameter | Description  |
    | ------- | --- |
    | TwitterLanguages | List of languages to use for the twitter streaming reader |
    | TwitterTermList | List of terms for twitter to listen to|
    
    - After the CloudFormation stack is launched please wait until its complete.
    
2. **Setting up S3 trigger for the lambda :**
    - After the CloudFormation stack launch is completed, go to the outputs tab. Click the LambdaFunctionConsoleURL link to go to the lambda function directly.
    ![alt CloudformationOutput](https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/SocialAnalyticsReader/images/stackoutput.gif)
    - We will now add S3 notification so that the Lambda function will be invoked when new tweets are written to S3:
        1. Under Add Triggers, please select the S3 trigger.
        2. Then configure the trigger with the new S3 bucket that CloudFormation created with the ‘raw/’ prefix. The event type should be Object Created (All).
        ![alt S3NotificationSetUp](https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/SocialAnalyticsReader/images/s3BucketConfigLambda.gif)

3. **Starting the tweeter stream producer :**
    - SSH into the EC2 instance that the stack created. (Please refer to the cloudformation stack output to get the SSh command and replace it wth your kep pair).
    - Once inside the instance please run the command `node twitter_stream_producer_app.js`    
    - After sometime, you should be able to see the various datasets in the S3 bucket that the CloudFormation template created:
    
    ![alt S3NotificationSetUp](https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/SocialAnalyticsReader/images/s3bucketdatasets.gif)


4. **Create Athena tables :**
    - Select Athena service from AWS console.
    - Create socialanalyticsblog table`    
    - Run queries from <a href="https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/athena/athena.sql/">here</a> . In queries replace `TwitterRawLocation`, `TwitterEntitiesLocation`, `TwitterSentimentLocation` from cloud formation template output.
    - Queries will create 3 tables -

    ![alt S3NotificationSetUp](https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/SocialAnalyticsReader/images/athena_tables.png)


4. **Create Dashboards :**
    - Select QuickSight from AWS console.
    - Choose Manage data
    - Create a new Athena Data Source
    - Select the `socialanalyticsblog` database and the `tweet_sentiments` table
    - Choose Edit/Preview Data
    - Choose Switch to custom SQL tool
    - Add queries from <a href="https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/quicksight/quicksight.sql/">here</a> 
    - Click on finish and saves the query
    - Choose Save and Visualize
    - Add the dashboards as per requirement.

4. **Video Tutorial :**
    - Video tutorial is available <a href="https://github.com/pradeepk85/CS-410/blob/master/sentiment-analysis/tutorial_video/cs_410_final_recording.mov/">here</a> 
