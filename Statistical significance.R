###### STATISTICAL SIGNIFICANCE TESTING 
library(psych)
library(lsr)

### ABOUT ORIGINAL DATA AND THE FORMAT:
### the original data file includes gender, age and group number as first 3 variables
### followed by all 25 verbal labels which are split into the 3 groups
### Each row is an answer by a participant -- the selected point on the line


## Loop to test statistical significance and cohen's d

df <- data[,-c(1:3)]
n <- ncol(df)
arrayP <- numeric(n)
arrayW <- numeric(n)
arrayD <- numeric(n)

# define as factors 
# "studij" refers to field of study
grp <- factor(data$studij, levels = c(1, 2), labels = c("psyc", "other"))

for (i in seq_len(n)){
  numX <- as.numeric(unlist(df[,i]))
  mwu <- wilcox.test(numX ~ grp)
  arrayP[i] <- mwu$p.value
  arrayW[i] <- mwu$statistic
  arrayD[i] <- cohensD(numX ~ grp)
}

# adjusting with the holm correction for multiple comparisons
pCorrect <- p.adjust(arrayP, method = "holm")

## Means by student group

M_psy <- colMeans(df[data$studij==1,])
M_othr <- colMeans(df[data$studij==2,])

## Creating the table with: labels, p, pcor and W statistic, and cohen's d

full_table <- data.frame(M_psy, M_othr, arrayW, arrayP, pCorrect, arrayD)
rownames(full_table) <- names(df[,1:25])
names(full_table) <- c("M_psy", "M_other", "W", "p-value", "corrected p-value", "cohen's d")

