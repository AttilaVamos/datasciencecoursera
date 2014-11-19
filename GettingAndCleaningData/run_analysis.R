## ----------------------------------------------
##
## Getting and Cleaning Data Course Project
##
## run_analysis.R
##
## Author: Attila Vamos
## (attila.vamos@gmail.com)
##
## Version: 1.0
##
##-----------------------------------------------

##
## ----------------------------------------------
## Set the working directory
## It should un-comment and change if you want to run this script other directory 
## than 'UCI HAR Dataser'
## 
## setwd("v:/Tutorials/Stanford University On-Line Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/")

##
## ----------------------------------------------
## Cheking the the environmnet.
## There should be a 'train' and 'test' subdirectory with proper files
##

subDirs <- list.dirs(recursive=FALSE)
if (!(("./test" %in% subDirs) & ("./train" %in% subDirs)))
{
  print(c("The current directory is:",getwd()))
  print("Here are not 'test' and 'train' subdirectories!")
  print("You should move this script into the 'UCI HAR Dataset' directory")
  print("or uncomment and update setwd() command at the beginning of thsi script!")
  stop("Bye", call.= FALSE)
} else 
{
  ## The directories are fine, check the test data files
  testDir <-list.files(path = './test', recursive=FALSE)
  if (!(("X_test.txt" %in% testDir) & ("subject_test.txt" %in% testDir) & ("y_test.txt" %in% testDir)))
  {
    print(c("The current directory is:",getwd()))
    print("I can't find necessary file(s) in the ./test directory!")
    stop("Bye", call.= FALSE)
  }

  ## Check the train data files
  trainDir <-list.files(path = './train', recursive=FALSE)
  if (!(("X_train.txt" %in% trainDir) & ("subject_train.txt" %in% trainDir) & ("y_train.txt" %in% trainDir)))
  {
    print(c("The current directory is:",getwd()))
    print("I can't find necessary file(s) in the ./train directory!")
    stop("Bye", call.= FALSE)
  }
}

##
## ----------------------------------------------
## Load necessary libraries

library(dplyr)
library(stringr)

##
## ----------------------------------------------
## Variable for debgug purposes 
## If it is -1 then process all rows from input tables 
## else process nrows number of rows only
## This is read.fwf() and read.csv() feature

nrows <- -1

##
## ----------------------------------------------
## Task 4. Use content of features.txt to create descriptive variale names
##

features <- read.csv("features.txt", sep = ' ', header=F)

## Remove id
features <- features[,2]

## Replace '-' and ',' characters to '_' 
## (They are invalid in variable name and automatically replaced to '.')
## I leave the '(' and ')' (also invalid chars in variable name) to indetifiy 
## mean() and std() origins later
## E.g. 'tBodyAcc-mean()-X' becomes ' tBodyAcc_mean()_X' or
##      'tBodyAcc-arCoeff()-X,1' becomes 'tBodyAcc_arCoeff()_X_1' 
## Later the read.wfw automaticaly replcase '(' and ')' to '.' when create variable (column) names

features <- str_replace_all(features, '[-,]', '_')

##
## ----------------------------------------------
## Prepare train and test data to merge
##

## Based on the input data files has fixed with records structure and 
## each column 16 chars wide 
## Generate a vector for 561 of them and store it colWidths

colWidths <- c(rep(16,561))

##
## ----------------------------------------------
## Process train data
##

## Read content of x_tran.txt into trainData and uses the content of the features 
## table for column/variable names
trainData <- read.fwf("train/X_train.txt", n=nrows, widths = colWidths, header=F, col.names=features)

## Read related y_train.txt into activities and use 'activity' as variable name
activities <- read.csv("train/y_train.txt", header=F, nrows = nrows, col.names = 'activity')

## Read related subject_train.txt into trainSubject and use 'subjectId' ad variable name
trainSubject <- read.csv("train/subject_train.txt", header=F, nrows = nrows, col.names = 'subjectId') 

##
## ----------------------------------------------
## Combine subject and activity identifier with the relevant train data
##

train <- data.frame(c(trainSubject, activities, trainData))

## clean-up, they are not necessary anymore
rm( list = c("trainSubject", "activities", "trainData") )

##
## ----------------------------------------------
## Process test data
##

## Read content of x_test.txt into testData and uses the content of the features 
## table for column/variable names
testData <- read.fwf("test/X_test.txt", n=nrows, widths = colWidths, header=F, col.names=features)

## Read related y_test.txt into activities and use 'activity' as variable name
activities <- read.csv("test/y_test.txt", header=F, nrows = nrows, col.names = 'activity')

## Read related subject_test.txt into testSubject and use 'subjectId' ad variable name
testSubject <- read.csv("test/subject_test.txt", header=F, nrows = nrows, col.names = 'subjectId') 

##
## ----------------------------------------------
## Combine subject and activity identifier with the relevant test data
##

test <- data.frame(c(testSubject, activities, testData))

## clean-up, they are not necessary anymore
rm( list = c("testSubject", "activities", "testData") )

##
## ----------------------------------------------
## Task 1. Merges the training and the test sets to create one data set.
##

final <- rbind(train, test)

## clean-up, they are not necessary anymore
rm(train, test, colWidths)

##
## ----------------------------------------------
## Task 2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement.
##

## the read.fwf() function replaced the '(' and ')' chars in the original feature
## names of 'mean()' to 'mean..' and 'std()' to 'std..'
## So now I can use them to identify the variables contain mean() and std() results.

extract <- select(final, subjectId:activity, contains('mean..'), contains('std..'))

## clean-up, they are not necessary anymore
rm(final, features)

##
## ------------------------------------------
## Task 3.  Uses descriptive activity names to name the activities in the data set
##

activities <- c("walking", "walking upstars", "walking downstairs", "siting", "standing", "laying")

extract <- mutate( extract, activity = activities[activity])

##
## ----------------------------------------------
## Task 5. Create average dataset
##

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

##
## ----------------------------------------------
##  We are finished.
##

print ("Done.")

