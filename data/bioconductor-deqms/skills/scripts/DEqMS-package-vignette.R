# Code example from 'DEqMS-package-vignette' vignette. See references/ for full tutorial.

## ----Loadpackage--------------------------------------------------------------
library(DEqMS)

## ----DownloadProteinTable-----------------------------------------------------
options(timeout = 1000)
url <- "https://ftp.ebi.ac.uk/pride-archive/2016/06/PXD004163/Yan_miR_Protein_table.flatprottable.txt"
download.file(url, destfile = "./miR_Proteintable.txt",method = "auto")

df.prot = read.table("miR_Proteintable.txt",stringsAsFactors = FALSE,
                     header = TRUE, quote = "", comment.char = "",sep = "\t")

## ----Extractcolumn------------------------------------------------------------
# filter at 1% protein FDR and extract TMT quantifications
TMT_columns = seq(15,33,2)
dat = df.prot[df.prot$miR.FASP_q.value<0.01,TMT_columns]
rownames(dat) = df.prot[df.prot$miR.FASP_q.value<0.01,]$Protein.accession
# The protein dataframe is a typical protein expression matrix structure
# Samples are in columns, proteins are in rows
# use unique protein IDs for rownames
# to view the whole data frame, use the command View(dat)

## ----log2transform1-----------------------------------------------------------
dat.log = log2(dat)
#remove rows with NAs
dat.log = na.omit(dat.log)

## ----boxplot1-----------------------------------------------------------------
boxplot(dat.log,las=2,main="TMT10plex data PXD004163")
# Here the data is already median centered, we skip the following step. 
# dat.log = equalMedianNormalization(dat.log)

## ----design-------------------------------------------------------------------
# if there is only one factor, such as treatment. You can define a vector with
# the treatment group in the same order as samples in the protein table.
cond = as.factor(c("ctrl","miR191","miR372","miR519","ctrl",
"miR372","miR519","ctrl","miR191","miR372"))

# The function model.matrix is used to generate the design matrix
design = model.matrix(~0+cond) # 0 means no intercept for the linear model
colnames(design) = gsub("cond","",colnames(design))

## ----limma--------------------------------------------------------------------
# you can define one or multiple contrasts here
x <- c("miR372-ctrl","miR519-ctrl","miR191-ctrl",
       "miR372-miR519","miR372-miR191","miR519-miR191")
contrast =  makeContrasts(contrasts=x,levels=design)
fit1 <- lmFit(dat.log, design)
fit2 <- contrasts.fit(fit1,contrasts = contrast)
fit3 <- eBayes(fit2)

## ----DEqMS1-------------------------------------------------------------------
# assign a extra variable `count` to fit3 object, telling how many PSMs are 
# quantifed for each protein
library(matrixStats)
count_columns = seq(16,34,2)
psm.count.table = data.frame(count = rowMins(
  as.matrix(df.prot[,count_columns])), row.names =  df.prot$Protein.accession)
fit3$count = psm.count.table[rownames(fit3$coefficients),"count"]
fit4 = spectraCounteBayes(fit3)

## ----plot---------------------------------------------------------------------
# n=30 limits the boxplot to show only proteins quantified by <= 30 PSMs.
VarianceBoxplot(fit4,n=30,main="TMT10plex dataset PXD004163",xlab="PSM count")
VarianceScatterplot(fit4,main="TMT10plex dataset PXD004163")

## ----result-------------------------------------------------------------------
DEqMS.results = outputResult(fit4,coef_col = 1)
#if you are not sure which coef_col refers to the specific contrast,type
head(fit4$coefficients)

# a quick look on the DEqMS results table
head(DEqMS.results)
# Save it into a tabular text file
write.table(DEqMS.results,"DEqMS.results.miR372-ctrl.txt",sep = "\t",
            row.names = F,quote=F)

## ----volcanoplot1-------------------------------------------------------------
library(ggrepel)
# Use ggplot2 allows more flexibility in plotting

DEqMS.results$log.sca.pval = -log10(DEqMS.results$sca.P.Value)
ggplot(DEqMS.results, aes(x = logFC, y =log.sca.pval )) + 
    geom_point(size=0.5 )+
    theme_bw(base_size = 16) + # change theme
    xlab(expression("log2(miR372/ctrl)")) + # x-axis label
    ylab(expression(" -log10(P-value)")) + # y-axis label
    geom_vline(xintercept = c(-1,1), colour = "red") + # Add fold change cutoffs
    geom_hline(yintercept = 3, colour = "red") + # Add significance cutoffs
    geom_vline(xintercept = 0, colour = "black") + # Add 0 lines
    scale_colour_gradient(low = "black", high = "black", guide = FALSE)+
    geom_text_repel(data=subset(DEqMS.results, abs(logFC)>1&log.sca.pval > 3),
                    aes( logFC, log.sca.pval ,label=gene)) # add gene label

## ----volcanoplot2-------------------------------------------------------------
fit4$p.value = fit4$sca.p
# volcanoplot highlight top 20 proteins ranked by p-value here
volcanoplot(fit4,coef=1, style = "p-value", highlight = 20,
            names=rownames(fit4$coefficients))

## ----DownloadLabelfreeData----------------------------------------------------
url2 <- "https://ftp.ebi.ac.uk/pride-archive/2014/09/PXD000279/proteomebenchmark.zip"
download.file(url2, destfile = "./PXD000279.zip",method = "auto")
unzip("PXD000279.zip")

## ----LFQprotein---------------------------------------------------------------
df.prot = read.table("proteinGroups.txt",header=T,sep="\t",stringsAsFactors = F,
                        comment.char = "",quote ="")

# remove decoy matches and matches to contaminant
df.prot = df.prot[!df.prot$Reverse=="+",]
df.prot = df.prot[!df.prot$Contaminant=="+",]

# Extract columns of LFQ intensites
df.LFQ = df.prot[,89:94]
df.LFQ[df.LFQ==0] <- NA

rownames(df.LFQ) = df.prot$Majority.protein.IDs
df.LFQ$na_count_H = apply(df.LFQ,1,function(x) sum(is.na(x[1:3])))
df.LFQ$na_count_L = apply(df.LFQ,1,function(x) sum(is.na(x[4:6])))
# Filter protein table. DEqMS require minimum two values for each group.
df.LFQ.filter = df.LFQ[df.LFQ$na_count_H<2 & df.LFQ$na_count_L<2,1:6]

## ----pepCountTable------------------------------------------------------------
library(matrixStats)
# we use minimum peptide count among six samples
# count unique+razor peptides used for quantification
pep.count.table = data.frame(count = rowMins(as.matrix(df.prot[,19:24])),
                             row.names = df.prot$Majority.protein.IDs)
# Minimum peptide count of some proteins can be 0
# add pseudocount 1 to all proteins
pep.count.table$count = pep.count.table$count+1

## ----labelfreeDEqMS-----------------------------------------------------------
protein.matrix = log2(as.matrix(df.LFQ.filter))

class = as.factor(c("H","H","H","L","L","L"))
design = model.matrix(~0+class) # fitting without intercept

fit1 = lmFit(protein.matrix,design = design)
cont <- makeContrasts(classH-classL, levels = design)
fit2 = contrasts.fit(fit1,contrasts = cont)
fit3 <- eBayes(fit2)

fit3$count = pep.count.table[rownames(fit3$coefficients),"count"]

#check the values in the vector fit3$count
#if min(fit3$count) return NA or 0, you should troubleshoot the error first
min(fit3$count)

fit4 = spectraCounteBayes(fit3)

## ----LFQboxplot---------------------------------------------------------------
VarianceBoxplot(fit4, n=20, main = "Label-free dataset PXD000279",
                xlab="peptide count + 1")

## ----LFQresult----------------------------------------------------------------
DEqMS.results = outputResult(fit4,coef_col = 1)
# Add Gene names to the data frame
rownames(df.prot) = df.prot$Majority.protein.IDs
DEqMS.results$Gene.name = df.prot[DEqMS.results$gene,]$Gene.names
head(DEqMS.results)
write.table(DEqMS.results,"H-L.DEqMS.results.txt",sep = "\t",
            row.names = F,quote=F)

## ----retrieveExampleData, message=FALSE---------------------------------------
### retrieve example PSM dataset from ExperimentHub
library(ExperimentHub)
eh = ExperimentHub()
query(eh, "DEqMS")
dat.psm = eh[["EH1663"]]

## ----log2transform2-----------------------------------------------------------
dat.psm.log = dat.psm
dat.psm.log[,3:12] =  log2(dat.psm[,3:12])
head(dat.psm.log)

## ----boxplot2-----------------------------------------------------------------
dat.gene.nm = medianSweeping(dat.psm.log,group_col = 2)
boxplot(dat.gene.nm,las=2,ylab="log2 ratio",main="TMT10plex dataset PXD004163")

## ----DEqMS2-------------------------------------------------------------------
gene.matrix = as.matrix(dat.gene.nm)

# make design table
cond = as.factor(c("ctrl","miR191","miR372","miR519","ctrl",
"miR372","miR519","ctrl","miR191","miR372"))
design = model.matrix(~0+cond) 
colnames(design) = gsub("cond","",colnames(design))

#limma part analysis
fit1 <- lmFit(gene.matrix,design)
x <- c("miR372-ctrl","miR519-ctrl","miR191-ctrl")
contrast =  makeContrasts(contrasts=x,levels=design)
fit2 <- eBayes(contrasts.fit(fit1,contrasts = contrast))

#DEqMS part analysis
psm.count.table = as.data.frame(table(dat.psm$gene))
rownames(psm.count.table) = psm.count.table$Var1

fit2$count = psm.count.table[rownames(fit2$coefficients),2]
fit3 = spectraCounteBayes(fit2)
# extract DEqMS results
DEqMS.results = outputResult(fit3,coef_col = 1) 
head(DEqMS.results)
write.table(DEqMS.results,"DEqMS.results.miR372-ctrl.fromPSMtable.txt",
            sep = "\t",row.names = F,quote=F)

## ----PriorVarianceTrend-------------------------------------------------------
VarianceBoxplot(fit3,n=20, xlab="PSM count",main="TMT10plex dataset PXD004163")

## ----PSMintensity-------------------------------------------------------------
peptideProfilePlot(dat=dat.psm.log,col=2,gene="TGFBR2")
# col=2 is tell in which column of dat.psm.log to look for the gene

## ----PriorVar-----------------------------------------------------------------
VarianceScatterplot(fit3, xlab="log2(PSM count)")
limma.prior = fit3$s2.prior
abline(h = log(limma.prior),col="green",lwd=3 )
legend("topright",legend=c("DEqMS prior variance","Limma prior variance"),
        col=c("red","green"),lwd=3)

## ----Residualplot-------------------------------------------------------------
op <- par(mfrow=c(1,2), mar=c(4,4,4,1), oma=c(0.5,0.5,0.5,0))
Residualplot(fit3,  xlab="log2(PSM count)",main="DEqMS")
x = fit3$count
y = log(limma.prior) - log(fit3$sigma^2)
plot(log2(x),y,ylim=c(-6,2),ylab="Variance(estimated-observed)", pch=20, cex=0.5,
     xlab = "log2(PSMcount)",main="Limma")

## ----PostVar, echo=TRUE, fig.height=5, fig.width=10---------------------------
library(LSD)
op <- par(mfrow=c(1,2), mar=c(4,4,4,1), oma=c(0.5,0.5,0.5,0))
x = fit3$count
y = fit3$s2.post
heatscatter(log2(x),log(y),pch=20, xlab = "log2(PSMcount)", 
     ylab="log(Variance)",
     main="Posterior Variance in Limma")

y = fit3$sca.postvar
heatscatter(log2(x),log(y),pch=20, xlab = "log2(PSMcount)",
     ylab="log(Variance)", 
     main="Posterior Variance in DEqMS")

## ----t-test-------------------------------------------------------------------
pval.372 = apply(dat.gene.nm, 1, function(x) 
t.test(as.numeric(x[c(1,5,8)]), as.numeric(x[c(3,6,10)]))$p.value)

logFC.372 = rowMeans(dat.gene.nm[,c(3,6,10)])-rowMeans(dat.gene.nm[,c(1,5,8)])

## ----echo=TRUE----------------------------------------------------------------
ttest.results = data.frame(gene=rownames(dat.gene.nm),
                    logFC=logFC.372,P.Value = pval.372, 
                    adj.pval = p.adjust(pval.372,method = "BH")) 

ttest.results$PSMcount = psm.count.table[ttest.results$gene,"count"]
ttest.results = ttest.results[with(ttest.results, order(P.Value)), ]
head(ttest.results)

## ----Anova--------------------------------------------------------------------
ord.t = fit1$coefficients[, 1]/fit1$sigma/fit1$stdev.unscaled[, 1]
ord.p = 2*pt(abs(ord.t), fit1$df.residual, lower.tail = FALSE)
ord.q = p.adjust(ord.p,method = "BH")
anova.results = data.frame(gene=names(fit1$sigma),
                            logFC=fit1$coefficients[,1],
                            t=ord.t, 
                            P.Value=ord.p, 
                            adj.P.Val = ord.q)

anova.results$PSMcount = psm.count.table[anova.results$gene,"count"]
anova.results = anova.results[with(anova.results,order(P.Value)),]

head(anova.results)

## ----echo=TRUE----------------------------------------------------------------
limma.results = topTable(fit2,coef = 1,n= Inf)
limma.results$gene = rownames(limma.results)
#Add PSM count values in the data frame
limma.results$PSMcount = psm.count.table[limma.results$gene,"count"]

head(limma.results)

## ----pvalueall----------------------------------------------------------------
plot(sort(-log10(limma.results$P.Value),decreasing = TRUE), 
    type="l",lty=2,lwd=2, ylab="-log10(p-value)",ylim = c(0,10),
    xlab="Proteins ranked by p-values",
    col="purple")
lines(sort(-log10(DEqMS.results$sca.P.Value),decreasing = TRUE), 
        lty=1,lwd=2,col="red")
lines(sort(-log10(anova.results$P.Value),decreasing = TRUE), 
        lty=2,lwd=2,col="blue")
lines(sort(-log10(ttest.results$P.Value),decreasing = TRUE), 
        lty=2,lwd=2,col="orange")
legend("topright",legend = c("Limma","DEqMS","Anova","t.test"),
        col = c("purple","red","blue","orange"),lty=c(2,1,2,2),lwd=2)

## ----pvalue500----------------------------------------------------------------
plot(sort(-log10(limma.results$P.Value),decreasing = TRUE)[1:500], 
    type="l",lty=2,lwd=2, ylab="-log10(p-value)", ylim = c(2,10),
    xlab="Proteins ranked by p-values",
    col="purple")
lines(sort(-log10(DEqMS.results$sca.P.Value),decreasing = TRUE)[1:500], 
        lty=1,lwd=2,col="red")
lines(sort(-log10(anova.results$P.Value),decreasing = TRUE)[1:500], 
        lty=2,lwd=2,col="blue")
lines(sort(-log10(ttest.results$P.Value),decreasing = TRUE)[1:500], 
        lty=2,lwd=2,col="orange")
legend("topright",legend = c("Limma","DEqMS","Anova","t.test"),
        col = c("purple","red","blue","orange"),lty=c(2,1,2,2),lwd=2)

