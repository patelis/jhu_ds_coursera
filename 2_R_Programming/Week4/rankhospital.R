rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  
  df <- read.csv(here::here("2_R_Programming", "Week4", "outcome-of-care-measures.csv"), colClasses = "character")
  
  ## Check that state and outcome are valid
  
  if (!(state %in% unique(df$State))) {
    
    stop("invalid state")
    
  } 
  
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
    
    stop("invalid outcome")
    
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  if (outcome == "heart attack") {
    
    condition <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    
  } else if (outcome == "heart failure") {
    
    condition <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    
  } else {
    
    condition <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    
  }
  
  df <- df[df["State"] == state, ]
  df[df[condition] ==  "Not Available", condition] <- NA
  df[, condition] <- as.numeric(df[, condition])
  df <- df[!is.na(df[,condition]), ]
  df <- df[order(df[condition], df["Hospital.Name"]), ]
  df[, "Rank"] <- 1:nrow(df)
  
  if (num == "best") {
    
    df[df["Rank"] == 1, "Hospital.Name"]
    
  } else if (num == "worst") {
    
    df[df["Rank"] == nrow(df), "Hospital.Name"]
    
  } else if (num > nrow(df)) {
    
    NA
    
  } else {
    
    df[df["Rank"] == num, "Hospital.Name"]
    
  }
  
}
