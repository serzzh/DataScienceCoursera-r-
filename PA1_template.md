# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data
Here is R code unzipping, reading data from file and removing NA values

```r
unzip ('activity.zip')
data <- read.csv('activity.csv')
```


## What is mean total number of steps taken per day?
Calculating total steps a day and writing to a vector.  
1. Making a histogram of the total number of steps taken each day.

```r
daily <- tapply(data$steps, data$date, FUN=sum)
daily <- daily[complete.cases(daily)]
hist(daily)
```

![](PA1_template_files/figure-html/unnamed-chunk-2-1.png) 

2. Calculating and reporting the mean and median total number of steps taken per day

```r
mean(daily)
```

```
## [1] 10766.19
```

```r
median(daily)
```

```
## [1] 10765
```

## What is the average daily activity pattern?

1. Making a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
data1 <- data[complete.cases(data),]
ts <- tapply(data1$steps, as.factor(data1$interval), FUN=mean)
plot(names(ts),ts, type='l', xlab= 'Interval', ylab= 'Number of steps', col='green' , lwd=2)
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png) 

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
names(which.max(ts))
```

```
## [1] "835"
```

## Imputing missing values

Note that there are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)


```r
sum(is.na(data))
```

```
## [1] 2304
```

2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.  
I am going to use the mean for this 5-minute interval

```r
data1 <- data[complete.cases(data),]
ts <- tapply(data1[,1], as.factor(data1$interval), FUN=mean)
```

3. Create a new dataset that is equal to the original dataset but with the missing data filled in.


```r
new_data <- data
na <- is.na(new_data[,1])
new_data[na,1] <- ts[na]
```

4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?


```r
daily_n <- tapply(new_data$steps, new_data$date, FUN=sum)
daily_n <- daily[complete.cases(daily_n)]
hist(daily_n)
```

![](PA1_template_files/figure-html/unnamed-chunk-9-1.png) 

```r
mean(daily_n)
```

```
## [1] NA
```

```r
median(daily_n)
```

```
## <NA> 
##   NA
```

## Are there differences in activity patterns between weekdays and weekends?

For this part the weekdays() function may be of some help here. Use the dataset with the filled-in missing values for this part.

1. Create a new factor variable in the dataset with two levels -- "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.

2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). The plot should look something like the following, which was created using simulated data:
