#Rading Files

x_test<-read.table(".//UCI HAR Dataset//test//X_test.txt")
y_test<-read.table(".//UCI HAR Dataset//test//y_test.txt")
subject_test<-read.table(".//UCI HAR Dataset//test//subject_test.txt")
x_train<-read.table(".//UCI HAR Dataset//train//X_train.txt")
y_train<-read.table(".//UCI HAR Dataset//train//y_train.txt")
subject_train<-read.table(".//UCI HAR Dataset//train//subject_train.txt")
features<-read.table(".//UCI HAR Dataset//features.txt")
activities<-read.table(".//UCI HAR Dataset//activity_labels.txt")

#Assigning Column Names

colnames(x_train)<-features[,2]
colnames(x_train)  #Just checking if the names are correct
colnames(y_train)<-"activity_id"
colnames(subject_train)<-"subject_id"
colnames(x_test)<-features[,2]
colnames(y_test)<-"activity_id"
colnames(subject_test)<-"subject_id"

#Merging Datasets

train_final<-cbind(y_train,subject_train,x_train)
test_final<-cbind(y_test,subject_test,x_test)
all_data<-rbind(train_final,test_final)
write.csv(all_data,"alldata.csv") #Just getting the feel of data :-)

# Subsetting only columns with means and standard deviation

k<-tolower(colnames(all_data))
reqcols<-(grepl("mean+",k) | grepl("std+",k) | grepl("activity_id",k) | grepl("subject_id",k))
sub_all_data<-all_data[,reqcols==TRUE]
#write.csv(sub_all_data,"sub.csv")
colnames(activities)<-c("activity_id","activity_descrp")

#write.csv(new_all_data,"final_data.csv")
# Aggregating with activity id and subject id

data1<- aggregate(sub_all_data, list(new_all_data$activity_id,new_all_data$subject_id),mean)
#write.csv(data1,"exp.csv")
final_data<-data1[,-c(3,4)]  
tidy<-merge(activities,final_data,by.x = "activity_id",by.y="Group.1",all.y=TRUE) #Adding descriptive activity name
#tidy text file
write.csv(tidy,"tidy.csv")
write.table(tidy,"tidy1.txt",row.names = FALSE)
