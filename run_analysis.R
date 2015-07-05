url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
destfile <- 'getdata-projectfiles-UCI HAR Dataset.zip'
dir <- 'UCI HAR Dataset'
options <- c('_test','_train')


## Function chsrc for checking if the data exists
source('chsrc.R')

if(chsrc(destfile, dir)) {
        
        ## Reading filenames to a vector
        files <- as.vector(dir(dir, full.names = TRUE, recursive = TRUE))
     
        resdata <- c()
        ## 1. Merging the training and the test sets to create one data set.  
        for (i in c(1,2)){
                
                ##Reading subjects, activities, labels
                subj_file <- files[grepl(paste0('subject', options[i]), files)] 
                y_file <- files[grepl(paste0('/y',options[i]), files)]
                act_file <- files[grepl('activity_labels', files)]
                subject <- read.table(subj_file, header=FALSE, col.names=c('subject'))
                activity <- read.table(y_file, header=F, col.names=c('act_id'))
                labels <- read.table(act_file, header=FALSE, col.names=c('act_id', 'activity')) 
                
                ##Reading data
                X_file <- files[grepl(paste0('X', options[i]), files)]
                cnames_file <- files[grepl('features.txt', files)] 
                X.cnames <- read.table(cnames_file, header=FALSE)[,2]               
                X <- read.table(X_file, header=FALSE, col.names=X.cnames)
                       
                ##Extracting only mean and standard deviation for each measurement
                ##Using descriptive activity names to name the activities in the data set.  
                library(dplyr)
                df <- tbl_df(X) %>%                      
                        bind_cols(subject)  %>%
                        bind_cols(activity) %>%
                        inner_join(labels) %>%
                        select(subject, activity, contains('.mean.'), contains('.std.'))
                              
                ## 4. Merging train and test data
                resdata <- rbind(resdata, df)
                rm('df')
                rm('X')
         }

        
        ## 5. Creating a second (from data set in step 4), independent tidy data set with the average of each variable for each activity and each subject.

        resdata2 <- resdata %>%
                group_by(subject,activity) %>%
                summarise_each(funs(mean))
        
        write.table(resdata2, file='result_data.txt', row.name=FALSE)
                
}




