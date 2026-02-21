SVM2CRM: support vector machine for the
cis-regulatory elements detections

Guidantonio Malagoli Tagliazucchi, Silvio Bicciato
Center for genome research
University of Modena and Reggio Emilia, Modena

October 30, 2018

October 30, 2018

Contents

1 Introduction

2 Input data and pre-processing

3 Generation of training set

4 Integration of the annotation with the signals

5 Variables selection

6 Tuning parameters for SVM

7 Prediction genome wide

8 References

9 Session information

1

Introduction

1

2

3

4

5

7

9

12

13

The genome-wide identiﬁcation of cis-regulatory elements (CRE), i.e., those
DNA sequences, as promoters, enhancers, insulators, and silencers required

1

to regulate gene expression, still represents a major challenge for compu-
tational biology. Recently, the question has been addressed through the
analysis of ChIP-seq data with algorithms based on, e.g., Hidden Markov
Models ([1]). All these approaches require ChIP-seq data for a variety of
histone marks, but a consensus on the optimal set of histone modiﬁcations
for an eﬃcient identiﬁcation of CRE has not been reached yet. Here we
report a computational procedure based on LibLinear ([2]) and ChIP-seq
data to determine the optimal number of histone marks necessary for the
genome-wide identiﬁcation of cis-regulatory elements. The methods ﬁrst
performed a step of feature selection to reduce the number of histone marks
to use during the analysis. In SVM2CRM we implemented a method based
on k-means algorithms followed by the estimation of the index coverage of
regualtory regions (ICRR). This value compares the coverage and the signals
of the histone marks associated with enhancers and background genomic re-
gions. Then we implemented a function that generate all combinations of
histone marksmodels using from n (number minimum of histone marks) to
M (number maximum of histone marks). After this step the user can select
the best combination of histone marks to predict enhancers.In this vignette
we used SVM2CRM on a reduce public ChIP-seq dataset from CD4+ T-
cells([3]). Questions, comments or bug reports about this document or about
the SVM2CRM functions are welcome. Please address them to the author
(guidantonio.malagolitagliazucchi@unimore.it).

2

Input data and pre-processing

The ﬁrst step of the analysis with SVM2CRM is the preprocessing of the
data. Basically, SVM2CRM allows to import bed ﬁles in the working direc-
tory using cisREﬁndbed function. This bed ﬁles to import should be contain
the signals of each histone marks considering the windows size deﬁned by the
user. For details about this object see documentation of SVM2CRMdata.
Specially this function requires diverse parameters. A vector with the list of
bed ﬁles that the user want use. The bin.size and the window size that re-
spectivelly represent the size of bin used to normalized the data (e.g. 100bp)
and windows size that the user want to use to describe the signal of each his-
tone marks (e.g. 1000bp). Finally, the user can set a function to smooth the
signal of the histone marks inside a particular window (e.g. median). During
this step cisREﬁndbed generate a data.frame that contains in the columns
the histone marks, and in the rows the corresponding signals genome-wide.
In the follow example we used cisREﬁndbed on chromosome 1 and using a

2

windows size of 1000bp without provide a function to model the signals. To
reduce the computational cost we considered only one histone modiﬁcation,
but the user can re-run the analysis using all histone modiﬁcation provide
in this package in the external dataset folder.

> library(SVM2CRM)
> library(SVM2CRMdata)
> library(GenomicRanges)
> library(rtracklayer)
> library(zoo)
> library(squash)
> library(pls)

> setwd(system.file("extdata", package = "SVM2CRMdata"))
> chr<-"chr1"
> bin.size<-100
> windows<-1000
> smoothing<-"FALSE"
> function.smoothing<-"median"
> list_file<-grep(dir(),pattern=".bz2",value=TRUE)
>
> #completeTABLE_example<-cisREfindbed(list_file=list_file[1],chr=chr,bin.size=bin.size,windows=windows,window.smooth=window.smooth,smoothing="FALSE",function.smoothing="median")
>
> #str(completeTABLE_example)

3 Generation of training set

In the second step SVM2CRM requires to generate the training set. The
user can create this set using getSignal function. getSignal function as for
cisREﬁndbed require to deﬁne the list of bed ﬁles of the histone modiﬁca-
tions to use during the analysis and two tables with the genomics coordinates
of the ”features”, e.g. the p300 binding sites that describe enhancers regions
and random regions of the genome. This function simply models the sig-
nals of each histone marks around the features used in the input ﬁles and
considering the bin.size and windows size deﬁned during the step of pre-
processing. Here we used two training set already generated using getSignal
function.The ﬁrst one contain the signal of the histone marks in correspon-
dence of p300 binding sites (or other genomic-regions of true enhancers).
The second matrix contains the signals of the histone marks in correspon-
In the
dence of genomic-random regions (background genomic regions).

3

follow comment lines we reported two examples of the usage of getSignal
function. Finally we merged together the results of getSignal.

> setwd(system.file("data",package="SVM2CRMdata"))
> load("CD4_matrixInputSVMbin100window1000.rda")
> completeTABLE<-CD4_matrixInputSVMbin100window1000
> new.strings<-gsub(x=colnames(completeTABLE[,c(6:ncol(completeTABLE))]),pattern="CD4.",replacement="")
> new.strings<-gsub(new.strings,pattern=".norm.w100.bed",replacement="")
> colnames(completeTABLE)[c(6:ncol(completeTABLE))]<-new.strings
> #list_file<-grep(dir(),pattern=".sort.txt",value=T)
>
> setwd(system.file("data",package="SVM2CRMdata"))
> load("train_positive.rda")
> load("train_negative.rda")
> #train_positive<-getSignal(list_file,chr="chr1",reference="p300.distal.fromTSS.txt",win.size=500,bin.size=100,label1="enhancers")
> #train_negative<-getSignal(list_file,chr="chr1",reference="random.region.hg18.nop300.txt",win.size=500,bin.size=100,label1="not_enhancers")
> #training_set<-rbind(train_positive,train_negative)
>
> training_set<-rbind(train_positive,train_negative)
> colnames(training_set)[c(5:ncol(training_set))]<-gsub(x=gsub(x=colnames(training_set[,c(5:ncol(training_set))]),pattern="sort.txt.",replacement=""),pattern="CD4.",replacement="")

4

Integration of the annotation with the signals

Using createSVMinput we can integrate the results of getSignal with an
annotation of cis-regulatory elements already characterized and then add
two labels that describe for example if a particular genomic region is an
enhancer region or not. The user can set speciﬁc two labels to indicate the
functional role of the chromatin. (e.g. ”enhancers”, ”not enhancers”)

> setwd(system.file("extdata", package = "SVM2CRMdata"))
> data_level2 <- read.table(file = "GSM393946.distal.p300fromTSS.txt",sep = "\t", stringsAsFactors = FALSE)
> data_level2<-data_level2[data_level2[,1]=="chr1",]
> DB <- data_level2[, c(1:3)]
> colnames(DB)<-c("chromosome","start","end")
> label <- "p300"
> table.final.overlap<-findFeatureOverlap(query=completeTABLE,subject=DB,select="all")
> data_enhancer_svm<-createSVMinput(inputpos=table.final.overlap,inputfull=completeTABLE,label1="enhancers",label2="not_enhancers")
> colnames(data_enhancer_svm)[c(5:ncol(data_enhancer_svm))]<-gsub(gsub(x=colnames(data_enhancer_svm[,c(5:ncol(data_enhancer_svm))]),pattern="CD4.",replacement=""),pattern=".norm.w100.bed",replacement="")
>

4

5 Variables selection

When the users want to perform the research genome-wide of enhancers
regions can handle ChIP-seq dataset containing several experiments of dif-
ferent histone marks. The number of histone modiﬁcations is certainly a
variable that impacts on the prediction of enhancers. Diﬀerent works tried to
deﬁne which is the best combination of histone marks to predict enhancers.
However it seems that until now there is not a consensus about the optimal
number of histone marks for the prediction of this class of cis-regulatory
elements. Moreover, in the genome the number of histone marks is greater
than of 50 and the functional and biological roles of each of those are not
yet clear. From the computationl aspect, consider a large number of vari-
ables (histone marks) can introduce biases. In particular redundant signals
between histone marks can be considered. Source of error on the prediction
of enhancers is the usage of histone marks that are slightly associated with
enhancers regions. For that reason, before the perfoming the prediction of
enhancers it is necessary to ﬁlter the initial dataset from the variables that
could inﬂuence the analysis of prediction. Therefore we implemented a step
of features selection in SVM2CRM. In particular we developed a two step
based procedure of variable ﬁltering encoded in smoothInputFS and featSe-
lectionWithKmeans functions based on k-means algorithm and the index of
coverage of the regulatory regions ICRR. In the ﬁrst step smoothInputFS
allow to perfom the signals smoothing of each histone mark. For example,
if the data were binned of 100 bp, a windows size of smoothing equal to 2
means that the signal of the histone marks is smooth every 200 bp. Next
using k-means algorithm with a nk number of histone marks deﬁnes by the
user it is possible clusterized the signals of the histone marks and estimate
the means of these inside each group with featSelectionWithKmeans. In the
second step the index coverage of the regulatory regions (ICRR) is estimated
(for details see. the documentation of featSelectionWithKmeans function).
Brieﬂy, this is an index that is computed from the total coverage of the
positive features (e.g. p300 binding sites) and background genomic regions
and associates the signals of eachclass with the coverages. The results of
featSelectionWithKmeans can be ﬁltered using two thresholds based on the
signals median of histone marks and considering the a ICRR values maxi-
mum. This values assume values from 0 to 1. A value close to 0 means that
the diﬀerence between the coverage of the two classes of enhancers is little,
in contrast, if this value is close to 1 this means that there is a diversity
between the two fraction of the cis-regulatory elements. featSelectionWith-
Kmeans is a function that returns a object (list) with diﬀerent elements. The

5

ﬁrst one contain a matrix with the results of the feature selection analysis,
the parameters deﬁned by the user and the histone marks recovered after
feature selection. Finally the user can visualize the results of the analysis
from two plot: in theﬁrst the x-axis contain the name of the histone marks
while in y-axis the median of mean of each group.The second plot contains
the index of coverage between enhancers and not enhancers regions.

Here we created a vector with the list of histone marks to use during the

step of features selection.

> listcolnames<-c("H2AK5ac","H2AK9ac","H3K23ac","H3K27ac","H3K4me1","H3K4me2","H3K4me3")

The ﬁrst step of feature selection perfoms the smoothing of the signals
using a windows size of k, here for e.g. we set k equal to 20 that correspond
to 20*100=2000

> dftotann<-smoothInputFS(train_positive[,c(6:ncol(train_positive))],listcolnames,k=20)

[1] "H2AK5ac"
[1] "rename"
[1] "H2AK9ac"
[1] "rename"
[1] "H3K23ac"
[1] "rename"
[1] "H3K27ac"
[1] "rename"
[1] "H3K4me1"
[1] "rename"
[1] "H3K4me2"
[1] "rename"
[1] "H3K4me3"
[1] "rename"

The second step allows to run the feature selection step. The only pa-
rameter required is the number of cluster for k-means algorihtm (nk). feat-
SelectionWithKmeans implement also the automatically investigation of nk
clusters using a Bayesian Information Criterion for EM initialized.

> results<-featSelectionWithKmeans(dftotann,5)

[1] "H2AK5ac_1"
[1] "H2AK9ac_1"
[1] "H3K23ac_1"

6

[1] "H3K27ac_1"
[1] "H3K4me1_1"
[1] "H3K4me2_1"
[1] "H3K4me3_1"
[1] "H2AK5ac_1"
[1] "H2AK9ac_1"
[1] "H3K23ac_1"
[1] "H3K27ac_1"
[1] "H3K4me1_1"
[1] "H3K4me2_1"
[1] "H3K4me3_1"

The ”results” object is a list that containg 7 elements. Here we save a
data.frame that contain in the ﬁrst column all histone marks, in the second
column the signals of the histone modiﬁcations smooth. In the last column
are the ICRR values.

>

resultsFS<-results[[7]]

A second threshold based on the ICRR values was used. In fact in the
plot generated with featSelectionWithKmeans we observed that for some
histone marks with high signals they have also high values of ICRR. This
means that these features have high signals for few cis-regulatory elements.
Here we ﬁltered using a value of ”0.5”.

> resultsFSfilterICRR<-resultsFS[which(resultsFS[,3]<0.26),]

The list of histone marks after feature selection analysis is saved.

> listHM<-resultsFSfilterICRR[,1]
> listHM<-gsub(gsub(listHM,pattern="_.",replacement=""),pattern="CD4.",replacement="")

Finally we saved the list of histone marks after feature selection analysis.

> selectFeature<-grep(x=colnames(training_set[,c(6:ncol(training_set))]),pattern=paste(listHM,collapse="|"),value=TRUE)
> colSelect<-c("chromosome","start","end","label",selectFeature)
> training_set<-training_set[,colSelect]
>

6 Tuning parameters for SVM

SVM2CRM implements function from LibLinear package. Before to pro-
ceeding with to prediction it is necessary performs the tuning of parameters

7

for svm predictions. Diﬀerent parameters can be tuned by the user to predict
the diﬀerent classes correctly. The ﬁrst parameter to deﬁne is the the weight
of each class. If you generated a training set with a diﬀerent number of posi-
tive and negative examples (e.g. the binding sites of p300 or random regions)
you need to set the weight of each class (e.g. enhancers/not enhancers) to
investigate the eﬀect of the weights on the prediction. The second important
parameter to deﬁne is the type of kernel ”typeSVM”. SVM2CRM is based
on LibLinear . This package implement diﬀerent kinds of kernel functions: 0
-L2- regularized logistic regression, 1 -L2-regularized L2-loss support vector
classiﬁcation (dual), 2 -L2-regularized L2-loss support vector classiﬁcation
(primal), 3 -L2-regularized L1-loss support vector classiﬁcation (dual), 4
-multi-class support vector classiﬁcation by Crammer and Singer, 5 -L1-
regularized L2-loss support vector classiﬁcation, 6 -L1-regularized logistic
regression, 7-L2-regularized logistic regression (dual). The last parameter
to set is ”costV”, the cost of constraints violation. The default value is 1.
Finally, if you have more than 2 histone marks, you need to ﬁnd which is the
best combination of histone modiﬁcation to predict cis-regulatory elements.
SVM2CRM allows to perform this analysis using tuningParametersCom-
bROC function. tuningParametersCombROC implements performanceSVM
function that estimate the performance of prediction during each iteration
of tuningParametersCombROC (for details ?perfomanceSVM). The function
tuningParametersCombROC allow high ﬂexibility: the user can initially set
the type of kernel, the cost, the number of histone marks. The output of
tuningParametersCombROC is a data.frame where for each model there are
the parameters compute with performanceSVM. To help the user to discrim-
inate how to choose the best model SVM2CRM implement several functions
to plot the performance obtained with performanceSVM during the use of
tuningParametersCombROC. In the follow code we wanted asses the perfo-
mance of prediction using all histone marks avaible after the step of feature
selection. Then, we created several vectors containing diﬀerent parameters
of typeSVM and costV, but we run the analysis only using typeSVM and
costV equal to 0.

> vecS <- c(2:length(listHM))
> typeSVM <- c(0, 6, 7)[1]
> costV <- c(0.001, 0.01, 0.1, 1, 10, 100, 1000)[6]
> infofile<-data.frame(a=c(paste(listHM,"signal",sep=".")))
> infofile[,1]<-gsub(gsub(x=infofile[,1],pattern="CD4.",replacement=""),pattern=".sort.bed",replacement="")

In this example we test the perfomance of all models considerig a cost

8

0, a L2- regularized logistic regression and we set a number of positive and
negative classes respectivelly of 100 and 400.

> tuningTAB <- tuningParametersCombROC(training_set = training_set, typeSVM = typeSVM, costV = costV,different.weight="TRUE", vecS = vecS[1],pcClass=100,ncClass=400,infofile)

[1] "last comparison"
[1] 6 2
[1] 6 2
[1] "k-fold-validation in all combination"
[1] "H2AK5ac.signal" "H3K23ac.signal"
[1] "H2AK5ac.signal" "H3K4me1.signal"
[1] "H2AK5ac.signal" "H3K4me2.signal"
[1] "H3K23ac.signal" "H3K4me1.signal"
[1] "H3K23ac.signal" "H3K4me2.signal"
[1] "H3K4me1.signal" "H3K4me2.signal"

Because tuningParametersCombROC estimate the performance of pre-
diction for each model the user can ﬁlter the results using several criteria
(e.g. sensitivity, speciﬁcity etc). Here we used the F-score asparameter to
reduce the total number of generated models. For each dataset and cell
type it is necessary to manually set the correct values of F-score adequate
to exclude the models that risk to overﬁt.
In particular we set a thresh-
olds of F-score <= to 0.95. Next the user can use a further ﬁlter using
two approaches: in the ﬁrst one perform the manually selection of the his-
tone marks with the highest frequencies. Secondly the user can use the top
models of tuningComParameterROC.

Here we used a F-score of 0.95 such threshold and selected all models with
the number of histone marks that is greater than 2 and with maximimum
F-score.

> tuningTABfilter<-tuningTAB[(tuningTAB$fscore<0.95),]
> row_max_fscore<-which.max(tuningTABfilter[,"fscore"])
> listHM_prediction<-gsub(tuningTABfilter[row_max_fscore,4],pattern="//",replacement="|")

7 Prediction genome wide

In the last step, the user can perfom the prediction of enhancers genome-
wide using the histone marks deﬁned during the step of feature selection and
the best parameters selected using tuningParametersCombROC. The pre-
diction of cis-regulatory elements genome-wide is possibile using the function

9

predictionGW. This function return a bed ﬁle with the genomic coordinate
of putative-enhancers.

> columnPR<-grep(colnames(training_set),pattern=paste(listHM_prediction,collapse="|"),value=TRUE)
> predictionGW(training_set=training_set,data_enhancer_svm=data_enhancer_svm, listHM=columnPR,pcClass.string="enhancers",nClass.string="not_enhancers",pcClass=100,ncClas=400,cost=100,type=0,"prediction_enhancers_CD4_results_cost=100_type=0")

[[1]]
An object of class "performance"
Slot "x.name":
[1] "None"

Slot "y.name":
[1] "Area under the ROC curve"

Slot "alpha.name":
[1] "none"

Slot "x.values":
list()

Slot "y.values":
[[1]]
[1] 0.9684336

[[2]]
[1] 0.9821534

[[3]]
[1] 0.9775996

Slot "alpha.values":
list()

[[2]]

tpr.sensitivity

fpr

acc

res
res1
res2

0.9352941 0.09377902 0.9101844 0.9205281
0.9375000 0.08246445 0.9206095 0.9274103
0.9548387 0.07967033 0.9246191 0.9372667

10

fscore spc.specificity

ppv
0.9062210 0.6115385
0.9175355 0.6741573
0.9203297 0.6297872

fdr
npv
res 0.9888551 0.3884615
res1 0.9877551 0.3258427
res2 0.9930830 0.3702128

[[3]]
[1] 0.008201656 0.008796977 0.010099196

[[4]]
[1] 2.429945e-86 8.043030e-101 4.625685e-83

11

8 References

References

[1] Kheradpour P Ernst J, Mikkelsen TS, Shoresh N, Ward LD, Zhang X
Epstein CB, Issner R Wang L, Ku M Coyne M, Durham T, and Bern-
stein BE Kellis M. Mapping and analysis of chromatin state dynamics
in nine human cell types. Nature, 473(7345):43–9, 2011.

[2] KW Chang RE Fan, CJ Hsieh, and CJ Lin. XR Wang. Liblinear: A
library for large linear classiﬁcation. Journal of Machine Learning Re-
search, (51):1871–1874, 2008.

[3] Rosenfeld JA Wang Z, Zang C, Schones DE, Cuddapah S Barski A,
Roh TY Cui K, Zhang MQ Peng W, and Zhao K. Combinatorial patterns
of histone acetylations andmethylations in the human genome. Nature
Genetics, 7(40):897–903, 2008.

12

9 Session information

The output in this vignette was produced under the following conditions:

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats4
[8] methods

base

stats

graphics grDevices utils

datasets

other attached packages:

[1] pls_2.7-0
[4] rtracklayer_1.42.0
[7] IRanges_2.16.0
[10] SVM2CRM_1.14.0

zoo_1.8-4

squash_1.0.8
GenomicRanges_1.34.0 GenomeInfoDb_1.18.0
BiocGenerics_0.28.0
S4Vectors_0.20.0
LiblineaR_2.10-8
SVM2CRMdata_1.13.0

loaded via a namespace (and not attached):

[1] Rcpp_0.12.19
[3] XVector_0.22.0
[5] tools_3.5.1
[7] mclust_5.4.1
[9] bit_1.1-14

[11] dotCall64_1.0-0
[13] RSQLite_2.1.1
[15] Matrix_1.2-14

compiler_3.5.1
bitops_1.0-6
zlibbioc_1.28.0
digest_0.6.18
boot_1.3-20
memoise_1.1.0
lattice_0.20-35
DBI_1.0.0

13

[17] DelayedArray_0.8.0
[19] GenomeInfoDbData_1.2.0
[21] gtools_3.8.1
[23] fields_9.6
[25] bit64_0.9-7
[27] Biobase_2.42.0
[29] AnnotationDbi_1.44.0
[31] BiocParallel_1.16.0
[33] blob_1.1.1
[35] MASS_7.3-51
[37] Rsamtools_1.34.0
[39] matrixStats_0.54.0
[41] SummarizedExperiment_1.12.0 KernSmooth_2.23-15
[43] proxy_0.4-22
[45] verification_1.42

spam_2.2-0
Biostrings_2.50.0
caTools_1.17.1.1
maps_3.3.0
grid_3.5.1
dtw_1.20-1
XML_3.98-1.16
gdata_2.18.0
ROCR_1.0-7
CircStats_0.2-6
gplots_3.0.1
GenomicAlignments_1.18.0

RCurl_1.95-4.11

14

