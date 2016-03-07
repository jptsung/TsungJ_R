#1 Using the diamonds data set, I create plot that shows relationship of diamond weight to price
require("ggplot2") #loads ggplot package
?print
?print.ggplot

require("grid") #Loading required package: grid

## Prof G: need to require gridExtra, I've added here
require("gridExtra")

#Brings Diamonds data into memory
data(diamonds)
str(diamonds)

#Plot relationship of carat on price by color
carat_prc <-ggplot(diamonds, aes(x=carat,y=price)) #creates ggplot with data set diamonds
#assigns x axis as carat and y axis as price
#aes () creates a list of unevaluated expressions, partial name matching, converts color to colour

carat_prc <-carat_prc + labs(title='Diamonds - Weight to Price by Color') +
            theme(plot.title = element_text(size = rel(2), colour = 'blue')) +
            labs(x='Weight', y='Price') + geom_point(aes(color = factor(color)))
#adds title, colour, axis titles

print(carat_prc) #prints the plot of data set Diamonds with weight to price by color

#2 Removing the non-linearity, I replot with both price and weight log-transformed by taking natural log of both variables

carat_prc <- ggplot(diamonds, aes(x=log(carat), y=log(price))) #log transformation on the x and y
log_carat_prc <-carat_prc + labs(title = "Diamonds - Weight to Price (Linear)") + 
                theme(plot.title = element_text(size = rel(2), colour = "blue")) + 
                labs(x = "Weight", y = "Price") + geom_point(aes(color = factor(color)))
#assigns log_carat_prc to the log transformation and adds titles and colours

print(log_carat_prc) #prints the transformed plot

#3 Remove the linear trend (create a linear model and use the residuals on the y-axis
#create a plot using grid package to create a custom version of the plot
#histogram on the left is a density historgram of the price
#histogram on bottom is density histogram of carat

require(grid) #using grid package to create custom version of plothist
require(gridExtra) #using gridExtra package to arrange plots

retrend <- lm(log(price) ~ log(carat), data = diamonds) #removes the linear trend, creates linear model w/ residuals on y

diamonds$lprice2 <- resid(retrend) #assigns residuals of linear model to lprice2 variable

blank <- ggplot() #assigns blank to an empty vector
blank <- blank + geom_point(aes(1, 1), colour = "white") #adds geom point, used to create scatterplot
blank <- blank + theme(axis.ticks = element_blank(), panel.background = element_blank(), 
                       axis.text.x = element_blank(), axis.text.y = element_blank(), 
                       axis.title.x = element_blank(), axis.title.y = element_blank(), 
                       panel.grid = element_blank()) #This theme element draws nothing, and assigns no space

hist_carat <- ggplot(diamonds, aes(x=carat, fill=color)) #assigns hist_carat to the ggplot of carat in data set diamonds with color
hist_carat <- hist_carat + geom_histogram(bins = 1000, binwidth = 0.1)
hist_carat <- hist_carat + theme(legend.position = "none") + 
              labs(x = NULL, y = NULL, title = NULL)
#creates the histogram of carat with no titles, axis headers, or legend

plot <- qplot(log(carat), lprice2, data = diamonds, xlab = "Weight", ylab = "Price Residuals", 
              colour = factor(color), main = "Diamonds - Weight to Price by Color")
plot <- plot + theme(legend.box = "horizontal", legend.direction = "horizontal",legend.position = "top")
plot <- plot + theme(plot.title = element_text(colour = "blue", size = 30))

#creates a qplot with log(carat) and the residuals (lprice2) with diamonds data
#includes the legend on the top in a horizontal setting
#includes large blue plot title

hist_price <- ggplot(diamonds, aes(x=price, fill=color)) #assigns hist_price the ggplot of price in data set diamonds with color
hist_price <- hist_price + geom_histogram(binwidth = 50, aes(y = ..density..)) #sets binwidth to 50
hist_price <- hist_price + theme(legend.position = "none") #removes legend
hist_price <- hist_price + labs(x = NULL, y = NULL, title = NULL) #removes any header titles
hist_price <- hist_price + theme(axis.text.x = element_text(angle=90, vjust=0.5, 
                                                          hjust=0.5)) 
hist_price <- hist_price + theme(axis.text.y = element_text(angle=90, vjust=0.5, 
                                                          hjust=0.5))
#sets the axis numbers/units straight at correct incrememnts 
#using vertical and horizontal justifications

grid.arrange(arrangeGrob(hist_price + scale_y_reverse() + coord_flip(), plot, 
                         ncol=2, widths = c(1,3)), arrangeGrob(blank, hist_carat,
                          ncol=2, widths = c(1,3)), heights = c(3,1))
#arranges the three plots, reverses the y-axis scale on hist_price
#places graphs in appropriate spectrums ie c(1,3)

#4 Using grid package, using viewports, create overlays
require(grid)

hist_carat <- hist_carat + theme(plot.margin = unit(c(0, 0, 0, 0), units = "mm"))
#margin around entire plot (unit with the sizes of the top, right, bottom, and left margins)

hist_price <- hist_price + theme(plot.margin = unit(c(0, 0, 0, 0), units = "mm"))
#margin around entire plot (unit with the sizes of the top, right, bottom, and left margins)

pushViewport(viewport(layout = grid.layout(25,25))) #set the grid layout as 25 by 25 units
#using viewport functions create viewports
#describe rectangular regions on a graphics device and defines number of coordinate systems within those regions

print(plot, vp = viewport(layout.pos.row = 1:25, layout.pos.col = 1:25))
print(hist_carat, vp = viewport(layout.pos.row = 8:12, layout.pos.col = 17:24))
print(hist_price, vp = viewport(layout.pos.row = 19:23, layout.pos.col = 3:11))
#prints the hist_price and hist_carat on top of the plot through viewpoint

## Prof G: Did not print all of the plots?