# Code example from 'LinkHD' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE,tidy=TRUE----------------------
suppressPackageStartupMessages({
library('LinkHD')
})

## ----results=' hide',eval=FALSE,tidy=TRUE-------------------------------------
# #if you don't have devtools, please install it:
# install.packages("devtools")
# #if devtools is already installed, ommit previous step
# library(devtools)
# devtools::install_github(repo ="lauzingaretti/LinkHD" ,dependencies = TRUE)
# library(LinkHD)

## ----results=' hide',eval=FALSE,tidy=TRUE-------------------------------------
#  ?? LinKData()

## ----message=FALSE,tidy=TRUE--------------------------------------------------
library(LinkHD)

## ----tidy=TRUE----------------------------------------------------------------
data("Taraoceans")
data(Taraoceans)
pro.phylo <- Taraoceans$taxonomy[ ,"Phylum"]
TaraOc<-list(Taraoceans$phychem,as.data.frame(Taraoceans$pro.phylo),
             as.data.frame(Taraoceans$pro.NOGs))
TaraOc_1<-scale(TaraOc[[1]])
Normalization<-lapply(list(TaraOc[[2]],TaraOc[[3]]),
                      function(x){DataProcessing(x,Method="Compositional")})
colnames(Normalization[[1]])=pro.phylo
colnames(Normalization[[2]])=Taraoceans$GO
TaraOc<-list(TaraOc_1,Normalization[[1]],Normalization[[2]])
names(TaraOc)<-c("phychem","pro_phylo","pro_NOGs")
TaraOc<-lapply(TaraOc,as.data.frame)
TaraOc<-lapply(TaraOc,as.data.frame)
Tara_Out<-LinkData(TaraOc,Scale =FALSE,Center=FALSE,Distance = c("ScalarProduct","Euclidean","Euclidean"))

## ----tidy=TRUE----------------------------------------------------------------
CompromisePlot(Tara_Out)+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                               panel.background = element_blank(), axis.line = element_line(colour = "black"))

## ----tidy=TRUE----------------------------------------------------------------
CorrelationPlot(Tara_Out) +
 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(colour = "black"))

## ----tidy=TRUE----------------------------------------------------------------
Selection<-VarSelection(Tara_Out,TaraOc,Crit="Rsquare",perc=0.95)

## ----tidy=TRUE----------------------------------------------------------------
library(reshape2)
Ds<-as.data.frame(table(Variables(Selection)))
ggplot(Ds, aes(x=Var1, y = Freq)) +
  geom_bar(stat="identity", fill="steelblue") +
  ggpubr::rotate_x_text(45)


## ----results='hide',eval=FALSE,tidy=TRUE--------------------------------------
# library(LinkHD)
# data("Ruminotypes")

## ----results='hide', message=FALSE, warning=FALSE,tidy=TRUE----
library("LinkHD")
library("ggplot2")
options(width =50)

## ----tidy=TRUE----------------------------------
data("Ruminotypes")

## ----tidy=TRUE----------------------------------
Normalization<-lapply(list(Ruminotypes$`16_S`,Ruminotypes$Archaea,Ruminotypes$`18_S`)
                      ,function(x){DataProcessing(x,Method="Compositional")})
Dataset<-Normalization
names(Dataset)<-c("16_S","Archaea","18_S")

## ----tidy=TRUE----------------------------------
library(MultiAssayExperiment)
library(LinkHD)
data("Ruminotypes")
Normalization<-lapply(list(Ruminotypes$`16_S`,Ruminotypes$Archaea,Ruminotypes$`18_S`),
                      function(x){DataProcessing(x,Method="Compositional")})
Dataset<-Normalization
names(Dataset)<-c("16_S","Archaea","18_S")
Dataset<-MultiAssayExperiment(experiments = Dataset)

## ----tidy=TRUE----------------------------------
Output<-LinkData(Dataset,Distance=rep("euclidean",3),Scale = FALSE,Center=FALSE,nCluster = 3)
#variance explained by compromise coordinates
CompromisePlot(Output)+theme(panel.grid.major = element_blank(),
panel.grid.minor = element_blank(),
panel.background = element_blank(),
axis.line = element_line(colour="black"))

## ----eval=FALSE,tidy=TRUE-----------------------
# B<-ExpressionSet()
# Dataset1<-Normalization
# A<-lapply(Dataset1,as.matrix)
# B<-lapply(A,ExpressionSet)
# Output_<-LinkData(B,Distance=rep("euclidean",3),Scale = FALSE,Center=FALSE,nCluster = 3)

## ----message=FALSE,tidy=TRUE--------------------
GlobalPlot(Output)

## ----tidy=TRUE----------------------------------
CorrelationPlot(Output)

## ----tidy=TRUE----------------------------------
mydata=compromise_coords(Output)
#set colors
cols <- c("1" = "red", "2" = "blue", "3" = "orange")
mydata$fit.cluster<-as.factor(mydata$fit.cluster)
p<-ggplot(mydata, aes(Dim.1,Dim.2)) +
geom_point(aes(colour = fit.cluster))
p + scale_colour_manual(values = cols) + theme_classic() 

## ----message=FALSE,tidy=TRUE--------------------
library( emmeans)
Dat<-data.frame("y"=Ruminotypes$phenotype$ch4y,"E"=as.factor(mydata$fit.cluster))
s=lm(y~E,data=Dat)
#summary(s)
lsmeans(s, "E")
pairs(lsmeans(s, "E"))

## ----message=FALSE,tidy=TRUE--------------------
Select_Var<-VarSelection(Output,Data=Dataset,Crit = "Rsquare",perc=0.9)

## ----message=FALSE,tidy=TRUE--------------------
M<-dAB(Output,Data=Dataset)

## ----message=FALSE,tidy=TRUE--------------------
#Select only the selected variables form Select_Var object
SelectedB_16S<-Variables(Select_Var)[VarTable(Select_Var)=="16_S"]
SelectedB_Archaea<-Variables(Select_Var)[VarTable(Select_Var)=="Archaea"]
SelectedB_18S<-Variables(Select_Var)[VarTable(Select_Var)=="18_S"]

## ----message=FALSE,tidy=TRUE--------------------
Selec_16S<-as.matrix(Ruminotypes[[1]][,colnames(Dataset[[1]])%in%names(M[[1]])])
Selec_Archaea<-as.matrix(Ruminotypes[[2]][,colnames(Dataset[[2]])%in%names(M[[2]])])
Selec_18S<-as.matrix(Ruminotypes[[3]][,colnames(Dataset[[3]])%in%names(M[[3]])])

## ----message=FALSE,tidy=TRUE--------------------
library(reshape2)
SignTaxa<-OTU2Taxa(Selection=VarTable(Select_Var),TaxonInfo=Ruminotypes$Taxa_16S,
                   tableName="16_S",AnalysisLev = "Family")
melted_Table <- melt(SignTaxa$TotalUp1)
ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
  scale_fill_gradient(low = "steelblue",
                      high = "#63D2E4",na.value="steelblue") +
  geom_bar(stat="identity", fill="#63D2E4")+
  theme_classic()+
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  ggpubr::rotate_x_text(90)+
  theme(axis.text.x=element_text(size=rel(1.5)))

## ----message=FALSE,tidy=TRUE--------------------
SignTaxa<-OTU2Taxa(Selection=M,TaxonInfo=Ruminotypes$Taxa_16S,tableName="16_S",AnalysisLev = "Family")
melted_Table <- melt(SignTaxa$TotalUp1)
ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
  scale_fill_gradient(low = "steelblue",
                      high = "#FF0066",na.value="steelblue") +
  theme_classic()+
  geom_bar(stat="identity", fill=  "#56B4E9" )+
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  ggpubr::rotate_x_text(90) +
  theme(axis.text.x=element_text(size=rel(0.9)))

## ----message=FALSE,tidy=TRUE--------------------
Rumin<-which(Ruminotypes$Taxa_16S[Ruminotypes$Taxa_16S$OTUID%in%SelectedB_16S,]$Family=="Ruminococcaceae")
OTUs<-Ruminotypes$Taxa_16S[Ruminotypes$Taxa_16S$OTUID%in%SelectedB_16S,][Rumin,]$OTUID
Rumin_Tot<-Dataset[['16_S']][,colnames(Dataset[['16_S']])%in%OTUs]
RuminSum<-apply(Rumin_Tot,1,sum)

Total<-data.frame(RuminSum,"Group"=as.factor(compromise_coords(Output)$fit.cluster))
p <- ggplot(Total, aes(x=Group, y=RuminSum, fill=Group)) +
  geom_boxplot()+
  scale_fill_manual(values=c("Tomato", "Orange", "DodgerBlue"))+
  theme_classic()+ ggtitle(paste("Differences at level",rownames(melted_Table)[16]))
p


## ----message=FALSE,tidy=TRUE--------------------
Christ<-which(Ruminotypes$Taxa_16S[Ruminotypes$Taxa_16S$OTUID%in%SelectedB_16S,]$Family==rownames(melted_Table)[14])
OTUs<-Ruminotypes$Taxa_16S[Ruminotypes$Taxa_16S$OTUID%in%SelectedB_16S,][Christ,]$OTUID
Christ_Tot<-Dataset[['16_S']][,colnames(Dataset[['16_S']])%in%OTUs]
ChristSum<-apply(Christ_Tot,1,sum)
Total<-data.frame(ChristSum,"Group"=as.factor(compromise_coords(Output)$fit.cluster))
p <- ggplot(Total, aes(x=Group, y=ChristSum, fill=Group)) +
  geom_boxplot()+
  scale_fill_manual(values=c("Tomato", "Orange", "DodgerBlue"))+
  theme_classic()+ ggtitle(paste("Differences at level",rownames(melted_Table)[14]))
p

## ----message=FALSE,tidy=TRUE--------------------
ggplot(Total, aes(x=Group, y=rownames(Total), fill=ChristSum)) +
  geom_tile() + scale_fill_gradient(low = "steelblue",
                                    high = "#FF0066",na.value="steelblue") +
  ggpubr::rotate_x_text(45)+
  theme_classic() +
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  theme(axis.text.y=element_text(size=rel(0.6)))


## ----message=FALSE,tidy=TRUE--------------------
Succi<-which(Ruminotypes$Taxa_16S[Ruminotypes$Taxa_16S$OTUID%in%SelectedB_16S,]$Family=="Succinivibrionaceae")
OTUs<-Ruminotypes$Taxa_16S[Ruminotypes$Taxa_16S$OTUID%in%SelectedB_16S,][Succi,]$OTUID
Succi_Tot<-Dataset[['16_S']][,colnames(Dataset[['16_S']])%in%OTUs]
SucciSum<-apply(Succi_Tot,1,sum)

Total<-data.frame(SucciSum,"Group"=as.factor(compromise_coords(Output)$fit.cluster))
Total<-Total[- which(Total[,1]>1),]
p <- ggplot(Total, aes(x=Group, y=SucciSum, fill=Group)) +
  geom_boxplot()+
  scale_fill_manual(values=c("#e46563", "#357fe3", "#75e463"))+
  theme_classic()+ ggtitle(paste("Differences at level","Succinivibrionaceae"))+
   theme(axis.text.x=element_text(size=rel(1.5)),legend.title=element_text(size=rel(1.5)), 
        legend.text=element_text(size=rel(1.5)))
p

## ----message=FALSE,tidy=TRUE--------------------
SignTaxa<-OTU2Taxa(Selection=VarTable(Select_Var),
                   TaxonInfo=Ruminotypes$Taxa_18S,tableName="18_S")
melted_Table <- melt(SignTaxa$TotalUp1)
ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
  scale_fill_gradient(low = "steelblue",
                      high = "#B848DB",na.value="steelblue") +
  geom_bar(stat="identity", fill="#B848DB")+
  theme_classic()+
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  ggpubr::rotate_x_text(90)+
  theme(axis.text.x=element_text(size=rel(1.5)))

## ----message=FALSE,tidy=TRUE--------------------
SignTaxa<-OTU2Taxa(Selection=M,TaxonInfo=Ruminotypes$Taxa_18S,tableName="18_S")
melted_Table <- melt(SignTaxa$TotalUp1[SignTaxa$TotalUp1>1])
ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
scale_fill_gradient(low = "steelblue",
                      high = "#FF0066",na.value="steelblue") +
  geom_bar(stat="identity", fill=  "#56B4E9" )+
  theme_classic()+
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  ggpubr::rotate_x_text(90)+
  theme(axis.text.x=element_text(size=rel(0.8)))

## ----message=FALSE,tidy=TRUE--------------------
Dip<-which(Ruminotypes$Taxa_18S[Ruminotypes$Taxa_18S$OTUID%in%SelectedB_18S,]$Genus=="Diplodinium")
OTUs<-Ruminotypes$Taxa_18S[Ruminotypes$Taxa_18S$OTUID%in%SelectedB_18S,][Dip,]$OTUID
Dip_Tot<-Dataset[['18_S']][,colnames(Dataset[['18_S']])%in%OTUs]
DipSum<-apply(Dip_Tot,1,sum)

Total<-data.frame(DipSum,"Group"=as.factor(compromise_coords(Output)$fit.cluster))


p <- ggplot(Total, aes(x=Group, y=DipSum, fill=Group)) +
  geom_boxplot()+
  scale_fill_manual(values=c("Tomato", "Orange", "DodgerBlue"))+
  theme_classic()+ ggtitle(paste("Differences at level","Diplodinium"))
p


## ----message=FALSE,tidy=TRUE--------------------
ggplot(Total, aes(x=Group, y=rownames(Total), fill=DipSum)) +
  geom_tile() + scale_fill_gradient(low = "steelblue",
                                    high = "#FF0066",na.value="steelblue") +
  ggpubr::rotate_x_text(45)+
  theme_classic() +
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  theme(axis.text.y=element_text(size=rel(0.6)))

## ----message=FALSE,warning=FALSE,tidy=TRUE------

SignTaxa<-OTU2Taxa(Selection=VarTable(Select_Var),TaxonInfo=Ruminotypes$Taxa_Archaea,tableName="Archaea")
melted_Table <- melt(SignTaxa$TotalUp1)
ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
  scale_fill_gradient(low = "steelblue",
                      high = "#46D6AD",na.value="steelblue") +
  geom_bar(stat="identity", fill="#46D6AD")+
  theme_classic()+
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  ggpubr::rotate_x_text(90)+
  theme(axis.text.x=element_text(size=rel(1.5)))


## ----message=FALSE,warning=FALSE,tidy=TRUE------
SignTaxa<-OTU2Taxa(Selection=M,TaxonInfo=Ruminotypes$Taxa_Archaea,tableName="Archaea")
melted_Table <- melt(SignTaxa$TotalUp1)
ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
  scale_fill_gradient(low = "steelblue",
                      high = "#FF0066",na.value="steelblue") +
  geom_bar(stat="identity", fill=  "#56B4E9" )+
  theme_classic()+
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  ggpubr::rotate_x_text(90)+
  theme(axis.text.x=element_text(size=rel(0.9)))


## ----message=FALSE,warning=FALSE,tidy=TRUE------

Met<-which(Ruminotypes$Taxa_Archaea[Ruminotypes$Taxa_Archaea$OTU%in%SelectedB_Archaea,]$Genus==levels(Ruminotypes$Taxa_Archaea$Genus)[4])
OTUs<-Ruminotypes$Taxa_Archaea[Ruminotypes$Taxa_Archaea$OTU%in%SelectedB_Archaea,][Met,]$OTU
Met_Tot<-Dataset[['Archaea']][,colnames(Dataset[['Archaea']])%in%OTUs]
MetSum<-apply(Met_Tot,1,sum)
Total<-data.frame(MetSum,"Group"=as.factor(compromise_coords(Output)$fit.cluster))
p <- ggplot(Total, aes(x=Group, y=MetSum, fill=Group)) +
  geom_boxplot()+
  scale_fill_manual(values=c("Tomato", "Orange", "DodgerBlue"))+
  theme_classic()+ ggtitle(paste("Differences at level","Methanobrevibacter"))
p


## ----message=FALSE,warning=FALSE,tidy=TRUE------
ggplot(Total, aes(x=Group, y=rownames(Total), fill=MetSum)) +
  geom_tile() + scale_fill_gradient(low = "steelblue",
                                    high = "#FF0066",na.value="steelblue") +
  ggpubr::rotate_x_text(45)+
  theme_classic() +
  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
  theme(axis.text.y=element_text(size=rel(0.6)))

## ----message=FALSE,warning=FALSE,eval=FALSE,tidy=TRUE----
# #library("readxl")
# #library("XLConnect")
# #library("openxlsx")
# 
# # Download the list from supplementary material:
# #temp = tempfile(fileext = ".xls")
# #dataURL <- "https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fjbg.12427&file=jbg12427-sup-0004-TableS4.xls"
# #download.file(dataURL, destfile=temp, mode='wb')
# #SPLS_DA<-read_excel(temp,sheet=1)
# #SPLS<-read_excel(temp,sheet=2)
# 
# #Create a list with selected OTU. Note that if you have only one table, the list should have lenght equal to 1.
# 
# #Selected_OTU<-list("SPLS"=SPLS$OTU,"SPLS_DA"=SPLS_DA$OTU)
# # OTUs have to be the lists names:
# #names(Selected_OTU$SPLS)<-SPLS$OTU
# #names(Selected_OTU$SPLS_DA)<-SPLS_DA$OTU
# 
# 
# #TaxonInfo is the same than 16_S taxon info into Ruminotypes dataset:
# #Apply OTU2Taxa
# #SignTaxa<-OTU2Taxa(Selection=Selected_OTU,TaxonInfo=Ruminotypes$Taxa_16S,tableName="SPLS",AnalysisLev = "Family")
# #SignTaxa2<-OTU2Taxa(Selection=Selected_OTU,TaxonInfo=Ruminotypes$Taxa_16S,tableName="SPLS_DA",AnalysisLev = "Family")
# 
# 
# 
# #melted_Table <- melt(SignTaxa2$TotalUp1)
# #ggplot(data =melted_Table, aes(x= reorder(rownames(melted_Table), -value), y=value)) +
# #scale_fill_gradient(low = "steelblue",high = "#FF0066",na.value="steelblue") +
# #  theme_classic()+
# #  geom_bar(stat="identity", fill=  "#ff661a" )+
# #  theme( axis.ticks = element_blank(),axis.title.x=element_blank(),axis.title.y = element_blank())+
# #  ggpubr::rotate_x_text(90) +
# #  theme(axis.text.x=element_text(size=rel(0.9)))

