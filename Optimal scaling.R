###### OPTIMAL SCALING
library(Gifi)

### ABOUT ORIGINAL DATA AND THE FORMAT:
### data is a table where columns are item names 
### and rows are choices by participant, 
### representing to which degree they agree or disagree with an statement


## Defining variables 

df <- data # choose the data frame
k <- 5 # number of categories, replace x with number
p <- 15 # number of items, replace xx with number
vpr <- "xxx" # replace with the name of the questionnaire
post <- c(2,9,11,13,15) # define the variables that are reverse-scored
up <- 100 # upper limit for interpolation

# define category names, replace label with name 
c_names <- c("label1", "label2", "label3",
             "label4", "label5")


## Optimal scaling

princ <- princals(df, ndim = 1)
quant <- princ$quantifications

## Creating a quantifications table

tbl <- matrix(NA,nrow = k,ncol=p)

for(t in 1:p){
  if(length(quant[[t]])==k){         
    tbl[,t] <- quant[[t]]
  }else{                                   
    tt <-quant[[t]]
    for(i in 1:k){
      if(length(tt[which(rownames(tt)==i)])){
        tbl[i,t] <- tt[which(rownames(tt)==i)]}
    }
  }
  
}
colnames(tbl) <- paste0(vpr, 1:p)

# only in case the table needs to be reversed:
#tbl <- tbl * -1 

# only in the case of reverse-scored items:
tbl <- as.data.frame(tbl)
for(num in post) {
  tbl[num] <- tbl[num] * -1
}


## Equating difficulty

tbl0 <- tbl
for(j in 1:p){
  tbl0[,j] <- tbl0[,j] - mean(tbl0[,j], na.rm=TRUE)
}

# applying category names
rownames(tbl0) <- c_names


## Calculating

# mean scale values
plv <- rowMeans(tbl0, na.rm=TRUE)
round(plv, 3)

# variability
plv_sd <- apply(tbl0, 1, sd, na.rm=TRUE)
round(apply(tbl0, 1, sd, na.rm=TRUE), 3)

# distances
distance <- rep(NA,k-1)
for(i in 1:k-1){
  distance[i] <- plv[i+1] - plv[i]
}
round(distance,3) 

## Dot chart

dotchart(tbl0[,1], labels = rownames(tbl0), 
         xlim=c(min(tbl0, na.rm=TRUE),max(tbl0, na.rm=TRUE)), main = vpr)
for(j in 2:p){
  points(tbl0[,j], 1:k)
}
points(plv, 1:k, pch=18)

## Interpolation

b <- up/(plv[k] - plv[1])
a <- -b*plv[1]

plv_trans <- a + b*plv
round(plv_trans)

