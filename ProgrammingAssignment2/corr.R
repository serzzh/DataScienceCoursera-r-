corr <- function(directory, threshold = 0) {
    compl <- complete (directory)
    sel <- compl$nobs > threshold
    id <-compl[sel,1]
    out <- c()
    for (i in id){
      filename <- paste(directory, "/" ,sprintf("%03s", i) ,'.csv', sep='')
      file <- read.csv(filename)
      file_c <- file[complete.cases(file),]
      sulfate <- file_c$sulfate
      nitrate <- file_c$nitrate
      correl <- cor(sulfate,nitrate)
      out[length(out)+1] <- correl
    }
  out  
}

