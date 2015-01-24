There are one table, called UCI_HAR_Averages.txt.

The origin of this table come from the UCI Human Activity Recognition (HAR) Using Smartphones train and test data.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

The UCI_HAR_Averages.txt generated from the merged train and test tables, extended by the subject identifier (1..30) and decoded (descriptive string) of activities: "walking", "walking upstars", etc.

The fields are space separated, the only one string filed (activity) is quoted. All numeric values normalized and bounded within [-1,1].

Rows contain average values each activities of each individuals' mean and standard deviation variables form the original  train and test tables.

Variable names generated from 2 or 3 parts depend on the data is scalar or vector and separated by the underscore '_':

1. The measurememt  from accelerometer (Acc) or gyroscope (Gyro) or calculation/filtering (Gravity). The prefix 't' to denote    time and 'f' to indicate the frequency domain signals.

2. Pre processing method: meand or standard deviation (std)

3. If the data is vector the X, Y or Z to identify the direction


	UCI_HAR_Averages.txt
	 1. subjectId: numeric Identifiy the voluntier who caried out activities.
	
	 2. activity: varchar(18) stored activity type from this dictionary
		. "walking"
		. "walking upstars"
		. "walking downstairs"
		. "siting", 
		. "standing"
		. "laying"

	 3. tBodyAcc_mean_X numeric. Mean of Body acceleration in X direction (time domain)
	 4. tBodyAcc_mean_Y numeric. Mean of Body acceleration in Y direction (time domain)
	 5. tBodyAcc_mean_Z numeric. Mean of Body acceleration in Z direction (time domain)

	 6. tGravityAcc_mean_X numeric. Mean of Gravity acceleration in X direction (time domain)
	 7. tGravityAcc_mean_Y numeric. Mean of Gravity acceleration in Y direction (time domain)
	 8. tGravityAcc_mean_Z numeric. Mean of Gravity acceleration in Z direction (time domain)

	 9. tBodyAccJerk_mean_X numeric. Mean of Body jerk acceleration in X direction (time domain)
	10. tBodyAccJerk_mean_Y numeric. Mean of Body jerk acceleration in X direction (time domain)
	11. tBodyAccJerk_mean_Z numeric. Mean of Body jerk acceleration in Z direction (time domain)

	12. tBodyGyro_mean_X numeric. Mean of Body rotation aroud X axis (time domain)
	13. tBodyGyro_mean_Y numeric. Mean of Body rotation aroud Y axis (time domain)
	14. tBodyGyro_mean_Z numeric. Mean of Body rotation aroud Z axis (time domain)

	15. tBodyGyroJerk_mean_X numeric. Mean of Body jerk rotation aroud X axis (time domain)
	16. tBodyGyroJerk_mean_Y numeric. Mean of Body jerk rotation aroud Y axis (time domain)
	17. tBodyGyroJerk_mean_Z numeric. Mean of Body jerk rotation aroud Z axis (time domain)

	18. tBodyAccMag_mean numeric. Mean of magnification of Body acceleration (time domain)
	19. tGravityAccMag_mean numeric. Mean of magnification of Body gravity acceleration (time domain)
	20. tBodyAccJerkMag_mean numeric. Mean of magnification of Body jerk acceleration (time domain)
	21. tBodyGyroMag_mean numeric. Mean of magnification of Body rotation (time domain)
	22. tBodyGyroJerkMag_mean numeric. Mean of magnification of Body jerk rotation (time domain)

	23. fBodyAcc_mean_X numeric. Mean of Body acceleration in X direction (frequency domain)
	24. fBodyAcc_mean_Y numeric. Mean of Body acceleration in Y direction (frequency domain)
	25. fBodyAcc_mean_Z numeric. Mean of Body acceleration in Z direction (frequency domain)

	26. fBodyAccJerk_mean_X numeric. Mean of Body jerk acceleration in X direction (frequency domain)
	27. fBodyAccJerk_mean_Y numeric. Mean of Body jerk acceleration in Y direction (frequency domain)
	28. fBodyAccJerk_mean_Z numeric. Mean of Body jerk acceleration in Z direction (frequency domain)

	29. fBodyGyro_mean_X numeric. Mean of Body rotation aroud X axis (frequency domain)
	30. fBodyGyro_mean_Y numeric. Mean of Body rotation aroud Y axis (frequency domain)
	31. fBodyGyro_mean_Z numeric. Mean of Body rotation aroud Z axis (frequency domain)

	32. fBodyAccMag_mean numeric. Mean of magnification of Body acceleration (frequency domain)
	33. fBodyBodyAccJerkMag_mean numeric. Mean of magnification of Body jerk acceleration (frequency domain)
	34. fBodyBodyGyroMag_mean numeric. Mean of magnification of Body rotation (frequency domain)
	35. fBodyBodyGyroJerkMag_mean numeric. Mean of magnification of Body jerk rotation (frequency domain)

	36. tBodyAcc_std_X numeric. Standard deviation of Body acceleration in X direction (time domain)
	37. tBodyAcc_std_Y numeric. Standard deviation of Body acceleration in Y direction (time domain)
	38. tBodyAcc_std_Z numeric. Standard deviation of Body acceleration in Z direction (time domain)

	39. tGravityAcc_std_X numeric. Standard deviation of Gravity acceleration in X direction (time domain)
	40. tGravityAcc_std_Y numeric. Standard deviation of Gravity acceleration in Y direction (time domain)
	41. tGravityAcc_std_Z numeric. Standard deviation of Gravity acceleration in Z direction (time domain)

	42. tBodyAccJerk_std_X numeric. Standard deviation of Body jerk acceleration in X direction (time domain)
	43. tBodyAccJerk_std_Y numeric. Standard deviation of Body jerk acceleration in Y direction (time domain)
	44. tBodyAccJerk_std_Z numeric. Standard deviation of Body jerk acceleration in Z direction (time domain)

	45. tBodyGyro_std_X numeric. Standard deviation of Body rotation aroud X axis (time domain)
	46. tBodyGyro_std_Y numeric. Standard deviation of Body rotation aroud Y axis (time domain)
	47. tBodyGyro_std_Z numeric. Standard deviation of Body rotation aroud Z axis (time domain)

	48. tBodyGyroJerk_std_X numeric. Standard deviation of Body jerk rotation aroud X axis (time domain)
	49. tBodyGyroJerk_std_Y numeric. Standard deviation of Body jerk rotation aroud Y axis (time domain)
	50. tBodyGyroJerk_std_Z numeric. Standard deviation of Body jerk rotation aroud Z axis (time domain)

	51. tBodyAccMag_std numeric. Standard deviation of magnification of Body acceleration (time domain)
	52. tGravityAccMag_std numeric. Standard deviation of magnification of Body gravity acceleration (time domain)
	53. tBodyAccJerkMag_std numeric. Standard deviation of magnification of Body jerk acceleration (time domain)
	54. tBodyGyroMag_std numeric. Standard deviation of magnification of Body rotation (time domain)
	55. tBodyGyroJerkMag_std numeric. Standard deviation of magnification of Body jerk rotation (time domain)

	56. fBodyAcc_std_X numeric. Standard deviation of Body acceleration in X direction (frequency domain)
	57. fBodyAcc_std_Y numeric. Standard deviation of Body acceleration in Y direction (frequency domain)
	58. fBodyAcc_std_Z numeric. Standard deviation of Body acceleration in Z direction (frequency domain)

	59. fBodyAccJerk_std_X numeric. Standard deviation of Body jerk acceleration in X direction (frequency domain)
	60. fBodyAccJerk_std_Y numeric. Standard deviation of Body jerk acceleration in Y direction (frequency domain)
	61. fBodyAccJerk_std_Z numeric. Standard deviation of Body jerk acceleration in Z direction (frequency domain)

	62. fBodyGyro_std_X numeric. Standard deviation of Body rotation aroud X axis (frequency domain)
	63. fBodyGyro_std_Y numeric. Standard deviation of Body rotation aroud Y axis (frequency domain)
	64. fBodyGyro_std_Z numeric. Standard deviation of Body rotation aroud Z axis (frequency domain)

	65. fBodyAccMag_std numeric. Standard deviation of magnification of Body acceleration (frequency domain)
	66. fBodyBodyAccJerkMag_std numeric. Standard deviation of magnification of Body jerk acceleration (frequency domain)
	67. fBodyBodyGyroMag_std numeric. Standard deviation of magnification of Body rotation (frequency domain)
	68. fBodyBodyGyroJerkMag_std numeric. Standard deviation of magnification of Body jerk rotation (frequency domain)
	