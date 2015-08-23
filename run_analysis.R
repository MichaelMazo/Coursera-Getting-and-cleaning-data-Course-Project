#Creating a list of variables in X_test and X_train that we need
var<-rep("NULL",561)
var[c(c(1:6),c(41:46),c(121:126))]=NA

#reading X_test and X_train data. Reading only colums specified in "var" array
X<-read.table("test/X_test.txt",colClasses = var)
X<-rbind(X,read.table("train/X_train.txt",colClasses = var))

#reading activity numbers list
y<-read.table("test/y_test.txt")
y<-rbind(y,read.table("train/y_train.txt"))
#reading activity labels
activity_labels<-read.table("activity_labels.txt")
#replacing activity numbers by activity labels
y[,2]=activity_labels[y[,1],2]

#adding activity labels to X.
X<-cbind(y[,2],X)

#reading subject numbers
subject<-read.table("test/subject_test.txt")
subject<-rbind(subject,read.table("train/subject_train.txt"))

#adding subject to X
X<-cbind(subject,X)

#Adding names to columns
Names<-c("Subject","Activity",
         "BodyAcc-mean-X","BodyAcc-mean-Y","BodyAcc-mean-Z",
         "BodyAcc-std-X","BodyAcc-std-Y","BodyAcc-std-Z",
         "GravityAcc-mean-X","GravityAcc-mean-Y","GravityAcc-mean-Z",
         "GravityAcc-std-X","GravityAcc-std-Y","GravityAcc-std-Z",
         "Gyro-mean-X","Gyro-mean-Y","Gyro-mean-Z",
         "Gyro-std-X","Gyro-std-Y","Gyro-std-Z")
colnames(X)<-Names

#Creating data sets of averages
A<-aggregate(X[,3:20],by=list(X$Subject,X$Activity),FUN=mean)
colnames(A)[c(1,2)]=Names[c(1,2)]

#writing A to a file
write.table(A,file="Averages.txt",row.name=FALSE)