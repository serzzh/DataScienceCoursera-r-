url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
destfile <- 'getdata-projectfiles-UCI HAR Dataset.zip'
dir <- 'UCI HAR Dataset'
vars <- c('X', 'body_acc_x', 'body_acc_y', 'body_acc_z', 'body_gyro_x', 'body_gyro_y', 'body_gyro_z', 'total_acc_x','total_acc_y','total_acc_z')
resdata <- data.frame('subject'=character(), 'activity'=character())
options <- c('_test','_train')

## Function chsrc for checking if the data exists
source('chsrc.R')

## Function for reading variable data from file and returning mean and median
source('read_var.R')

if(chsrc(destfile, dir)) {
        
        ## Reading filenames to a vector
        files <- as.vector(dir(dir, full.names = TRUE, recursive = TRUE))
        
        ## 1. Merging the training and the test sets to create one data set.  
        for (i in c(1,2)){
                             
                ## Reading subjects
                subj_file <- files[grepl(paste0('subject', options[i]), files)]
                subject <- read.table(subj_file, header=FALSE)[,1]
                
                ## 3. Using descriptive activity names to name the activities in the data set.   
                y_file <- files[grepl(paste0('/y',options[i]), files)]
                act_file <- files[grepl('activity_labels', files)]
                activity <- read.table(y_file, header=FALSE)
                labels <- read.table(act_file, header=FALSE)
                colnames(activity) <-c('act_id')
                colnames(labels) <-c('act_id', 'activity')
                
                ## Writing data to the dataset
                data <- cbind(subject, merge(activity,labels))[c(1,3)]
                               
                for (j in 1:10){
                        rdata <- read.var(vars[j], files, option=options[i])               
                        data <- cbind(data, rdata)
                }
                resdata <- rbind(resdata, data)
         }

        ## 5. Creating a second (from data set in step 4), independent tidy data set with the average of each variable for each activity and each subject.
        resdata2 <- resdata %>%
                group_by(subject,activity) %>%
                summarise_each(funs(mean))
        
        write.table(resdata2, file='result_data2.txt', row.name=FALSE)
                
}




