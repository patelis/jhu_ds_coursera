best <- function(state, outcome) {
  ## Read outcome data
  
  df <- read.csv(here::here("2_R_Programming", "Week4", "outcome-of-care-measures.csv"), colClasses = "character")
  
  ## Check that state and outcome are valid
  
  if (!(state %in% unique(df$State))) {
    
    stop("invalid state")
    
  } 
  
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

  df <- df[df$State == state, ]
  df[df[condition] ==  "Not Available", condition] <- NA
  df[, condition] <- as.numeric(df[, condition])
  df <- df[!is.na(df[,condition]), ]
  df <- df[df[,condition] == min(df[, condition]), ]
  
  df <- df[order(df$State),]
  
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  df[1, "Hospital.Name"]
  
}
