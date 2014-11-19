setwd("v:/Tutorials/Stanford University On-Line Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/")

library(dplyr)

## ----------------------------------
## Use content of features.txt to create descriptive variale names (4.)

features <- read.csv("features.txt", sep = ' ', header=F)

## Remove id
features <- features[,2]

## Replace (invalid) '-' to '_'
features <- str_replace_all(features, '[-,]', '_')


## Debgug purposes 
## (if it is -1 then process all rows from input else process nrows number of rows)
nrows <- -1

##
## ------------------------------------------
## Prepare train and test data to merge
##

## Based on the input data files has fixed with records tructure and 
## each column 16 chars wide generate a vector for 561 of them

colWidths <- c(rep(16,561))

## ------------------------------------------
## Process train data

## Read content of x_tran.txt into trainData and uses the content of the features 
## table for column/variable names
trainData <- read.fwf("train/X_train.txt", n=nrows, widths = colWidths, header=F, col.names=features)

## Read related y_train.txt into activities and use 'activity' as variable name
activities <- read.csv("train/y_train.txt", header=F, nrows = nrows, col.names = 'activity')

## Read related subject_train.txt into trainSubject and use 'subjectId' ad variable name
trainSubject <- read.csv("train/subject_train.txt", header=F, nrows = nrows, col.names = 'subjectId') 

##-------------------------------------------
## Combine subject and activity identifier with the relevant train data

train <- data.frame(c(trainSubject, activities, trainData))

## clean-up, they are not necessary anymore
rm( list = c("trainSubject", "activities", "trainData") )

## ------------------------------------------
## Process test data

## Read content of x_test.txt into testData and uses the content of the features 
## table for column/variable names
testData <- read.fwf("test/X_test.txt", n=nrows, widths = colWidths, header=F, col.names=features)

## Read related y_test.txt into activities and use 'activity' as variable name
activities <- read.csv("test/y_test.txt", header=F, nrows = nrows, col.names = 'activity')

## Read related subject_test.txt into testSubject and use 'subjectId' ad variable name
testSubject <- read.csv("test/subject_test.txt", header=F, nrows = nrows, col.names = 'subjectId') 

##-------------------------------------------
## Combine subject and activity identifier with the relevant test data

test <- data.frame(c(testSubject, activities, testData))

## clean-up, they are not necessary anymore
rm( list = c("testSubject", "activities", "testData") )

## ------------------------------------------
## 1. Merges the training and the test sets to create one data set.

final <- rbind(train, test)

## clean-up, they are not necessary anymore
rm(train, test, colWidths)

## ------------------------------------------
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

extract <- select(final, subjectId:activity, contains('mean..'), contains('std..'))

## clean-up, they are not necessary anymore
rm(final, features)

## ------------------------------------------
## 3.  Uses descriptive activity names to name the activities in the data set

activities <- c("walking", "walking upstars", "walking downstairs", "siting", "standing", "laying")

extract <- mutate( extract, activity = activities[activity])

## ------------------------------------------
## Create average dataset

averages <- extract %>% group_by(subjectId, activity) %>% summarise_each(funs(mean))

## clean-up, they are not necessary anymore
rm(extract)

## Remove ".."  
## Originally they were the '()' but they are invalid chars in variable name, 
## therfore at read data replaced them by '.'

names(averages) <- gsub("\\.\\.", "", names(averages))

## Write out the averages 
write.table(averages, "UCI_HAR_Averages.txt", row.name=FALSE)


## Write out the variable names to help code book creation
write.table(names(averages), "CodeBook.md", row.name=FALSE, quote=FALSE)
