ls()
weights <- c(50, 60, 65, 82)
weights
animals <- c("mouse", "rat", "dog")
animals
#nmber of elements in an object
length(weights)
length(animals)

#find a class of an object
class(weights)
class(animals)

#structure gives the object class, rows (observations), columns (variables)
str(weights)
str(animals)

#adding elements to vectors
weights <- c(weights, 90)
weights  <- c(30, weights)

x <- 15
y <- 4
z <- c(x, y, weights)
z
mean(z)

#Find current directory
getwd()

#lists files in the current directory
list.files()

#move to a new directory use "setwd"
setwd("C:/Users/Sarah/Desktop/swc-wsu")

#Load files as objects
gapminder  <- read.csv("gapminder.csv")

#Gives the first few rows of data, by default it will show the first 6
#Can alter the rows shown by providing an integer as second part of argument
head(gapminder)
str(gapminder)

#subsetting can be done with square brackets
#indexing gives the first value
weights[1]
#also use the index to return the first few values
weights[1:3]
#dataframe is more complicated because you need to specify both rows and columns
#first row and firest column
gapminder[1, 1]
#first row, third column
gapminder[1,3]
#can also use $ to return a single variable(column)
gapminder$pop
#subset by category
#also if column is not specific, it will return all columns for that row
gapminder[gapminder$country == "Finland", ]
#countries and years where pop is <=100000
#Could use column numbers instead of names
gapminder[gapminder$pop <= 100000, c("country", "year")]
#subsets must be saved as objects to be used later
#coutnries with life expectancy greater than 80
gapminder[gapminder$lifeExp>80, "country"]

#install package