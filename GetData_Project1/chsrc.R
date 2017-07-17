## Function for checking if the data exists
chsrc <- function (destfile, dir){ 
        
        if (file.exists(dir)){
                files <- as.vector(dir(dir, full.names = TRUE, recursive = TRUE))
                if (length(files) == '28') {
                        rt <- TRUE
                } else {
                        rt <-FALSE
                        stop ('Files in folder "UCI HAR Dataset" are missing. Please download and unzip source file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip')
                        
                }
        } else if(file.exists(destfile)) {
                unzip (destfile)
                rt <- TRUE
        }  else {
                rt <- FALSE
                stop ('Please download source file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip')
                ##  download.file(url, destfile, method = 'curl')
        }
        rt
}