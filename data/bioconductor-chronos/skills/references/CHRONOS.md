CHRONOS: A time-varying method for microRNA-mediated
sub-pathway enrichment analysis

Aristidis G. Vrahatis, Konstantina Dimitrakopoulou, Panos Balomenos

2025-10-29

Table of Contents

1. Package Setup
2. User Input
3. Default Run

Package Setup

CHRONOS (time-vaRying enriCHment integrOmics Subpathway aNalysis tOol) is an R package
built to extract regulatory subpathways along with their miRNA regulators at each time point
based on KEGG pathway maps and user-defined time series mRNA and microRNA (if available)
expression profiles for microarray experiments. It is flexible by allowing the user to intervene and
adapt all discrete phases to the needs of the study under investigation. CHRONOS can assist
significantly in complex disease analysis by enabling the experimentalists to shift from the dynamic
to the more realistic time-varying view of the involved perturbed mechanisms.

Before loading the package, please specify a user-accessible home directory. The default directories
for each architecture are as follows:
if (.Platform$OS.type == 'unix')

{ options('CHRONOS_CACHE'=file.path(path.expand("~"), '.CHRONOS') ) }

if (.Platform$OS.type == 'windows')

{ options('CHRONOS_CACHE'=file.path(gsub("\\\\", "/",

Sys.getenv("USERPROFILE")), "AppData/.CHRONOS")) }

User Input

CHRONOS requires mRNA and microRNA (if available) time-series expression data along with their
labels. The expression data needs to be formatted in matrices with dimensions (N, E), where N is
the number of mRNAs/ microRNAs and E the time points of data (i.e. X(i,j) is the expression value
of mRNA/miRNA i at time j). In case microRNA expression data are not available, CHRONOS can
be run without processing and exporting miRNAs in the final subpathways. CHRONOS operates
more effectively if data are normalized and log2-fold change differences relative to an initial condition
(control state) are computed. Multiple biological replicates should be summarized so that one
sample per time point is provided as input. An indicative example is:

1

library('CHRONOS')
load(system.file('extdata', 'Examples//data.RData', package='CHRONOS'))
head(mRNAexpr)

[,1]

[,2]

[,5]
[,4]
[,3]
##
0.105607748
0.14038253
## 18 -0.0301981 -0.13214159 0.16098142
0.512760639 -0.07647562
0.1002393 0.11929417 -0.15358686
## 32
0.05409575
0.454677105
0.1678181 0.17534780 0.33999395
## 35
## 37
1.3563976 0.92800903 -0.65185547 -0.970592022 -0.14037323
## 39 -0.1676469 -0.11763173 -0.10790169 -0.002826691 -0.01870847
0.224429607 -0.02530050
## 60

0.0373764 -0.05872822 0.01590395

Default Run

Next we present a default run of CHRONOS, which (i) imports mRNA from CHRONOS/extdata/Input/.txt
and miRNA expressions from CHRONOS/extdata/Input/.txt, (ii) downloads (all availiable)
pathways for a specified organism from KEGG, (iii) creates pathway graphs from downloaded
KGML files, (iv) extracts linear subpathways from metabolic and non metabolic graphs, (v)
downloads miRecords miRNA-mRNA interactions, (vi) scores extracted subpathways in order to
extract significant results, (vii) visualizes the most the significant results.
out <- CHRONOSrun( mRNAexp=mRNAexpr,

mRNAlabel='entrezgene',
miRNAexp=miRNAexpr,
pathType=c('04915', '04917', '04930', '05031'),
org='hsa',
subType='All',
thresholds=c('subScore'=0.4, 'mirScore'=0.4),
miRNAinteractions=miRNAinteractions,
export='.txt')

Figure 1: Results

2

Citation

The CHRONOS software package itself can be cited as: Vrahatis, A. G., Dimitrakopoulou, K.,
Balomenos, P., Tsakalidis, A. K., & Bezerianos, A. (2015). CHRONOS: A time-varying method for
microRNA-mediated sub-pathway enrichment analysis. Bioinformatics (2016) 32 (6) : 884-892

3

