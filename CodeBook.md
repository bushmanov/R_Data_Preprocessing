---
title: "CodeBook"
author: "Sergey Bushmanov"
date: "07/24/2014"
output: html_document
---

CodeBook
========


This CodeBook.md file is intended to provide:  

* structure of the meanTidyData.txt file  

* definitions of the variables recorded

* summary of data processing design

* summary choices

The meanTidyData.txt file contains **averages** of means and standard deviations 
of measurements coming from accelerator and gyroscope attached to 30 anonymous 
individuals. The measurements were performed while individuals undertook 6 types of
activities. The data is organized into 181 rows and 68 white space separated columns.


Rows:
=====

* First row represents names of variables (for column name definitions see
**Columns** section)

* Next 180 rows represent averages of means and standard deviations of measurements 
obtained for each subject and each activity (30 individuals multiplied by 6 activities)

* Altogether, there are 181 rows

Columns:
========

There are 68 variables each recorded in its own separate column:

* 1-st column, "subject" variable: id of an individual.  

Range: 1, 30  

Type of variable("class"): "integer"

* 2-nd column, "activity" variable: descriptive names of activities performed, while 
recording gyroscope and accelerator measurements  

Range: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  

Type of variable ("class"): "character"

* 3rd - 68th columns are calculated averages (means) of standard deviations
and means of gyroscope and accelerator measurements

Variable names:


```
##  [1] "tBodyAcc.mean.X"        "tBodyAcc.mean.Y"       
##  [3] "tBodyAcc.mean.Z"        "tBodyAcc.std.X"        
##  [5] "tBodyAcc.std.Y"         "tBodyAcc.std.Z"        
##  [7] "tGravityAcc.mean.X"     "tGravityAcc.mean.Y"    
##  [9] "tGravityAcc.mean.Z"     "tGravityAcc.std.X"     
## [11] "tGravityAcc.std.Y"      "tGravityAcc.std.Z"     
## [13] "tBodyAccJerk.mean.X"    "tBodyAccJerk.mean.Y"   
## [15] "tBodyAccJerk.mean.Z"    "tBodyAccJerk.std.X"    
## [17] "tBodyAccJerk.std.Y"     "tBodyAccJerk.std.Z"    
## [19] "tBodyGyro.mean.X"       "tBodyGyro.mean.Y"      
## [21] "tBodyGyro.mean.Z"       "tBodyGyro.std.X"       
## [23] "tBodyGyro.std.Y"        "tBodyGyro.std.Z"       
## [25] "tBodyGyroJerk.mean.X"   "tBodyGyroJerk.mean.Y"  
## [27] "tBodyGyroJerk.mean.Z"   "tBodyGyroJerk.std.X"   
## [29] "tBodyGyroJerk.std.Y"    "tBodyGyroJerk.std.Z"   
## [31] "tBodyAccMag.mean."      "tBodyAccMag.std."      
## [33] "tGravityAccMag.mean."   "tGravityAccMag.std."   
## [35] "tBodyAccJerkMag.mean."  "tBodyAccJerkMag.std."  
## [37] "tBodyGyroMag.mean."     "tBodyGyroMag.std."     
## [39] "tBodyGyroJerkMag.mean." "tBodyGyroJerkMag.std." 
## [41] "fBodyAcc.mean.X"        "fBodyAcc.mean.Y"       
## [43] "fBodyAcc.mean.Z"        "fBodyAcc.std.X"        
## [45] "fBodyAcc.std.Y"         "fBodyAcc.std.Z"        
## [47] "fBodyAccJerk.mean.X"    "fBodyAccJerk.mean.Y"   
## [49] "fBodyAccJerk.mean.Z"    "fBodyAccJerk.std.X"    
## [51] "fBodyAccJerk.std.Y"     "fBodyAccJerk.std.Z"    
## [53] "fBodyGyro.mean.X"       "fBodyGyro.mean.Y"      
## [55] "fBodyGyro.mean.Z"       "fBodyGyro.std.X"       
## [57] "fBodyGyro.std.Y"        "fBodyGyro.std.Z"       
## [59] "fBodyAccMag.mean."      "fBodyAccMag.std."      
## [61] "fBodyAccJerkMag.mean."  "fBodyAccJerkMag.std."  
## [63] "fBodyGyroMag.mean."     "fBodyGyroMag.std."     
## [65] "fBodyGyroJerkMag.mean." "fBodyGyroJerkMag.std."
```

Meaning of variable names:

* prefixes "t" and "f" stand for the "time" and "frequency"
domains correspondingly, from which underlying series come from

* "BodyAcc" and "GravityAcc" stand for body and gravity components of
accelerator signal

* "BodyAccJerk" and "BodyGyroJerk" stand for body linear acceleration and angular 
velocity

* "Mag" stands for signal magnitude

* XYZ stand for the names of euclidean coordinate projections

* suffixes "mean" and "std" denote mean and standard deviations of the measured
series over which averaging was performed

Range: variables are normalized and scaled within [-1,1]


Summary of data processing design that leads to meanTidyData.txt
================================================================

The resulting data presented is obtained via combining and summarizing raw data 
that can be obtained at the time of this report at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In general, after downloading data, the steps to obtain meanTidyData.txt are as follows:

* Step 1. Combine train and test data sets.

* Step 2. Only extract means and standard deviations of measurements.

* Step 3. Substitute activity id's with their descriptive labels.

* Step 4. Give descriptive, valid labels to measurement variables and export file.

* Step 5. Average extracted measures over each activity for each subject.

More detailed explanation of the process is given in the README.md file found at
https://github.com/sbushmanov/GnCD_Course_Project

Summary choices:
==================

* Only 66 varibles with 33 mean() and 33 std() in their names entered the final 
dataset of calculated averages. Variables whose name contained other forms of mean, 
e.g meanFreq, are not considerd a "true" mean (they are part of frequency domain 
filtering).

* Filtering for invalid characters in variable names was performed with
make.names() R function. Resulting variable names were further processed
by substituting recurring strings "BodyBody", "...", and ".." for "Body" and ".".
