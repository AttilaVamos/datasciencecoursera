Getting and Cleaning Data Course Project
========================================

Source of data:
---------------

The input datasets come from the Human Activity Recognition (HAR) Using Smartphones Dataset Version 1.0
by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original HAR collection contains two partitions of data: train and test stored in separated sub-dirctories.

Usage of run_analysis.R:
-------------------------

1. Extract the data from the getdata-projectfiles-UCI HAR Dataset.zip into your working directory.
   The result directory structure is:
    <your working directory>
        └───UCI HAR Dataset
            ├───train
            │   └───Inertial Signals
            └───test
                └───Inertial Signals

2. Donwload the run_analysis.R script from my repo into 'UCI HAR Dataset' directory.
   If you want to use my script from different location, please un-comment the setwd(...) line 
    
    ## Set the working directory
    ## It should change if you want to run this script other directory than 'UCI HAR Dataser'
    ## setwd("v:/Tutorials/Stanford University On-Line Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/")

   and modify it accordingly to your environment.


3. Run the script either in R enviromnet or R Studio.

How it works:
-------------

Each data directory (test, train) contais 3 data tables:
 - X_test.txt
 - subject_test.txt
 - y_test.txt

Each row in the X_test.txt contains feature vector of one individual one activty like this:
  
 ( tBodyAcc-mean()-X | tBodyAcc-mean()-Y | tBodyAcc-mean()-Z | tBodyAcc-std()-X | tBodyAcc-std()-Y | tBodyAcc-std()-Z | ... |)
  -------------------------------------------------------------------------------------------------------------------------
 |    2.5717778e-001 |   -2.3285230e-002 |   -1.4653762e-002 |  -9.3840400e-001 |  -9.2009078e-001 |  -6.6768331e-001 | ... |
  -------------------------------------------------------------------------------------------------------------------------
 |    2.8602671e-001 |   -1.3163359e-002 |   -1.1908252e-001 |  -9.7541469e-001 |  -9.6745790e-001 |  -9.4495817e-001 | ... |
  -------------------------------------------------------------------------------------------------------------------------
 |    2.7548482e-001 |   -2.6050420e-002 |   -1.1815167e-001 |  -9.9381904e-001 |  -9.6992551e-001 |  -9.6274798e-001 | ... |
  -------------------------------------------------------------------------------------------------------------------------
 |                                                                                                                          |

and so on, without the column/variable names. 

Furthermore there is not reference to the individual nor to the activity inside the table. 

These infromation stored in subject_test.txt and y_test.txt respectively. The link is among these 3 tables is the row index. The first row in X_test.txt is the result of the activity in the first row of y_test.data of the user identified by the first row in subject_test.txt.

There were 5 tasks what the script should done. My script follows mainly follows these steps. There is only one exception the step 4. (Appropriately labels the data set with descriptive variable names.). I did it two phases, mainly in step 1 and finally in step 5.

I copied then commented (self documented) run_analysis.R script here. Lets go through the source code, the tasks and see what the script do to fulfil the it.  

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

    ## ------------------------------------------
    ## Task 3.  Uses descriptive activity names to name the activities in the data set

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
