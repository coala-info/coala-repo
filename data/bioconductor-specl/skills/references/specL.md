# Prepare Peptide Spectrum Matches for Use in Targeted Proteomics

Christian Panse1,2\*, Christian Trachsel1, Jonas Grossmann1,2\*\* and Witold E. Wolski1,2\*\*\*

1Functional Genomics Center Zurich - Swiss Federal Institute of Technology in Zurich
2Swiss Institute of Bioinformatics, Quartier Sorge - Batiment Amphipole, CH-1015 Lausanne, Switzerland

\*cp@fgcz.ethz.ch
\*\*jg@fgcz.ethz.ch
\*\*\*wew@fgcz.ethz.ch

#### 30 October 2025

#### Abstract

Targeted data extraction methods are attractive ways to obtain
quantitative peptide information from a proteomics experiment.
Sequential Window Acquisition of all Theoretical Spectra (SWATH) and
Data Independent Acquisition (DIA) methods increase reproducibility of
acquired data because the classical precursor selection is omitted and
all present precursors are fragmented. However, especially for targeted
data extraction, MS coordinates (retention time information precursor
and fragment masses) are required for the particular entities (peptide
ions). These coordinates are usually generated in a so-called discovery
experiment earlier on in the project if not available in public spectral
library repositories. The quality of the assay panel is crucial to
ensure appropriate downstream analysis. For that, a method is needed to
create spectral libraries and to export customizable assay panels.

#### Package

specL 1.44.0

# 1 Introduction

Targeted proteomics is a fast evolving field in proteomics science and
was even elected as the method of the year in 2012
. Especially targeted methods like SWATH (Gillet et al. [2012](#ref-SWATH)) open
promising perspectives for for identifying and quantifying of
peptides and proteins. All targeted
methods have in common the need of precise MS coordinates composed
of precursor mass, fragment masses, and retention time. The combination
of this information is kept in so-called assays or spectra libraries. Here we
present an R package able to produce such libraries out of peptide
identification results (Mascot (dat), TPP (pep.xml and mzXMLs),
ProteinPilot (group), Omssa (omx)).
*[specL](https://bioconductor.org/packages/3.22/specL)* (Panse et al. [2015](#ref-specLBioInf)) is an easy-to-use,
versatile, and flexible function,
which can be integrated into already existing commercial
or non-commercial analysis pipelines for targeted proteomics
data analysis. Some examples of today’s pipelines are ProteinPilot
combined with Peakview (AB Sciex), Spectronaut (Biognosys) or
OpenSwath (Rost et al. [2014](#ref-pmid24727770)).

In the following vignette it is described how the *[specL](https://bioconductor.org/packages/3.22/specL)* package
can be used for the included data sets `peptideStd` and
`peptideStd.redundant`.

# 2 Workflow

## 2.1 Prologue - How to get the input for the specL package?

Since peptide identification (using, e.g., Mascot, Sequest, xTandem!,
Omssa, ProteinPilot)
usually creates result files which are
heavily redundant and therefore unsuited for spectral library building,
the search results must first be filtered. To create non-redundant
input files, we use the BiblioSpec (Frewen and MacCoss [2007](#ref-pmid18428681)) algorithm
implemented in Skyline (MacLean et al. [2010](#ref-pmid20147306)). A given search result (e.g.
Mascot result file) is loaded into the software Skyline and is redundancy
filtered. The ‘Skyline workflow step’ provides two sqlite readable
files
as output named `*.blib` and `*.redundant.blib`.
These files are used as ideal input for this packages.
Note here, that Skyline is very flexible when it comes to peptide
identification results. It means with Skyline you can build the spectrum
library files for almost all search engines (even from other spectrum
library files such as spectraST (Lam et al. [2008](#ref-pmid18806791))).

The first step which has to be performed on the R shell is loading
*[specL](https://bioconductor.org/packages/3.22/specL)* library.

```
library(specL)
packageVersion('specL')
```

```
## [1] '1.44.0'
```

## 2.2 Read from redundant plus non-redundant blib files

for demonstration, *[specL](https://bioconductor.org/packages/3.22/specL)* contains the two data sets, namely `peptideStd` and
`peptideStd.redundant`. This data set
comes from two standard-run experiments routinely
used to check if the liquid chromatographic system is still working
appropriately. The sample consists of a digest of the Fetuin protein
(Bos taurus, uniprot id: P12763). 40 femtomole are loaded on the column.
Mascot was used to search and identify the respective peptides.

```
summary(peptideStd)
```

```
## Summary of a "psmSet" object.
## Number of precursor:
##  137
## Number of precursors in Filename(s)
##  0140910_01_fetuin_400amol_1.raw 21
##  0140910_07_fetuin_400amol_2.raw 116
## Number of annotated precursor:
##  0
```

For both `peptideStd`, `peptideStd.redandant` data sets the
Skyline software was used to generate the bibliospec files which
contain the peptide sequences with the respective peptide spectrum
match (PSM). The `specL::read.bibliospec` function was used
to read the blib files into R.

The from `read.bibliospec` generated object has its own plot functions.
The LC-MS map graphs peptide mass versus retention time.

```
# plot(peptideStd)
plot(0,0, main='MISSING')
```

![](data:image/png;base64...)

The individual peptide spectrum match (psm) is displayed by using the
*[protViz](https://CRAN.R-project.org/package%3DprotViz)* `peakplot` function.

```
demoIdx <- 40
# str(peptideStd[[demoIdx]])
#res <- plot(peptideStd[[demoIdx]], ion.axes=TRUE)
plot(0,0, main='MISSING')
```

![](data:image/png;base64...)

## 2.3 Read from Mascot result files

Alternatively, Mascot search result files (dat) can be used by applying
*[protViz](https://CRAN.R-project.org/package%3DprotViz)* perl script
`protViz\-\_mascotDat2RData.pl`.

The Perl script can be found in the exec directory of the
*[protViz](https://CRAN.R-project.org/package%3DprotViz)* package.
The mascot mod\_file can be found in the configurations of the mascot server.
An example on our Linux shell looks as follows:

```
$ /usr/local/lib/R/site-library/protViz/exec/protViz_mascotDat2RData.pl \
-d=/usr/local/mascot/data/20130116/F178287.dat \
-m=mod_file
```

`mascotDat2RData.pl` requires the Mascot server `mod\_file` keeping
all the configured modification.

Once the {erl script is finished, the resulting RData file can be read into the R session using `load`.

Next, the variable modifications, and the S3 psmSet object has to be generated. This can be done by using `specL:::.mascot2psmSet`

```
specL:::.mascot2psmSet
```

```
## function (dat, mod, mascotScoreCutOff = 40)
## {
##     res <- lapply(dat, function(x) {
##         x$MonoisotopicAAmass <- protViz::aa2mass(x$peptideSequence)[[1]]
##         modString <- as.numeric(strsplit(x$modification, "")[[1]])
##         modIdx <- which(modString > 0) - 1
##         modString.length <- length(modString)
##         x$varModification <- mod[modString[c(-1, -modString.length)] +
##             1]
##         if (length(modIdx) > 0) {
##             warning("modified varModification caused.")
##             x$varModification[modIdx] <- x$varModification[modIdx] -
##                 x$MonoisotopicAAmass[modIdx]
##         }
##         rt <- x$rtinseconds
##         x <- c(x, rt = rt, fileName = "mascot")
##         class(x) <- "psm"
##         return(x)
##     })
##     res <- res[which(unlist(lapply(dat, function(x) {
##         x$mascotScore > mascotScoreCutOff && length(x$mZ) > 10
##     })))]
##     class(res) <- "psmSet"
##     return(res)
## }
## <bytecode: 0x5856075a0d88>
## <environment: namespace:specL>
```

If you are processing Mascot result files, you can continue reading in the section `genSwathIonLib`.

However, please note due do the high potential redundancy of peptide spectrum matches in a database search approach, it might not result in useful ion library for targeted data extraction unless redundancy filtering is handled.
However, in a future release, a redundancy filter algorithm might be proposed to resolve this problem.

## 2.4 Annotate protein IDs using FASTA

The information to which protein a peptide-spectrum-match belongs (PSM)
is not stored by BiblioSpec. Therefore *[specL](https://bioconductor.org/packages/3.22/specL)* provides the `annotate.protein\_id` function which uses R’s internal `grep`
to ‘reassign’ the protein information. Therefore a `fasta` object has
to be loaded into the R system using `read.fasta` of the
*[seqinr](https://CRAN.R-project.org/package%3Dseqinr)* package. For this, not necessarily, the same `fasta` file needs to be provided as in the original database
search.

The following lines demonstrate a simple sanity check with a single
FASTA style formatted protein entry. Also it demonstrates the use case
how to identify entries in the R-object which are from one or a few proteins
of interest.

```
irtFASTAseq <- paste(">zz|ZZ_FGCZCont0260|",
"iRT_Protein_with_AAAAK_spacers concatenated Biognosys\n",
"LGGNEQVTRAAAAKGAGSSEPVTGLDAKAAAAKVEATFGVDESNAKAAAAKYILAGVENS",
"KAAAAKTPVISGGPYEYRAAAAKTPVITGAPYEYRAAAAKDGLDAASYYAPVRAAAAKAD",
"VTPADFSEWSKAAAAKGTFIIDPGGVIRAAAAKGTFIIDPAAVIRAAAAKLFLQFGAQGS",
"PFLK\n")

Tfile <- file();  cat(irtFASTAseq, file = Tfile);
fasta.irtFASTAseq <- read.fasta(Tfile, as.string=TRUE, seqtype="AA")
close(Tfile)
```

As expected, the `peptideStd` data, e.g., our demo object, does not contain any protein information yet.

```
peptideStd[[demoIdx]]$proteinInformation
```

```
## [1] ""
```

The protein information can be added as follow:

```
peptideStd <- annotate.protein_id(peptideStd,
    fasta=fasta.irtFASTAseq)
```

```
## start protein annotation ...
```

```
## time taken:  0.00017096201578776 minutes
```

The following lines now show the object indices of those entries which do
have protein information now.

```
(idx <- which(unlist(lapply(peptideStd,
    function(x){nchar(x$proteinInformation)>0}))))
```

```
## [1] 1 2 3 4 5 6
```

As expected, there are now a number of peptide sequences
annotated with the protein ID.

```
peptideStd[[demoIdx]]$proteinInformation
```

```
## [1] "zz|ZZ_FGCZCont0260|"
```

Of note, that the default digest pattern is defined as

```
digestPattern = "(([RK])|(^)|(^M))"
```

for tryptic peptides. For other enzymes, the pattern has to
be adapted. For example, for semi-tryptic identifications, use
`digestPattern = ""`.

## 2.5 Generate the spectral library (assay)

`genSwathIonLib` is the main contribution of the
*[specL](https://bioconductor.org/packages/3.22/specL)* package. It generates the spectral library used in a targeted data extraction workflow from a mass spectrometric
measurement. Generating the ion library using iRT peptides is highly recommended as described. However if you have no iRT peptide, continue reading in section noiRT.

Generation of the spec Library with default (see Table) settings.

```
res.genSwathIonLib <- genSwathIonLib(data = peptideStd,
   data.fit = peptideStd.redundant)
```

```
## normalizing RT ...
```

```
## found 7 iRT peptide(s) in s:\p1239\Proteomics\QEXACTIVE_3\ctrachse_20140910_Nuclei_diff_extraction_methods\20140910_01_fetuin_400amol_1.raw
```

```
## found 7 iRT peptide(s) in s:\p1239\Proteomics\QEXACTIVE_3\ctrachse_20140910_Nuclei_diff_extraction_methods\20140910_07_fetuin_400amol_2.raw
```

```
## building model ...
```

```
## generating ion library ...
```

```
## start generating specLSet object ...
```

```
## length of findNN idx  137
```

```
## length of genSwathIonLibSpecL   137
```

```
## time taken:  0.212137222290039 secs
```

```
## length of genSwathIonLibSpecL  after fragmentIonRange filtering 137
```

genSwathIonLib default settings

| parameter | description | value |
| --- | --- | --- |
| max.mZ.Da.error | max ms2 tolerance | 0.1 |
| topN | the n most intense fragment ion | 10 |
| fragmentIonMzRange | mZ range filter of fragment ion | c(300, 1800) |
| fragmentIonRange | min/max number of fragment ions | c(5,100) |
| fragmentIonFUN} | desired fragment ion types | b1+,y1+,b2+,y2+,b3+,y3+ |

```
summary(res.genSwathIonLib)
```

```
## Summary of a "specLSet" object.
##
## Parameter:
##
## Number of precursor (q1 and peptideModSeq) = 137
## Number of unique precursor
## (q1.in-silico and peptideModSeq) = 126
## Number of iRT peptide(s) = 8
## Which std peptides (iRTs) where found in which raw files:
##   0140910_01_fetuin_400amol_1.raw GAGSSEPVTGLDAK
##       0140910_01_fetuin_400amol_1.raw TPVITGAPYEYR
##       0140910_01_fetuin_400amol_1.raw VEATFGVDESNAK
##       0140910_07_fetuin_400amol_2.raw ADVTPADFSEWSK
##       0140910_07_fetuin_400amol_2.raw DGLDAASYYAPVR
##       0140910_07_fetuin_400amol_2.raw GTFIIDPGGVIR
##       0140910_07_fetuin_400amol_2.raw LFLQFGAQGSPFLK
##       0140910_07_fetuin_400amol_2.raw TPVISGGPYEYR
##
## Number of transitions frequency:
##  4   1
##  5   5
##  6   10
##  7   7
##  8   18
##  9   32
##  10  64
##
## Number of annotated precursor = 6
## Number of file(s)
##  2
##
## Number of precursors in Filename(s)
##  0140910_01_fetuin_400amol_1.raw 21
##  0140910_07_fetuin_400amol_2.raw 116
##
## Misc:
##
## Memory usage =    676976 bytes
```

The determined mass spec coordinates of the selected tandem mass spectrum
`demoIdx` look like this:

```
res.genSwathIonLib@ionlibrary[[demoIdx]]
```

```
## An "specL" object.
##
##
## content:
## group_id = GAGSSEPVTGLDAK.2
## peptide_sequence = GAGSSEPVTGLDAK
## proteinInformation = zz|ZZ_FGCZCont0260|
## q1 = 644.8219
## q1.in_silico = 1288.638
## q3 = 800.4497 604.3285 1016.522 503.2805 929.4925 400.7282
## 333.176 1160.581 703.3948 343.1235
## q3.in_silico = 800.4512 604.3301 1016.526 503.2824 929.4938
## 400.7295 333.1769 1160.579 703.3985 343.1615
## prec_z = 2
## frg_type = y y y y y y y y y b
## frg_nr = 8 6 10 5 9 8 3 12 7 8
## frg_z = 1 1 1 1 1 2 1 1 1 2
## relativeFragmentIntensity = 100 21 19 12 10 9 9 8 8 6
## irt = -0.95
## peptideModSeq = GAGSSEPVTGLDAK
## mZ.error = 0.001514 0.00156 0.003685 0.001914 0.001318
## 0.001313 0.000856 0.001846 0.003686 0.0380015
## uclei_diff_extraction_methods\20140910_01_fetuin_400amol_1.raw
## score = 41.54902
##
## size:
## Memory usage: 4776 bytes
```

It can be displayed using the function.

```
plot(res.genSwathIonLib@ionlibrary[[demoIdx]])
```

![](data:image/png;base64...)

The following code considers only the top five y ions.

```
# define customized fragment ions
# for demonstration lets consider only the top five singly charged y ions.

r.genSwathIonLib.top5 <- genSwathIonLib(peptideStd,
    peptideStd.redundant, topN=5,
    fragmentIonFUN=function (b, y) {
      return( cbind(y1_=y) )
      }
    )
```

```
## normalizing RT ...
```

```
## found 7 iRT peptide(s) in s:\p1239\Proteomics\QEXACTIVE_3\ctrachse_20140910_Nuclei_diff_extraction_methods\20140910_01_fetuin_400amol_1.raw
```

```
## found 7 iRT peptide(s) in s:\p1239\Proteomics\QEXACTIVE_3\ctrachse_20140910_Nuclei_diff_extraction_methods\20140910_07_fetuin_400amol_2.raw
```

```
## building model ...
```

```
## generating ion library ...
```

```
## start generating specLSet object ...
```

```
## length of findNN idx  137
```

```
## length of genSwathIonLibSpecL   137
```

```
## time taken:  0.185325860977173 secs
```

```
## length of genSwathIonLibSpecL  after fragmentIonRange filtering 137
```

```
plot(r.genSwathIonLib.top5@ionlibrary[[demoIdx]])
```

![](data:image/png;base64...)

## 2.6 Normalizing the retention time using iRT peptides

Retention time is an essential parameter in targeted data
extraction. However, retention times are difficult to transfer between
reverse phase columns or HPLC systems. To make transfer
applicable and account for the inter-run shift in retention time Biognosys
(Escher et al. [2012](#ref-pmid22577012)) invented the iRT normalization based on iRT / HRM
peptides. For this, a set of well-behaving peptides (good flying
properties, good fragmentation characteristics, completely artificial)
which cover the whole rt-gradient and are spiked into each sample.
For this set of peptides, an idependent retention time (dimension less)
is suggested by Biognosys. With this at hand, the set of peptides can later
be used to apply a linear regression model to adapt all measured
retention times into an independent retention time
scale.

If the identification results contain iRT peptides, the package
supports the conversion to the iRT scale. For this (if the identification
the outcome is based on multiple input files), the redundant BiblioSpec file
is required where all iRT peptides from all measurements are stored.
For the most representative spectrum in the non-redundant R-object the
original filename is identified, and the respective linear model for this
one particular MS experiment is applied
to normalize the retention time to the iRT scale.
The iRT peptides, as well as their independent retention times, are
stored in the `iRTpeptides` object.

*[specL](https://bioconductor.org/packages/3.22/specL)* uses by default the iRT peptide table to
normalize
into the independent retention time but could also be extended or
changed to custom iRT peptides if available.

```
iRTpeptides
```

```
##           peptide        rt
## 1       LGGNEQVTR -24.92000
## 2  GAGSSEPVTGLDAK   0.00000
## 3   AAVYHHFISDGVR  10.48963
## 4   VEATFGVDESNAK  12.39000
## 5      YILAGVENSK  19.79000
## 6   HIQNIDIQHLAGK  23.93091
## 7    TPVISGGPYEYR  28.71000
## 8    TPVITGAPYEYR  33.38000
## 9   DGLDAASYYAPVR  42.26000
## 10 TEVSSNHVLIYLDK  43.54062
## 11  ADVTPADFSEWSK  54.62000
## 12 LVAYYTLIGASGQR  64.15480
## 13   GTFIIDPGGVIR  70.52000
## 14 TEHPFTVEEFVLPK  74.50968
## 15 TTNIQGINLLFSSR  84.36927
## 16   GTFIIDPAAVIR  87.23000
## 17 LFLQFGAQGSPFLK 100.00000
## 18  NQGNTWLTAFVLK 104.06935
## 19 DSPVLIDFFEDTER 112.63426
## 20 ITPNLAEFAFSLYR 122.24622
## 21      LGGNETQVR -24.92000
## 22 AGGSSEPVTGLADK   0.00000
## 23  VEATFGVDESANK  12.39000
## 24     YILAGVESNK  19.79000
## 25   TPVISGGPYYER  28.71000
## 26   TPVITGAPYYER  33.38000
## 27  GDLDAASYYAPVR  42.26000
## 28  DAVTPADFSEWSK  54.62000
## 29   TGFIIDPGGVIR  70.52000
## 30   GTFIIDPAAIVR  87.23000
## 31 FLLQFGAQGSPLFK 100.00000
```

The method genSwathIonLib uses:

```
fit <- lm(formula = rt ~ aggregateInputRT * fileName, data = m)
```

to build the linear models for each MS measurement individually.
For defining `m` both data sets were aggregated over the attributes
`peptide` and `fileName` using the `mean` operator.

```
data <- aggregate(df$rt, by = list(df$peptide, df$fileName),
  FUN = mean)
data.fit <- aggregate(df.fit$rt,
  by = list(df.fit$peptide, df.fit$fileName),
  FUN = mean)
```

Afterwards the following join operator was applied.

```
m <- merge(iRT, data.fit, by.x='peptide', by.y='peptide')
```

The following graph displays the normalized retention time versus
the measured retention time after applying the calculated model
to the two data sets.

```
# calls the plot method for a specLSet object
op <- par(mfrow=c(2,3))
plot(res.genSwathIonLib)
```

```
## [1] 16.83185 13.13262 18.54058 18.36923 15.30478 15.30478
```

```
## [1]  7.032372  6.490769 14.787681 14.544429 15.207398
## [6] 15.207398
```

```
par(op)
```

![](data:image/png;base64...)

Shown are the original retention time (in minutes) and iRT (dimensionless)
for two standard run experiments (color black and red). Indicated
with black {} are the iRT peptides, which are the base for the
regression.

## 2.7 Generate the spectral library having no iRTs

If no iRT peptides are contained in the data, not iRT normalization is applied.
The scatter plot below shows on the y-axis that there was not iRT transformation.

```
idx.iRT <- which(unlist(lapply(peptideStd,
  function(x){
    if(x$peptideSequence %in% iRTpeptides$peptide){0}
    else{1}
  })) == 0)

# remove all iRTs and compute ion library
res.genSwathIonLib.no_iRT <- genSwathIonLib(peptideStd[-idx.iRT])
```

```
## normalizing RT ...
```

```
## no iRT peptides found for building the model.
```

```
## => no iRT regression applied, using orgiginal rt instead!
```

```
## generating ion library ...
```

```
## start generating specLSet object ...
```

```
## length of findNN idx  129
```

```
## length of genSwathIonLibSpecL   129
```

```
## time taken:  0.214298009872437 secs
```

```
## length of genSwathIonLibSpecL  after fragmentIonRange filtering 129
```

```
summary(res.genSwathIonLib.no_iRT)
```

```
## Summary of a "specLSet" object.
##
## Parameter:
##
## Number of precursor (q1 and peptideModSeq) = 129
## Number of unique precursor
## (q1.in-silico and peptideModSeq) = 118
## Number of iRT peptide(s) = 0
## Number of transitions frequency:
##  4   1
##  5   5
##  6   10
##  7   7
##  8   17
##  9   31
##  10  58
##
## Number of annotated precursor = 0
## Number of file(s)
##  2
##
## Number of precursors in Filename(s)
##  0140910_01_fetuin_400amol_1.raw 18
##  0140910_07_fetuin_400amol_2.raw 111
##
## Misc:
##
## Memory usage =    630368 bytes
```

```
op <- par(mfrow = c(2, 3))
plot(res.genSwathIonLib.no_iRT)
```

```
## [1] 16.83185 18.54058 18.36923 15.30478 15.30478 19.36682
```

```
## [1]  7.032372  6.490769 14.787681 14.544429 15.207398
## [6] 15.207398
```

```
par(op)
```

![](data:image/png;base64...)

## 2.8 Write output to file

The output can be written as an ASCII text file.

```
write.spectronaut(res.genSwathIonLib,
  file="specL-Spectronaut.txt")
```

```
## writting specL object (including header) to file 'specL-Spectronaut.txt' ...
```

# 3 Epilogue

## 3.1 What can I do with that library now?

The *[specL](https://bioconductor.org/packages/3.22/specL)* output text file can directly be used
as input (assay) for
the Spectronaut software from Biognosys or with minimal reshaping for
Peakview. Alternatively, it can be used as a basis for script-based
construction of SRM/MRM assays.

# 4 Benchmark

The benchmarks were processed on a
12 core XEON Server (X5650 @ 2.67GHz) running Linux Debian wheezy
having
R version 3.1.1 (2014-07-10) , specL 1.1.2, and BiocParallel 1.0.0
installed. The default setting of BiocParallel uses eight cores.
As FASTA, we used a TAIR10 retrieved from and Human Swissprot.

```
\begin{table}[h]
\centering
\resizebox{.99\textwidth}{!}{
\begin{tabular}{rrr|rr|rr}
\hline
fasta=TAIR10     &                    &           & blib  [unpublished]                 &           & runtime  &           \\
\#proteins & \#tryptic peptides & file size & \#specs &  file size & annotate & generate\\\hline \hline
71032      & 3423196            & 39M       & 39648/118268  & 51M       & 79min         &   19sec \\
71032      & 3423196            & 39M       & 65018/136963  & 120M      & 130min         &  30sec \\
\hline
fasta=HUMAN   &                    &           & blib  \cite[Rosenberger]{Rosenberger} &           &   &           \\
88969& 3997085   &   43M     &   256908/3060421 & 4.4G     & $\approx$7h &$\approx$5min \\

%HUMAN\footnote{Rosenberger et al. in Scientific Data (doi:10.1038/sdata.2014.31)} &&    & & & 256908/3060421&         & 4.4G       & & $\approx$5min\\
\hline
\end{tabular}
}
\end{table}
```

The following parameter settings were given to the `genSwathIonLib` function:

```
res <- genSwathIonLib(data, data.fit,
  topN=10,
  fragmentIonMzRange=c(200,2000),
  fragmentIonRange=c(2,100))
```

# 5 Acknowledgement

The authors thank all colleagues of the Functional Genomics Center
Zuerich (FGCZ), and especial thank goes to our test users
Sira Echevarr'{i}a~Zome~{n}o (ETHZ),
Tobias Kockmann (ETHZ),
Lukas von Ziegler (Brain Research Institute, UZH/ETH Zurich),
and Stephan~Michalik (Ernst-Moritz-Arndt-Universität Greifswald, Germany).

# 6 TODO for next releases

* importer for peakview csv format; enable
* new option for ; Exclude fragment
  ions from precursor
* new option for ; Predict
  transitions for heavy labeled peptides using information from light
  peptides
* new export function into TraML format for compatibility with OpenSWATH
* replace by using
  to handle fasta files
* add varMods to specL class
* replace Mascot score by a generic score
* in-silico rt ion map plot ()
  split window into SWATH windows (one plot per, e.g., 25Da window)
* assay refinement - replace contaminated fragment ion in library

# 7 Session information

An overview of the package versions used to produce this document are
shown below.

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets
## [6] methods   base
##
## other attached packages:
## [1] knitr_1.50       specL_1.44.0     seqinr_4.2-36
## [4] RSQLite_2.4.3    protViz_0.7.9    DBI_1.2.3
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         cli_3.6.5
##  [3] magick_2.9.0        rlang_1.1.6
##  [5] xfun_0.53           jsonlite_2.0.0
##  [7] bit_4.6.0           htmltools_0.5.8.1
##  [9] tinytex_0.57        sass_0.4.10
## [11] rmarkdown_2.30      evaluate_1.0.5
## [13] jquerylib_0.1.4     MASS_7.3-65
## [15] fastmap_1.2.0       yaml_2.3.10
## [17] lifecycle_1.0.4     memoise_2.0.1
## [19] bookdown_0.45       BiocManager_1.30.26
## [21] compiler_4.5.1      codetools_0.2-20
## [23] blob_1.2.4          Rcpp_1.1.0
## [25] digest_0.6.37       R6_2.6.1
## [27] parallel_4.5.1      magrittr_2.0.4
## [29] bslib_0.9.0         tools_4.5.1
## [31] bit64_4.6.0-1       ade4_1.7-23
## [33] cachem_1.1.0
```

# References

Escher, C., L. Reiter, B. MacLean, R. Ossola, F. Herzog, J. Chilton, M. J. MacCoss, and O. Rinner. 2012. “Using iRT, a normalized retention time for more targeted measurement of peptides.” *Proteomics* 12 (8): 1111–21.

Frewen, B., and M. J. MacCoss. 2007. “Using BiblioSpec for creating and searching tandem MS peptide libraries.” *Curr Protoc Bioinformatics* Chapter 13 (December): Unit 13.7.

Gillet, L. C., P. Navarro, S. Tate, H. Rost, N. Selevsek, L. Reiter, R. Bonner, and R. Aebersold. 2012. “Targeted data extraction of the MS/MS spectra generated by data-independent acquisition: a new concept for consistent and accurate proteome analysis.” *Mol. Cell Proteomics* 11 (6): O111.016717.

Lam, H., E. W. Deutsch, J. S. Eddes, J. K. Eng, S. E. Stein, and R. Aebersold. 2008. “Building consensus spectral libraries for peptide identification in proteomics.” *Nat. Methods* 5 (10): 873–75.

MacLean, B., D. M. Tomazela, N. Shulman, M. Chambers, G. L. Finney, B. Frewen, R. Kern, D. L. Tabb, D. C. Liebler, and M. J. MacCoss. 2010. “Skyline: an open source document editor for creating and analyzing targeted proteomics experiments.” *Bioinformatics* 26 (7): 966–68.

Panse, Christian, Christian Trachsel, Jonas Grossmann, and Ralph Schlapbach. 2015. “specL — an R/Bioconductor Package to Prepare Peptide Spectrum Matches for Use in Targeted Proteomics.” *Bioinformatics* 31 (13): 2228. <https://doi.org/10.1093/bioinformatics/btv105>.

Rost, H. L., G. Rosenberger, P. Navarro, L. Gillet, S. M. Miladinovi?, O. T. Schubert, W. Wolski, et al. 2014. “OpenSWATH enables automated, targeted analysis of data-independent acquisition MS data.” *Nat. Biotechnol.* 32 (3): 219–23.