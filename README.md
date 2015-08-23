---
title: "Cleanin data from Human Activity Recognition Using Smartphones Dataset"
output: html_document
---

#Choosing variables
We choose variables corresponding to the mean and standart deviation of the Inertial signals. We can see the numbers we need readin the file "features.txt"
```{r}
read.table("features.txt")
```
The numbers are from 1 to 6, from 41 to 46, and from 121 to 126.

We create an array which we will use to read variables chosen above only
```{r}
var<-rep("NULL",561)
var[c(c(1:6),c(41:46),c(121:126))]=NA
```
#Readind an binding data
reading X_test and X_train data. Reading only colums specified in "var" array
```{r}
X<-read.table("test/X_test.txt",colClasses = var)
X<-rbind(X,read.table("train/X_train.txt",colClasses = var))
```

reading activity numbers list
```{r}
y<-read.table("test/y_test.txt")
y<-rbind(y,read.table("train/y_train.txt"))
```

reading activity labels
```{r}
activity_labels<-read.table("activity_labels.txt")
```

replacing activity numbers by activity labels
```{r}
y[,2]=activity_labels[y[,1],2]
```

adding activity labels to X.
```{r}
X<-cbind(y[,2],X)
```

reading subject numbers
```{r}
subject<-read.table("test/subject_test.txt")
subject<-rbind(subject,read.table("train/subject_train.txt"))
```

adding subject to X
```{r}
X<-cbind(subject,X)
```
#Adding names to variables
creating the list of names
```{r}
Names<-c("Subject","Activity",
         "BodyAcc-mean-X","BodyAcc-mean-Y","BodyAcc-mean-Z",
         "BodyAcc-std-X","BodyAcc-std-Y","BodyAcc-std-Z",
         "GravityAcc-mean-X","GravityAcc-mean-Y","GravityAcc-mean-Z",
         "GravityAcc-std-X","GravityAcc-std-Y","GravityAcc-std-Z",
         "Gyro-mean-X","Gyro-mean-Y","Gyro-mean-Z",
         "Gyro-std-X","Gyro-std-Y","Gyro-std-Z")
```

assigning names
```{r}
colnames(X)<-Names
```
#Creating data sets of averages
```{r}
A<-aggregate(X[,3:20],by=list(X$Subject,X$Activity),FUN=mean)
```
Need to fix names of first and second columns
```{r}
colnames(A)[c(1,2)]=Names[c(1,2)]
```

#Writing set of averages to a file
write.table(A,file="Averages.txt",row.name=FALSE)