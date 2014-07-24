# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url, 
#               destfile="dataset.zip",
#               method="curl")
# unzip("dataset.zip")
# # rename folder

################################################################
#
# Assignment Step 1:
# Merge the training and the test sets to create one data set.
#
################################################################

# read train data
trainRecords <- read.table("data/train/X_train.txt",
                           colClasses="numeric")
trainSubjects <- read.table("data/train/subject_train.txt")
trainActivities <- read.table("data/train/y_train.txt")


# merge train data into one train df by column
dim(trainRecords)               # sanity check
dim(trainSubjects)              # sanity check
dim(trainActivities)            # sanity check
trainData <- cbind(trainSubjects, trainActivities, trainRecords)


# read test data
testRecords <- read.table("data/test/X_test.txt",
                          colClasses="numeric")
testSubjects <- read.table("data/test/subject_test.txt")
testActivities <- read.table("data/test/y_test.txt")


# merge test data into one test df by column
dim(testRecords)               # sanity check
dim(testSubjects)              # sanity check
dim(testActivities)            # sanity check
testData <- cbind(testSubjects, testActivities, testRecords)


# merge test and train data into one df by row
dim(trainData)                  # sanity check
dim(testData)                   # sanity check
mergedData <- rbind(trainData, testData)


################################################################
#
# Assignment Step 2:
# Extract only the measurements on the mean and standard deviation 
# for each measurement
#
################################################################


# create vector of column positions for means and standard deviations
allMeasureNames <- read.table("data/features.txt",
                              stringsAsFactors=F)
columnPositions <- grep("*mean\\(\\)|std",
                        allMeasureNames[,2])
length(columnPositions)


# extract from mergeData only columns of interest
extractedData <- mergedData[, c(1,2, columnPositions +2)] # shift right by 2 for ids

# sanity check: did we extract what we intended to?
dim(extractedData)
head(mergedData[3])
head(extractedData[3])


################################################################
#
# Assignment Step 3:
# Use descriptive activity names to name the activities in the data set
#
################################################################


# read activity names from description file
activityNames <- read.table("data/activity_labels.txt",
                            stringsAsFactor=F)
head(activityNames, 3)          #what we've got?
extractedDataDescriptive <- extractedData
extractedDataDescriptive[,2] <- factor(extractedDataDescriptive[,2],
                                               levels = as.vector(activityNames[,1]),
                                               labels = as.vector(activityNames[,2]))


head(extractedDataDescriptive[,2])      #what we've got?


# sanity check: correct substitution?
for (i in 1:5) {
        k <- runif(1, min=1, max = nrow(mergedData))
        print(k)
        print(extractedDataDescriptive[k, 2])
        print(extractedData[k, 2])
        m <- extractedData[k,2]
        print(activityNames[m,])      
}

################################################################
#
# Assignment Step 4:
# Appropriately label the data set with descriptive variable names. 
#
################################################################

# Make vector of names etxracted for values of means and std
namesExtracted <- allMeasureNames[columnPositions, 2]
namesExtracted


# Make valid R names
validExtractedNames <- make.names(namesExtracted)
validExtractedNames


# Cleaning names from "BodyBody" artefact
validExtractedNamesBody <- gsub("BodyBody", "Body", 
                                validExtractedNames)

# Cleaning extra dots
validExtractedNamesClean <- gsub("\\.\\.\\.|\\.\\.", "\\.", 
                                 validExtractedNamesBody)
validExtractedNamesClean

# assign names to the columns of merged data frame
colnames(extractedDataDescriptive) <- c(c("subject", "activity"), 
                                        validExtractedNamesClean)


# check: what we've got
extractedDataDescriptive[1:5, 1:5]


###############################################################
#
# Assignment Step 5:
# Create a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
#
################################################################

meanTidyData <- aggregate(.~ subject + activity,
                         data=extractedDataDescriptive,
                         FUN="mean")
dim(meanTidyData)
meanTidyData[1:35, 1:5]         # what we've got?
write.table(meanTidyData,
            file="meanTidyData.txt",
            row.names=F)
