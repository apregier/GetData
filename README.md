---
title: "README"
output: html_document
---

Running the script run\_analysis.R will read in the original UCI HAR data set.  It reads in both the training and testing data sets and merges them into a single dataset.  The feature columns are labeled according to the features.txt file from the original data set.  The subject ids are loaded from subject\_*.txt in the original data set.
Only features containing the strings mean() or std() are kept.
The activity code is translated to the descriptive label given in the original data set in the file activity_labels.txt.
Multiple observations of the same feature for the same subject and activity are averaged together.