MANTA:
Microbial Assemblage
Normalized Transcript Analysis
(Version 1.22.0)

Adrian Marchetti
amarchetti@unc.edu

April 24, 2017

1 Licensing

This package is licensed under the Artistic License v2.0: it is therefore free
to use and redistribute, however, we, the copyright holders, wish to maintain
primary artistic control over any further development. Please be sure to cite us
if you use this package in work leading to publication.

2

Installation

Building the manta package from source requires that you have the proper
dependency packages, caroline and edgeR, installed from CRAN and Bioconduc-
tor respectively. This can typically be accomplished via the following commands
from within the R command line environment:

’

’

install.packages(
biocLite(
biocLite(

)
http://bioconductor.org/biocLite.R
edgeR

# CRAN install
’

# Bioconductor install

caroline

’
’

)

’

)

Currently, however, the most recent development version of the edgeR pack-
age (> v2.5) is recommended. It must be downloaded from http://bioconductor.
org/packages/2.10/bioc/ and built manually. The manta and edgeR packages
should be installed from these source archives using the following commands:

R CMD INSTALL edgeR_x.y.z.tar.gz
R CMD INSTALL manta_x.y.z.tar.gz

After a successful installation the manta package can be loaded in the normal
way: by starting R and invoking the following library command:

> library(manta)

1

3

Introduction

One of the most diﬃcult aspects of working with environmental shotgun
sequence data has been the challenge of assigning reads to speciﬁc taxa that
are collectively part of a mixed community assemblage. Continued advances
in sequencing technologies–both in read lengths and throughput–have improved
taxonomic assignment certainties and boosted the signiﬁcance of diﬀerential ex-
pression [DE] analyses between samples. Key challenges, however, still remain
in performing robust DE analysis on taxonomic subsets of these community level
samples. Selection-induced shifts in the species composition of the underlying
community of study are unfortunate side-eﬀects of a multi-condition experiment
and can alter measured taxonomic proportions and confound DE analysis. This
is also applicable when comparing sequence libraries from environmental sur-
veys in space and time. Employing robust normalizing techniques to control for
these shifts is important when attempting to perform comparative transcrip-
tomics on a taxonomic subset of a metatranscriptome. Equally important is
deciding upon appropriately ﬁltered taxonomic subsets for valid DE analysis.
This document provides an introduction to the manta R package, which en-
ables comparative metatranscritomic statistical analysis by helping users decide
how to appropriately subset mixed transcript collections and thereby aide in
disentangling taxonomic abundance shifts from the underlying within-species
expression diﬀerences for subsequent DE analysis.

4 The MANTA object

The MANTA object is derivative of the DGEList object (from the edgeR
package) but additionally keeps track of taxonomic meta-information and sum-
maries of these taxonomic bins. As with its parent class, the DGEList object,
the two required inputs for manta object instantiation are: 1) read counts orga-
nized into a gene (rows) by lane (columns) matrix where each row and column
has a unique name and 2) a dataframe detailing provenance information for
each column of the count matrix (at the very minimum, a ’groups’ parameter
binning the conditions of counts into replicates of individual conditions).

> cts.path <- system.file("extdata","PapaGO-BWA.counts-diatoms.tab", package="manta")
> cts <- read.delim(cts.path)
> samples <- makeSampleDF(cts)
> obj.simple <- manta(counts= cts, samples = samples)
> print(obj.simple)
>

5 Data Input

Although the manta object can be instantiated for non-meta transcriptomic
analysis (as demonstrated in the previous section), it is often the case that the

2

original raw data is more complicated, comes in a variety of formats, and/or
contains additional information that would not otherwise be utilized. In this
section we outline several diﬀerent ways that (meta) transcriptomic (and associ-
ated) data can be read into the manta object to enable subsequent visualization
and analysis.

5.1 Counts

The simplest way to create a manta object is from raw count data. These
counts must be annotated minimally with gene names and ideally with tax-
onomic (meta) information as well. The function counts2manta (which calls
the underlying tableMetas and tableMetaSums functions) is the method you
should use when converting counts.

> cts.path <- system.file("extdata","PapaGO-BWA.counts-diatoms.tab", package="manta")
> cts <- read.delim(cts.path)
> cts.annot.path <- system.file("extdata","PapaGO-BWA.annot-diatoms.tab", package="manta")
> cts.annot <- read.delim(cts.annot.path, stringsAsFactors=FALSE)
> obj <- counts2manta(cts, annotation=cts.annot,
+
+

a.merge.clmn=
gene.clmns=c(

, agg.clmn=
’
,

query_seq
’
what_def

what_def
))

, meta.clmns=c(

pathway

family

kid

’
’

,

’

’

’

’

’

’

’

’

’

,

genus_sp

),

’

Notice that the secondary annotation table can (and often will) be completely

diﬀerent dimensions than the cts table.

5.2 Annotation Alignment

Another very common and convenient source format for manta object in-
stantiation is tabular output from an alignment program such as BLAST. It is
required that the alignment data frame have at least two columns at a mini-
mum: a gene name column and a condition column. To get full use out of the
package, however, it is recommended that taxonomic meta information is also
included. The align2manta function is the method of choice for converting this
alignment into a manta object.

> align.path <- system.file("extdata","PapaGO-BLAST.results-diatoms.tab", package="manta")
> annot.diatoms <- read.delim(align.path, stringsAsFactors=FALSE)
> obj <- align2manta(annot.diatoms, cond.clmn=
+
+

, agg.clmn=
pathway
’

gene.clmns=c(
meta.clmns=c(

treatment
,

kid
,
genus_sp

what_def
,
family

what_def

’
’

’
’

’
’

))

),

,

’

’

’

’

’

’

’

5.3 SEAStAR Format

A third possibility (a special case of count input, detailed above in 5.1) is
the Armbrust Lab’s SEASTaR format which can easily be converted into counts
via readSeastar or the seastar2manta functions: where the later is a wrapper
for the former.

3

> conditions <- caroline::nv(factor(x=1:2, labels=c(
> ss.names <- caroline::nv(paste(
> ss.paths <- system.file("extdata",ss.names, package="manta")
> df <- readSeastar(ss.paths[1])
>

,conditions,

Pgranii-

ambient

’

’

’

,

’

’

’

plusFe

’

’

’

’

’

’

)),c(
’’

ref

,
), conditions)

obs

))

.seastar

, sep=

5.4 PPlacer Format

A fourth input option is pplacer format, the output of the (shotgun sequenc-
ing read) phylogenetic placement program by the same name. This format con-
sists of a directory of gene named folders, each of which contains an underlying
SQLite taxonomic database ﬁle.

> KOG.SQLite.repo <- system.file("extdata","pplacer", package="manta")
> obj.KOG <- pplacer2manta(dir=KOG.SQLite.repo,
+
,
+
+

groups=c(
norm=FALSE, disp=FALSE
)

coastal

surface

costal

DCM

,

,

’

’

’

’

’

’

’

’

’

,

upwelling

’

),

KOG0035, KOG0119, KOG0521,

>

6 Assemblage Subsetting & Compositional Bias

One key assumption of assessing DE genes in a mixed community of organ-
isms is that they have similar diﬀerential genetic responses between conditions.
It is possible, however, that organisms within a community may not respond in
the same way under varied experimental conditions, violating this assumption
(of no-compositional bias). We have therefore developed a test to determine if
a particular community sample is composed of biased taxonomic subsets.

To test this assumption, we suggest begining with a barchart-style visual-

ization using a compbiasPlot

> compbiasPlot(obj, pair=conditions, meta.lev=

’

genus_sp

’

, meta.lev.lim=7)

We’ve also written a simple F-test function for the manta object which can

be run as follows:

> compbiasTest(obj, meta.lev=

’

genus_sp

’

)

Analysis of Variance Table

Response: R

Df Sum Sq Mean Sq F value

Pr(>F)

subtaxa
Residuals 2710 6734.9 2.4852

6

97.7 16.2884 6.5541 6.932e-07 ***

4

Figure 1: compbiasPlot(obj)

---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

If the test is signiﬁcant, it’s advisable to remove the outlier population(s) before
performing subsequent DE analysis. In the example above, the boxplots suggest
that both Pseudo-nitzschia granii & P.australis have housekeeping genes with
fold change distributions diﬀerent from the other diatom species detected in
this dataset. And indeed, compbiasTest conﬁrms that these diﬀerences are
probably not due to chance. Once this has been determined, we can subset out
and re-test like so:

> annot.diatoms.sub <- subset(annot.diatoms, !genus_sp %in% paste(
> obj.sub <- align2manta(annot.diatoms.sub, cond.clmn=
+
+
> compbiasTest(obj.sub, meta.lev=

gene.clmns=c(
meta.clmns=c(
genus_sp

treatment
,

what_def
,
family

,
kid
genus_sp

’
’

’
’

’
’

)

’

’

’

’

’

’

))

, agg.clmn=
pathway
’

),

’

’

Pseudo-nitzschia
’

what_def

,c(
’
,

’

’

’

’

’

granii

,

australis

)))

Analysis of Variance Table

Response: R

Df Sum Sq Mean Sq F value Pr(>F)

subtaxa

4

20.3 5.0681 2.1738 0.06958 .

5

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllPseudo−nitzschia graniiThalassiosiraPhaeodactylumPseudo−nitzschia australis−4−20246Residuals 2058 4798.0 2.3314
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

As you can see, the same test on this new subset of diatoms fails to reject
the null hypothesis of no housekeeping gene change in expression. We can
now move on to assessing signiﬁcant diﬀerential expression of the genes in this
subset, without the misinforming species confounding the analysis. By focusing
on a more homogenous, similarly responding subset of species, we can greatly
improve the power of the DE analysis.

7 Normalization and Diﬀerential Expression

The edgeR and manta packages both provide support for normalization and
estimation of DE genes. Prerequisite calculations for normalization factors and
dispersion coeﬃcients (respectively) can be carried out like so:

> obj.sub <- calcNormFactors(obj.sub)
> obj.sub <- estimateCommonDisp(obj.sub)

Because our example dataset doesn’t have any replicates, estimateCommonDisp
returns NA. Although it is not advised to proceded on to performing inferential
statistics without replicates, the edgeR manual oﬀers several alternatives to
assuming that biological variability is absent. For the purposes of example we
use edgeR’s estimateGLMCommonDisp.

> obj.sub <- estimateGLMCommonDisp(obj.sub, method="deviance", robust=TRUE , subset=NULL)
> obj.sub$common.dispersion

[1] 0.4450603

DE analysis is carried out on the normalized and dispersion estimated object

in the standard way using the exactTest function.

> test <- exactTest(obj.sub) # edgeR

Other likelihood based tests such as glmFit and glmLRT also run in a similar

fashion.

7.1 Finding Outliers

One useful function built into manta’s underlying edgeR package is the
topTags function, which returns the most extreme up and down regulated DE
genes as sorted by either p.value or fold change. Another function, outGenes (in
the manta package), provides additional (cut-oﬀ based) functionality for identi-
fying these fold change outliers as well as those with high average absolute read
count.

6

> topTags(test, n=5)

Comparison of groups: plusFe-ambient

what_def
magnesium chelatase
magnesium chelatase
small subunit ribosomal protein S30e small subunit ribosomal protein S30e
small subunit ribosomal protein S29e small subunit ribosomal protein S29e
actin, other eukaryote
actin, other eukaryote
taurine dioxygenase
taurine dioxygenase

kid pathway
magnesium chelatase
<NA>
small subunit ribosomal protein S30e K02983 Ribosome
<NA>
small subunit ribosomal protein S29e K02980
<NA>
K10355
actin, other eukaryote
<NA>
K03119
taurine dioxygenase

K03403

logFC

logCPM
magnesium chelatase
8.265404 13.22878
small subunit ribosomal protein S30e 7.521348 12.58239
small subunit ribosomal protein S29e 6.965635 12.12976
-3.437644 13.75871
actin, other eukaryote
6.529179 11.79682
taurine dioxygenase
PValue FDR
1
1
1
1
1

magnesium chelatase
0.004885506
small subunit ribosomal protein S30e 0.014920741
small subunit ribosomal protein S29e 0.031374603
0.050537155
actin, other eukaryote
0.055485482
taurine dioxygenase

> out <- outGenes(test)

obs/ref (up-regulated)

R

A
magnesium chelatase
8.265404 13.22878
small subunit ribosomal protein S30e 7.521348 12.58239
small subunit ribosomal protein S29e 6.965635 12.12976
PValue adj.p
1
1
1

magnesium chelatase
0.004885506
small subunit ribosomal protein S30e 0.014920741
small subunit ribosomal protein S29e 0.031374603

ref/obs (down-regulated)
R A PValue adj.p
NA

NA NA NA

NA

high abundance (house-keeping)

R

A

PValue adj.p

7

tubulin alpha -1.126268 16.04838 0.4467385
1.756782 14.37118 0.2582533
fucoxanthin

1
1

8 RA Plots

Another feature the manta package oﬀers is the ability to create sophisti-
cated plots for visualizing DE. Improving upon edgeR which contains maPlot
for creating Magnitude Amplitude [MA] plots from a pair of count vectors, the
manta package oﬀers native plotting support for its manta object, instead em-
ploying raPlot to generate Ratio Average [RA] plots, as implemented in the
caroline package. RA plots are nearly identical to MA plots with the exception
of the distinctive geometric ’ray’ (arrow) shape caused by the way the condition
unique points are included, via an added epsilon factor, in the plot. The diag-
onal positioning of these library-unique wings (forming the head of the arrow),
aligns points in the wings to fold-change and amplitude levels of non-wing points
that have similar p-values.

8.1 MANTA RA-plots

Any meta information available in the ’meta’ slot of the manta object can
be included in the RA plot as pie-chart overlays depicting the taxonomic distri-
bution of any particular gene on the plot. Signiﬁcance of DE is easily visualized
in the plot via the ’borders’ parameter. The normalization line can be added
using the mm parameter or the mm slot on the plotted manta object.

> obj.sub$nr <- nf2nr(x=obj.sub, pair=conditions)
> plot(obj.sub, main=

Diatom Gene Expression\n at Ocean Station Papa

’

’

, meta.lev=

’

genus_sp

’

, pair=conditions, lgd.pos=

bottomright

)

’

’

8.2 Pseudo RA-plots

Another simple way to plot the diﬀerential expression data is directly plot
the raw R (logFC) and A (logCPM) values output from exactTest. This can
be a convenient solution when plotting count data with replicates (something
that is currently not supported in raPlot or maPlot).

> with(test$table, plot(logCPM, logFC))
>

8

Figure 2: an example of plot(manta) call.

9

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0246−4−20246Diatom Gene Expression at Ocean Station PapaARllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll fold change = log2( plusFe / ambient ) amplitude = (log2(plusFe) + log2(ambient))/2Pseudo−nitzschia multiseriesThalassiosiraFragilariopsisPhaeodactylumChaetocerosFigure 3: plot(logCPM, logFC)

10

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll10111213141516−505logCPMlogFC8.3 Annotating via HyperPlot

A new R function for annotating scatterplots with interactive hover text and

links is also compatible with the manta object.

> caroline::hyperplot(obj, annout=out, browse=FALSE)

References

Marchetti A, Schruth DM, Durkin CA, Parker MS, Kodner RB, Berthiaume
CT, Morales R, Allen A, and Armbrust EV (2012). Comparative metatran-
scriptomics identiﬁes molecular bases for the physiological responses of phy-
toplankton to varying iron availability. Proceedings of the National Academy
of Sciences 109, no.6, E317

Matsen FA, Kodner RB, and Armbrust EV (2010). pplacer:

linear time
maximum-likelihood and Bayesian phylogenetic placement of sequences onto
a ﬁxed reference tree. BMC Bioinformatics 11, 538

Robinson MD, McCarthy DJ and Smyth GK (2010). edgeR: a Bioconductor
package for diﬀerential expression analysis of digital gene expression data.
Bioinformatics 26, 139-140

Robinson MD and Smyth GK (2007). Moderated statistical tests for assessing

diﬀerences in tag abundance. Bioinformatics 23, 2881-2887

11

