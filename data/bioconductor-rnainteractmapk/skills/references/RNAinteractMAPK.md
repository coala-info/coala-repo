Mapping of Signalling Networks through Synthetic Genetic
Interaction Analysis by RNAi

Bernd Fischer

November 1, 2018

Contents

1 Introduction

2 Installation of the RNAinteractMAPK package

3 Loading data and creating an RNAinteract object

4 Main analysis of the synthetic genetic interaction screen

4.1 Creation of an RNAinteract object from ﬂat ﬁles . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Single RNAi eﬀects and pairwise interactions

5 Main ﬁgures

6 Supplementary Figures

7 Tables

1 Introduction

1

1

2

2
2
2

3

5

23

The package contains the data from the RNAi interaction screen reported in

Thomas Horn, Thomas Sandmann, Bernd Fischer, Elin Axelsson, Wolfgang Huber, and
Michael Boutros (2011): Mapping of Signalling Networks through Synthetic Genetic
Interaction Analysis by RNAi, Nature Methods 8(4): 341-346.

This vignette shows the R code for ploting all ﬁgures in the paper.

2 Installation of the RNAinteractMAPK package

To install the package RNAinteractMAPK, you need a running version of R (www.r-project.org, version ≥ 2.13.0).
After installing R you can run the following commands from the R command shell to install RNAinteractMAPK
and all required packages.

> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install("RNAinteractMAPK")

install.packages("BiocManager")

1

3 Loading data and creating an RNAinteract object

The package RNAinteractMAPK is loaded by the following command.

> library("RNAinteractMAPK")

The package contains the data and the source code for reproducing all ﬁgures from the paper Mapping of
Signalling Networks through Synthetic Genetic Interaction Analysis by RNAi by Horn, Sandmann, Fischer,
Huber, Boutros, Mapping of Signalling Networks through Synthetic Genetic Interaction Analysis by RNAi,
Nature Methods, 2011. Most of the underlying analysis is implemented in the software package RNAinteract.
Please refer to the RNAinteract vignette for further details.
The main interaction matrix PI can be loaded by the following by the following code.

> data("Dmel2PPMAPK", package="RNAinteractMAPK")
> PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean", withoutgroups = c("pos", "neg"))

If you want to reproduce a single ﬁgure you can now immediately jump to the respective section and run the
code within one section. The source code shown in this PDF document shows the essential part of the analysis.
Sometimes, some further formatting is needed to produce the plots as shown here; the code for that is not
displayed in the PDF, but can be accessed in the Sweave ﬁle RNAinteractMAPK.Rnw. The R code is extracted
from the Sweave ﬁle and written to a ﬁle RNAinteractMAPK.R by

> Stangle(system.file("doc", "RNAinteractMAPK.Rnw", package="RNAinteractMAPK"))

It is an R-script that reproduces all ﬁgures including any formatting steps. In addition it is easier to copy the
code out of the R script to the R console when going through this manuscript.

4 Main analysis of the synthetic genetic interaction screen

4.1 Creation of an RNAinteract object from ﬂat ﬁles

The raw data of the screen and the plate conﬁguration can be found in the following directory

> inputpath = system.file("extdata", "Dmel2PPMAPK",package="RNAinteractMAPK")
> inputpath

The directory inputpath contains ﬁve text ﬁles:
Platelist.txt, Targets.txt, Reagents.txt, TemplateDesign.txt, QueryDesign.txt.
See the vignette of RNAinteract for further details on the ﬁle formats. The data and annotation are loaded and
an RNAinteract object is created with the following command.

> Dmel2PPMAPK = createRNAinteractFromFiles(name="Pairwise PPMAPK screen", path = inputpath)

The object Dmel2PPMAPK contains two replicate screens and three readout channels.

> getScreenNames(Dmel2PPMAPK)

[1] "1" "2"

> getChannelNames(Dmel2PPMAPK)

[1] "nrCells"

"area"

"intensity"

4.2 Single RNAi eﬀects and pairwise interactions

First, the single perturbation eﬀects (called main eﬀects) are estimated from the screen. For each template
position and for each query reagent a main eﬀect is estimated.

> Dmel2PPMAPK <- estimateMainEffect(Dmel2PPMAPK)
> Dmel2PPMAPK <- normalizeMainEffectQuery(Dmel2PPMAPK,batch=rep(1:4,each=48))
> Dmel2PPMAPK <- normalizeMainEffectTemplate(Dmel2PPMAPK, channel="intensity")

2

In our data, the main eﬀect contained apparent time or plate dependent trends. We adjusted and removed them.
The normalization of the main eﬀects does not inﬂuence the subsequent estimation of the pairwise interaction,
but it makes the main eﬀects better comparable between replicates and diﬀerent screens. Next, the pairwise
interaction term was estimated.

> Dmel2PPMAPK <- computePI(Dmel2PPMAPK)

The object Dmel2PPMAPK contains two replicate screens. We summarized these two screens by taking the mean
value for each measurement and added the mean screen as a new screen to the original screen.

> Dmel2PPMAPKmean <- summarizeScreens(Dmel2PPMAPK, screens=c("1","2"))
> Dmel2PPMAPK <- bindscreens(Dmel2PPMAPK, Dmel2PPMAPKmean)

Three diﬀerent p-values (t-test with pooled variance morderation, limma, and multivariate Hotelling T 2 test)
were computed by

I = which(is.finite(x))
qjob = qvalue(x[I])
q.value = rep(NA,length(x))
q.value[I] = qjob$qvalues

> library(qvalue)
> p.adj.fct <- function(x) {
+
+
+
+
+ }
> Dmel2PPMAPK <- computePValues(Dmel2PPMAPK, p.adjust.function = p.adj.fct, verbose = FALSE)
> Dmel2PPMAPKT2 <- computePValues(Dmel2PPMAPK, method="HotellingT2", p.adjust.function = p.adj.fct, verbose = FALSE)
> Dmel2PPMAPKlimma <- computePValues(Dmel2PPMAPK, method="limma", p.adjust.function = p.adj.fct, verbose = FALSE)

independently for each screen and each channel. The p-values are corrected for multiple testing by the method
of Storey, 2003. If the p.adjust.function is not speciﬁed, the method of Benjamini-Hochberg is applied.

5 Main ﬁgures

Figure 1 abc: Genetic interaction surfaces

The code to generate these is the same as that for Suppl. Figure S5, shown later in this vignette.

Figure 2: Heatmap of genetic interactions

See Suppl. Figures S6, S7, and S8.

Figure 4 b: Node degree distribution

See Suppl. Figure S11.

Figure 4 cd, Fig. 5 a: double RNAi plots for CG10376, Gap1, Cka

Double RNAi plots are plotted for three diﬀerent genes.

> plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="CG10376",
+
+
+

main="CG10376", range=c(-1, 0.05),
axisOnOrigin=FALSE, drawBox=FALSE, show.labels="q.value",
xlab="rel. nuclear count [log2]", ylab="rel. nuclear count [log2]")

> plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="Gap1",
+
+
+

main="Gap1 (CG6721)", range=c(-2.3, 1.0),
axisOnOrigin=FALSE, drawBox=FALSE, show.labels="q.value",
xlab="rel. nuclear count [log2]", ylab="rel. nuclear count [log2]")

> plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="Cka",
+
+
+

main="Cka (CG7392)", range=c(-2.3, 1.0),
axisOnOrigin=FALSE, drawBox=FALSE, show.labels="q.value",
xlab="rel. nuclear count [log2]", ylab="rel. nuclear count [log2]")

3

Figure 4 ef: Classiﬁcation

To train a classiﬁer a training set is deﬁned. A sparse linear discriminant analysis is trained individually for
each channel and each screen. By leave-one-out cross validation the cross validated posterior probability for
each gene in the training set is computed. This is an estimate of the predictive power of each classiﬁer. The
classiﬁers are combined by averaging their posterior probabilities.

RasMapKInh = c("Gap1","PTP-ER","Mkp3","aop","Pten"),
JNK = c("Gadd45","Btk29A","msn","slpr","bsk","Jra","kay"),
others = c("CG10376","CG42327","CG13197","CG12746","CG3530","CG17029","CG17598",

> traingroups = list(RasMapK = c("csw","drk","Sos","Ras85D","phl","Dsor1","rl","pnt"),
+
+
+
+
> groupcol = c(RasMapK = "blue", RasMapKInh = "orange", JNK = "green", others = "white")
> sgi <- sgisubset(Dmel2PPMAPK, screen=c("1","2"))
> CV <- MAPK.cv.classifier(sgi, traingroups)

"CG9391","CG9784","CG10089"))

In a ternary plot one can only
The cross-validated posterior probabilities are depicted by a ternary plot.
display probabilities for three classes. Since a fourth (cid:127)doubt class is included in the training set, the assignment
probability to the doubt class is depicted as the circle diameter. The smaller the circle diameter, the more likely
the gene belongs to the doubt class. The distance to the apexes shows the assignment probability of a gene
to one of the three classes given that the gene does not belong to the doubt class. In the same manner the
posterior probabilities of the classiﬁer for new genes outside the training set are shown in an extra plot.

> MAPK.plot.classification(CV$CVposterior, y=CV$y,
+
+
+
+
+
+

classes = c("RasMapKInh", "JNK", "RasMapK"),
classnames = c("RasMAPK-Inhibitors","JNK","RasMAPK"),
classcol = c("orange", "#389e33", "blue"),
main = "Cross-Validated Posterior Probabilities",
textToLeft = c("Ras85D","Sos","Dsor1")

)

> prediction <- MAPK.predict.classification(sgi, traingroups)
> MAPK.plot.classification(prediction$posteriornew,
+
+
+
+
+
+

classes = c("RasMapKInh", "JNK", "RasMapK"),
classnames = c("RasMAPK-Inhibitors","JNK","RasMAPK"),
classcol = c("orange", "#389e33", "blue"),
main = "Posterior Probabilities of genes outside training set",
textToRight = c("stg","Cka"),
threshText = 0.4)

4

−1−0.8−0.6−0.4−0.20−1−0.8−0.6−0.4−0.20rel. nuclear count [log2]rel. nuclear count [log2]lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllCG10376stgdouble RNAi effectsingle RNAi effect−2−1.5−1−0.500.51−2−1.5−1−0.500.51rel. nuclear count [log2]rel. nuclear count [log2]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllGap1 (CG6721)cdc14alphcbtPpVstgmskrlDsor1Ras85DphlcswCkadomeSospucpntPvrdrkl(1)G0232mtsPTP−ERmtmRho1Ptp69DPtendouble RNAi effectsingle RNAi effect−2−1.5−1−0.500.51−2−1.5−1−0.500.51rel. nuclear count [log2]rel. nuclear count [log2]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllCka (CG7392)Src42APtp69DmRNA−capping−enzymelicTak1JrakaymtsRho1Gap1msnPvrdrkcswPlipsynjCG17746rlcbtpntpucalphdouble RNAi effectsingle RNAi effect6 Supplementary Figures

Suppl. Figure S1: Validation of mRNA levels for single RNAi knockdowns

For each gene there were two independent dsRNA designs. The mRNA level of the targeted genes was measured
by qRT-PCR 5 days after infection. The table T contains mean and stderror over replicates of qRT-PCR
experiments for each RNAi reagent. Each row contains the mRNA levels for two RNAi designs.

levels=c("design 1","design 2")))

levels=mRNAsingleKDefficiency[I,"Symbol"]),

design=factor(rep(c("design 1","design 2"),each=89),

sd=c(mRNAsingleKDefficiency[,"StderrDesign1"],mRNAsingleKDefficiency[,"StderrDesign2"]),
Gene=factor(c(mRNAsingleKDefficiency[,"Symbol"],mRNAsingleKDefficiency[,"Symbol"]),

> data("mRNAsingleKDefficiency", package = "RNAinteractMAPK")
> hh <- apply(as.matrix(mRNAsingleKDefficiency[,c("MeanDesign1","MeanDesign2")]),1,mean)
> I <- order(-hh)
> D <- data.frame(mRNAlevel=c(mRNAsingleKDefficiency[,"MeanDesign1"],mRNAsingleKDefficiency[,"MeanDesign2"]),
+
+
+
+
+
> library(lattice)
> bc <- barchart(mRNAlevel ~ Gene, data = D,
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
>

layout = c(1,1), origin = 1, stack = FALSE,
group = D$design, col = c("lightblue", "red"),
auto.key = list(points=FALSE, rectangles = TRUE, corner = c(0.97,0.97)),
par.settings = list(superpose.polygon = list(col=c("lightblue", "red"))),
xlab="Gene", ylab = "mRNA level",
sub = "error bars: standard deviation", col.sub = "gray30",
scales = list(x = list(cex=0.7,rot = 45), y=list(tick.number=9)),
ylim=c(0,1.82), main = "mRNA Knock Down Efficiency",
panel=function(...) {

panel.abline(h=seq(0.2, 1.9, by=0.2),lty="dotted")
panel.abline(h=1)
panel.barchart(...)
x = (as.integer(D$Gene) + 0.375 * (as.integer(D$design) - (2 + 1)/2))
y1 = D$mRNAlevel - D$sd
y2 = D$mRNAlevel + D$sd
panel.arrows(x,y1,x,y2,code=3,angle=90,length=0.03,col="gray30")

} )

5

Cross−Validated Posterior ProbabilitiesRasMAPK−InhibitorsJNKRasMAPK0.80.20.80.60.40.60.40.60.40.20.80.2lllllllllllllllllllllldrkSosGap1Ras85DDsor1PtenPTP−ERaopmsnrlpntkaycswJrabskslprphlPosterior Probabilities of genes outside training setRasMAPK−InhibitorsJNKRasMAPK0.80.20.80.60.40.60.40.60.40.20.80.2llllllllllllllllllllllllllllllllllllllllllllllllllllllllmtsdomePtp69DpucalphmtmPtp61FTak1DoaCkaPvrstgmoplicsharkRho1cbtPpVSrc42ACG3573mRNA−capping−enzymeMekk1mskSrc64BMkk4Suppl. Figure S2: Validation of mRNA levels for double RNAi knockdowns

The mRNA level of 8 genes was measured by qRT-PCR after RNAi knockdown of these genes in the presence
of a second RNAi knockdown. The experiment was repeated twice (passage 4, passage 42).

> data("mRNAdoubleKDefficiency", package="RNAinteractMAPK")

mRNAdoubleKDefficiency$query, groups = mRNAdoubleKDefficiency$passage, ylim=c(-5,105),

> dp <- dotplot(100-(mRNAdoubleKDefficiency$RNAi) ~ mRNAdoubleKDefficiency$template |
+
+
+
+
+

main="co-RNAi efficiency", layout = c(2,4),
xlab="template dsRNA", ylab="query gene mRNA levels [% remaining after RNAi]",
scales=list(x=list(rot=45)),
key = simpleKey(c("biol. replicate 1", "biol. replicate 2"),space = "bottom"))

6

mRNA Knock Down Efficiencyerror bars: standard deviationGenemRNA level0.20.40.60.81.01.21.41.6cbtCG10426stgPezpuckaysharkpntGadd45LaraopphlGap1Dsor1pydMkp3CanA−14FSosMtlPvrPtp10DmbtRas85DDoaRac2CG7115Ptp4EPtp99APTP−ERsshPp2C1CG3573CG42327CG3632Ptp61FPpD3slprGef26cswCG9784mRNA−cappingPtpmegwunPdpSrc42Amsn5PtaseICG17598Ckal(1)G0232mopMKP−4CG17746JraPakPtp69Drlcdc14Src64BmskdrkBtk29APtenPlipMekk1mtmCG13197Tak1domeCG12746CG10376CG6805grkalphCG10417CG3530PRL−1synjMkk4PpVCG17029p38bbskPp1alpha−96AmtsegrCG9391Rho1licdesign 1design 2Suppl. Figure S3: Single RNAi phenotypes

Load the data and the plate annotation. The number-of-cells and area features are extracted from the feature
set and features are log-transformed.

> data("singleKDphenotype", package="RNAinteractMAPK")
> singleKDphenotype[,"nrcells"] <- log2(singleKDphenotype[,"nrcells"])
> singleKDphenotype[,"area"] <- log2(singleKDphenotype[,"area"])
> # inputfile <- system.file("extdata","singleKnockDownPhenotype/annoSingleKnockDownEffect.csv",
> #
> # Anno <- read.csv(inputfile,sep=";",stringsAsFactors = FALSE)
> # Anno$Symbol <- substr(Anno$Symbol,1,12)
> # exclude csw, PTP-ER, and puc, because they are measured twice
> # F <- factor(Anno$Symbol[!(Anno$Symbol %in% c("csw_exp2","PTP-ER_exp2","puc_exp2"))])
> # F = factor(Anno$Symbol, levels = unique(Anno$Symbol[!(Anno$Symbol %in% c("csw_exp2","PTP-ER_exp2","puc_exp2"))]))

package="RNAinteractMAPK")

The experiment consisted of 4 plates. Within each plate 4 neighboring wells contained the same RNAi-reagent.
Plates 1 and 2 contained the ﬁrst RNAi design, plates 3 and 4 the second RNAi design for each gene. The
data was ﬁrst reorganized in a matrix with wells in the rows and the 4 plates in columns. The knockdown csw,
PTP-ER, and puc were measured twice in the experiment. The second experiment was removed. The data was
normalized by subtracting the shorth on each plate. For each gene on each plate the mean value was computed
for the four replicates.

> Mean <- list()
> DRho1 <- list()
> Dpnt <- list()
> for (ds in colnames(singleKDphenotype)) {
+
+

D <- matrix(singleKDphenotype[,ds],nr=384,nc=4)
Mean[[ds]] <- matrix(0.0,nr=nlevels(singleKDphenotypeAnno$Symbol),nc=4)

7

co−RNAi efficiencytemplate dsRNAquery gene mRNA levels [% remaining after RNAi]020406080100FlucCG10417CG13197CG9391egrlicPRL−1Rho1Tak1llllllllllllllllllllllllllllllllllllllllCG10417 [query dsRNA]FlucCG10417CG13197CG9391egrlicPRL−1Rho1Tak1llllllllllllllllllllllllllllllllllllllllCG13197 [query dsRNA]llllllllllllllllllllllllllllllllllllllllCG9391 [query dsRNA]020406080100llllllllllllllllllllllllllllllllllllllllegr [query dsRNA]020406080100lllllllllllllllllllllllllllllllllllllllllic [query dsRNA]llllllllllllllllllllllllllllllllllllllllPRL−1 [query dsRNA]lllllllllllllllllllllllllllllllllllllllRho1 [query dsRNA]020406080100llllllllllllllllllllllllllllllllllllllllTak1 [query dsRNA]biol. replicate 1biol. replicate 2llrow.names(Mean[[ds]]) = levels(singleKDphenotypeAnno$Symbol)
DRho1[[ds]] <- D[which(singleKDphenotypeAnno$Symbol == "Rho1"),]
Dpnt[[ds]] <- D[which(singleKDphenotypeAnno$Symbol == "pnt"),]
for (i in 1:4) {

mm <- genefilter:::shorth(D[,i],tie.limit=0.5)
DRho1[[ds]][,i] <- DRho1[[ds]][,i] - mm
Dpnt[[ds]][,i] <- Dpnt[[ds]][,i] - mm
Mean[[ds]][,i] <- tapply(D[,i]-mm,singleKDphenotypeAnno$Symbol,mean)

}

+
+
+
+
+
+
+
+
+
+ }

Rho1 shows diﬀerent phenotype than control for nrCells feature.

> t.test(as.vector(DRho1[["nrcells"]]))

One Sample t-test

data: as.vector(DRho1[["nrcells"]])
t = -105.55, df = 15, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:

-1.209427 -1.161549

sample estimates:
mean of x
-1.185488

Rho1 shows diﬀerent phenotype than control for area feature.

> t.test(as.vector(DRho1[["area"]]))

One Sample t-test

data: as.vector(DRho1[["area"]])
t = 65.777, df = 15, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:

0.5261616 0.5614030

sample estimates:
mean of x
0.5437823

pnt shows diﬀerent phenotype than control for nrCells feature.

> t.test(as.vector(Dpnt[["nrcells"]]))

One Sample t-test

data: as.vector(Dpnt[["nrcells"]])
t = -45.665, df = 15, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:

-1.598643 -1.456062

sample estimates:
mean of x
-1.527352

pnt shows diﬀerent phenotype than control for area feature.

> t.test(as.vector(Dpnt[["area"]]))

8

One Sample t-test

data: as.vector(Dpnt[["area"]])
t = -40.463, df = 15, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:

-0.4314376 -0.3882589

sample estimates:

mean of x
-0.4098483

Mean and standard deviation were computed for each RNAi design over two replicates.

> M2 <- list()
> SD2 <- list()
> M3 <- list()
> SD3 <- list()
> for (ds in colnames(singleKDphenotype)) {
+
+
+
+
+
+
+
+
+
+ }

M2[[ds]] <- matrix(NA,nr=nrow(Mean[[ds]]),nc=2)
SD2[[ds]] <- matrix(NA,nr=nrow(Mean[[ds]]),nc=2)
M2[[ds]][,1] <- apply(Mean[[ds]][,1:2],1,mean)
M2[[ds]][,2] <- apply(Mean[[ds]][,3:4],1,mean)
SD2[[ds]][,1] <- apply(Mean[[ds]][,1:2],1,sd)
SD2[[ds]][,2] <- apply(Mean[[ds]][,3:4],1,sd)

M3[[ds]] <- apply(M2[[ds]],1,mean)
SD3[[ds]] <- apply(M2[[ds]],1,sd)

A barplot was plotted for both features.

levels=c("design 1","design 2")))

Gene=factor(rep(row.names(Mean[[ds]]),2), levels=row.names(Mean[[ds]])[I]),
design=factor(rep(c("design 1","design 2"),each=nrow(Mean[[ds]])),

> ds <- "nrcells"
> I <- order(-M3[[ds]])
> D <- data.frame(level=c(M2[[ds]][,1],M2[[ds]][,2]),sd=c(SD2[[ds]][,1],SD2[[ds]][,2]),
+
+
+
> bc <- barchart(level ~ Gene, data = D,
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

layout = c(1,1), origin=0, stack = FALSE,
groups=D$design, col = c("lightblue", "red"),
auto.key = list(points = FALSE, rectangles = TRUE, corner=c(0.97,0.97)),
par.settings = list(superpose.polygon=list(col=c("lightblue", "red"))),
ylab = "rel. nuclear count [log2]",
scales = list(x = list(cex=0.7,rot = 45), y=list(tick.number=9)),
xlab="Gene",
sub = "error bars: standard deviation", col.sub = "gray40",
main = "Phenotypic Knock-Down Effect (viability)",
panel=function(...) {

panel.abline(h=c(-2,-1.5,-1,-0.5,0,0.5),lty="dotted")
panel.abline(h=0)
pbc = panel.barchart(...)
x = (as.integer(D$Gene) + 0.375 * (as.integer(D$design) - (2 + 1)/2))
y1 = D$level - D$sd
y2 = D$level + D$sd
panel.arrows(x,y1,x,y2,code=3,angle=90,length=0.03,col="gray40")

} )

9

levels=c("design 1","design 2")))

Gene=factor(rep(row.names(Mean[[ds]]),2), levels=row.names(Mean[[ds]])[I]),
design=factor(rep(c("design 1","design 2"),each=nrow(Mean[[ds]])),

> ds <- "area"
> I <- order(-M3[[ds]])
> D <- data.frame(level=c(M2[[ds]][,1],M2[[ds]][,2]),sd=c(SD2[[ds]][,1],SD2[[ds]][,2]),
+
+
+
> bc <- barchart(level ~ Gene, data = D,
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
>

layout = c(1,1), origin=0,stack = FALSE,
groups=D$design, col = c("lightblue", "red"),
auto.key = list(points = FALSE, rectangles = TRUE, corner=c(0.97,0.97)),
par.settings = list(superpose.polygon=list(col=c("lightblue", "red"))),
ylab = "relative area [log2]",
scales = list(x = list(cex=0.7,rot = 45), y=list(tick.number=9)),
xlab="Gene",
sub = "error bars: standard deviation", col.sub = "gray40",
main = "Phenotypic Knock Down Effect (area)",
panel=function(...) {

panel.abline(h=c(-2,-1.5,-1,-0.5,0,0.5),lty="dotted")
panel.abline(h=0)
pbc = panel.barchart(...)
x = (as.integer(D$Gene) + 0.375 * (as.integer(D$design) - (2 + 1)/2))
y1 = D$level - D$sd
y2 = D$level + D$sd
panel.arrows(x,y1,x,y2,code=3,angle=90,length=0.03,col="gray40")

} )

10

Phenotypic Knock−Down Effect (viability)error bars: standard deviationGenerel. nuclear count [log2]−2.0−1.5−1.0−0.50.0PpD3licPtp69DMekk1slprCG3632Pdp5PtaseIwun2mbtGap1p38bPtp10DLarRac2CG6805l(1)G0232Pp1alpha−96AMtlCG42327CG17598bskMKP−4aoppydPtpmegCG9391CG7115synjsharkCG13197CG9784Mkk4CG10426PRL−1CG10417egrSrc64BCG3530Ptp99ACG12746CanA−14FCG17029PlipgrktweGef26mskSrc42ATak1PTP−ERKrnMkp3Gadd45CG10089cdc14wunCG17746Ptp4EPtp61FmtmPezBtk29AmsnPtenDoaPp2C1CG10376domePaksshJracbtphlalphCkamRNA−cappingcswmoprlCG3573PpVpuckaySosRas85DstgDsor1Rho1mtspntdrkPvrdesign 1design 2Suppl. Figure S4: Correlation of diﬀerent features

The readout D normalized by the time-eﬀect and the pairwise interaction score PI is extracted from the
Dmel2PPMAPK-object. To speed up drawing, only 5000 randomly selected gene pairs are plotted.

> D <- getData(Dmel2PPMAPK,type="data",screen="mean")[,1,c("nrCells","area","intensity")]
> PI <- getData(Dmel2PPMAPK,type="pi",screen="mean")[,1,c("nrCells","area","intensity")]
> set.seed(491127)
> I <- sample(1:nrow(D),5000)

> MAPK.smooth.scatter(D[I,"nrCells"], D[I,"area"], respect=FALSE, nrpoints=300,
+

xlab="cell number [log2]", ylab="nuclear area [log2]")

> MAPK.smooth.scatter(D[I,"nrCells"], D[I,"intensity"], respect=FALSE, nrpoints=300,
+

xlab="cell number [log2]", ylab="mean intensity [log2]")

> MAPK.smooth.scatter(D[I,"intensity"], D[I,"area"], respect=FALSE, nrpoints=300,
+

xlab="mean intensity [log2]", ylab="nuclear area [log2]")

> MAPK.smooth.scatter(PI[I,"nrCells"], PI[I,"area"], respect=FALSE, nrpoints=300,
+

xlab="pi-score cell number [log2]", ylab="pi-score nuclear area [log2]")

> MAPK.smooth.scatter(PI[I,"nrCells"], PI[I,"intensity"], respect=FALSE, nrpoints=300,
+

xlab="pi-score cell number [log2]", ylab="pi-score mean intensity [log2]")

> MAPK.smooth.scatter(PI[I,"intensity"], PI[I,"area"], respect=FALSE, nrpoints=300,
+

xlab="pi-score mean intensity [log2]", ylab="pi-score nuclear area [log2]")

11

Phenotypic Knock Down Effect (area)error bars: standard deviationGenerelative area [log2]−0.5−0.4−0.3−0.2−0.10.00.10.20.30.40.5Rho1CG3573PtenrlmtmstgalphCG17746wunDoaGadd45Ptp61FsshPtp69DCG10089phlPp2C1pydPTP−ERMtlTak1CG3530Ptp10Dgrkl(1)G0232synjMkk4CG10426CanA−14FDsor1PezcswGef26Src64BCG10417CG17029Ptp99ACG13197Gap1cbtslprkayPdpPRL−1PpD3LarBtk29AbskPp1alpha−96APtp4EJrap38bCG3632MKP−4Plipwun2CG42327cdc14CG68055PtaseIPtpmegKrnmbtPakCG9784CG9391pucegrMkp3CG7115CG17598Mekk1CG12746sharkRac2mopaopPpVlicRas85DSostwedomemsnCkaCG10376mRNA−cappingmtsmskSrc42AdrkpntPvrdesign 1design 2Suppl. Figure S5:

For 6×6 gene pairs a dilution series was done. For each gene pair, 8×8 diﬀerent pairs of dsRNA concentration (0
ng,10 ng,20 ng,40 ng,80 ng,100 ng,120 ng,140 ng) were tested. The readout is ﬁrst reshaped into a 5-dimensional
array A (features×gene1×gene2×concentration1×concentration2).

> data("dsRNAiDilutionSeries")
> dsRNAiDilutionSeries[,"nrCells"] <- log2(dsRNAiDilutionSeries[,"nrCells",drop=FALSE])
> A <- MAPK.screen.as.array(dsRNAiDilutionSeries, dsRNAiDilutionSeriesAnno)

To reduce measurement noise the 8 × 8 concentration dependent feature surfaces are smoothed by thin plate
splines. Cross validation is performed to estimate the degree of freedom for each feature surface. Since this
process is quite time consuming you don’t need to run the next code chunk, but can load a precomputed tables
as is shown in the subsequent code chunk.

> set.seed(491127)
> # warning: Very time consuming. Go on with next code chunk and load precomputed values.
> dsRNAiDilutionSeriesDF <- MAPK.cv.TPS(A)
> write.table(dsRNAiDilutionSeriesDF, file="Figure-S06-resCV.txt", sep="\t", quote=FALSE)

Together with the data a matrix dsRNAiDilutionSeriesDF with precomputed degrees of freedom is already
loaded.
For the high resolution images in Figure 1, a thin plate spline model was ﬁtted in the interaction surface. The
interactions were estimated and the surface was screend on a 50 × 50 grid.

> TPSmodel <- MAPK.estimate.TPS(A, DF=dsRNAiDilutionSeriesDF, n.out=50)

> print(MAPK.plot.TPS.single(gene1="Ras85D", gene2="CG13197", TPSmodel=TPSmodel, range=c(-2,2)))

> print(MAPK.plot.TPS.single(gene1="Ras85D", gene2="Gap1", TPSmodel=TPSmodel, range=c(-2,2)))

> print(MAPK.plot.TPS.single(gene1="Ptp69D", gene2="Gap1", TPSmodel=TPSmodel, range=c(-2,2)))

12

1313.51414.51515.555.25.45.65.866.26.4llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllcell number [log2]nuclear area [log2]1313.51414.51515.5−5.5−5−4.5llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllcell number [log2]mean intensity [log2]−5.5−5−4.555.25.45.65.866.26.4llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllmean intensity [log2]nuclear area [log2]−1−0.500.511.52−0.4−0.200.20.40.6llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllpi−score cell number [log2]pi−score nuclear area [log2]−1−0.500.511.52−0.200.20.40.60.8llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllpi−score cell number [log2]pi−score mean intensity [log2]−0.200.20.40.60.8−0.4−0.200.20.40.6llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllpi−score mean intensity [log2]pi−score nuclear area [log2]To show a table with all 6 × 6 genetic interaction surfaces, we screen the estimated interaction surfaces with a
lower rate (25 × 25 grid).

> print(MAPK.plot.TPS.all(TPSmodel=TPSmodel, range=c(-2,2)))

Suppl. Figure S6, S7, S8:

All heatmaps show the same ordering of genes which is derived from the clustering of the genetic interaction
matrix for the cell number feature. In Figure 2, the number-of-cells interaction matrix is plotted completely.
From the area and intensity matrix only the rows containing the RasMAPK and JNK pathway members are
shown.

channel="nrCells",withoutgroups=c("pos","neg"))

> PInrcells <- getData(Dmel2PPMAPK,type="pi",format="targetMatrix",screen="mean",
+
> PIarea <- getData(Dmel2PPMAPK,type="pi",format="targetMatrix",screen="mean",
+
channel="area",withoutgroups=c("pos","neg"))
> PIintensity <- getData(Dmel2PPMAPK,type="pi",format="targetMatrix",screen="mean",
channel="intensity",withoutgroups=c("pos","neg"))
+
> PC = embedPCA(Dmel2PPMAPK, screen="mean", channel="nrCells", dim=4, withoutgroups=c("pos","neg"))
> hc = hclust(dist(PC))
> hc <- RNAinteract:::swaptree(hc, 92)
> subset1 <- row.names(PInrcells)[hc$order[1:6]]
> subset2 <- row.names(PInrcells)[hc$order[74:93]]
> allgenes <- row.names(PInrcells)[hc$order]

13

CG13197 [ng]Ras85D [ng]0501000501000.0Gap1 [ng]Ras85D [ng]0501000501000.51.01.52.0Gap1 [ng]Ptp69D [ng]050100050100−1.5−1.0−0.50.0Genetic Interaction SurfacesdsRNA concentrationdsRNA concentration050100Ptp69DPtp69D0.0CG42327Ptp69D0.00.51.01.51.52.0drkPtp69D0.00.51.0Ras85DPtp69D−1.5−1.0−0.50.0Gap1Ptp69D0.51.0CG13197Ptp69D−0.50.0Ptp69DCG42327CG42327CG42327−0.50.00.51.01.5drkCG423270.00.51.01.52.0Ras85DCG423270.5Gap1CG423270501000.00.00.51.01.5CG13197CG423270501000.00.5Ptp69Ddrk−0.50.0CG42327drkdrkdrk0.00.51.01.52.0Ras85Ddrk0.51.01.52.0Gap1drk0.00.00.0CG13197drk0.00.51.01.5Ptp69DRas85D0.0CG42327Ras85D−1.0−0.50.00.51.01.52.0drkRas85DRas85DRas85D0.51.01.52.0Gap1Ras85D0501000.0CG13197Ras85D050100−0.50.0Ptp69DGap10.51.01.5CG42327Gap10.51.01.52.0drkGap10.00.51.01.5Ras85DGap1Gap1Gap10.5CG13197Gap10501000.51.01.52.0Ptp69DCG131970501000.00.00.5CG42327CG13197050100−1.0−0.50.0drkCG131970501000.0Ras85DCG131970501000.0Gap1CG13197050100050100CG13197CG13197−2.0−1.5−1.0−0.50.00.51.01.52.0> RNAinteract:::grid.sgiDendrogram(hc = hc)

> MAPK.plot.heatmap.raster(PInrcells, subset=allgenes, hc.row = hc, hc.col=hc, pi.max=0.05)

> MAPK.plot.heatmap.raster(PIarea, subset=subset2, hc.row = hc, hc.col=hc, pi.max=0.02)

> MAPK.plot.heatmap.raster(PIarea, subset=subset1, hc.row = hc, hc.col=hc, pi.max=0.02)

> MAPK.plot.heatmap.raster(PIintensity, subset=subset2, hc.row = hc, hc.col=hc, pi.max=0.02)

> MAPK.plot.heatmap.raster(PIintensity, subset=subset1, hc.row = hc, hc.col=hc, pi.max=0.02)

The supplemental ﬁgures S6, S7, and S8 show the complete interaction matrices for the three features nrCells,
area, and intensity. The ordering of genes is the same in all three heatmaps. They are ordered according to a
clustering of the nrCells interaction map.

> grid.sgiHeatmap(PInrcells, pi.max=0.2,
+

main=expression(paste("number cells ", pi,"-score")), hc.row = hc, hc.col = hc)

> grid.sgiHeatmap(PIarea, pi.max=0.5,
+

main=expression(paste("area ", pi,"-score")), hc.row = hc, hc.col = hc)

> grid.sgiHeatmap(PIintensity, pi.max=0.5,
+

main=expression(paste("intensity ", pi,"-score")), hc.row = hc, hc.col = hc)

14

Suppl. Figure S9: Correlation of features across replicates

Scatter plots of read-out for number-of-cells feature. A scatter plot is shown for within-screen replicates, between
independent dsRNA designs, and for between-screen replicates.

> D <- getData(Dmel2PPMAPK, normalized = TRUE)
> Main <- getMainNeg(Dmel2PPMAPK)
> RepData <- getReplicateData(Dmel2PPMAPK, screen="1", channel="nrCells", type="data",
+
> IndDesignData <- getIndDesignData(Dmel2PPMAPK, screen="1", channel="nrCells", type="data",
+

normalized = TRUE)

normalized = TRUE)

> MAPK.smooth.scatter(RepData$x-Main["1","nrCells"], RepData$y-Main["1","nrCells"],
+
+
+
+

ylab=c("rel. cell number [log2]", "replicate 2"),respect=TRUE)

sprintf("cor = %0.3f", cor(RepData$x,RepData$y))),

xlab=c("rel. cell number [log2]", "replicate 1",

nrpoints=300,

> MAPK.smooth.scatter(IndDesignData$x-Main["1","nrCells"], IndDesignData$y-Main["1","nrCells"],
+
+
+
+

sprintf("cor = %0.3f", cor(IndDesignData$x,IndDesignData$y))),
ylab=c("rel. cell number [log2]", "RNAi design 2"),respect=TRUE)

xlab=c("rel. cell number [log2]", "RNAi design 1",

nrpoints=300,

> MAPK.smooth.scatter(D[,"1","nrCells"]-Main["1","nrCells"], D[,"2","nrCells"]-Main["2","nrCells"],
+
+
+
+

sprintf("cor = %0.3f", cor(D[,"1","nrCells"],D[,"2","nrCells"]))),

ylab=c("rel. cell number [log2]", "screen 2"),respect=TRUE)

xlab=c("rel. cell number [log2]", "screen 1",

nrpoints=300,

In the same way the scatter plots for area and intensity features were generated.

15

JrakaysharkslprbsklicSrc42AdomeCG3530PtpmegCanA−14FCG9784Ptp99ACG10426Gef26p38bRac25PtaseICG17029MtlCG42327Pp1alpha−96APRL−1CG17598synjCG12746egrCG10089CG13197CG10376wun2Mekk1Src64BCG10417Tak1PpD3pydCG3632mtmPtp61FCG17746PTP−ERl(1)G0232Ptp69DPtenmsnPakDoaaopPtp10DwunMkk4Ptp4EPp2C1CG9391LarCG6805Btk29AMKP−4grkPezmbtPdpGadd45CG7115alphcbtcdc14KrnMkp3sshtwePliprlphlcswmskSosRas85DDsor1CkastgmRNA−capping−enzymemopPpVCG3573Gap1Rho1pntpucdrkPvrmts−0.20.2number cells p−scoreJrakaysharkslprbsklicSrc42AdomeCG3530PtpmegCanA−14FCG9784Ptp99ACG10426Gef26p38bRac25PtaseICG17029MtlCG42327Pp1alpha−96APRL−1CG17598synjCG12746egrCG10089CG13197CG10376wun2Mekk1Src64BCG10417Tak1PpD3pydCG3632mtmPtp61FCG17746PTP−ERl(1)G0232Ptp69DPtenmsnPakDoaaopPtp10DwunMkk4Ptp4EPp2C1CG9391LarCG6805Btk29AMKP−4grkPezmbtPdpGadd45CG7115alphcbtcdc14KrnMkp3sshtwePliprlphlcswmskSosRas85DDsor1CkastgmRNA−capping−enzymemopPpVCG3573Gap1Rho1pntpucdrkPvrmts−0.60.6area p−scoreJrakaysharkslprbsklicSrc42AdomeCG3530PtpmegCanA−14FCG9784Ptp99ACG10426Gef26p38bRac25PtaseICG17029MtlCG42327Pp1alpha−96APRL−1CG17598synjCG12746egrCG10089CG13197CG10376wun2Mekk1Src64BCG10417Tak1PpD3pydCG3632mtmPtp61FCG17746PTP−ERl(1)G0232Ptp69DPtenmsnPakDoaaopPtp10DwunMkk4Ptp4EPp2C1CG9391LarCG6805Btk29AMKP−4grkPezmbtPdpGadd45CG7115alphcbtcdc14KrnMkp3sshtwePliprlphlcswmskSosRas85DDsor1CkastgmRNA−capping−enzymemopPpVCG3573Gap1Rho1pntpucdrkPvrmts−0.60.6intensity p−scoreSuppl. Figure S10: Correlation of interaction scores across replicates

Same as Figure S9, but for interaction scores.

> D <- getData(Dmel2PPMAPK, type="pi", normalized = TRUE)
> RepData <- getReplicateData(Dmel2PPMAPK, screen="1", channel="nrCells", type="pi",
+
> IndDesignData <- getIndDesignData(Dmel2PPMAPK, screen="1", channel="nrCells", type="pi",
normalized = TRUE)
+

normalized = TRUE)

> MAPK.smooth.scatter(RepData$x, RepData$y,nrpoints=300,
+
+
+

xlab=c("rel. cell number [log2]", "replicate 1",

sprintf("cor = %0.3f", cor(RepData$x, RepData$y))),

ylab=c("rel. cell number [log2]", "replicate 2"),respect=TRUE)

> MAPK.smooth.scatter(IndDesignData$x, IndDesignData$y,nrpoints=300,
+
xlab=c("rel. cell number [log2]", "RNAi design 1",
+
+
>

sprintf("cor = %0.3f", cor(IndDesignData$x, IndDesignData$y))),

ylab=c("rel. cell number [log2]", "RNAi design 2"),respect=TRUE)

> MAPK.smooth.scatter(D[,"1","nrCells"], D[,"2","nrCells"], nrpoints=300,
+
+
+

xlab=c("rel. cell number [log2]", "screen 1",

ylab=c("rel. cell number [log2]", "screen 2"),respect=TRUE)

sprintf("cor = %0.3f", cor(D[,"1","nrCells"], D[,"2","nrCells"]))),

16

−3−2.5−2−1.5−1−0.50−3−2.5−2−1.5−1−0.50llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]replicate 1cor = 0.968rel. cell number [log2]replicate 2−2.5−2−1.5−1−0.50−2.5−2−1.5−1−0.50llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]RNAi design 1cor = 0.903rel. cell number [log2]RNAi design 2−3−2−10−3−2−10llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]screen 1cor = 0.948rel. cell number [log2]screen 2−1−0.500.5−1−0.500.5llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]replicate 1cor = 0.954rel. cell number [log2]replicate 2−1−0.500.5−1−0.500.5llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]RNAi design 1cor = 0.916rel. cell number [log2]RNAi design 2−1−0.500.5−1−0.500.5llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]screen 1cor = 0.938rel. cell number [log2]screen 2−1−0.500.5−1−0.500.5llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]replicate 1cor = 0.906rel. cell number [log2]replicate 2−1−0.8−0.6−0.4−0.200.20.4−1−0.8−0.6−0.4−0.200.20.4llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]RNAi design 1cor = 0.887rel. cell number [log2]RNAi design 2−1−0.500.51−1−0.500.51llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]screen 1cor = 0.934rel. cell number [log2]screen 2Suppl. Figure S11, Figure 4 b: Node degree distributions

For each gene the number of positively and negatively interacting genes (on a global 5% FDR) is computed and
summarized in a histogram.

nrCells="Figure-4-b-nodeDegreeNrCells.pdf",
area="Figure-S11-a-nodeDegreeArea.pdf",
intensity="Figure-S11-b-nodeDegreeIntensity.pdf")

switch(channel, nrCells = "nuclear count", area = "area", intensity = "intensity"))

QV = getData(Dmel2PPMAPK, type="q.value", format="targetMatrix", screen=screen, channel=channel,

format="targetMatrix", screen=screen, channel=channel,

M = getMain(Dmel2PPMAPK,type="main",design="template",summary="target",

withoutgroups=c("pos","neg"), screen=screen,channel=channel)

filename <- switch(channel,

withoutgroups=c("pos","neg"))

withoutgroups=c("pos","neg"))

PI = getData(Dmel2PPMAPK, type="pi",

main <- sprintf("node degree distribution (%s)",

q = 0.05
by = 3
col = c("blue","yellow")

> screen = "mean"
> for (channel in c("nrCells","area","intensity")) {
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

pdf(width=4.5,height=4.5,file=filename)
mv = max(c(a.pos,a.neg))
breaks = c(-0.5,seq(0.5,mv-0.5,by=3),mv+0.5)
h=0
T = matrix(c(0,1),nr=1,nc=2)
z=1
if (by > 1) {

a.pos = apply(A.pos,1,sum)
a.neg = apply(A.neg,1,sum)
A = A.pos | A.neg
a = apply(A,1,sum)

names.arg = c("0")
for (i in 3:length(breaks)) {

A.pos = (QV <= q) & (PI > 0)
A.neg = (QV <= q) & (PI < 0)

diag(A.pos) = FALSE
diag(A.neg) = FALSE

names.arg = c(names.arg,sprintf("%d-%d",h+1,h+by))

17

−2−1012−2−1012llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]replicate 1cor = 0.639rel. cell number [log2]replicate 2−0.500.511.5−0.500.511.5llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]RNAi design 1cor = 0.567rel. cell number [log2]RNAi design 2−2−1012−2−1012llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllrel. cell number [log2]screen 1cor = 0.619rel. cell number [log2]screen 2z=z+1
for (j in 1:by) {

T = rbind(T, c(h+j,z))

}
h = h + by

}

}
h.a.pos = hist(a.pos,breaks=breaks,plot=FALSE)
h.a.neg = hist(a.neg,breaks=breaks,plot=FALSE)
df = data.frame(pos = h.a.pos$counts/92, neg = h.a.neg$counts/92, names=names.arg)
df[1,1] = df[1,2] = 0
bp=barplot(t(as.matrix(df[,c(2,1)])),beside=TRUE,col=col,main=main,
xlab="number of interactions per gene", ylab="fraction of genes",
cex.axis=1,cex.names=1,yaxt="n")

axis(2,at=c(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4),

labels=c("0%","","10%","","20%","","30%","",""))

rect(1.5,0,2.5,sum(a==0)/92,col="black")
mtext(names.arg,side=1,at=apply(bp,2,mean),cex=1,line=c(1.5,0.5))
legend("topright",c("neg. interactions", "pos. interactions"), fill=col)
dev.off()

+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ }

Suppl. Figure S12: Comparison to known interactions from DroID

The data.frame Networks contains the list of interactions reported in DroID (version 2010 10) resticted to
the gene considered in this paper. reportNetworks computes p-values with the exact Fisher test on the set of
interactions with FDR 5%.

> data("Networks", package="RNAinteractMAPK")
> reportNetworks(sgisubset(Dmel2PPMAPK, screen="mean"), Networks = Networks)

The p-values are written to a text ﬁle.

> print(read.table("networks/networks-pv-mean-nrCells.txt", sep="\t", header=TRUE))

correlation 5.826518e-14
1.766395e-15
genetic
3.591339e-03
human

p.value odds.ratio
4.104737
5.996728
2.368796

> print(read.table("networks/networks-pv-mean-area.txt", sep="\t", header=TRUE))

correlation 7.228662e-15
3.400385e-15
genetic
6.566888e-05
human

p.value odds.ratio
4.247135
5.864882
3.109088

18

node degree distribution (nuclear count)number of interactions per genefraction of genes0%01−34−67−910−1213−1516−1819−2122−24neg. interactionspos. interactionsnode degree distribution (area)number of interactions per genefraction of genes0%01−34−67−910−1213−1516−1819−21neg. interactionspos. interactionsnode degree distribution (intensity)number of interactions per genefraction of genes0%01−34−67−910−1213−1516−1819−21neg. interactionspos. interactions> print(read.table("networks/networks-pv-mean-intensity.txt", sep="\t", header=TRUE))

correlation 4.392413e-13
1.211680e-16
genetic
1.674841e-02
human

p.value odds.ratio
4.140770
6.712831
2.110339

Suppl. Figure S13: Known protein-protein interactions are overrepresented

The genetic interactions (FDR 5%) are compared to known physical interactions between the genes. Since
the DroID database only reports 3 physical interactions among the considered genes, all direct links on the
RasMAPK and JNK pathways are regarded as known physical interactions. Since, in the genetic interaction
screen, there are much more interactions within the two pathways than between phosphatases, only a subset
of the complete genetic interaction matrix is compared. We selected only those gene pairs within one of the
two pathways and compared the genetic interactions among these with the physical interactions (direct links
on pathway).
At ﬁrst a complete interaction matrix INT extracted from the screeen with the entries −1, 0, 1 for negative
interaction, no interaction, and positive interaction.

screen="mean", channel="nrCells", withoutgroups=c("pos","neg"))

> PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix",
+
> QV <- getData(Dmel2PPMAPK, type="q.value", format="targetMatrix",
+
> INT <- matrix(0, nr=93, nc=93)
> INT[QV <= 0.05] = 1
> INT[(QV <= 0.05) & (PI < 0)] = -1
> diag(INT) <- NA

screen="mean", channel="nrCells", withoutgroups=c("pos","neg"))

The matrices G1 and G2 contain the information, which genes are part of the RasMAPK or JNK pathway.

> data("pathwayMembership", package="RNAinteractMAPK")
> G1 <- matrix(pathwayMembership[row.names(PI)], nr=93, nc=93)
> G2 <- t(G1)
> diag(G1) <- diag(G2) <- NA

19

ll3272011483805280101nrCellscorrelation148327 53ll339118 773804570101nrCellsgenetic 77339 41ll364 87 713804510101nrCellshuman 71364 16ll3322011463875330101areacorrelation146332 55ll346118 773874640101areagenetic 77346 41ll367 87 673874540101areahuman 67367 20ll2872011533354880101intensitycorrelation153287 48ll295118 783354130101intensitygenetic 78295 40ll322 87 743354090101intensityhuman 74322 13The physical interactions (direct links in the pathways) are loaded and stored in a matrix with 0 for no physical
interaction and 1 for interaction.

> data("PhysicalInteractions", package="RNAinteractMAPK")
> isPP <- matrix(0, nr=93, nc=93, dimnames = list(row.names(PI),row.names(PI)))
> for (i in 1:nrow(PhysicalInteractions)) {
+
+
+ }
> diag(isPP) <- NA

isPP[PhysicalInteractions[i,1], PhysicalInteractions[i,2]] <- 1
isPP[PhysicalInteractions[i,2], PhysicalInteractions[i,1]] <- 1

The matrices are stored as a data.frame where each row represents one gene pair. The gene pairs within the
RasMAPK and JNK pathway are selected.

> df <- data.frame(int = as.vector(INT), G1 = as.vector(G1), G2 = as.vector(G2),
+
> df <- df[!is.na(df$G1),]
> df <- df[((df$G1 == "RASMAPK" & df$G2 == "RASMAPK") | (df$G1 == "JNK" & df$G2 == "JNK")),]

isPP = as.vector(isPP))

The continguency table of genetic and physical interactions and Fisher’s exact test comparing the two sets of
interactions.

> t <- table(df[,c(1,4)])
> print(t)

int

isPP
1
0
-1 42 12
0 374 24
56 16
1

> t3 <- t[2:3,]
> t3[2,] <- t3[2,] + t[1,]
> t3 <- t3 / 2 # the matrix is symetric and contains each gene pair twice
> print(t3)

int

isPP
1
0
0 187 12
1 49 14

> fisher.test(t3, alternative="greater")

’

Fisher

s Exact Test for Count Data

data: t3
p-value = 0.0005198
alternative hypothesis: true odds ratio is greater than 1
95 percent confidence interval:

2.025466

Inf

sample estimates:
odds ratio
4.419974

A barplot of the distribution of genetic interactions within the set of gene that physically interact and within
the set of genes were we do not have evidence of a physical interactions.

> t2 <- t
> t2[,1] <- t2[,1] / sum(t2[,1])
> t2[,2] <- t2[,2] / sum(t2[,2])
> t2 <- t2[c(1,3,2),]
> colnames(t2) <- c("no PP interaction", "PP interaction")
> barplot(t2, col=c("blue", "yellow", "gray"), main="overlap with physical interactions")

20

Suppl. Figure S14: Correlation proﬁles of Cka, Ras85 and bsk

The Pearson correlation matrix is computed from the interaction scores. The correlation proﬁle of bsk (JNK
pathway) and Ras85D (RasMAPK pathway) are plotted against the correlation proﬁle of Cka.

> PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean", channel="nrCells",
+
> C = cor(PI)

withoutgroups = c("pos", "neg"))

> plot(C["Cka",], C["Ras85D",], pch=20, cex=2, xlim=c(-1,1), ylim=c(-1,1),
+
+
+

cex.axis=2, cex.lab=2,
xlab="correlation to Cka interaction profile",
ylab="correlation to Ras85D interaction profile")

> plot(C["Cka",], C["bsk",], pch=20, cex=2, xlim=c(-1,1), ylim=c(-1,1),
+
+
+

cex.axis=2, cex.lab=2,
xlab="correlation to Cka interaction profile",
ylab="correlation to bsk interaction profile")

21

no PP interactionPP interactionoverlap with physical interactions0.00.20.40.60.81.0lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−1.0−0.50.00.51.0−1.0−0.50.00.51.0correlation to Cka interaction profilecorrelation to Ras85D interaction profilembtmskCkapucPtp99APpD3Ptp69DPdpCG3632cswkaySospntpydRas85DSrc64BdrkDsor1Mekk1p38bPvrKrnPpVstgmtsCG3573mopdomelllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−1.0−0.50.00.51.0−1.0−0.50.00.51.0correlation to Cka interaction profilecorrelation to bsk interaction profilecswSosRas85DdrkDsor1mskCkaKrnpucPpVstgCG3573mopalphbskJrakaypydSrc64BGap1sharklicMkk4Mekk1p38bslprPpD3PdpCG3632Suppl. Figure S15: Comparison between Acumen and CellTiterGlo pi-scores

The pi-score derived in the main screen were compared to the pi-score derived by a CellTiterGlo experiment. The
CellTiterGlo validation screen were performed for a small set of gene pairs for this purpose. The CellTiterGlo
data were loaded. The screen was performed in triplicates. Each replicate was located on a separate plate.
Each gene pair was repeated multiple times within one column. To eliminate plate eﬀects, a median polish was
applied. The log-transformed estimated column eﬀects were used for the further analysis.

> data("cellTiterGlo", package="RNAinteractMAPK")
> M1 <- t(matrix(cellTiterGlo$plate1,nr=24,nc=16))
> M2 <- t(matrix(cellTiterGlo$plate2,nr=24,nc=16))
> M3 <- t(matrix(cellTiterGlo$plate3,nr=24,nc=16))
> MP1 <- medpolish(M1)
> MP2 <- medpolish(M2)
> MP3 <- medpolish(M3)
> Anno <- cellTiterGlo[1:24,2:3]
> data <- log2(cbind(MP1$col+MP1$overall, MP2$col+MP2$overall, MP3$col+MP3$overall))

The respective values from the main screen were loaded.

> PIscreen <- Anno[(Anno$dsRNA_1 != "Fluc") & (Anno$dsRNA_2 != "Fluc"),]
> PIscreen$pi.screen <- log2(getData(Dmel2PPMAPK, type="pi", format="targetMatrix",
+ channel="nrCells", screen="mean", do.inv.trafo=TRUE)[as.matrix(PIscreen)])

Main eﬀects and pairwise interaction scores are estimated from the CellTiterGlo data and added to the PIscreen
data.frame.

| ((Anno$dsRNA_1 == "Fluc") & (Anno$dsRNA_2 == PIscreen[i,1])))

| ((Anno$dsRNA_1 == PIscreen[i,2]) & (Anno$dsRNA_2 == "Fluc")))

| ((Anno$dsRNA_1 == PIscreen[i,2]) & (Anno$dsRNA_2 == PIscreen[i,1])))

singleRNAi1 <- which(((Anno$dsRNA_1 == PIscreen[i,1]) & (Anno$dsRNA_2 == "Fluc"))

singleRNAi2 <- which(((Anno$dsRNA_1 == "Fluc") & (Anno$dsRNA_2 == PIscreen[i,2]))

N <- which((Anno$dsRNA_1 == "Fluc") & (Anno$dsRNA_2 == "Fluc"))
doubleRNAi <- which(((Anno$dsRNA_1 == PIscreen[i,1]) & (Anno$dsRNA_2 == PIscreen[i,2]))

> result <- data.frame(PIscreen, pi.CTG = 0.0, main1.CTG = 0.0, main2.CTG = 0.0, p.value.CTG = 1.0)
> for (i in 1:nrow(PIscreen)) {
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ }

neg <- apply(data[N,],2,mean)
main1 <- data[singleRNAi1,] - neg
main2 <- data[singleRNAi2,] - neg
nimodel <- neg + main1 + main2
piCTG <- data[doubleRNAi,] - nimodel
pvCTG <- t.test(piCTG)
result[i,"pi.CTG"] <- mean(piCTG)
result[i,"main1.CTG"] <- mean(main1)
result[i,"main2.CTG"] <- mean(main2)
result[i,"p.value.CTG"] <- t.test(piCTG)$p.value

Finally the π-score from the main screen is plotted against the π-score of the CellTitderGlo experiment.

> plot(result[,"pi.screen"], result[,"pi.CTG"], xlim=c(-0.7,1.2), ylim=c(-0.7, 1.2), pch=19,
+
+
+

xlab="pi-score main screen", ylab="pi-score cellTiterGlo",
main=sprintf("correlation of pi-score (main screen and cellTiterGlo) = %0.2f",

cor(result[,"pi.screen"], result[,"pi.CTG"])))

22

7 Tables

Suppl. Table 3:

The function reportGeneListsPaper is similar to the reportGeneLists function in the package RNAinteract.
It writes tab separated values for each of the three features (nrCells, area, intensity) as well as one text ﬁle
containing Hotellings T 2 p-value.

> Dmel2PPMAPKT2 <- computePValues(Dmel2PPMAPK, method="HotellingT2", verbose = FALSE)
> Dmel2PPMAPKlimma <- computePValues(Dmel2PPMAPK, method="limma",verbose = FALSE)
> MAPK.report.gene.lists.paper(Dmel2PPMAPK, Dmel2PPMAPKlimma, Dmel2PPMAPKT2)
> head(read.table("Tab3_nrCells.txt", sep="\t", header=TRUE))

gene1 gene2 q.value.ttest p.value.ttest q.value.limma p.value.limma

main1
mts 3.407287e-07 1.056825e-10 8.685126e-12 1.754571e-15 0.3426912
mts 2.938592e-06 1.846088e-09 1.115070e-09 9.010667e-13 0.5267007
mts 2.938592e-06 2.734355e-09 1.053069e-09 4.254825e-13 0.2542159
puc 4.111501e-06 5.100995e-09 1.115070e-09 7.129572e-13 0.7695607
puc 6.922132e-06 1.073506e-08 8.652531e-09 1.223590e-11 0.9096439
Pvr 9.292358e-06 1.729305e-08 6.031712e-09 6.598052e-12 0.3426912

1
drk
2 Rho1
Pvr
3
kay
4
Jra
5
drk
6

neg

main2

NI Measured

FBgn2
1 0.3892580 48225.76 6713.295 15088.88 2.246533 FBgn0004638 FBgn0004177
2 0.3892580 48225.76 10374.652 17829.81 1.718926 FBgn0014020 FBgn0004177
3 0.3892580 48225.76 4923.544 13037.12 2.645926 FBgn0032006 FBgn0004177
4 0.5394751 48225.76 21756.898 34910.44 1.591260 FBgn0001297 FBgn0243512
5 0.5394751 48225.76 24240.402 37124.00 1.518502 FBgn0001291 FBgn0243512
6 0.2542159 48225.76 4191.323 9143.50 2.136130 FBgn0004638 FBgn0032006

FBgn1

pi

Name1
CG2
CG1
downstream of receptor kinase
1 CG6033 CG7109
2 CG8416 CG7109
Rho1
3 CG8222 CG7109 PDGF- and VEGF-receptor related
4 CG33956 CG7850
kayak
5 CG2275 CG7850
Jun-related antigen
downstream of receptor kinase
6 CG6033 CG8222

1
2

Name2
microtubule star
microtubule star

23

llllllllll−0.50.00.51.0−0.50.00.51.0correlation of pi−score (main screen and cellTiterGlo) = 0.84pi−score main screenpi−score cellTiterGloRas85D − Gap1drk − Gap1Ras85D − drkdrk − CkaCka − Gap1puc − kaykay − drkkay − Src42Absk − pucmts − CG3573microtubule star
3
puckered
4
5
puckered
6 PDGF- and VEGF-receptor related

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
[1] parallel grid
base
[8] methods

stats

graphics grDevices utils

datasets

other attached packages:

[1] lattice_0.20-35
[4] RNAinteract_1.30.0
[7] locfit_1.5-9.1

[10] fields_9.6
[13] dotCall64_1.0-0

qvalue_2.14.0
Biobase_2.42.0
abind_1.4-5
maps_3.3.0

RNAinteractMAPK_1.20.0
BiocGenerics_0.28.0
sparseLDA_0.1-9
spam_2.2-0

loaded via a namespace (and not attached):

[1] vsn_3.50.0
[4] elasticnet_1.1.1
[7] assertthat_0.2.0

bit64_0.9-7
gtools_3.8.1
BiocManager_1.30.3
latticeExtra_0.6-28
Category_2.48.0
pillar_1.3.0
limma_3.38.0
colorspace_1.3-2
survey_3.34
pcaPP_1.9-73
genefilter_1.64.0
xtable_1.8-3
gdata_2.18.0
tibble_1.4.2
IRanges_2.16.0
survival_2.43-1
memoise_1.1.0
hwriter_1.3.2
tools_3.5.1
munsell_0.5.0

[10] stats4_3.5.1
[13] blob_1.1.1
[16] splots_1.48.0
[19] glue_1.3.0
[22] RColorBrewer_1.1-2
[25] Matrix_1.2-14
[28] GSEABase_1.44.0
[31] pkgconfig_2.0.2
[34] purrr_0.2.5
[37] scales_1.0.0
[40] cellHTS2_2.46.0
[43] mda_0.4-10
[46] lazyeval_0.2.1
[49] crayon_1.3.4
[52] gplots_3.0.1
[55] graph_1.60.0
[58] S4Vectors_0.20.0
[61] AnnotationDbi_1.44.0 bindrcpp_0.2.2
[64] caTools_1.17.1.1
[67] bitops_1.0-6
[70] DBI_1.0.0

rlang_0.3.0.1
gtable_0.2.0
reshape2_1.4.3

splines_3.5.1
ICSNP_1.1-1
affy_1.60.0
RBGL_1.58.0
robustbase_0.93-3
RSQLite_2.1.1
digest_0.6.18
preprocessCore_1.44.0
plyr_1.8.4
XML_3.98-1.16
zlibbioc_1.28.0
mvtnorm_1.0-8
affyio_1.52.0
annotate_1.60.0
ggplot2_3.1.0
magrittr_1.5
MASS_7.3-51
class_7.3-14
stringr_1.3.1
cluster_2.0.7-1
compiler_3.5.1
RCurl_1.95-4.11
lars_1.2
rrcov_1.4-4

24

[73] R6_2.3.0
[76] bindr_0.1.1
[79] stringi_1.2.4
[82] geneplotter_1.60.0

dplyr_0.7.7
KernSmooth_2.23-15
Rcpp_0.12.19
DEoptimR_1.0-8

bit_1.1-14
prada_1.58.0
ICS_1.3-1
tidyselect_0.2.5

25

