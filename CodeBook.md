---
title: "CodeBook"
output: html_document
---

The dataset is based on the UCI HAR dataset.  It contains one row per \*-mean() and \*-std() feature for each subject and activity.
The subject column contains the subject id, ranging in value from 1-30.
The label column contains the activity, which can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.
The variable column indicates the name of the feature from the original data set.  Only features containing -mean() and -std() were kept.
The mean column contains the average of all observations in the original data set for that subject, activity, and variable.