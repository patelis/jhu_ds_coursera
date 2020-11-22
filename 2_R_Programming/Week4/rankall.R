rankall <- function(outcome, num = "best") {
  
  ## Read outcome data
  
  df <- read.csv(here::here("2_R_Programming", "Week4", "outcome-of-care-measures.csv"), colClasses = "character")
  
  ## Check that state and outcome are valid

  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
    
    stop("invalid outcome")
    
  }
  
  if (outcome == "heart attack") {
    
    condition <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    
  } else if (outcome == "heart failure") {
    
    condition <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    
  } else {
    
    condition <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    
  }
  
  df[df[condition] ==  "Not Available", condition] <- NA
  df[, condition] <- as.numeric(df[, condition])
  df <- df[!is.na(df[,condition]), ]
  df <- df[order(df[condition], df["Hospital.Name"]), ]
  # df[, "Rank"] <- NA
  
  ## For each state, find the hospital of the given rank
  
  states <- unique(df$State)
  
  collector <- data.frame()
  frame <- data.frame()
  
  for (i in states) {
    
    frame <- df[df$State == i, ]
    
    if (num == "best") {
      
      frame <- frame[1, c("Hospital.Name", "State")]
      
    } else if (num == "worst") {
      
      frame <- frame[nrow(frame), c("Hospital.Name", "State")]
      
    } else if (num > nrow(frame)) {
      
      frame <- data.frame("Hospital.Name" = NA, "State" = i)
      
    } else {
      
      frame <- frame[num, c("Hospital.Name", "State")]
      
    }
    
    collector <- rbind(collector, frame)
    
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  collector <- collector[order(collector$State), ]
  colnames(collector) <- c("hospital", "state")
  
  collector
  
}
