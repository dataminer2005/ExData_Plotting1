

### read data that was unzipped to the local folder
##  C:\Users\fangl_000\Desktop\Coursera\JHDS\Exploratory_data_analysis

## set working directory for this course
setwd("C:/Users/fangl_000/Desktop/Coursera/JHDS/Exploratory_data_analysis")

getwd()   # confirm work directory

## Reading the file from work dir
infile <- read.table("household_power_consumption.txt", header = TRUE, colClasses = "character", 
                     sep = ";", na.strings="?")
head(infile)   ## view basic structure

##change date format to use in subset

infile$Date <- as.Date(infile$Date, format="%d/%m/%Y")

## subset data for plot

plot_file <- subset(infile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

summary(plot_file)   # exam data
str(plot_file)

rm(infile)  # delete the input file after subset the data needed for plot

## change Global_active_power to numeric to be able to plot
plot_file$Global_active_power <- as.numeric(plot_file$Global_active_power)

## Converting dates
datetime <- paste(as.Date(plot_file$Date), plot_file$Time)
plot_file$Datetime <- as.POSIXct(datetime)

# Creating plot 3

with(plot_file, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Enery Sub Metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy plot1 to a plot3.png PNG file     

dev.copy(png, file = "plot3.png", height = 480, width = 480) 
dev.off()  # close the PNG device!


