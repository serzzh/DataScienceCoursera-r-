## Please install LaF package
library(LaF)

## Function for reading variable data from file and returning mean and median
read.var <- function (var1, files, option){
        
        ## Getting file for variable and option
        data_file <- files[grepl(paste0(var1,option), files)]
        
        ## Reading variable data, calculating mean and median
        width <- rep(16, each=128)
        type <- rep('double', each=128)
        x <- laf_open_fwf(data_file, column_widths = width, column_types=type)
        ## 2. Extracting only the measurements on the mean and standard deviation for each measurement.   
        mean <- apply(x[,], 1, mean)
        median <- apply(x[,], 1, median)
        rdata <- cbind(mean, median)
        ## 4. Labeling the data set with descriptive variable names. 
        colnames(rdata) <- c(paste0(var1,'.mean'), paste0(var1,'.median'))
        rdata
        
}
