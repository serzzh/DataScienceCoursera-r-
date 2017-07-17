best <- function(state, outcome) {
  ## Read outcome data
  data1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  cols <- c(11,17,23)
  names(cols) <- c('heart attack', 'heart failure', 'pneumonia')
  if(!outcome %in% names(cols)) stop ('invalid outcome')
  if(!state %in% data1[,7]) stop ('invalid state')     
  ## Return hospital name in that state with lowest 30-day death rate
  data2 <- data1[which(data1[,7]==state),]
  col1 <-as.integer(cols[outcome])
  data2[,col1] <- suppressWarnings(as.numeric(data2[,col1], na.rm=TRUE))
  min1<-min(data2[,col1], na.rm=TRUE)
  row <-which(data2[,col1]==min1)
  output<-sort(data2[row,2])
  output[1]
  }