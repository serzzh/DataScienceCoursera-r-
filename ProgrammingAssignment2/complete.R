complete <- function(directory='specdata', id = 1:332) {
  out <- data.frame( "id" = integer(0), "nobs" = integer(0), stringsAsFactors=FALSE)
  for (i in id){
    filename <- paste(directory, "/" ,sprintf("%03s", i) ,'.csv', sep='')
    file <- read.csv(filename)
    rows <- nrow(file[complete.cases(file),])
    out[nrow(out)+1,] <- c(i,rows)
  }
  out
}