pollutantmean <- function(directory='specdata', pollutant, id = 1:332) {
  out <-numeric()
  for (i in id){
    filename <- paste(directory, "/" ,sprintf("%03s", i) ,'.csv', sep='')
    file <- read.csv(filename)
    out <- append(out,file[[pollutant]])
  }
  mean(out, na.rm = TRUE)
}


