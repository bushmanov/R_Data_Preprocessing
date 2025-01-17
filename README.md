---
title: "GnCD_Course_Project"
author: "Sergey Bushmanov"
date: "07/24/2014"
output: html_document
---


README.md
=========


This README.md is to:

* briefly explain the purpose and background of this data cleaning project

* provide description of working directory file structure

* state naming conventions

* describe how the run_analysis.R script works

* credit source of the original data


Project purpose and background
-------------------------------

The original data collection was performed by recording accelerator and gyroscope mesurements from 30 individuals while they were performing 6 types of physical 
activities. The goal of this project is to combine and summarize data in a format
suitable for further analysis. More specifically, a [tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) set of averages of means and standard deviations 
of measurements in .txt format should be generated.


File structure  
---------------

In order to execute run_analysis.R script, zipped raw data should be downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After the file has been downloaded to the working directory of R and unzipped,
folder "UCI HAR Dataset" to be renamed to "data" to eliminate spaces in the 
file path.

After performing these preparation steps the working directory **must** have the
following files to ensure successful running of run_analysis.R script:

* "./run_analysis.R" - R script to perform analysis.

* "./data/train/X_train.txt"  and  "./data/test/X_test.txt" - train and
test measurement data to be combined

* "./data/train/subject_train.txt" and "./data/test/subject_test.txt" - subject
id's for train and test data accordingly.

* "./data/train/y_train.txt" and "./data/test/y_test.txt" - activity id for
train and test data accordingly

* "./data/activity_labels.txt" - file matching activity labels and activity id's

* "./data/features.txt" - file containing measurement names

No other files are necessary for executing run_analysis.R script.

Files that are not necessary for executing script but critical to understanding
the nature of resulting variables:

* "./CodeBook.md" - definitions of variables in resulting meanTidyData.txt, data formats, ranges, as well as summary choices made during data processing.

Optional files to peruse:

* "./data/README.txt" - detailed explanation of how raw data was recorded, processed,
and packed into zipped downloaded file from the source of raw data.

What you got after executing the script:

* "./meanTidyData.txt" - resulting tidy data set


Naming conventions
--------------------

Variables used in the analysis are named according to 
[camelCase](http://en.wikipedia.org/wiki/CamelCase) convention, 
i.e. each next word in a variable name starts with a capital letter.


How the run_analysis.R script works
------------------------------------

There are five steps in the run_analysis.R script to perform sequentially 
to arrive from input files to resulting meanTidyData.txt

* Step 1. Merge the training and the test sets to create one data set:
  * Read measurement train data
  * Read and append to the left train subject id and train activity id
  * Read measurement test data
  * Read and append to the left test subject id and test activity id
  * Combine resulting train and test data to obtain `mergedData` R object
        
* Step 2. Extract only the measurements on the mean and standard deviation 
for each measurement
  * Read measure names
  * Find positions (via grep) of only those containing "mean()" and "std()".
  Disregard others containing "mean" in other forms, e.g. "meanFreq", as not being
  "true" means.
  * Extract columns for positions found, plus two first columns forsubject and 
  individual ids.
  * Result of Step 2 is `extractedData` R object only containing id's for
        individuals and activities, and means and standard deviations.
        
* Step 3. Use descriptive activity names to name the activities in the data set.
  * Read descriptive activity names into object of class Data Frame
  * Use ids from this file as levels, and activity labels as labels to
  factorize `extactedData[, 2]`, that represented activity id's.
  * Resulting `extractedDataDescriptive` will present activities with
  a descriptive label.
  
* Step 4. Label the data set with descriptive variable names. In the context 
of this project, a name considered descriptive if it provides
some insight into what the variable stand for, as opposed to V1, V2 e.g. As such,
`fBodyGyroJerkMag.mean.` considered descriptive (see CodeBook.md for meaning).
Otherwise, names could be too lengthy.
  * Make vector `namesExtracted` of all names of means and standard deviations extracted  
  * Make vector of valid R names with the help of `make.names()` R function  
  * Clean resulting vector of artifacts like `"BodyBody"`, `"..."` and `".."`  
  * Append `c("subject", "activity")` to the left and name `extractedDataDescriptive`
with resulting vector of names.

* Step 5. Average of each variable for each activity and each subject.
  * Aggregate data by subject and activity and calculate means. Resulting
  `meanTidyData` considered [tidy](http://vita.had.co.nz/papers/tidy-data.pdf) because  
      * the whole table only contains data of similar type (averages)
      * one observation for every row
      * one variable for every column
  * Write `meanTidyData` to `meanTidyData.txt`
        

Credit for original data:
--------------------------

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012
