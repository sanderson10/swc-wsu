#load ggplot2 library and gapminder data
library(ggplot2)
gapminder <- read.csv("gapminder.csv")

#scatterplot of lifeExp vs gdpPercap
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + geom_point()
#Two major parts of ggplot are aes and geom_point
#First part of plot is aes=aesthetics, define columns in data as some attribute in the plot
#This is setting up the plot
#Second part of plot is the geometric objects (geoms) of plot through geom_point 
#which is creating dot for each observations
#The ggplot command is making a graphical object that the other parts of command are adding to
p<-ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))
p2<-p + geom_point()
print(p2)
#can create each layer and add individually, print makes display of data

#Third part of ggplot are scales that allow transforming data
#Make x-axis have long scale 
p3 <- p + geom_point() + scale_x_log10()
print(p3)
#Could also transform data in the aes section, but axes will be labelled differently
ggplot(gapminder, aes(x=log10(gdpPercap), y=lifeExp)) + geom_point()

#Challenge 1
#Make a scatterplot of life expectancy vs gdpPercap with only for the data with China
China <- gapminder[gapminder$country == "China", ]
ggplot(China, aes(x=gdpPercap, y=lifeExp)) +geom_point() + scale_x_log10()
#Could also
gapminder %>%
  filter(country == "China") %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10()

#All arguments thus far can take additional arguments
gapminder %>%
  filter(country == "China") %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) + geom_point(size = 3) + scale_x_log10()

#Aesthetics includes the x and y variables, size/color other aspects of points could be related to data
#Example: points could be colored by continent
#alpha is another Aesthetic, this changes the transparency
p <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))+ geom_point() + scale_x_log10() 
p2 <- p + aes(color=continent)
print(p2)

#geoms are not connected back to data
#If symbolizing by data, done through aes

#Challenge 2->Try out the size, shape, and color aesthetics, both with categorical and numeric variables
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) + geom_point() + scale_x_log10()

#Can change the geom to points, lines; each of which is a layer
#These will stack on each other with later layers on top of earlier ones
#Aesthetics will apply to all geom layers
gapminder %>%
  filter(country == "China") %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) + geom_point(color="blue", size = 3) + geom_line(color="violetred")
#To only have an aesthetic apply to one geom, can add aesthetics within geom
gapminder %>%
  filter(country == "China") %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(aes(color=year), size = 3) + 
  geom_line(color="violetred")

#Challenge 3->plot of ifeExp v gdpPercap for China and India with lines in black and points colored by country
#Several ways to do "or" in code in order to get China and India
#   The %in% -> country %in% c("China", "India")
#   The pipe (|) -> country("China) | country("India")
#   Coded
#aes of group allows symbolizing the data by a categorical variable
gapminder %>%
  filter(country %in% c("China", "India")) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(aes(color=country), size = 3) + 
  geom_line(aes(group=country),color="black")

#ggplot plots more than just scatter plots, e.g. histogram
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=lifeExp)) + geom_histogram(binwidth=2.5, fill="blue", color="black")
#or a boxplot but boxplots need two variables (x and y), wants x to be categorical
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=continent, y=lifeExp)) + geom_boxplot(binwidth=2.5, fill="blue", color="black") + coord_flip()

#coord_flip will turn your plot so it is horizontal instead of vertical and vice versa
#Do not use an == if you are trying to include more than one group

#Scatterplot with jitter allows you to see points more clearly thanks to off-set by jitter
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=continent, y=lifeExp)) + geom_point(position=position_jitter(width=0.1, height=0))

#Can put both histogram and scatter with jitter together
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=continent, y=lifeExp)) + geom_boxplot(binwidth=2.5, fill="blue", color="black") + geom_point(position=position_jitter(width=0.1, height=0))

#Faceting splits plot into multiple boxes
#facet_grid and facet_wrap
#facet_grid can take 2 variables and split data by both
gapminder %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() + facet_grid(continent ~ year)
#facet_wrap will wrap plots around onto multiple lines
gapminder %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent)) + geom_point() + scale_x_log10() + facet_wrap(~year)

#Challenge 5-> select 5 countries of interest and plot lifeExp v gdpPercap across time with (geom_lint), 
#faceting by country
gapminder %>%
  filter(country %in% c("Canada", "Tanzania", "Sweden", "Norway", "Kenya")) %>%
  ggplot(aes(y=lifeExp, x=gdpPercap)) + geom_point() + geom_line(aes(group=country)) + 
  facet_wrap(~country) + scale_x_log10() 
  
ggsave("~/swc-wsu/fivecountries.pdf", height=7, width=10)
#Themes can be added to change the style of ggplots
#Package of ggthemes has even more themes to choose from

#Saving a plot
#ggsave(file location name, file name with extension, height, width)
