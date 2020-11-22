# Programming Assignment Week 3

## This is a set of two functions to calculate and cache the inverse of 
## a matrix to avoid calculating it more than once

## Create dummy test matrices to for testing purposes

# a1 <- c(3, 2, 5)
# a2 <- c(2, 3, 2)
# a3 <- c(5, 2, 4)
# a4 <- c(4, 3, 4)
# 
# A <- rbind(a1, a2, a3)
# B <- rbind(a1, a2, a4)

## This function accepts a matrix as input and outputs a list containing four
## functions to 1) set the value of the matrix, 2) get its value, 3) set its inverse 
## and 4) get the inverse

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  set_inv <- function(inv) m <<- inv
  get_inv <- function() m
  list(
       set = set,
       get = get,
       set_inv = set_inv,
       get_inv = get_inv)
  
}


## cacheSolve inverses a special "matrix" (actually a list of functions)
##that is provided from the output of the makeCacheMatrix function. 
## The function first checks if the cached calculation of the inverse matrix is 
## available and returns it. If it is not, it proceeds with calculating the inverse 
## and caching it.

cacheSolve <- function(x, ...) {
  
  m <- x$get_inv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$set_inv(m)
  m
  
}
