#1. Create the vectors:
c(1:20) #a. creates vector 1,2,3,...,19,20
c(20:1) #b. creates vector 20,19,...,2,1
c(1:20,19:1) #c. creates vector 1,2,3,...,19,20,19,18,...,2,1
tmp <- c(4,6,3) #d. Assigns vector to tmp with values (4,6,3)
rep(tmp,t=10) #e. repeats tmp 10 times, so there are 10 occurences of 4
## Prof G: Works but not in a general way. Have to know
##         the values in tmp.
c(rep(tmp,t=10),4) #f. repeats tmp 10 times but includes a 4 at the end so there are 11 occurences of just 4
rep(tmp,times = c(10,20,30)) #g. repeats 4 in tmp have 10 occurences, 6 have 20 occurences, 3 have 30 occurences

#2. Create a vector of values
x<-seq(3,6,by=0.1) #assigns x to a sequence from 3 to 6 counting by 0.1
exp(x)*cos(x) #calculates e^x*cos(x)

#3.Create following vectors:

#3a.
y <- (0.1^seq(3,36,by=3)) #assigns y to 0.1 to the power of a sequence of exponents 3 to 36 that counts up by 3
z <- (0.2^seq(1,34,by=3)) #assigns z to 0.2 to the power of a sequence of exponents 1 to 34, counting by 3 
y*z #multiplies the two variables so that 0.1^3*0.2^1...0.1^36*0.2^34

#3b
a<-2^(1:25) #assigns a to 2 to the exponential sequence from 1 to 25
b<-(1:25) #assigns b to the sequence from 1 to 25
a/b #calculates 2^n and divides it by n, so 2, 2^2/2, 2^3/3... 

#4. Calculate the following

#4a.
i <- c(10:100) #assigns i to a sequence of 10 to 100, counting by 1
sum(i^3 + 4*i^2) #sums all the values in the given sequence (i^3+4i^2)

#4b.
i <- c(1:25) #assigns i to a sequence of 1 to 25, counting by 1
sum(2^i/i + 3^i/i^2) #sums all the values in the given sequence where i are 1 to 25

#5: Use function paste to create vectors of length 30

#5a. 
paste("label", sep = " ", c(1:30)) #creates character vector with pasting "label" with an increasing number; sep = " " so there is space between

#5b.
paste("fn", sep = "", c(1:30)) #creates vector with pasting fn with increasing numbers from 1 to 30, sep = "" to remove space between

#6: Execute lines which create two vectors of random integers with replacement from 0 to 999
set.seed(50) #given, specifies the seed at 50
xVec <- sample(0:999, 250, replace = T) #denotes x = (x1,x2,...xn), length 250
yVec <- sample(0:999, 250, replace = T) #denotes y = (y1,y2,...yn), length 250

#6a. Create the vector y2-x1,...,yn-xn-1
yVec[-1]-xVec[-length(xVec)] #creates vector where yVec skips first value (y1) and xVec skips last value (x250)

#6b. Create the vector siny1/cosx2...
sin(yVec[-length(yVec)])/cos(xVec[-1]) #creates vector where yVec skips last value (y250) and xvec skips first value (x1)

#6c. Create the vector x1+2x2-x3...
xVec[-c(249,250)]+2*xVec[-c(1,250)]-xVec[-c(1,2)]
#removes n = 249 and 250 for x1 + 2* removes when n = 1 and 250, - removes first two

#6d. Calculate the function
sum(exp(-xVec[-1])/(xVec[-length(xVec)]+10))
#calculates the sum of e^-x (where x skips first n) divided by xVec where it skips last value n

#7 Vectors xVec and yVec used in the following

#a. Pick out the values in yVec >600
yVec[yVec>600] #picks out the values in yVec that are greater than 600

#b. What are the index positions in yVec of the values > 600?
which(yVec > 600) #which command to dtermine index positions in yVec of the values >600

#c. What are the values in xVec which correspond to the values in yVec
xVec[yVec>600] #determines the values in xVec that correspond to yVec values >600 (same index positions)

#d. Creating a vector of absolutes
(abs(xVec-mean(xVec)))^0.5 #creates vector where the absolute value of the difference between xVec mean of x is square rooted

#e. How many values in yVec are within 200 of the max value of the terms in yVec
sum(yVec>max(yVec)-200) #calculates how many values in yVec are within 200 of the max value of terms in yVec
#sums the amount of numbers that have a value > max(y) - 200

#f. How many numbers in xVec are divisible by 2
sum(xVec%%2==0) #mod operator(%%) calculates the remainder when divided by 2; if divisible, then remainder = 0; function sums the number of values in xVec that are divisible by 2

#g. Sort numbers in vector xVec in the order of increasing values in yVec
xVec[order(yVec)] #order function puts yVec in increasing order and indexes it inside xVec to produce ordered vector 

#h. Pick out the elements in yVec at index positions 1,4,7,10,13...
yVec[seq(1,250,by=3)] #includes sequence from 1 to 250 differing by 3 units and place sequence in index position for yVec to create sequence

#8. Using function cumprod to calculate function
num <- seq(2,38,by=2) #assigns num to sequence of 2 to 38 differing by 2 units
den <- seq(3,39,by=2) #assigns den to sequence of 3 to 39 differing by 2 units
1+sum(cumprod(num/den)) #cumprod() function to calculate cumulative product of each item
#sum the items and add 1 for the first part to get solution