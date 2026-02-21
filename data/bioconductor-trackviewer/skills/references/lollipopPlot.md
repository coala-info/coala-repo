# trackViewer Vignette: lollipopPlot

#### Jianhong Ou, Lihua Julie Zhu

#### 30 October 2025

Abstract

Visualize methylation or mutation sites along with annotation as track layers.

# Lolliplot

Lolliplot is for the visualization of the methylation/variant/mutation data.

```
library(trackViewer)
SNP <- c(10, 12, 1400, 1402)
sample.gr <- GRanges("chr1", IRanges(SNP, width=1, names=paste0("snp", SNP)))
features <- GRanges("chr1", IRanges(c(1, 501, 1001),
                                    width=c(120, 400, 405),
                                    names=paste0("block", 1:3)))
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
## More SNPs
SNP <- c(10, 100, 105, 108, 400, 410, 420, 600, 700, 805, 840, 1400, 1402)
sample.gr <- GRanges("chr1", IRanges(SNP, width=1, names=paste0("snp", SNP)))
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
## Define the range
lolliplot(sample.gr, unname(features), ranges = GRanges("chr1", IRanges(104, 109)))
```

![](data:image/png;base64...)

## Change the lolliplot color

### Change the color of the features.

```
features$fill <- c("#FF8833", "#51C6E6", "#DFA32D")
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

### Change the color and opacity of the lollipop.

```
sample.gr$color <- sample.int(6, length(SNP), replace=TRUE)
sample.gr$border <- sample(c("gray80", "gray30"), length(SNP), replace=TRUE)
sample.gr$alpha <- sample(100:255, length(SNP), replace = TRUE)/255
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

## Add the index labels in the node

Users can control the node labels one by one by setting metadata start with ‘node.label.’ Please note that for each node label, the node.label.gp must be a list to control the style of node labels. You can also simply use node.label.col, node.label.cex, node.label.fontsize, node.label.fontfamily, node.label.fontface, node.label.font to assign the node labels attributes.

```
sample.gr$node.label <- as.character(seq_along(sample.gr))
sample.gr$node.label.col <-
  ifelse(sample.gr$alpha>0.5 | sample.gr$color==1, "white", "black")
sample.gr$node.label.cex <- sample.int(3, length(sample.gr), replace = TRUE)/2
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
sample.gr$node.label.cex <- 1 ## change it back for pretty showcase.
```

## Change the height of the features

```
features$height <- c(0.02, 0.05, 0.08)
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
## Specifying the height and its unit
features$height <- list(unit(1/16, "inches"),
                        unit(3, "mm"),
                        unit(12, "points"))
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

## Plot multiple transcripts in the features

The metadata ‘featureLayerID’ are used for drawing features in different layers.

```
features.mul <- rep(features, 2)
features.mul$height[4:6] <- list(unit(1/8, "inches"),
                                 unit(0.5, "lines"),
                                 unit(.2, "char"))
features.mul$fill <- c("#FF8833", "#F9712A", "#DFA32D",
                       "#51C6E6", "#009DDA", "#4B9CDF")
end(features.mul)[5] <- end(features.mul[5])+50
features.mul$featureLayerID <-
    paste("tx", rep(1:2, each=length(features)), sep="_")
names(features.mul) <-
    paste(features.mul$featureLayerID,
          rep(1:length(features), 2), sep="_")
lolliplot(sample.gr, features.mul)
```

![](data:image/png;base64...)

```
## One name per transcript
names(features.mul) <- features.mul$featureLayerID
lolliplot(sample.gr, features.mul)
```

![](data:image/png;base64...)

## Change the height of a lollipop plot

```
#Note: the score value is an integer less than 10
sample.gr$score <- sample.int(5, length(sample.gr), replace = TRUE)
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
##Remove y-axis
lolliplot(sample.gr, features, yaxis=FALSE)
```

![](data:image/png;base64...)

```
#Try a score value greater than 10
sample.gr$score <- sample.int(15, length(sample.gr), replace=TRUE)
sample.gr$node.label <- as.character(sample.gr$score)
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
#increase the cutoff value of style switch.
lolliplot(sample.gr, features, lollipop_style_switch_limit=15)
```

![](data:image/png;base64...)

```
#Try a float numeric score
sample.gr$score <- runif(length(sample.gr))*10
sample.gr$node.label <- as.character(round(sample.gr$score, digits = 1))
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

```
# Score should not be smaller than 1
# remove the alpha for following samples
sample.gr$alpha <- NULL
```

## Customize the x-axis label position

```
xaxis <- c(1, 200, 400, 701, 1000, 1200, 1402) ## define the position
lolliplot(sample.gr, features, xaxis=xaxis)
```

![](data:image/png;base64...)

```
names(xaxis) <- xaxis # define the labels
names(xaxis)[4] <- "center"
lolliplot(sample.gr, features, xaxis=xaxis)
```

![](data:image/png;base64...)

## Customize the y-axis label position

```
#yaxis <- c(0, 5) ## define the position
#lolliplot(sample.gr, features, yaxis=yaxis)
yaxis <- c(0, 5, 10, 15) ## define the position
names(yaxis) <- yaxis # define the labels
names(yaxis)[3] <- "y-axis"
lolliplot(sample.gr, features, yaxis=yaxis)
```

![](data:image/png;base64...)

## Jitter the label

```
sample.gr$dashline.col <- sample.gr$color
lolliplot(sample.gr, features, jitter="label")
```

![](data:image/png;base64...)

## Add a legend

```
legend <- 1:6 ## legend fill color
names(legend) <- paste0("legend", letters[1:6]) ## legend labels
lolliplot(sample.gr, features, legend=legend)
```

![](data:image/png;base64...)

```
## use list to define more attributes. see ?grid::gpar to get more details.
legend <- list(labels=paste0("legend", LETTERS[1:6]),
               col=palette()[6:1],
               fill=palette()[legend])
lolliplot(sample.gr, features, legend=legend)
```

![](data:image/png;base64...)

```
## if you have multiple tracks, please try to set the legend by list.
## see more examples in the section [Plot multiple samples](#plot-multiple-samples)
legendList <- list(legend)
lolliplot(sample.gr, features, legend=legendList)
```

![](data:image/png;base64...)

```
# from version 1.21.8, users can also try to set legend
# as a column name in the metadata of GRanges.
sample.gr.newlegend <- sample.gr
sample.gr.newlegend$legend <- LETTERS[sample.gr$color]
lolliplot(sample.gr.newlegend, features, legend="legend")
```

![](data:image/png;base64...)

```
# from version 1.41.6, users can set the legend position to right
lolliplot(sample.gr, features, legend=legend,
          legendPosition = list(position='right',
                                width=unit(1, 'inch')))
```

![](data:image/png;base64...)

```
## use ncol or nrow to control the legend layout.
legendList[[1]]$ncol <- 2 # if legend is not a list of list, use legend$ncol <- 2
lolliplot(sample.gr, features, legend=legendList, legendPosition = 'right')
```

![](data:image/png;base64...)

## Control the labels

Users can control the parameters of labels by naming the metadata start as label.parameter such as label.parameter.rot or label.parameter.gp. Note: label.parameter.label can be used to plot snp labels other than the names of inputs. The parameter is used for [grid.text](https://www.rdocumentation.org/packages/grid/topics/grid.text).

```
sample.gr.rot <- sample.gr
sample.gr.rot$label.parameter.rot <- 45
lolliplot(sample.gr.rot, features, legend=legend)
```

![](data:image/png;base64...)

```
sample.gr.rot$label.parameter.rot <- 60
sample.gr.rot$label.parameter.col <- "brown"
## change the label text into user-defined names other than names of the sample.gr
sample.gr.rot$label.parameter.label <- names(sample.gr)
random_ids <- sample(seq_along(sample.gr), 5)
sample.gr.rot$label.parameter.label[random_ids] <-
  paste("new label", random_ids)
random_ids <- sample(seq_along(sample.gr), 2)
sample.gr.rot$label.parameter.label[random_ids] <- NA ## remove some labels
lolliplot(sample.gr.rot, features, legend=legend)
```

![](data:image/png;base64...)

```
## try different colors
sample.gr.rot$label.parameter.col <- sample.int(7,
                                                length(sample.gr),
                                                replace = TRUE)
sample.gr.rot$label.parameter.draw <- TRUE
sample.gr.rot$label.parameter.draw[[1]] <- FALSE ## another method to remove the first label
lolliplot(sample.gr.rot, features, legend=legend)
```

![](data:image/png;base64...)

Users can also control the labels one by one by setting label.parameter.gp. Please note that for each label, the label.parameter.gp must be a list.

```
label.parameter.gp.brown <- gpar(col="brown")
label.parameter.gp.blue <- gpar(col="blue")
label.parameter.gp.red <- gpar(col="red")
sample.gr$label.parameter.gp <- sample(list(label.parameter.gp.blue,
                                            label.parameter.gp.brown,
                                            label.parameter.gp.red),
                                       length(sample.gr), replace = TRUE)
lolliplot(sample.gr, features)
```

![](data:image/png;base64...)

User can write the labels of the features directly on them and not in the legend by set the parameter label\_on\_feature to `TRUE`.

```
lolliplot(sample.gr, features, label_on_feature=TRUE)
```

![](data:image/png;base64...)

Please note that **lolliplot** does not support any parameters to set the title and xlab. If you want to add the title and xlab, please try to add them by [grid.text](https://www.rdocumentation.org/packages/grid/topics/grid.text).

```
lolliplot(sample.gr.rot, features, legend=legend, ylab="y label here")
grid.text("label of x-axis here", x=.5, y=.01, just="bottom")
grid.text("title here", x=.5, y=.98, just="top",
          gp=gpar(cex=1.5, fontface="bold"))
```

![](data:image/png;base64...)

Start from version `1.33.3`, **lolliplot** can also plot motifs as labels. The parameters are controlled by the parameters of labels by naming the metadata start as label.parameter such as label.parameter.pfm or label.parameter.font. The parameter is used for [plotMotifLogoA](https://www.rdocumentation.org/packages/motifStack/topics/plotMotifLogoA).

```
library(motifStack)
pcms<-readPCM(file.path(find.package("motifStack"), "extdata"),"pcm$")
sample.gr.rot$label.parameter.pfm <- pcms[sample(seq_along(pcms),
                                                 length(sample.gr.rot),
                                                 replace = TRUE)]
lolliplot(sample.gr.rot, features, legend=legend)
```

![](data:image/png;base64...)

## Change the lolliplot type

### Change the shape for “circle” plot

```
## shape must be "circle", "square", "diamond", "triangle_point_up", or "triangle_point_down"
available.shapes <- c("circle", "square", "diamond",
                      "triangle_point_up", "triangle_point_down")
sample.gr$shape <- sample(available.shapes, size = length(sample.gr), replace = TRUE)
sample.gr$legend <- paste0("legend", as.numeric(factor(sample.gr$shape)))
lolliplot(sample.gr, features, type="circle", legend = "legend")
```

![](data:image/png;base64...)

```
sample.gr.mul.shape <- sample.gr
sample.gr.mul.shape$score <- ceiling(sample.gr.mul.shape$score)
sample.gr.mul.shape$shape <- lapply(sample.gr.mul.shape$score, function(s){
  sample(available.shapes, size = s, replace = TRUE)
})
sample.gr.mul.shape$color <- lapply(sample.gr.mul.shape$score, function(s){
  sample.int(7, size = s, replace = TRUE)
})
lolliplot(sample.gr.mul.shape, features, type="circle",
          lollipop_style_switch_limit = max(sample.gr.mul.shape$score))
```

![](data:image/png;base64...)

### Google pin

```
lolliplot(sample.gr, features, type="pin")
```

![](data:image/png;base64...)

```
sample.gr$color <- lapply(sample.gr$color, function(.ele) c(.ele, sample.int(6, 1)))
sample.gr$border <- sample.int(6, length(SNP), replace=TRUE)
lolliplot(sample.gr, features, type="pin")
```

![](data:image/png;base64...)

### Flag

```
sample.gr.flag <- sample.gr
sample.gr.flag$label <- names(sample.gr) ## move the names to metadata:label
names(sample.gr.flag) <- NULL
#lolliplot(sample.gr.flag, features,
#          ranges=GRanges("chr1", IRanges(0, 1600)), ## use ranges to leave more space on the right margin.
#          type="flag")
## change the flag rotation angle
sample.gr.flag$node.label.rot <- 15
sample.gr.flag$node.label.rot[c(2, 5)] <- c(60, -15)
sample.gr.flag$label[7] <- "I have a long name"
sample.gr.flag$node.label.cex <- 1
sample.gr.flag$node.label.cex[4] <- 2
lolliplot(sample.gr.flag, features,
          ranges=GRanges("chr1", IRanges(0, 1600)),## use ranges to leave more space on the right margin.
          type="flag")
```

![](data:image/png;base64...)

### Pie plot

```
sample.gr$score <- NULL ## must be removed, because pie will consider all the numeric columns except column "color", "fill", "alpha", "shape", "lwd", "id" and "id.col".
sample.gr$label <- NULL
sample.gr$node.label.col <- NULL
x <- sample.int(100, length(SNP))
sample.gr$value1 <- x
sample.gr$value2 <- 100 - x # for pie plot, 2 value columns are required.
## the length of the color should be no less than that of value1 or value2
sample.gr$color <- rep(list(c("#87CEFA", '#98CE31')), length(SNP))
sample.gr$border <- "gray30"
lolliplot(sample.gr, features, type="pie")
```

![](data:image/png;base64...)

## Plot multiple samples

### Multiple layers

```
SNP2 <- sample(4000:8000, 30)
x2 <- sample.int(100, length(SNP2), replace=TRUE)
sample2.gr <- GRanges("chr3", IRanges(SNP2, width=1, names=paste0("snp", SNP2)),
             value1=x2, value2=100-x2)
sample2.gr$color <- rep(list(c('#DB7575', '#FFD700')), length(SNP2))
sample2.gr$border <- "gray30"

features2 <- GRanges("chr3", IRanges(c(5001, 5801, 7001),
                                    width=c(500, 500, 405),
                                    names=paste0("block", 4:6)),
                    fill=c("orange", "gray30", "lightblue"),
                    height=unit(c(0.5, 0.3, 0.8), "cm"))
legends <- list(list(labels=c("WT", "MUT"), fill=c("#87CEFA", '#98CE31')),
                list(labels=c("WT", "MUT"), fill=c('#DB7575', '#FFD700')))
lolliplot(list(A=sample.gr, B=sample2.gr),
          list(x=features, y=features2),
          type="pie", legend=legends)
```

![](data:image/png;base64...)

Different layouts are also possible.

```
sample2.gr$score <- sample2.gr$value1 ## The circle layout needs the score column
lolliplot(list(A=sample.gr, B=sample2.gr),
          list(x=features, y=features2),
          type=c("pie", "circle"), legend=legends)
```

![](data:image/png;base64...)

### pie.stack layout

```
rand.id <- sample.int(length(sample.gr), 3*length(sample.gr), replace=TRUE)
rand.id <- sort(rand.id)
sample.gr.mul.patient <- sample.gr[rand.id]
## pie.stack require metadata "stack.factor", and the metadata can not be
## stack.factor.order or stack.factor.first
len.max <- max(table(rand.id))
stack.factors <- paste0("patient", formatC(1:len.max,
                                           width=nchar(as.character(len.max)),
                                           flag="0"))
sample.gr.mul.patient$stack.factor <-
    unlist(lapply(table(rand.id), sample, x=stack.factors))
sample.gr.mul.patient$value1 <-
    sample.int(100, length(sample.gr.mul.patient), replace=TRUE)
sample.gr.mul.patient$value2 <- 100 - sample.gr.mul.patient$value1
patient.color.set <- as.list(as.data.frame(rbind(rainbow(length(stack.factors)),
                                                 "#FFFFFFFF"),
                                           stringsAsFactors=FALSE))
names(patient.color.set) <- stack.factors
sample.gr.mul.patient$color <-
    patient.color.set[sample.gr.mul.patient$stack.factor]
legend <- list(labels=stack.factors, col="gray80",
               fill=sapply(patient.color.set, `[`, 1))
## remove one mutation label
sample.gr.mul.patient$label.parameter.draw <- TRUE
sample.gr.mul.patient$label.parameter.draw[
  names(sample.gr.mul.patient)==
    sample(unique(names(sample.gr.mul.patient)), 1)] <-
  FALSE
lolliplot(sample.gr.mul.patient, features, type="pie.stack",
          legend=legend, dashline.col="gray")
```

![](data:image/png;base64...)

### Caterpillar layout

Metadata SNPsideID is used to trigger caterpillar layout. SNPsideID must be ‘top’ or ‘bottom’.

```
sample.gr$SNPsideID <- sample(c("top", "bottom"),
                               length(sample.gr),
                               replace=TRUE)
lolliplot(sample.gr, features, type="pie",
          legend=legends[[1]])
```

![](data:image/png;base64...)

```
## Two layers
sample2.gr$SNPsideID <- "top"
idx <- sample.int(length(sample2.gr), 15)
sample2.gr$SNPsideID[idx] <- "bottom"
sample2.gr$color[idx] <- '#FFD700'
lolliplot(list(A=sample.gr, B=sample2.gr),
          list(x=features.mul, y=features2),
          type=c("pie", "circle"), legend=legends)
```

![](data:image/png;base64...)

## EMBL-EBI Proteins API

Following code will show how to use [EBI Proteins REST API](https://www.ebi.ac.uk/proteins/api/doc/) to get annotations of protein domains.

```
library(httr) # load library to get data from REST API
APIurl <- "https://www.ebi.ac.uk/proteins/api/" # base URL of the API
taxid <- "9606" # human tax ID
gene <- "TP53" # target gene
orgDB <- "org.Hs.eg.db" # org database to get the uniprot accession id
eid <- mget("TP53", get(sub(".db", "SYMBOL2EG", orgDB)))[[1]]
chr <- mget(eid, get(sub(".db", "CHR", orgDB)))[[1]]
accession <- unlist(lapply(eid, function(.ele){
  mget(.ele, get(sub(".db", "UNIPROT", orgDB)))
}))
stopifnot(length(accession)<=20) # max number of accession is 20

tryCatch({ ## in case the internet connection does not work
  featureURL <- paste0(APIurl,
                       "features?offset=0&size=-1&reviewed=true",
                       "&types=DNA_BIND%2CMOTIF%2CDOMAIN",
                       "&taxid=", taxid,
                       "&accession=", paste(accession, collapse = "%2C")
  )
  response <- GET(featureURL)
  if(!http_error(response)){
    content <- httr::content(response)
    content <- content[[1]]
    acc <- content$accession
    sequence <- content$sequence
    gr <- GRanges(chr, IRanges(1, nchar(sequence)))
    domains <- do.call(rbind, content$features)
    domains <- GRanges(chr, IRanges(as.numeric(domains[, "begin"]),
                                     as.numeric(domains[, "end"]),
                                     names = domains[, "description"]))
    names(domains)[1] <- "DNA_BIND" ## this is hard coding.
    domains$fill <- 1+seq_along(domains)
    domains$height <- 0.04
    ## GET variations. This part can be replaced by user-defined data.
    variationURL <- paste0(APIurl,
                           "variation?offset=0&size=-1",
                           "&sourcetype=uniprot&dbtype=dbSNP",
                           "&taxid=", taxid,
                           "&accession=", acc)
    response <- GET(variationURL)
    if(!http_error(response)){
      content <- httr::content(response)
      content <- content[[1]]
      keep <- sapply(content$features, function(.ele) length(.ele$evidences)>2 && # filter the data by at least 2 evidences
                       !grepl("Unclassified", .ele$clinicalSignificances)) # filter the data by classified clinical significances.
      nkeep <- c("wildType", "alternativeSequence", "begin", "end",
                 "somaticStatus", "consequenceType", "score")
      content$features <- lapply(content$features[keep], function(.ele){
        .ele$score <- length(.ele$evidences)
        unlist(.ele[nkeep])
      })
      variation <- do.call(rbind, content$features)
      variation <-
        GRanges(chr,
                IRanges(as.numeric(variation[, "begin"]),
                        width = 1,
                        names = paste0(variation[, "wildType"],
                                       variation[, "begin"],
                                       variation[, "alternativeSequence"])),
                score = as.numeric(variation[, "score"]),
                color = as.numeric(factor(variation[, "consequenceType"]))+1)
      variation$label.parameter.gp <- gpar(cex=.5)
      lolliplot(variation, domains, ranges = gr, ylab = "# evidences", yaxis = FALSE)
    }else{
      message("Can not get variations. http error")
    }
  }else{
    message("Can not get features. http error")
  }
},error=function(e){
  message(e)
},warning=function(w){
  message(w)
},interrupt=function(i){
  message(i)
})
```

## Variant Call Format (VCF) data

```
library(VariantAnnotation)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
gr <- GRanges("22", IRanges(50968014, 50970514, names="TYMP"))
if(.Platform$OS.type!="windows"){# This line is for avoiding error from VariantAnnotation in the windows platform, which will be removed when VariantAnnotation's issue gets fixed.
tab <- TabixFile(fl)
vcf <- readVcf(fl, "hg19", param=gr)
mutation.frequency <- rowRanges(vcf)
mcols(mutation.frequency) <- cbind(mcols(mutation.frequency),
                                   VariantAnnotation::info(vcf))
mutation.frequency$border <- "gray30"
mutation.frequency$color <-
    ifelse(grepl("^rs", names(mutation.frequency)), "lightcyan", "lavender")
## Plot Global Allele Frequency based on AC/AN
mutation.frequency$score <- mutation.frequency$AF*100
seqlevelsStyle(mutation.frequency) <- "UCSC"
if(!grepl("chr", seqlevels(mutation.frequency)[1])){
  seqlevels(mutation.frequency) <-
    paste0("chr", seqlevels(mutation.frequency))
}
}
seqlevelsStyle(gr) <- "UCSC"
trs <- geneModelFromTxdb(TxDb.Hsapiens.UCSC.hg19.knownGene,
                         org.Hs.eg.db,
                         gr=gr)
features <- c(range(trs[[1]]$dat), range(trs[[5]]$dat))
names(features) <- c(trs[[1]]$name, trs[[5]]$name)
features$fill <- c("lightblue", "mistyrose")
features$height <- c(.02, .04)
if(.Platform$OS.type!="windows"){
lolliplot(mutation.frequency, features, ranges=gr)
}
```

![](data:image/png;base64...)

## Methylation data

```
library(rtracklayer)
session <- browserSession()
query <- ucscTableQuery(session,
                        table="wgEncodeHaibMethylRrbs",
                        range=GRangesForUCSCGenome("hg19",
                                                   seqnames(gr),
                                                   ranges(gr)))
tableName(query) <- tableNames(query)[1]
methy <- track(query)
methy <- GRanges(methy)
```

```
lolliplot(methy, features, ranges=gr, type="pin")
```

![](data:image/png;base64...)

## Change the node size

In the above example, some of the nodes overlap each other. To change the node size, cex prameter could be used.

```
methy$lwd <- .5
lolliplot(methy, features, ranges=gr, type="pin", cex=.5)
```

![](data:image/png;base64...)

```
#lolliplot(methy, features, ranges=gr, type="circle", cex=.5)
methy$score2 <- max(methy$score) - methy$score
lolliplot(methy, features, ranges=gr, type="pie", cex=.5)
```

![](data:image/png;base64...)

```
## We can change it one by one
methy$cex <- runif(length(methy))
lolliplot(methy, features, ranges=gr, type="pin")
```

![](data:image/png;base64...)

```
#lolliplot(methy, features, ranges=gr, type="circle")
```

## Change the scale of the x-axis (xscale)

In the above examples, some of the nodes are moved too far from the original coordinates. To rescale, the x-axis could be reset as below.

```
methy$cex <- 1
lolliplot(methy, features, ranges=gr, rescale = TRUE)
```

![](data:image/png;base64...)

```
## by set percentage for features and non-features segments
xaxis <- c(50968014, 50968514, 50968710, 50968838, 50970514)
rescale <- c(.3, .4, .3)
lolliplot(methy, features, ranges=gr, type="pin",
          rescale = rescale, xaxis = xaxis)
```

![](data:image/png;base64...)

```
## by set data.frame to rescale
rescale <- data.frame(
  from.start = c(50968014, 50968515, 50968838),
  from.end   = c(50968514, 50968837, 50970514),
  to.start   = c(50968014, 50968838, 50969501),
  to.end     = c(50968837, 50969500, 50970514)
)
lolliplot(methy, features, ranges=gr, type="pin",
          rescale = rescale, xaxis = xaxis)
```

![](data:image/png;base64...)

Rescale the region to emphasize exons region only or introns region only. Here “exon” indicates all regions in features.

```
lolliplot(methy, features, ranges=gr, rescale = "exon")
```

![](data:image/png;base64...)

```
# exon region occupy 99% of the plot region.
lolliplot(methy, features, ranges=gr, rescale = "exon_99")
```

![](data:image/png;base64...)

```
lolliplot(methy, features, ranges=gr, rescale = "intron")
```

![](data:image/png;base64...)

## Split the lollipop plot into multiLayers

In the above examples, people may be misled when the x-axis is ignored. It will be better to plot the data into multiple layers. This can be done by setting parameter `ranges` into a `GRangesList` object.

```
grSplited <- tile(gr, n=2)
lolliplot(methy, features, ranges=grSplited, type="pin")
```

![](data:image/png;base64...)

# Plot the lollipop plot with the coverage and annotation tracks

```
gene <- geneTrack(get("HSPA8", org.Hs.egSYMBOL2EG), TxDb.Hsapiens.UCSC.hg19.knownGene)[[1]]
SNPs <- GRanges("chr11", IRanges(sample(122929275:122930122, size = 20), width = 1), strand="-")
SNPs$score <- sample.int(5, length(SNPs), replace = TRUE)
SNPs$color <- sample.int(6, length(SNPs), replace=TRUE)
SNPs$border <- "gray80"
SNPs$feature.height = .1
gene$dat2 <- SNPs
extdata <- system.file("extdata", package="trackViewer",
                       mustWork=TRUE)
repA <- importScore(file.path(extdata, "cpsf160.repA_-.wig"),
                    file.path(extdata, "cpsf160.repA_+.wig"),
                    format="WIG")
fox2 <- importScore(file.path(extdata, "fox2.bed"), format="BED",
                    ranges=GRanges("chr11", IRanges(122830799, 123116707)))
optSty <- optimizeStyle(trackList(repA, fox2, gene), theme="col")
trackList <- optSty$tracks
viewerStyle <- optSty$style
gr <- GRanges("chr11", IRanges(122929275, 122930122))
setTrackStyleParam(trackList[[3]], "ylabgp", list(cex=.8))
vp <- viewTracks(trackList, gr=gr, viewerStyle=viewerStyle)
```

![](data:image/png;base64...)

```
## lollipopData track
SNPs2 <- GRanges("chr11", IRanges(sample(122929275:122930122, size = 30), width = 1), strand="-")
SNPs2 <- c(SNPs2, promoters(gene$dat, upstream = 0, downstream = 1))
SNPs2$score <- sample.int(3, length(SNPs2), replace = TRUE)
SNPs2$color <- sample.int(6, length(SNPs2), replace=TRUE)
SNPs2$border <- "gray30"
SNPs2$feature.height = .1
lollipopData <- new("track", dat=SNPs, dat2=SNPs2, type="lollipopData")
gene <- geneTrack(get("HSPA8", org.Hs.egSYMBOL2EG), TxDb.Hsapiens.UCSC.hg19.knownGene)[[1]]
optSty <- optimizeStyle(trackList(repA, lollipopData, gene, heightDist = c(3, 3, 1)), theme="col")
trackList <- optSty$tracks
viewerStyle <- optSty$style
gr <- GRanges("chr11", IRanges(122929275, 122930122))
setTrackStyleParam(trackList[[2]], "ylabgp", list(cex=.8))
vp <- viewTracks(trackList, gr=gr, viewerStyle=viewerStyle)
addGuideLine(122929538, vp=vp)
```

![](data:image/png;base64...)

```
## plot with customized geneTrack
dat <- gene$dat
mcols(dat) <- NULL
dat <- subsetByOverlaps(dat, gr)
dat$feature <- 'exon' # feature is required
dat$featureID <- paste0('name', seq_along(dat)) # treat each as single exon gene
dat$color <- sample(seq.int(7), length(dat), replace = TRUE) # set the color
dat$height <- sample(c(0.5, 1, 2), length(dat), replace = TRUE) # set the height
dat$hide_label <- TRUE # do not add labels to the block
gene <- new('track', dat=dat, dat2=SNPs, type='gene', name='a name')
optSty <- optimizeStyle(trackList(fox2, gene), theme="col")
trackList <- optSty$tracks
viewerStyle <- optSty$style
vp <- viewTracks(trackList, gr=gr, viewerStyle=viewerStyle)
```

![](data:image/png;base64...)

# Session Info

```
sessionInfo()
```

R version 4.5.1 Patched (2025-08-23 r88802) Platform: x86\_64-pc-linux-gnu Running under: Ubuntu 24.04.3 LTS

Matrix products: default BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale: [1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C
[3] LC\_TIME=en\_GB LC\_COLLATE=C
[5] LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C
[9] LC\_ADDRESS=C LC\_TELEPHONE=C
[11] LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York tzcode source: system (glibc)

attached base packages: [1] grid stats4 stats graphics grDevices utils datasets [8] methods base

other attached packages: [1] motifStack\_1.54.0
[2] httr\_1.4.7
[3] VariantAnnotation\_1.56.0
[4] Rsamtools\_2.26.0
[5] Biostrings\_2.78.0
[6] XVector\_0.50.0
[7] SummarizedExperiment\_1.40.0
[8] MatrixGenerics\_1.22.0
[9] matrixStats\_1.5.0
[10] org.Hs.eg.db\_3.22.0
[11] TxDb.Hsapiens.UCSC.hg19.knownGene\_3.22.1 [12] GenomicFeatures\_1.62.0
[13] AnnotationDbi\_1.72.0
[14] Biobase\_2.70.0
[15] Gviz\_1.54.0
[16] rtracklayer\_1.70.0
[17] trackViewer\_1.46.0
[18] GenomicRanges\_1.62.0
[19] Seqinfo\_1.0.0
[20] IRanges\_2.44.0
[21] S4Vectors\_0.48.0
[22] BiocGenerics\_0.56.0
[23] generics\_0.1.4

loaded via a namespace (and not attached): [1] RColorBrewer\_1.1-3 strawr\_0.0.92
[3] rstudioapi\_0.17.1 jsonlite\_2.0.0
[5] magrittr\_2.0.4 farver\_2.1.2
[7] rmarkdown\_2.30 BiocIO\_1.20.0
[9] vctrs\_0.6.5 Cairo\_1.7-0
[11] memoise\_2.0.1 RCurl\_1.98-1.17
[13] base64enc\_0.1-3 htmltools\_0.5.8.1
[15] S4Arrays\_1.10.0 progress\_1.2.3
[17] curl\_7.0.0 Rhdf5lib\_1.32.0
[19] SparseArray\_1.10.0 Formula\_1.2-5
[21] rhdf5\_2.54.0 sass\_0.4.10
[23] bslib\_0.9.0 htmlwidgets\_1.6.4
[25] httr2\_1.2.1 cachem\_1.1.0
[27] GenomicAlignments\_1.46.0 lifecycle\_1.0.4
[29] pkgconfig\_2.0.3 Matrix\_1.7-4
[31] R6\_2.6.1 fastmap\_1.2.0
[33] digest\_0.6.37 TFMPvalue\_0.0.9
[35] colorspace\_2.1-2 Hmisc\_5.2-4
[37] RSQLite\_2.4.3 seqLogo\_1.76.0
[39] filelock\_1.0.3 abind\_1.4-8
[41] compiler\_4.5.1 bit64\_4.6.0-1
[43] htmlTable\_2.4.3 S7\_0.2.0
[45] backports\_1.5.0 BiocParallel\_1.44.0
[47] DBI\_1.2.3 biomaRt\_2.66.0
[49] MASS\_7.3-65 rappdirs\_0.3.3
[51] DelayedArray\_0.36.0 rjson\_0.2.23
[53] gtools\_3.9.5 caTools\_1.18.3
[55] tools\_4.5.1 foreign\_0.8-90
[57] nnet\_7.3-20 glue\_1.8.0
[59] restfulr\_0.0.16 InteractionSet\_1.38.0
[61] rhdf5filters\_1.22.0 checkmate\_2.3.3
[63] ade4\_1.7-23 cluster\_2.1.8.1
[65] TFBSTools\_1.48.0 gtable\_0.3.6
[67] BSgenome\_1.78.0 ensembldb\_2.34.0
[69] data.table\_1.17.8 hms\_1.1.4
[71] pillar\_1.11.1 stringr\_1.5.2
[73] dplyr\_1.1.4 BiocFileCache\_3.0.0
[75] lattice\_0.22-7 bit\_4.6.0
[77] deldir\_2.0-4 biovizBase\_1.58.0
[79] DirichletMultinomial\_1.52.0 tidyselect\_1.2.1
[81] knitr\_1.50 gridExtra\_2.3
[83] grImport2\_0.3-3 ProtGenerics\_1.42.0
[85] xfun\_0.53 stringi\_1.8.7
[87] UCSC.utils\_1.6.0 lazyeval\_0.2.2
[89] yaml\_2.3.10 evaluate\_1.0.5
[91] codetools\_0.2-20 cigarillo\_1.0.0
[93] interp\_1.1-6 tibble\_3.3.0
[95] BiocManager\_1.30.26 cli\_3.6.5
[97] rpart\_4.1.24 jquerylib\_0.1.4
[99] dichromat\_2.0-0.1 Rcpp\_1.1.0
[101] GenomeInfoDb\_1.46.0 grImport\_0.9-7
[103] dbplyr\_2.5.1 png\_0.1-8
[105] XML\_3.99-0.19 parallel\_4.5.1
[107] ggplot2\_4.0.0 blob\_1.2.4
[109] prettyunits\_1.2.0 latticeExtra\_0.6-31
[111] jpeg\_0.1-11 AnnotationFilter\_1.34.0
[113] bitops\_1.0-9 pwalign\_1.6.0
[115] txdbmaker\_1.6.0 scales\_1.4.0
[117] crayon\_1.5.3 BiocStyle\_2.38.0
[119] rlang\_1.1.6 KEGGREST\_1.50.0