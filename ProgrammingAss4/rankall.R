rankall <- function(outcome, num='best') {
  ## Read outcome data
  data1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  cols <- c(11,17,23)
  names(cols) <- c('heart attack', 'heart failure', 'pneumonia')
  if(!outcome %in% names(cols)) stop ('invalid outcome')
     ## Return hospital name in that state with the given rank
  ## 30-day death rate
  col1 <-as.integer(cols[outcome])
  data1[,col1] <- suppressWarnings(as.numeric(data1[,col1], na.rm=TRUE))
  data2 <- split(data1[,c(2,7,col1)],data1[,7])
  output <- data.frame(character(),character(),stringsAsFactors=FALSE)
  names(output) <- c('hospital','state')
  for (i in names(data2)){
    state_data <- do.call(rbind,data2[i])
    sort1 <- state_data[order(state_data[,3],state_data[,1]),]
    sort2 <- sort1[!is.na(sort1[,3]),]
    if (num=='best'){n<-1}
    else if (num=='worst'){n<-length(sort2[,3])}  
    else {n<-num}
    output[i,'hospital'] <- sort2[n,1]
    output[i,'state'] <- i
  }
  output
  }