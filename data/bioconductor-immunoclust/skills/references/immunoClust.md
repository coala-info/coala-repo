immunoClust - Automated Pipeline for Pop-
ulation Detection in Flow Cytometry

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

2

2

3

6

7

10

Till Sörensen1

October 30, 2025

Contents

1

2

3

4

Licensing .

Overview.

.

.

.

.

.

.

.

Getting started .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Example Illustrating the immunoClust Pipeline .

4.1

4.2

4.3

Cell Event Clustering .

Meta Clustering .

Meta Annotation .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

5

Session Info .

.

.

.

.

.

1till-antoni.soerensen@charite.de

immunoClust

1

Licensing

Under the Artistic License, you are free to use and redistribute this software. However, we
ask you to cite the following paper if you use this software for publication.

Sörensen, T., Baumgart, S., Durek, P., Grützkau, A. and Häupl, T.

immunoClust - an automated analysis pipeline for the identification of

immunophenotypic signatures in high-dimensional cytometric datasets.

Cytometry A (accepted).

2

Overview

immunoClust presents an automated analysis pipeline for uncompensated fluorescence and
mass cytometry data and consists of two parts. First, cell events of each sample are grouped
into individual clusters (cell-clustering). Subsequently, a classification algorithm assorts these
cell event clusters into populations comparable between different samples (meta-clustering).
The clustering of cell events is designed for datasets with large event counts in high dimen-
sions as a global unsupervised method, sensitive to identify rare cell types even when next
to large populations. Both parts use model-based clustering with an iterative Expectation
Maximization (EM) algorithm and the Integrated Classification Likelihood (ICL) to obtain
the clusters.

The cell-clustering process fits a mixture model with t-distributions. Within the cluster-
ing process a optimisation of the asinh-transformation for the fluorescence parameters is
included.

The meta-clustering fits a Gaussian mixture model for the meta-clusters, where adjusted
Bhattacharyya-Coefficients give the probability measures between cell- and meta-clusters.

Several plotting routines are available visualising the results of the cell- and meta-clustering
process. Additional helper-routines to extract population features are provided.

3

Getting started

The installation on immunoClust is normally done within the Bioconductor.

The core functions of immunoClust are implemented in C/C++ for optimal utilization of sys-
tem resources and depend on the GNU Scientific Library (GSL) and Basic Linear Subprogram
(BLAS). When installing immunoClust form source using Rtools be aware to adjust the GSL
library and include pathes in src/Makevars.in or src/Makevars.win (on Windows systems)
repectively to the correct installation directory of the GSL-library on the system.

immunoClust relies on the flowFrame structure imported from the flowCore-package for
accessing the measured cell events from a flow cytometer device.

4

Example Illustrating the immunoClust Pipeline

The functionality of the immunoClust pipeline is demonstrated on a dataset of blood cell
samples of defined composition that were depleted of particular cell subsets by magnetic cell
sorting. Whole blood leukocytes taken from three healthy individuals, which were experimen-

2

immunoClust

tally modified by the depletion of one particular cell type per sample, including granulocytes
(using CD15-MACS-beads), monocytes (using CD14-MACS-beads), T lymphocytes (CD3-
MACS-beads), T helper lymphocytes (using CD4-MACS-beads) and B lymphocytes (using
CD19-MACS-beads).

The example datasets contain reduced (10.000 cell-events) of the first Flow Cytometry (FC)
sample in dat.fcs and the immunoClust cell-clustering results of all 5 reduced FC sam-
ples for the first donor in dat.exp. The full sized dataset is published and available under
http://flowrepository.org/id/FR-FCM-ZZWB.

4.1

Cell Event Clustering

> library(immunoClust)

The cell-clustering is performed by the cell.process function for each FC sample sepa-
rately. Its major input are the measured cell-events in a flowFrame-object imported from the
flowCore-package.

> data(dat.fcs)

> dat.fcs

flowFrame object '2d36b4cf-da0f-4b8d-9a4c-fc7e4f5fccc8'

with 10000 cells and 7 observables:

name

desc

range

minRange

maxRange

$P2

$P5

$P8

$P9

$P12

$P13

FSC-A

SSC-A

FITC-A

PE-A

APC-A

APC-Cy7-A

$P14 Pacific Blue-A

NA

NA

CD14

CD19

CD15

CD4

CD3

262144

0.00

262144

-111.00

262144

-111.00

262144

-111.00

262144

-111.00

262144

-111.00

262144

-98.94

262143

262143

262143

262143

262143

262143

262143

171 keywords are stored in the 'description' slot

In the parameters argument the parameters (named as observables in the flowFrame) used
for cell-clustering are specified. When omitted all determined parameters are used.

> pars=c("FSC-A","SSC-A","FITC-A","PE-A","APC-A","APC-Cy7-A","Pacific Blue-A")

> res.fcs <- cell.process(dat.fcs, parameters=pars)

The summary method for an immunoClust-object gives an overview of the clustering results.

> summary(res.fcs)

** Experiment Information **
Experiment name: 12443.fcs

Data Filename:

fcs/12443.fcs

Parameters:

FSC-A SSC-A FITC-A PE-A APC-A APC-Cy7-A Pacific Blue-A

Description: NA NA CD14 CD19 CD15 CD4 CD3

** Data Information **
Number of observations: 10000

Number of parameters:

7

Removed from above:

318 (3.18%)

3

immunoClust

Removed from below:

0 (0%)

** Transformation Information **
htrans-A:

0.000000 0.000000 0.010000 0.010000 0.010000 0.010000 0.010000

htrans-B:

0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

htrans-decade:

-1

** Clustering Summary **
ICL bias: 0.30

Number of clusters: 12

Cluster

Proportion Observations

1

2

3

4

5

6

7

8

9

10

11

12

0.637797

0.028573

0.015583

0.007331

0.114721

0.032445

0.017144

0.040359

0.004697

0.003663

0.005052

0.092637

Min.

Max.

0.003663

0.637797

6167

281

149

70

1112

320

165

391

44

35

49

899

35

6167

** Information Criteria **
Log likelihood: -254240.7 -254343.8 -173183.3

BIC: -254240.7

ICL: -254343.8

With the bias argument of the cell.process function the number of clusters in the final
model is controlled.

> res2 <- cell.process(dat.fcs, bias=0.25)

> summary(res2)

** Experiment Information **
Experiment name: 12443.fcs

Data Filename:

fcs/12443.fcs

Parameters:

FSC-A SSC-A FITC-A PE-A APC-A APC-Cy7-A Pacific Blue-A

Description: NA NA CD14 CD19 CD15 CD4 CD3

** Data Information **
Number of observations: 10000

Number of parameters:

7

Removed from above:

318 (3.18%)

Removed from below:

0 (0%)

** Transformation Information **
htrans-A:

0.000000 0.000000 0.010000 0.010000 0.010000 0.010000 0.010000

4

immunoClust

htrans-B:

0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

htrans-decade:

-1

** Clustering Summary **
ICL bias: 0.25

Number of clusters: 21

Cluster

Proportion Observations

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

0.027911

0.307942

0.329334

0.005147

0.009571

0.001950

0.001352

0.007046

0.007284

0.018225

0.018947

0.018799

0.018744

0.008611

0.012829

0.036998

0.054769

0.003376

0.000628

0.057177

0.053360

281

2897

3261

50

93

18

13

63

70

181

189

174

182

77

130

364

524

33

6

566

510

Min.

Max.

0.000628

0.329334

6

3261

** Information Criteria **
Log likelihood: -254038.9 -255645.4 -173002.1

BIC: -254038.9

ICL: -255645.4

An ICL-bias of 0.3 is reasonable for fluorescence cytometry data based on our experiences,
whereas the number of clusters increase dramatically when a bias below 0.2 is applied. A
principal strategy for the ICL-bias in the whole pipeline is the use of a moderately small bias
(0.2 - 0.3) for cell-clustering and to optimise the bias on meta-clustering level to retrieve the
common populations across all samples.

For plotting the clustering results on cell event level, the optimised asinh-transformation has
to be applied to the raw FC data first.

> dat.transformed <- trans.ApplyToData(res.fcs, dat.fcs)

A scatter plot matrix of all used parameters for clustering is obtained by the splom method.

> splom(res.fcs, dat.transformed, N=1000)

5

immunoClust

For a scatter plot of 2 particular parameters the plot method can be used, where parameters
of interest are specified in the subset argument.

> plot(res.fcs, data=dat.transformed, subset=c(1,2))

4.2 Meta Clustering

For meta-clustering the cell-clustering results of all FC samples obtained by the cell.process
function are collected in a vector of immunoClust-objects and processed by the meta.process
function.

> data(dat.exp)

> meta<-meta.process(dat.exp, meta.bias=0.3)

The obtained immunoMeta-object contains the meta-clustering result in $res.clusters, and
the used cell-clusters information in $dat.clusters. Additionally, the clusters can be struc-
tures manually in a hierarchical mannner using methods of the immunoMeta-object.

A scatter plot matrix of the meta-clustering is obtained by the plot method.

6

050000100000150000200000250000050000100000150000200000250000FSC−ASSC−AimmunoClust

> plot(meta, c(), plot.subset=c(1,2))

In these scatter plots each cell-cluster is marked by a point of its centre. With the default
plot.ellipse=TRUE argument the meta-clusters are outlined by ellipses of the 90% quantile.

4.3 Meta Annotation

We take a look and first sort the meta-clusters according to the scatter parameter into five
major areas

> cls <- clusters(meta,c())

> inc <- mu(meta,cls,1) > 20000 & mu(meta,cls,1) < 150000

> addLevel(meta,c(1),"leucocytes") <- cls[inc]

> cls <- clusters(meta,c(1))

> sort(mu(meta,cls,2))

cls-7

cls-8

cls-6

cls-2

cls-3

cls-18

cls-10

cls-19

12073.50 12781.05 14379.67 14987.31

24119.51

28807.31

38562.50

39089.67

cls-21

cls-16

cls-11

cls-1

cls-9

cls-20

cls-4

cls-13

7

50000100000150000050000100000150000200000.allFSC−A: FCSSSC−A: SSCimmunoClust

53084.06 59202.13 69861.55 69936.06 103994.99 130008.05 138993.45 198539.11

cls-15

cls-5

cls-14

209082.92 209737.65 211263.42

> inc <- (mu(meta,cls,2)) < 40000

> addLevel(meta,c(1,1), "ly") <- cls[inc]

> addLevel(meta,c(1,2), "mo") <- c()

> inc <- (mu(meta,cls,2)) > 100000

> addLevel(meta,c(1,3), "gr") <- cls[inc]

> move(meta,c(1,2)) <- unclassified(meta,c(1))

In the plot of this level the three major scatter population are seen easily

> plot(meta, c(1))

and we identify the clusters for the particular populations successivley by their expression lev-
els.

> cls <- clusters(meta,c(1,1))

> sort(mu(meta,cls,7))

## CD3 expression

8

1.all_leucocytesFSC−AFCSSSC−ASSCFITC−ACD14PE−ACD19APC−ACD15APC−Cy7−ACD4Pacific Blue−ACD3Sub LevellymogrimmunoClust

cls-3

cls-6

cls-18

cls-10

cls-19

cls-8

cls-2

cls-7

1.017751 1.023148 1.501441 2.043337 2.686877 5.248953 5.339878 5.693991

> sort(mu(meta,cls,6))

## CD4 expression

cls-2

cls-6

cls-3

cls-18

cls-10

cls-7

cls-8

cls-19

0.3526607 0.4631971 0.5680941 3.0448631 3.3933842 4.0296976 4.3310119 5.3378243

> inc <- mu(meta,cls,7) > 5 & mu(meta,cls,6) > 4

> addLevel(meta,c(1,1,1), "CD3+CD4+") <- cls[inc]

> inc <- mu(meta,cls,7) > 5 & mu(meta,cls,6) < 4

> addLevel(meta,c(1,1,2), "CD3+CD4-") <- cls[inc]

> cls <- unclassified(meta,c(1,1))

> inc <- (mu(meta,cls,4)) > 3

> addLevel(meta,c(1,1,3), "CD19+") <- cls[inc]

> cls <- clusters(meta,c(1,2))

> inc <- mu(meta,cls,3) > 5 & mu(meta,cls,7) < 5

> addLevel(meta,c(1,2,1), "CD14+") <- cls[inc]

> cls <- clusters(meta,c(1,3))

> inc <- mu(meta,cls,5) > 3 & mu(meta,cls,7) < 5

> addLevel(meta,c(1,3,1), "CD15+") <- cls[inc]

The whole analysis is performed on uncompensated FC data, thus the high CD19 values on
the CD14-population is explained by spillover of FITC into PE.

The event numbers of each meta-cluster and each sample are extracted in a numeric matrix
by the meta.numEvents function.

> tbl <- meta.numEvents(meta, out.unclassified=FALSE)

> tbl[,1:5]

measured

12543 12546 12549 12552 12555

10000 10000 10000 10000 10000

9682

9531

.all
1.all_leucocytes
1.1.all_leucocytes_ly
1911
1.1.1.all_leucocytes_ly_CD3+CD4+ 1107
1.1.2.all_leucocytes_ly_CD3+CD4-
389
1.1.3.all_leucocytes_ly_CD19+
1.2.all_leucocytes_mo
1.2.1.all_leucocytes_mo_CD14+
1.3.all_leucocytes_gr
1.3.1.all_leucocytes_gr_CD15+

6672

6459

948

948

0

9842

9736

9736

9510

9244

9479

9489

9232

6570

3391

1291

771

3332

1585

0

433

331

823

823

0

46

325

1044

1044

574

452

0

0

6088

7375

7417

5717

7280

7417

1079

926

2472

2370

202

101

Each row denotes an annotated hierarchical level or/and meta-cluster and each column a
data sample used in meta-clustering. The row names give the annotated population name.
In the last columns additionally the meta-cluster centre values in each parameter are given,
which helps to identify the meta-clusters. Further export functions retrieve relative cell event
frequencies and sample meta-cluster centre values in a particular parameter.

We see here, that for sample 12546 where the CD15-cells are depleted, the CD14-population
is missing. Anyway, this missing cluster could be in the so far unclassified clusters.

9

immunoClust

> plot(meta, c(1,2,1), plot.subset=c(1,2,3,4))

We see the CD14 population of sample 12546 shifted in FSC and CD3 expression levels,
probably due to technical variation in the measurement of the CD15-depleted sample, where
the granulocytes are missing which constitute about 60% - 70% of the events in the other
samples.

5

Session Info

The documentation and example output was compiled and obtained on the system:

> toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

10

1.2.1.all_leucocytes_mo_CD14+FSC−AFCSSSC−ASSCFITC−ACD14PE−ACD19immunoClust

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: flowCore 2.22.0, immunoClust 1.42.0

• Loaded via a namespace (and not attached): Biobase 2.70.0, BiocGenerics 0.56.0,
BiocManager 1.30.26, BiocStyle 2.38.0, RProtoBufLib 2.22.0, S4Vectors 0.48.0,
cli 3.6.5, compiler 4.5.1, cytolib 2.22.0, digest 0.6.37, evaluate 1.0.5, fastmap 1.2.0,
generics 0.1.4, grid 4.5.1, htmltools 0.5.8.1, knitr 1.50, lattice 0.22-7,
matrixStats 1.5.0, rlang 1.1.6, rmarkdown 2.30, stats4 4.5.1, tools 4.5.1, xfun 0.53,
yaml 2.3.10

11

