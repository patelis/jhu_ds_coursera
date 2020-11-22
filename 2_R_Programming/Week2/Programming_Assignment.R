# First function for the assignment

pollutantmean <- function(directory = "specdata", pollutant, id = 1:332) {
  
  path <- paste0(here::here())
  directory <- paste0(path, directory)
  
  # pollutant <- "sulfate"
  
  df <- data.frame()
  
  for (i in id) {
    
    if (i < 10) {
      
      file_name <- paste0("00", i)
      
    } else if (i >=10 & i < 100) {
      
      file_name <- paste0("0", i)
      
    } else {
      
      file_name <- as.character(i)
      
    }
    
    file_path <- paste0(directory, "/",file_name, ".csv")
    file <- read.csv(file_path)
    
    df <- rbind(df, file)
    
  }
  
  mean(df[[pollutant]], na.rm = TRUE)
  
}

# Second function for the assignment

complete <- function(directory, id = 1:332) {
  
  path <- paste0(here::here())
  directory <- paste0(path, directory)
  
  df <- data.frame()
  for (i in id) {
    
    if (i < 10) {
      
      file_name <- paste0("00", i)
      
    } else if (i >=10 & i < 100) {
      
      file_name <- paste0("0", i)
      
    } else {
      
      file_name <- as.character(i)
      
    }
    
    file_path <- paste0(directory, "/",file_name, ".csv")
    file <- read.csv(file_path)
    
    counter <- !is.na(file$sulfate) & !is.na(file$nitrate)
    # file[["counter"]] <- counter
    measurement <- data.frame(id = i, nobs = sum(counter))
    
    df <- rbind(df, measurement)
    
  }

  df
  
}

# Third function for the assignment

corr <- function(directory = "specdata", threshold = 0) {
  
  path <- paste0(here::here())
  directory <- paste0(path, directory)
  
  n <- 332
  
  vec <- vector()
  for (i in 1:n) {
    
    if (i < 10) {
      
      file_name <- paste0("00", i)
      
    } else if (i >=10 & i < 100) {
      
      file_name <- paste0("0", i)
      
    } else {
      
      file_name <- as.character(i)
      
    }
    
    file_path <- paste0(directory, "/",file_name, ".csv")
    file <- read.csv(file_path)
    
    counter <- !is.na(file$sulfate) & !is.na(file$nitrate)
    
    if (sum(counter) > threshold) {
      
      temp <- file[counter, ]
      
      vec <- rbind(vec, cor(temp$sulfate, temp$nitrate))
      
    }
    
  }
  
  vec
  
}