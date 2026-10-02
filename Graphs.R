###### GRAPHS
library(psych)
library(DescTools)

### ABOUT ORIGINAL DATA AND THE FORMAT:
### the original data file includes gender, age and group number as first 3 variables
### followed by all 25 verbal labels which are split into the 3 groups
### Each row is an answer by a participant -- the selected point on the line

## Preparation

only_data <- data[,-c(1:3)] # leave out gender, age and group number 

## Calculating M and SD

descr <- describe(only_data)
stat_table <- data.frame(descr$mean, descr$sd)
names(stat_table) <- c("M", "SD")
rownames(stat_table) <- names(only_data)

stat_table$SDmin <- stat_table$M - stat_table$SD 
stat_table$SDmax <- stat_table$M + stat_table$SD 


## Calculate confidence intervals 95 %

CI_lower = descr$mean - (1.96 * descr$se)
CI_upper = descr$mean + (1.96 * descr$se)

CI_table <- data.frame(descr$mean, CI_lower, CI_upper)
names(CI_table) <- c("M", "CI_lower", "CI_upper")
rownames(CI_table) <- names(only_data)

## Making a chart for each group (frequency, intensity1, intensity2)

# select the labels which correspond with each group
frequency <- 1:8 
intensity1 <- 9:15
intensity2 <- 16:25

marker <- frequency # choose which group
group_name <- "xxx" #name the group

stat_table_group <- stat_table[marker,]
CI_table_group <- CI_table[marker,]

minimG <- min(stat_table_group$SDmin)
maximG <- max(stat_table_group$SDmax)

# draw chart
PlotDotCI(CI_table_group, xlim=c(minimG,maximG),
          pch =20,
          args.legend = NULL,
          main = group_name)

# flip the table due to different chart default settings
stat_table_group_flip <- stat_table_group[nrow(stat_table_group):1, ]

for (i in marker){
  lines(x=c(stat_table_group_flip[i,3],stat_table_group_flip[i,4]), y=c(i,i))
}