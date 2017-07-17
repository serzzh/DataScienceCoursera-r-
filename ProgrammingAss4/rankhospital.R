rankhospital <- function(state, outcome, num='best') {
  ## Read outcome data
  data1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  cols <- c(11,17,23)
  names(cols) <- c('heart attack', 'heart failure', 'pneumonia')
  if(!outcome %in% names(cols)) stop ('invalid outcome')
  if(!state %in% data1[,7]) stop ('invalid state')     
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  data2 <- data1[which(data1[,7]==state),]
  col1 <-as.integer(cols[outcome])
  data2[,col1] <- suppressWarnings(as.numeric(data2[,col1], na.rm=TRUE))
  data2 <- data2[!is.na(data2[,col1]),]
  sort2 <- data2[order(data2[,col1],data2[,2]),]  
  if (num=='best'){num<-1}
  if (num=='worst'){num<-length(sort2[,col1])}
  sort2[num,2]
  }