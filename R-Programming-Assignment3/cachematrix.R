## This will take a matrix to let you register(cache) its inverse (Matrix^-1) and then access the result with no further computation

makeMatrix <- function(x = matrix()) {
    
    theInverse <- NULL
    
    get <- function( ) {
        x 
    }
    
    set <- function(y) {
        x <<- y
        theInverse <<- NULL                       #Since the matrix has changed, so does the mean
    }
    
    getinverse <- function () {
        theInverse
    }
    
    setinverse <- function (i) {
        theInverse <<- i
    }
    
    list (get = get, set = set,                   #Access those by using object$get(), obj#setmean(), etc
          getinverse = getinverse,
          setinverse = setinverse)
}


## This function will calculate a matrix inverse if it's not cached (not already calculated). If it is, then it'll return the cached value

cacheInverse <- function(a = list()) {            #z <- makeMatrix(matrixHere), then class(z) is a list, which is the element "cacheInverse" requires
    i <- a$getinverse()
    matrix <- a$get()
    
    if(!is.null(i)) {
        message("Getting cached data")
        return(i)                                 #Function ends here, in case of "if statement" satisfied
    }
    
    i <- solve(matrix)                            #Calculates inverse of matrix
    a$setinverse(i)
    
    return(i)
}
