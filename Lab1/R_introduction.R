##################
## Stat 312 R
## Anirban Mondal
## Introduction to R and simple EDA
##################

################################################
## R can function as a fancy calculator
a <- 3
exp(a)

x <- c(1,8,4)     # c() stands for column vector
y <- rep(4, times=3) # rep() is a handy function to create column vectors

exp(x)  # exponential of each element in x
log(x)  # natural logarithm of each element in x

## Matrix: 
A <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), 
            nrow=4, ncol=3)
# or: 
B <- matrix(1:12, 
       nrow=4, ncol=3, byrow=TRUE)
C <- diag(c(6,4,3))

diag(4)

## Matrix manipulations:
t(A)    # transpose

A %*% x #  '%*%' is used for matrix multiplication 
A %*% C
C %*% A # does not work
t(x) %*% x  # a scalar
x * x       # elementwise multiplication

det(C)   # determinant of C
solve(C) # inverse of C

################################################
## Multivariate data in R
## OBJECTS (entries in R)
## Intrinsic attributes of objects:
##    mode (numeric, complex, logical, character string...)
##    length (number of components)

## Examples: 
gender <- c("F", "F", "F", "M", "M")
height <- c(61, 66, 59, 70, 69)
sick <- c(FALSE, TRUE, TRUE, FALSE, TRUE)

## Missing data: NA
gender <- c("F", "F", "F", "M", "M", NA)

## Class of an R object
##    same as mode for vectors
##    Also: matrix, array, dataframe etc.

## Examples:
class(gender) # same as mode(gender)
class(height)
class(sick)
class(A)
mode(A)

## Length of an object:
length(gender)
length(A)
dim(A)

## Arrays in R:  multiple subscripted collections of items of the same mode
## Special cases:
##    1-dimensional (vector)
##    2-dimensional (matrix)
?array

## Lists: Groups of objects with different modes of classes
## Examples
Jones.Family <- list(name="Fred", 
                     spouse="Mary", 
                     no.children = 3, 
                     child.ages=c(4,7,9))
Jones.Family[[3]]
Jones.Family$no.children
class(Jones.Family)
length(Jones.Family)

## Data Frames: a special kind of list where the different components
##  are vectors of the same length but do not need to be of same mode
## Example:
gender <- c("F", "F", "F", "M", "M")
height <- c(61, 66, 59, 70, 69)
sick <- c(FALSE, TRUE, TRUE, FALSE, TRUE)
data <- data.frame(gender, height, sick)
data
class(data)
dim(data) # dimensions of data

## Subsetting
data[1,3]
data[1:3, ]  # Show rows 1 through 3 and all columns
data[ , 2] # second column
data$height

ls()  # list variables
rm(height, gender, sick)
ls()

attach(data)
height
detach(data)


## Set working directory
## Note: May have to replace "/" with "\" in Mac
##setwd("~//R_Codes_Data")

## Load the dataset. Set header=T if variable names are included in the file
UnivAdm <- read.table("APPENC04.txt")

## Getting to know the dataset:
class(UnivAdm) 		# read.table() returns a "data.frame"
dim(UnivAdm)		# size
head(UnivAdm)
names(UnivAdm)		# column names

## Set variable names:
names(UnivAdm) <- c("ID", "GPA", "HSrank", "ACT", "Year")
names(UnivAdm)

## Sub-setting
UnivAdm[1:10, ]  # Show rows 1 through 10 and all columns
UnivAdm$GPA		 # Gives only the GPA column
UnivAdm[4:10, "GPA"] 
UnivAdm[4:10, 2] 

UnivAdm$Year==1996
Y1996 <- UnivAdm[UnivAdm$Year==1996, ]

## Statistical summaries (continue in next class)
summary(UnivAdm)
mean(UnivAdm$GPA) # sample mean of GPA
median(UnivAdm$GPA) # sample median of GPA
sd(UnivAdm$GPA) # sample standard deviaion of GPA
var(UnivAdm$GPA) # sample variance of GPA

## A very useful function:
xbar <- apply(UnivAdm, 2, mean) # mean vector

## Histogram
hist(UnivAdm$GPA, xlab="GPA", main="")
hist(UnivAdm$GPA, xlab="GPA", main="My fancy histogram", 
     col='blue', density=10, breaks=20)
title("My fancy histogram")

## Two histograms
par(mfrow=c(1,2)) ## use par() to control how graphs look
hist(UnivAdm$GPA)
hist(UnivAdm$ACT)

## help on functions
?hist
help(hist)

## Boxplot
par(mfrow=c(1,2))
boxplot(UnivAdm$ACT)
boxplot(split(UnivAdm$ACT, UnivAdm$Year))

## Scatter plot - examine relationship between two variables
plot(UnivAdm$ACT, UnivAdm$GPA)
plot(UnivAdm$ACT, UnivAdm$GPA, xlab="ACT", ylab="GPA", 
     main="University admission data",
     pch=2, col="blue")

## To save as pdf:
pdf("Myplot.pdf")
plot(UnivAdm$ACT, UnivAdm$GPA, cex.lab=2)
dev.off()

## A quick look at all pairwise scatterplots
pairs(UnivAdm)

cov(UnivAdm)
cor(UnivAdm)

## some more stuff using ggplot

install.packages("ggplot2") ##install package
library(ggplot2) ##load package

ggplot(data=UnivAdm, mapping=aes(x=ACT, y=GPA, color=factor(Year))) + geom_point()
ggplot(data=UnivAdm, mapping=aes(x=ACT, y=GPA, color=HSrank)) + geom_point()

ggplot(data=UnivAdm, mapping=aes(x=ACT, y=GPA)) + geom_point()

