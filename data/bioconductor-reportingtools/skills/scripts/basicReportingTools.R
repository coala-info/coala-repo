# Code example from 'basicReportingTools' vignette. See references/ for full tutorial.

### R code from vignette source 'basicReportingTools.Rnw'

###################################################
### code chunk number 1: makeBasicDataFrame
###################################################

my.df <- data.frame(EGID = c("103", "104", "105", "106", "107"),
                    RPKM = c(4, 5, 3, 100, 75),
                    DE = c("Yes", "Yes", "No", "No", "No"))
my.df


###################################################
### code chunk number 2: makeCSVFile (eval = FALSE)
###################################################
## library(ReportingTools)
## 
## csvFile <- CSVFile(shortName = "my_csv_file", 
##     reportDirectory = "./reports")
## publish(my.df, csvFile)


###################################################
### code chunk number 3: basicHTMLReport (eval = FALSE)
###################################################
## htmlRep <- HTMLReport(shortName = "my_html_file",
##     reportDirectory = "./reports")
## publish(my.df, htmlRep)
## finish(htmlRep)


###################################################
### code chunk number 4: reportingTwoTypes (eval = FALSE)
###################################################
## csvFile2 <- CSVFile(shortName = "my_csv_file2", 
##     reportDirectory = "./reports")
## htmlRep2 <- HTMLReport(shortName = 'my_html_file2',
## 	title="Publishing a data frame and csv file together",
##     reportDirectory = "./reports")
## publish(my.df, list(csvFile2, htmlRep2))
## finish(htmlRep2)


###################################################
### code chunk number 5: AddImage (eval = FALSE)
###################################################
## plot(my.df$EGID, my.df$RPKM, xlab="EGID", 
## 	ylab="RPKM", main="Scatter plot of RPKMs", col="blue")
## scatterPlot <- recordPlot()
## library(lattice)
## barPlot <- barchart(my.df$RPKM~my.df$EGID)  ##lattice plots behave slightly differently
## 	
## htmlRep3 <- HTMLReport(shortName = "my_html_file3", title="Adding a plot directly to the page",
##     reportDirectory = "./reports")
## publish(scatterPlot, htmlRep3, name = "scatterPlot")  
## publish("This is a bar plot", htmlRep3)
## publish(barPlot, htmlRep3, name = "barPlot")
## publish(my.df, htmlRep3, name="Table")
## finish(htmlRep3)


###################################################
### code chunk number 6: AddTextPlot (eval = FALSE)
###################################################
## png(filename="reports/barplot.png")
## barplot(my.df$RPKM, names.arg=my.df$EGID, xlab="EGID", 
## 	ylab="RPKM", main="Bar plot of RPKMs", col="blue")
## dev.off()
## 
## library(hwriter)
## htmlRep4 <- HTMLReport(shortName = "my_html_file4", title="Adding a link, text and image",
##     reportDirectory = "./reports")
## publish(hwrite("This is a link to Bioconductor", link = "http://www.bioconductor.org"), htmlRep4) 
## publish(hwrite("Bar chart of results", heading=2), htmlRep4)
## himg <- hwriteImage("barplot.png", link="barplot.png")
## publish(hwrite(himg, br=TRUE), htmlRep4)
## publish(hwrite("Results Table", heading=2), htmlRep4)
## publish(my.df, htmlRep4)
## finish(htmlRep4)


###################################################
### code chunk number 7: AddPlotLink (eval = FALSE)
###################################################
## imagename <- c()
## for (i in 1:nrow(my.df)){
## 	imagename[i] <- paste0("plot", i, ".png")
## 	png(filename = paste0("reports/", imagename[i]))
## 	plot(my.df$RPKM[i], ylab="RPKM", xlab = my.df$EGID[i], main = "RPKM Plot", col = "blue")
## 	dev.off()
## }
## my.df$Image <- hwriteImage(imagename, link = imagename, table = FALSE, width=100, height=100)
## my.df$Link <- hwrite(as.character(my.df$EGID), link = paste("http://www.ncbi.nlm.nih.gov/gene/",
##                as.character(my.df$EGID), sep = ''), table=FALSE)
## 
## htmlRep5 <- HTMLReport(shortName = "my_html_file5", 
##                        title = "Adding images and links to data frame directly",
##                        reportDirectory = "./reports")
## publish(my.df, htmlRep5)
## finish(htmlRep5)


###################################################
### code chunk number 8: AddPlotLinkFunctions (eval = FALSE)
###################################################
## ##this function adds 5 to each value of my.df$RPKMs 
## add5 <- function(object,...){
## 	object$plus5 <- object$RPKM+5
## 	return(object)
## }
## ##this function replaces the scatter plot images with new plots
## makeNewImages<-function(object,...){
## 	imagename <- c()
## 	for (i in 1:nrow(object)){
## 		imagename[i] <- paste0("plotNew", i, ".png")
## 		png(filename = paste0("reports/", imagename[i]))
## 		plot(object$RPKM[i], ylab = "RPKM", xlab = object$EGID[i],
##                      main = "New RPKM Plot", col = "red", pch = 15, cex=3)
## 		dev.off()
## 	}
## 	object$Image <- hwriteImage(imagename, link = imagename, table = FALSE, height=150, width=150)
## 	return(object)
## }
## ##This function removes the link column 
## removeLink <- function(object, ...){
## 	object <- subset(object, select = -Link)
## 	return(object)
## }
## ##This function links the EGID column to the entrez database 
## addEGIDLink <- function(object, ...){
## 	object$EGID <- hwrite(as.character(object$EGID), 
##                               link = paste0("http://www.ncbi.nlm.nih.gov/gene/",
##                                 as.character(object$EGID)), table = FALSE)
## 	return(object)
## }
## htmlRep6 <- HTMLReport(shortName = "my_html_file6", 
##                        title = "Manipulating the data frame directly",
##                        reportDirectory = "./reports")
## publish(my.df, htmlRep6, 
##         .modifyDF = list(add5, makeNewImages, removeLink, addEGIDLink))
## finish(htmlRep6)


###################################################
### code chunk number 9: multipleTables (eval = FALSE)
###################################################
## df2 <- data.frame(x = 1:5, y = 11:15)
## df3 <- data.frame(x = c("a", "b", "c"), y = 1:3)
## 
## htmlRep7 <- HTMLReport(shortName = "my_html_file7", title = "Many tables, one page",
##                        reportDirectory = "./reports")
## publish(my.df, htmlRep7, 
##         .modifyDF = list(add5, makeNewImages, removeLink, addEGIDLink), 
##         name = "Df1")
## publish(df2, htmlRep7, name = "Df2")
## publish(df3, htmlRep7, name = "Df3", pos = 2)
## finish(htmlRep7)


###################################################
### code chunk number 10: publishMatrix (eval = FALSE)
###################################################
## set.seed(123)
## my.mat <- matrix(rnorm(20), nrow=5)
## makeDF <- function(object, ...){
## 	df <- as.data.frame(object[-2,])
## 	names(df) <- paste0("New ", 1:4)
## 	return(df)
## } 
## htmlRep8 <- HTMLReport(shortName = 'my_html_file8', 
##                        title="Publishing objects that are not data frames",
##                        reportDirectory = "./reports")
## publish(my.mat, htmlRep8, .toDF = makeDF)
## finish(htmlRep8)


