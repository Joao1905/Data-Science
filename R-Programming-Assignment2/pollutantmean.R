pollutantmean <- function (directory, pollutant, id = 1:332) {
    
    if (!is.integer(id)) {
        id <- 1:id
    }
  
    if (pollutant == "sulfate") {
        row = 2
    } else if (pollutant == "nitrate") {
        row = 3
    } else {
        print("No pollutant found")
    }
    
    conc <- paste(directory, "/", i, ".csv", sep = "")
    pollutantMatrix <- NULL
    
    for (i in id) {
        conc <- paste(directory, "/", i, ".csv", sep = "")
        m <- read.table(conc, header = TRUE, sep = ",", quote = "", , , , , , , , )
        pollutantMatrix <- rbind(pollutantMatrix, m)
    }
    
    result = mean(pollutantMatrix[ ,row], na.rm=T)
    result
    
}


complete <- function (directory, id = 1:332) {
    
    completeMatrix <- matrix(nrow=length(id),ncol=2)
    cleanMatrix <- NULL
    c <- 0
    
    for (i in id) {
        c <- c + 1
        conc <- paste(directory, "/", i, ".csv", sep = "")
        m <- read.table(conc, header = TRUE, sep = ",", quote = "", , , , , , , , )
        cleanMatrix <- na.omit(m)
        completeMatrix[c,1] <- i
        completeMatrix[c,2] <- length(cleanMatrix[ ,2])
    }
    completeMatrix
   
}


correlation <- function (directory, treshold) {
    
    c <- 0
    completeMatrix <- complete("specdata")
    corr <- vector("numeric")
    totalPollutantMatrix <- matrix(nrow = 0, ncol=4)
    
    for (i in 1:332) {
        
        conc <- paste(directory, "/", i, ".csv", sep = "")
        m <- read.table(conc, header = TRUE, sep = ",", quote = "", , , , , , , , )
        cleanMatrix <- na.omit(m)
        
        if ( treshold <= length(cleanMatrix[ ,2]) ) {
            c <- c + 1
            corr[c] <- cor(cleanMatrix[ ,2], cleanMatrix[ ,3])
        }
    }
    corr
    
}




