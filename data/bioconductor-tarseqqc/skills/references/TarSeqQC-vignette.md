TarSeqQC : Targeted Sequencing Experiment Quality Control

Gabriela A Merino1, Crist´obal Fresno1, Yanina Murua2, Andrea S Llera2, and Elmer A
Fern´andez1

1CONICET-Universidad Cat´olica de C´ordoba, Argentina
2Laboratory of Molecular and Cellular Therapy, Instituto Leloir-CONICET, Argentina

August 24, 2017

gmerino@bdmg.com.ar

Abstract

Targeted Sequencing experiments are a Next Generation Sequencing application, designed to explore
a small group of speciﬁc genomic regions. The TarSeqQC package models this kind of experiments in
R, and its main goal is to allow the quality control and fast exploration of the experiment results. To
do this, a new R class, called TargetExperiment, was implemented. This class is based on the Bed File,
that characterize the experiment, the alignment BAM File and the reference genome FASTA File. When
the constructor is called, coverage and read count information are computed for the targeted sequences.
After that, exploration and quality control could be carried out using graphical and numerical tools.
Density, bar, read proﬁle and box plots were implemented to achieve this task. A circular histogram plot
was also implemented in order to summarize all experiment results. Coverage or median count intervals
can be deﬁned and explored to further assist quality control analysis. Library and pool preparation,
sequencing errors, fragment length or GC content bias could be easily detected. Finally, an .xlsx ﬁle
reporting quality control results can be built.
Since its 1.1.8 version, TarSeqQC implements a new class, TargetExperimentList in order to allow the
comparison and joint analysis of several Targeted Sequencing experiments performed using the same Bed
File. This class includes several plots that can help to analyze several samples from the same patient or
from diﬀerent patients under the same pathological condition.

1

Contents

1 Introduction

2 Preliminaries

2.1

Installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.2 Citation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 The TargetExperiment class

3.1

Input Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.1.1 Bed File . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.1.2 BAM File . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.1.3 FASTA File . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.1.4 Additional input data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.2 Creating a TargetExperiment object

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.2.1 Controlling ﬁles consistency . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.2.2 Constructor call

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.2.3 Early exploration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3 Deep exploration and Quality Control

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3.1 Targeted selection performance . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3.2 Panel overview . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3.3 Controlling possible attribute bias

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3.4 Controlling low counts features . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3.5 Read counts exploration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.4 Quality Control Report

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 The TargetExperimentList class

4.1

Input Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4.2 Creating a TargetExperimentList object . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4.2.1 Constructor call

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4.2.2 Early exploration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4.3 Comparative analysis and Quality Control . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

4

5

5

5

6

7

7

8

8

8

9

9

10

11

14

14

15

17

20

24

28

28

29

30

30

30

31

5 Troubleshoot

37

3

1 Introduction

Next Generation Sequencing (NGS) technologies produce a huge volume of sequence data at relatively low
cost. Among the diﬀerent NGS applications, Targeted Sequencing (TS) allows the exploration of speciﬁc
genomic regions, called features, of a small group of genes (Metzker, 2010). An ordinary application of TS
is to detect Single Nucleotide Polymorphisms (SNPs) involved in several pathologies. Nowadays, TS cancer
panels are emerging as a new screening methodology to explore speciﬁc regions of a small number of genes
known to be related to cancer. In TS, speciﬁc regions of a DNA sample are copied and ampliﬁed by PCR.
If a target region is too large, several primers can be used to read it. In addition, if the panel also has a
large number of interest genomic regions, diﬀerent PCR pools could be required in order to achieve a good
coverage. All DNA fragments are sequenced in an NGS machine, generating millions of short sequence reads,
though less than if the whole genome was sequenced. Reads are then aligned against a reference genome
and, after that, a downstream analysis could be performed. However, prior to this, it is crucial to evaluate
the run performance, as well as the experiment quality control, i.e., how well the features were sequenced,
which feature and gene coverages were achieved, if some problems arise in the global setting or by speciﬁc
PCR pools (Metzker, 2010).

At present, several open access tools can be used to explore and control experiment results(Lee et al.,
2012). Those tools allow visualization and some level of read proﬁles quantiﬁcation. But, they were de-
veloped as general purpose tools to cover a wide range of NGS applications, mainly for whole genome
exploration. Consequently, they require a great amount of computational resources and power. On the
other hand, in TS only small group of regions, the features, are required to be explored and characterized
in terms of coverage or counts, as well as, the evaluation and comparison of pool eﬃciency. In addition,
this analysis should be also performed at a gene level in order to provide a general results overview.
In
this scenario, current genomic tools have become heavy and coarse for such amount of data. Consequently,
the availability of light, fast and speciﬁc tools for TS data handling and visualization is a must in current labs.

Here we present TarSeqQC R package, an exploration tool for fast visualization and quality control of
TS experiments. Its use is not restricted to TS and can also be used to analyze data from others NGS appli-
cations in which feature-gene structure could be deﬁned, like exons or isoforms in RNA-seq and amplicons
in DNA-seq.

This vignette intends to guide through to the use of the TarSeqQC R Bioconductor package. First, the
input data format is described. Then, we show how to build an instance of the TargetExperiment class. After
that, we will graphically explore the results and do the quality control over the sequenced features. Finally,
we will build an .xlsx report that summarize the analysis above.

4

2 Preliminaries

2.1 Installation

TarSeqQC is a package for the R computing environment and it is assumed that you have already installed R.
See the R project at http://www.r-project.org. To install the latest version of TarSeqQC , you will need to be
using the latest version of R. TarSeqQC is part of the Bioconductor project at http://www.bioconductor.org.
To get the TarSeqQC package you can use:

> source("http://www.bioconductor.org/biocLite.R")
> biocLite("TarSeqQC")

Like other Bioconductor packages, there are always two available versions of TarSeqQC . Most users will use
the current oﬃcial release version, which will be installed by biocLite if you are using the current version of
R. There is also a developmental version of the package that includes new features due for the next oﬃcial
Bioconductor release. The developmental version will be installed if you are using the developmental version
of R. Both can be found in the Bioconductor site.

2.2 Citation

The TarSeqQC R package can be cited using:

> citation("TarSeqQC")

Merino GA, Murua YA, Fresno C, Sendoya JM, Golubicki M, Iseas S, Coraglio M,
Podhajcer OL, Llera AS and Fernandez EA (2017): TarSeqQC: Quality control on
targeted sequencing experiments in R. Human Mutation 38 (5), 494-502

A BibTeX entry for LaTeX users is

@Article{,

title = {TarSeqQC: Quality control on targeted sequencing experiments in

R},

author = {Gabriela A. Merino and Yanina A. Murua and Cristobal Fresno and Juan M. Sendoya and Mariano Golubicki and Soledad Iseas and Mariana Coraglio and Osvaldo L. Podhajcer and Andrea S. Llera and Elmer A. Fernandez},
year = {2017},
journal = {Human Mutation},
volume = {38},
issue = {6},
pages = {494-502},
doi = {10.1002/humu.23204},
url = {http://onlinelibrary.wiley.com/doi/10.1002/humu.23204/abstract},

}

5

3 The TargetExperiment class

TarSeqQC R package is based on the TargetExperiment class. The Figure 1 shows the TargetExperiment
class structure.

Figure 1: TargetExperiment class diagram.

The TargetExperiment class has nine slots:

(cid:136) bedFile: a GRanges object that models the Bed File

(cid:136) bamFile: a BamFile object that is a reference to the BAM File.

(cid:136) fastaFile: a FaFile object that is a reference to the reference sequence ﬁle.

(cid:136) featurePanel: a GRanges object that models the feature panel and related statistics.

(cid:136) genePanel: a GRanges object that models the analyzed panel and related statistics at a gene level.

(cid:136) scanBamP: a ScanBamParam containing the information to scan the BAM File.

(cid:136) pileupP: a PileupParam containing the information to build the pileup matrix.

6

(cid:136) attribute: a character indicating which attribute coverage or medianCounts will be used to the

analysis.

(cid:136) feature: a character indicating the name of the analyzed features, e.g.: “amplicon”, “exon”, “tran-

script”.

The next sections will illustrate how the TargetExperiment methods can be used. For this, the TarSeqQC
R package provides a Bed File, a BAM File, a FASTA File and a dataset that stores the TargetExperiment
object built with those. This example case is based on a synthetic amplicon sequencing experiment contain-
ing 29 amplicons of 8 genes in 4 chromosomes.

3.1 Input Data

A TS experiment is characterized by the presence of a Bed File which deﬁnes the features that should be
sequenced. The TarSeqQC package follows this architecture, where the Bed File is the key data of the
experiment. However, TarSeqQC also requires mainly three pieces of information that should be provided
in order to call the TargetExperiment constructor. The Bed File, the BAM File, that contains the obtained
alignment for the sequenced reads, and the sequence FASTA File. The complete path to these ﬁles should
be deﬁned when the TargetExperiment constructor is called.
Other parameters can also be speciﬁed in the TargetExperiment object constructor. The scanBamP and
pileupP are instances of the ScanBamParam and PileupParam classes deﬁned in the RSamtools R Biocon-
ductor package (Morgan et al., 2015b). These parameters specify how to scan the BAM File and how to build
the corresponding pileup, that will be used for exploration and quality control. The scanBamP allows the
speciﬁcation of the features speciﬁed in the Bed File, according to Morgan et al. (2015b) speciﬁcations. The
pileupP establishes what information should be contained in the pileup matrix, for instance, if nucleotides
and/or strand should be distinguished. If these two parameters are not speciﬁed, the default values of their
constructors will be used.
Other important parameters that should be speciﬁed before to conduct the Quality Control are feature
and attribute. The ﬁrst is a character that determines which kind of features are contained in the Bed
File. In the example presented here, amplicon is the feature type. The second parameter, attribute, can
be coverage or medianCounts deﬁning which measures will be considered in the Quality Control analysis.

3.1.1 Bed File

The Bed File is stored as a TargetExperiment slot and it is modeled as a GRanges object (Lawrence et al.
(2013)). The Bed File must be a tabular ﬁle in which each row represents one feature. This ﬁle should
contain at least “chr”, “start”, “end” , “name” and “gene” named columns. Additional columns like “strand”
or another experimental information could be included and would be conserved. For example, in some
experiments, more than one PCR pool is necessary. In this case, the Bed File must also contain a “pool”
column specifying the pool in which each feature was deﬁned. This information is an imperative requisite to
evaluate the performance of each PCR pool.
A GRanges object represents a collection of genomic features each having a single start and end location
on the genome (Lawrence et al., 2013). In order to use it to represent the Bed File, the “chr”, “start” and
“end” mandatory ﬁelds will be used to deﬁne the “seqnames”, “start” and “end” GRanges slots. The same
will occur if the optional ﬁeld “strand” is included in the Bed File. The “name” column will be set to ranges
identiﬁers. Finally, “gene” and additional columns like “pool”, will be stored as metadata columns.
In order to create a TargetExperiment object, the complete route to the Bed File and its name must be
speciﬁed as a character R object. Thus, to use the example Bed File provided by TarSeqQC :

7

> bedFile<-system.file("extdata", "mybed.bed", package="TarSeqQC", mustWork=TRUE)

Note that any experiment, in which can be deﬁned feature-gene relations, could be analyzed using the
TarSeqQC R Bioconductor package. For instance, if you have an RNA-seq experiment and you are interested
in exploring some genes, you could build your customized Bed File in which the feature could be “exon” or
“transcript”.

3.1.2 BAM File

The BAM File stores the ordered alignment results (Li et al., 2009). In this example case, it corresponds
to the amplicon sequencing experiment alignment. This ﬁle will be used to build the pileup matrix for the
selected features. Brieﬂy, a pileup is a matrix in which each row represents a genomic position and have at
least three columns: “pos”, “chr” and “counts”. The ﬁrst and second columns specify the genomic position
and “counts” contains the total read counts for this position. Pileup matrix could contain four additional
columns that store the read counts for each nucleotide at this position.
In order to call the TargetExperiment constructor, the complete route to the BAM File and its name must
be speciﬁed as a character R object. For example, we can deﬁne it in order to use TargetExperiment external
data:

> bamFile<-system.file("extdata", "mybam.bam", package="TarSeqQC", mustWork=TRUE)

When the TargetExperiment constructor is called the BAM File, will be stored as a BamFile object (Morgan
et al., 2015b) and this object will be a TargetExperiment slot.

3.1.3 FASTA File

The FASTA File contains the reference sequence previously used to align the BAM File and will be used to
extract the feature sequences. This information is useful to compare the pileup results with the reference,
in order to detect potential nucleotide variants. To create a TargetExperiment object, the full path to the
FASTA File and its name must be speciﬁed as a character R object. For example:

> fastaFile<-system.file("extdata", "myfasta.fa", package="TarSeqQC",
mustWork=TRUE)
+

The FASTA File will be stored as a FaFile object (Morgan et al. (2015b)) and this object will be set to a
TargetExperiment slot.

3.1.4 Additional input data

The previous ﬁles are mandatory to call the TargetExperiment constructor. Additional parameters can be
set in order to apply several methods and perform quality control and results exploration. These parameters
are:

(cid:136) scanBamP: is a ScanBamParam object, that speciﬁes rules to scan a BamFile object. For example, if
you wish only keep those reads that were properly paired, or those that have a speciﬁc Cigar code,

8

scanBamP can be used to specify it. In TS experiments, we want to analyze only the features. The way
to specify this is using the which parameter in the scanBamP constructor. If the scanBamP parameter
was not speciﬁed in the TargetExperiment constructor calling, its default value will be used and then,
the which parameter will be speciﬁed using the Bed File.

(cid:136) pileupP: is a PileupParam object, that speciﬁes rules to build the pileup starting from a BamFile.
You can use the pileupP parameter to specify if you want to distinguish between nucleotides and or
strands, ﬁlter low read quality or low mapping quality bases. If the pileupP parameter is not speciﬁed,
its default value will be used.

(cid:136) attribute: is a character that speciﬁes which attribute must be used for the results exploration and
quality control. The user can choice between medianCounts or coverage. If the attribute parameter is
not speciﬁed in the TargetExperiment constructor, it will be set to "". But, prior to performing some
exploration or control, this argument must be set using the setAttribute() method.

(cid:136) feature: is a character that deﬁnes what means a feature. In this vignette a little example using a
synthetic amplicon targeted sequencing experiment is shown, thus the feature means an amplicon. But,
the use of TarSeqQC R package is not restricted to analyze only this kind of experiments. If you don’t
specify the feature parameter, it will be set to "". But, as in the attribute parameter, it must be
set prior to performing some exploration or control. It can be done using the setFeature() method.

(cid:136) BPPARAM: is a BiocParallelParam instance deﬁning the parallel back-end to be used during evaluation
(see (Morgan et al., 2015a)). It allows the speciﬁcation of how many workers (CPUs) will be used,
etc.

For more information about ScanBamParam and PileupParam constructors see Rsamtools manual.

3.2 Creating a TargetExperiment object

3.2.1 Controlling ﬁles consistency

TarSeqQC provides a speciﬁc method that allows the inspection of the Bed File and FASTA File consistency
previous to the TargetExperiment constructor call. The checkBedFasta method receives the full path to
those ﬁles and as it is executed it is printing several messages into the screen. Duplicated features location or
names, incorrect start/end positions and inconsistency between the features and the reference genome will
be analyzed.

> checkBedFasta(bedFile , fastaFile)

- Checking bed file, mandatory columns:

OK

- Checking bed file, duplicated feature IDs:

OK

- Checking bed file, duplicated feature locations:

OK

- Checking bed file, start and end values:

OK

- Checking bed-fasta chromosome consistency:

OK

- Checking bed-fasta genomic coordinates consistency:

OK

9

3.2.2 Constructor call

Once you have deﬁned the input data presented above, the TargetExperiment constructor could be called
using:

> library("TarSeqQC")
> library("BiocParallel")
> BPPARAM<-bpparam()
> myPanel<-TargetExperiment(bedFile, bamFile, fastaFile, feature="amplicon",
+

attribute="coverage", BPPARAM=BPPARAM)

When TargetExperiment is called, some TargetExperiment methods are invoked in order to deﬁne two of
the TargetExperiment slots. First, the buildFeaturePanel is internally used in order to build the fea-
turePanel slot. Then, the summarizePanel is invoked in order to build the genePanel slot, which contains
the information summarized at a gene level.
In the previous example, the feature and attribute parameter values were deﬁned. If they aren’t speciﬁed
in the constructor call, the TargetExperiment object can be created, but a warning message will be printed.
After that, the setFeature and setAttribute methods should be used to set these values. For example:

> # set feature slot value
> setFeature(myPanel)<-"amplicon"
> # set attribute slot value
> setAttribute(myPanel)<-"coverage"

As mentioned earlier, when the scanBamP and pileupP are not speciﬁed in the constructor call, they assume
their default constructor. But, after the constructor call, they could be speciﬁed using setScanBamP and
setPileupP methods.

> # set scanBamP slot value
> scanBamP<-ScanBamParam()
> #set scanBamP which slot
> bamWhich(scanBamP)<-getBedFile(myPanel)
> setScanBamP(myPanel)<-scanBamP
> # set pileupP slot value
> setPileupP(myPanel)<-PileupParam(max_depth=1000)
> # build the featurePanel again
> setFeaturePanel(myPanel)<-buildFeaturePanel(myPanel, BPPARAM)
> # build the genePanel again
> setGenePanel(myPanel)<-summarizePanel(myPanel, BPPARAM)

Note that the previous code speciﬁes that the maximum read depth can be 1000. If you have some genomic
positions that have more than 1000 reads, they will be truncated to this number. It is also important to note
that, if any change in the scanBamP and/or pileupP slots was done, the featurePanel and the genePanel
slots will be set again.
The TarSeqQC R package provides a dataset that stores the TargetExperiment object built in the previous
steps. To use it, run:

10

> data(ampliPanel, package="TarSeqQC")

The loaded object is called ampliPanel. As was mentioned before, some TargetExperiment() methods need
to consult the BAM File and FASTA File, and for this, the bamFile and fastaFile slots are used. Given
that ampliPanel was built by the package creators, the path ﬁle routes that have its slots are not the same in
which these ﬁles are located on users’ computers. Thus, after ampliPanel loading, it is necessary to re-deﬁne
the BAM File and FASTA File path ﬁles, running:

> # Defining bam file and fasta file names and paths
> setBamFile(ampliPanel)<-system.file("extdata", "mybam.bam",
+
> setFastaFile(ampliPanel)<-system.file("extdata", "myfasta.fa",
+

package="TarSeqQC", mustWork=TRUE)

package="TarSeqQC", mustWork=TRUE)

Note that featurePanel and genePanel do not need to be rebuilt. The redeﬁnition of the ﬁle names is only
necessary in order to use TargetExperiment methods that query this ﬁles.

3.2.3 Early exploration

The TargetExperiment class has typical show/print and summary R methods implemented. In addition, the
summaryGeneLev and summaryFeatureLev methods allow the summary exploration at “gene” and “feature”
level. The next example illustrates how these methods can be called:

> # show/print
> myPanel

TargetExperiment
amplicon panel:

ranges strand |

GRanges object with 3 ranges and 6 metadata columns:
seqnames
<Rle>

gc coverage sdCoverage
<IRanges> <Rle> | <character> <numeric> <numeric> <numeric>
19
90
12

chr1 [ 463, 551]
chr1 [1553, 1603]
chr1 [3766, 3814]

gene1
gene2
gene2

0.674
0.451
0.531

320
550
455

* |
* |
* |

gene

AMPL1
AMPL2
AMPL3

medianCounts IQRCounts
<numeric> <numeric>
24
14
27

326
574
463

AMPL1
AMPL2
AMPL3
-------
seqinfo: 4 sequences from an unspecified genome; no seqlengths

gene panel:

GRanges object with 3 ranges and 4 metadata columns:
seqnames
<Rle>

ranges strand | medianCounts IQRCounts coverage sdCoverage
<numeric> <numeric> <numeric> <numeric>
0

<IRanges> <Rle> |
* |

chr1 [ 463, 551]

320

326

0

gene1

11

chr1 [1553, 3814]
59]
chr3 [

gene2
gene3
-------
seqinfo: 4 sequences from an unspecified genome; no seqlengths

* |
* |

518
0

56
0

1,

502
0

67
0

selected attribute:

coverage

> # summary
> summary(myPanel)

gene
amplicon

Min. 1st Qu. Median Mean 3rd Qu. Max.
396 502
472 931

328 312
288 316

261
143

0
0

> #summary at feature level
> summaryFeatureLev(myPanel)

amplicon

Min. 1st Qu. Median Mean 3rd Qu. Max.
472 931

288 316

143

0

> #summary at gene level
> summaryGeneLev(myPanel)

Min. 1st Qu. Median Mean 3rd Qu. Max.
396 502

328 312

261

0

gene

Using those methods you can easily ﬁnd, for example, that amplicons were sequenced,in average, at a cov-
erage of 312. It can also be observed that there is at least one amplicon that was not read. This is because
the minimum value of the attribute (coverage) is 0. To complement this analysis, the attribute distribution
can be explored using:

> g<-plotAttrExpl(myPanel,level="feature",join=TRUE, log=FALSE, color="blue")
> x11(type="cairo");
> g

In Figure 2, the join parameter was set to TRUE. Thus, density and box plots are plotted together. If
it is set to FALSE, the ﬁgure will contain the attribute box-plot on the left and the corresponding attribute
density plot on the right.
Exploration of any metadata information is also provided. GC content, feature length distributions and
gene or pool frequencies can be explored using the plotMetaDataExpl method. Other metadata columns,
speciﬁed in the bedFile, can also be analyzed. If the analyzed metadata is numeric, then boxplot and density
plot is built. Those can be plotted together, or not, and in log10 scale. On the other hand, if it is categorical
like gene or pool, a bar frequency (absolute or in relative percentages) is plotted. The following code allows
the exploration of feature length distributions and gene frequencies along the features.

12

Figure 2: Attribute distribution and density plots.

> # explore amplicon length distribution
> plotMetaDataExpl(myPanel, "length", log=FALSE, join=FALSE, color=
+

"blueviolet")

Figure 3: Amplicon length distribution’ plot.

> # explore gene
> plotMetaDataExpl(myPanel, "gene", abs=FALSE)

s relative frequencies

’

Figure 3 indicates that the mean amplicon length is 74.7 nucleotides with standard deviations of 20.8.
In addition, half of the

But, as can be observed in the density plot, the mode is lower than this mean.
amplicons have their lengths lower than 71, and the rest between 71 and 125.
Figure 4 shows the gene relative frequencies, in percentages. As can be viewed, more than the 22% of the
amplicons belong to ‘gene8’ and approximately 21% belong to ‘gene5’. On the other hand, both ‘gene1’ and
‘gene3’ have less than 5% of total amplicons.

13

02505007501Mean = 316.1,  sd = 212.8,  median = 288,  IQR = 329Amplicon coverageAmplicon coverage5075100125Mean = 74.7,  sd = 20.8,  median = 71,  IQR = 32Length50751001250.0000.0050.0100.0150.020DensityLengthFigure 4: Gene’s relative frequencies.

3.3 Deep exploration and Quality Control

3.3.1 Targeted selection performance

In the context of TS experiments, it is expected that most of the sequencing reads come from the target
regions and not from the rest of the genome. If it does not, it may suggest an unexpected behavior of the
used primers library that could impact on the read counts of overlapped regions skewing interpretation.
One way to check this is using the readFrequencies method which returns a data frame containing, for
each chromosome, the amount and the percentage of reads fall in and out features. Therefore, if this graph
shows a high percentage of reads that fall outside of interest features, a large part of the sequencing reads
will be discarded when feature coverage is computed and consequently the power of detection will be lower.
After readFrequencies calling, the plotInOutFeatures method can be used in order to plot the obtained
data frame. It can be achieved running the next code:

> readFrequencies(myPanel)
> plotInOutFeatures(readFrequencies(myPanel))

Figure 5 shows that more than 15to genomic regions outside of the expected amplicons (red bars). This
result is not expected, since it indicates that the used primers were not so speciﬁcs to capture only the
targeted regions. Moreover, TS libraries are carefully designed to sequence speciﬁc genomic regions and the
loss of a lot of sequence reads has a direct impact on the achieved coverage of the targeted regions. For these
reasons the early detection of this technical eﬀect can avoid false subsequent analysis conclusions.

14

0510152025gene1gene2gene3gene4gene5gene6gene7gene8GeneRelative frequency (%)Gene frequenciesFigure 5: Percentages of reads falling in or out of the targeted regions.

3.3.2 Panel overview

Working on a TS experiment, it would be useful simultaneously evaluate the overall performance of the
features. For instance, the user could be interested in exploring the proportion or amount of features within
speciﬁc attribute intervals. In the example data, ﬁve coverage intervals could be deﬁned according to the
Table 1. Each user can deﬁne its attribute intervals table and the amount of them according to its needs.
In this example, 0 indicates no reads and Inf refers to features with coverage higher than 500. To incorporate

Table 1: Coverage intervals

Coverage Interval Motivation
[0, 1)
[1, 50)
[50, 200)
[200, 500)
[500, Inf )

Not sequenced
Low sequencing coverage
Regular sequencing coverage
Very good sequencing coverage
Excellent sequencing coverage

the coverage intervals into the analysis it is necessary to specify each interval extreme value like:

> # definition of the interval extreme values
> attributeThres<-c(0,1,50,200,500, Inf)

A panel results overview is critical in order to compare and integrate those at the feature, gene, and chromo-
some level. To help this task, TarSeqQC package implements the plot method, a graphical tool consisting in
a polar histogram where each gene is represented as a bar. Each bar is colored depending on the percentage
of features that have their attribute value within a particular preﬁxed interval. In addition, the bars (genes)

15

0102030chr1chr3chr7chr10ChromosomeValueIn targets (%)Out targets (%)can be grouped in chromosomes in order to facilitate coverage results comparison at this level. The next
code builds this plot:

> # plot panel overview
> plot(myPanel, attributeThres=attributeThres, chrLabels =TRUE)

Figure 6: Panel overview plot.

In the example presented here, we can easily distinguish that the unique amplicon of the “gene3” was not
sequenced. This is because in Figure 6, the bar corresponding to “gene3” is colored in red and this color is
related to the [0,1) coverage interval. In the same plot, can also be appreciated that this gene has only one
amplicon, as depicted in parenthesis in the bar label “gene3(1)”. Meanwhile “gene4” has 40% of its amplicons
(2) with a coverage between 1 and 50, 20 % (1 amplicon) with coverage between 50 and 200 and the rest
with a very good coverage value, greater than 200. It is notable that this plot provides a fast overview of
the coverage feature performance.

16

gene1(1)gene2(2)gene3(1)gene4(5)gene5(6)gene6(2)gene7(5)gene8(7)20% 40% 60% 80% chr1chr3chr7chr10Coverage_intervals[0,1)[1,50)[50,200)[200,500)[500,Inf]It is important to note that a small and simple example is presented here. The previous plot could have a
greater impact when the panel has more features and genes. Figure 7 shows the panel overview for a TS
Experiment based on the Ion AmpliSeq Cancer Panel Primer Pool ﬁ. This is a TS Panel oﬀered by Life
Technologies (Technologies (2014a)) that allows the inspection of 190 amplicons. In this case, can be easily
observed that MLH1 and CDKN2A genes were no sequenced. Can also be appreciated that several genes
like ALK, NRAS, BRAF, HNF1A, have uniform coverage values along their amplicons. On the contrary,
RB1 ’ and ATM genes have some amplicons with low coverage and some other with a high coverage. Another
alternative to explore attribute (coverage) performance is given by plotFeatPerform that shows a similar
plot expanding it along the x-axis. This method also allows the exploration of attribute values at feature
and gene levels, setting its parameter complete as TRUE. As result, the generated graph will contain two
plots. The upper panel is a bar plot at the feature level and the lower, at the gene level. Both graphics
incorporate the preﬁxed attribute intervals information and contain a red line to indicate the average value
of the attribute at the corresponding level. In our example, you could run:

> # plot panel overview
> g<-plotFeatPerform(myPanel, attributeThres, complete=TRUE, log=FALSE,
+
> g

featureLabs=TRUE, sepChr=TRUE, legend=TRUE)

Figure 8 helps the coverage value evaluation for each amplicon and gene. It is noticeable that when coverage
is summarized at gene level the highest value is lower than 500. However, at amplicon level, the highest
value is greater than 800.
The previous plot is also very useful when TS panels were made-up by several primer pools combination. For
example, the Comprehensive Cancer Panel ﬁ is another Life Technologies panel that allows the exploration
of 16000 amplicons from 409 genes related to several cancer types using 4 primer pools (Technologies (2014b)).
In this case, the Bed File contains a ‘pool column that stores the pool number for each feature. This
information will be conserved in the TargetExperiment object that was built from this panel.
In the Quality Control context, it is important to evaluate in early analysis stages, if some pool eﬀect exists
and if all pool results are comparable. For example, Figure 9 illustrates the use of the plotFeatPerform
in the described case. Now, you can see that the graphic corresponding to the amplicon level shows a
separation between amplicons according to its pool value. Note that the same plot at a gene level is not
showed because the complete parameter was set to FALSE. It is important to emphasize that, if correspond,
the pool information will be included in all methods of the TargetExperiment class. Thus, for example,
when you call the summary function for a TargetExperiment object that has pool information, the output
will contain statistic results for the amplicon level and for each pool separately.

3.3.3 Controlling possible attribute bias

It is known that those DNA fragments having high GC content or high length tends to be ’more sequenced’
those with lower GC/length values. Then, GC content and feature’s length can be considered as possible bias
sources, in particular, when the feature is an exon or a transcript. In order to check it, TarSeqQC incorporates
biasExploration that allows the inspection of the selected attribute (’coverage’ in the example) in terms
of groups or intervals of bias sources. To do this, the method deﬁnes four source groups according to the
distribution quartiles of the selected source (GC content, length or any included in the panel metadata) and
then assigns one group to each feature. After that boxplot and, optionally, density plot for each group are
plotted in order to evaluate possible bias. If the selected source is a categorical variable, like pool or gene,
each category will be considered as a group. For instance, the next lines allows the exploration of GC content
eﬀect:

17

18

Figure 7: Cancer Panel Primer Pool overview plot.

MPL(1)NRAS(2)ALK(2)ERBB4(8)IDH1(1)CTNNB1(1)MLH1(1)PIK3CA(7)VHL(3)FBXW7(5)FGFR3(5)KDR(9)KIT(9)PDGFRA(4)APC(7)CSF1R(2)NPM1(1)BRAF(2)EGFR(8)MET(5)SMO(5)FGFR1(2)ABL1(5)CDKN2A(1)NOTCH1(2)FGFR2(4)PTEN(7)RET(5)ATM(17)HRAS(2)HNF1A(2)KRAS(3)PTPN11(2)FLT3(5)RB1(8)AKT1(1)CDH1(3)ERBB2(4)TP53(8)SMAD4(8)JAK3(2)STK11(4)GNAS(1)SRC(1)SMARCB1(4)20% 40% 60% 80% Coverage_intervals[0,1)[1,50)[50,200)[200,500)[500,Inf]Figure 8: Amplicon coverage performance. The upper panel is a bar plot at feature level, and the lower, at
gene level.

Figure 9: Performance exploration of an Ion AmpliSeq Comprehensive Cancer Panel experiment.

19

0250500750AMPL1AMPL10AMPL11AMPL12AMPL13AMPL14AMPL15AMPL16AMPL17AMPL18AMPL19AMPL2AMPL20AMPL21AMPL22AMPL23AMPL24AMPL25AMPL26AMPL27AMPL28AMPL29AMPL3AMPL4AMPL5AMPL6AMPL7AMPL8AMPL9Amplicon coverageCoverage_intervals[0,1)[50,200)[200,500)[500,Inf]chr1chr3chr7chr100100200300400500gene1gene2gene3gene4gene5gene6gene7gene8GeneGene coverageCoverage_intervals[0,1)[200,500)[500,Inf]123401234log10(amplicon_coverage+1)Coverage_intervals[0,1)[1,50)[50,200)[200,500)[500,Inf]> x11(type="cairo")
> biasExploration(myPanel, source="gc", dens=TRUE)

Figure 10: Exploration of amplicon coverage in each of amplicon GC content’s quartiles.

3.3.4 Controlling low counts features

Low counts features should be detected in early analysis stages. The summaryIntervals method builds a
frequency table of the fetaures that have its attribute value between predeﬁned intervals. For example, if
you are interested in exploring the “coverage” intervals deﬁned before, you could do:

> # summaryIntervals
> summaryIntervals(myPanel, attributeThres)

0 <= coverage < 1
1 <= coverage < 50

amplicon_coverage_intervals abs cum_abs rel cum_rel
3.4
3.4
37.9
79.3
100.0

1
0
50 <= coverage < 200 10
200 <= coverage < 500 12
6

1 3.4
1 0.0
11 34.5
23 41.4
29 20.7

coverage >= 500

1
2
3
4
5

20

0250500750[0.263,0.377](0.377,0.425](0.425,0.531](0.531,0.685]CoverageGC groups[0.263,0.377](0.377,0.425](0.425,0.531](0.531,0.685]The previous method is also useful when you are interested in quantifying how many features have its at-
tribute value (coverage) lower or higher than a threshold. In this example, we are interested in knowing how
many amplicons have shown at least a coverage of 50, because we consider that this is a minimum value that
we will admit. This is a typical aspect that will be analyzed when you do an experiment Quality Control.
Complementing this method, the plotAttrPerform method allows the graphical exploration of relative and
cumulative feature frequencies in the predeﬁned intervals. The corresponding function call is:

> plotAttrPerform(myPanel, attributeThres)

Figure 11: Relative and cumulative amplicon frequencies in the speciﬁed intervals.

In the cases in which several pools were used, both summaryIntervals and plotAttrPerform allows the
exploration at pool level. Thus, diﬀerences among pool can be easily detected.
Another method that could help this analysis is getLowCtsFeatures. This method returns a data frame
object containing all the features that have its attribute value lower than a threshold. The output data frame
also contains panel and attribute information for each feature. For example, to known which are the genes
that have a coverage value lower than 50, you can do:

> getLowCtsFeatures(myPanel, level="gene", threshold=50)

names seqname start end medianCounts IQRCounts coverage sdCoverage
0

1 59

chr3

1 gene3

0

0

0

In addition, if you want to known which amplicons have a coverage value lower than 50, you should execute:

> getLowCtsFeatures(myPanel, level="feature", threshold=50)

names seqname start end gene

1 AMPL4

chr3

1 59 gene3 0.492

gc coverage sdCoverage medianCounts IQRCounts
0

0

0

0

21

lllll02550751000  <=  coverage  <  11  <=  coverage  <  5050  <=  coverage  <  200200  <=  coverage  <  500coverage  >=  500Frequency (%)Coverage_intervals0  <=  coverage  <  11  <=  coverage  <  5050  <=  coverage  <  200200  <=  coverage  <  500coverage  >=  500Cumulative frequencyGraphical methods were also implemented. The plotGeneAttrPerFeat allows the attribute value exploration
for all the features of a selected gene. For instance, if you want to explore the “gene4”, you should do:

> g<-plotGeneAttrPerFeat(myPanel, geneID="gene4")
> # adjust text size
> g<-g+theme(title=element_text(size=16), axis.title=element_text(size=16),
+
> g

legend.text=element_text(size=14))

Figure 12: Performance attribute exploration of the gene4.

The attribute value for each feature contained in the “gene4” can be observed in Figure 12. If the selected
gene has some features overlapped, the overlap and level parameters of the plotGeneAttrPerFeat method
could be useful. When the overlap parameter is TRUE the method determines the overlap between features
and deﬁnes new features called ‘Regions’. For each of those regions, their attribute value is deﬁned as the
mean value of the attributes of the overlapped features. The level parameter, indicates the level of the
output plot of the PlotGeneAttrPerFeat. The allowed values for level are: "feature", "region" and
"both". The combination of these two parameters deﬁne the plot behavior:

(cid:136) overlap=FALSE: amplicon overlap will be ignored.

1. level must be "feature" (default values)

(cid:136) overlap = TRUE: Amplicons will be grouped into regions according to their overlap

1. level ="feature", feature coverage bar plot grouped by overlapped regions as facets.
2. level ="region", overlapped region’s coverage bar plot.
3. level ="both", plot with two paneles: the bar plot at feature level and at the region level.

22

0250500750AMPL5AMPL6AMPL7AMPL8AMPL9AmpliconAmplicon coverageAmplicon coverage of  gene4 geneFor instance, in the last case, overlap=TRUE and level="both" the returned plot will consist of two panels.
The top panel is the same that is generated when the level is "feature" including ggplot2 facets indicating
which features are included in each region. The bottom panel is the returned when level is "region".

> g<-plotGeneAttrPerFeat(myPanel, geneID="gene4", overlap = TRUE, level="both")
> g

Figure 13: Performance attribute exploration of the gene4 at amplicon and overlapped region levels.

It is worth to note that if a quality control at overlapped regions level is required, the user could deﬁne
a new bed ﬁle in which the features will be the regions and run the TarSeqQC over this new bed ﬁle. To
assist this task, the package provides the getOverlappedRegions method, internally called by the plot-
GeneAttrPerFeat method. getOverlappedRegions needs two parameters, a TargetExperiment object and
a logical object, collapse indicating if the overlap information should be collapsed or not at the collapsed
region level. Thus, if the user wants to deﬁne a new Bed File based on the overlapped regions, he could run
the code below to obtain a data.frame summarizing the feature panel at a region level. Then, this object
can be saved to a Bed File for future use of TarSeqQC .

> dfRegions<-getOverlappedRegions(myPanel,collapse=TRUE)
> head(dfRegions)

chr start end gene region_id region_coverage
320

463 551 gene1

Region1

1 chr1

23

56789AMPL5AMPL6AMPL7AMPL8AMPL90250500750AmpliconAmplicon coverageAmplicon coverage of  gene4 gene0250500750Region5Region6Region7Region8Region9RegionRegion coverage2 chr1 1553 1603 gene2
3 chr1 3766 3814 gene2
4 chr3
59 gene3
1
5 chr3 1062 1125 gene4
6 chr3 5720 5788 gene4

Region2
Region3
Region4
Region5
Region6

550
455
0
222
143

> #change the region_id field name to consistency of the new bed file
> names(dfRegions)[5]<-"name"

> #save the new bed file
> write.table(dfRegions[,1:5], file="myRegions.bed", sep="\t", col.names=T,
+ row.names=F,quote=F)

3.3.5 Read counts exploration

Quality Control in TS experiments implies the analysis of coverage/median counts achieved for each feature.
But, sometimes, the exploration of the read proﬁle that was obtained for a particular genomic region or a
feature could be interesting. For this reason, the TarSeqQC R package provides methods to help the explo-
ration at a nucleotide resolution. Those methods are based on the data frame returned by the pileupCounts
method. This contains the read counts information for each nuecleotide of the features contained in the Bed
File. Note that the columns in the obtained data frame could change, depending on the pileupP parameter
deﬁnition. In our case we are working with its default constructor and only the maxdepth parameter was
modiﬁed. For this reason, the resultant data frame will contain one column for each nucleotide and one
column (“-”) storing deletion counts.
pileupCounts is a function, not a TargetExperiment method, thus it could be called externally to the class.
In order to call it, the speciﬁcation of several parameters is needed:

(cid:136) bed: is a GRanges object that, at least, should have values in the seqnames, start and end slots.

(cid:136) bamFile: is a character indicating the full path to the BAM File.

(cid:136) fastaFile: is a character indicating the full path to the FASTA File.

(cid:136) scanBamP: is a ScanBamParam object, that speciﬁes rules to scan the BamFile. If it was not speciﬁed,
its default constructor values will be used and then, the which parameter will be speciﬁed using the
bed parameter.

(cid:136) pileupP: is a PileupParam object, that speciﬁes rules to build the pileup, starting from the BamFile.
If it was not speciﬁed, the pileupP parameter will be deﬁned using the constructor default values.

(cid:136) BPPARAM: is a BiocParallelParam instance deﬁning the parallel back-end to be used during evaluation

(see (Morgan et al., 2015a)).

In order to work with the example data, it is necessary do:

> # define function parameters
> bed<-getBedFile(myPanel)
> bamFile<-system.file("extdata", "mybam.bam", package="TarSeqQC", mustWork=TRUE)
> fastaFile<-system.file("extdata", "myfasta.fa", package="TarSeqQC",
+
mustWork=TRUE)
> scanBamP<-getScanBamP(myPanel)

24

> pileupP<-getPileupP(myPanel)
> #call pileupCounts function
> myCounts<-pileupCounts(bed=bed, bamFile=bamFile, fastaFile=fastaFile,
+

scanBamP=scanBamP, pileupP=pileupP, BPPARAM=BPPARAM)

> head(myCounts)

T N

A
pos seqnames seq
T
1
A 169
1
G
0
T
0
G
0 181
C

chr1
chr1
chr1
chr1
chr1
chr1

1345 463
1346 464
1347 465
1348 466
1349 467
1350 468

G
C
0 167 0 167 0 chr1:463-551
4
2 0 169 0 chr1:463-551
0
1
1 0 174 0 chr1:463-551
0 174
1 175 0 175 0 chr1:463-551
1
0 0 181 0 chr1:463-551
0 181
0 0 181 0 chr1:463-551
0

= - which_label counts
172
172
176
177
181
181

The obtained data frame contains the pileup information. It can be used to build a read proﬁle plot where
the x-axis represents the genomic position and the y-axis, the obtained read counts. The plotRegion allows
exploration of the read proﬁle for a speciﬁc genomic region. The getRegion method extracts the information
for a genomic region. For example, the code below returns a data frame with location information of “gene7”
amplicons:

> #complete information for gene7
> getRegion(myPanel, level="gene", ID="gene7", collapse=FALSE)

names seqname start end gene
141 233 gene7
chr10
chr10 1007 1079 gene7
chr10 4866 4928 gene7
chr10 6632 6693 gene7
chr10 8475 8527 gene7

1 AMPL18
2 AMPL19
3 AMPL20
4 AMPL21
5 AMPL22

> #summarized information for gene7
> getRegion(myPanel, level="gene", ID="gene7", collapse=TRUE)

1 AMPL18, AMPL19, AMPL20, AMPL21, AMPL22

names seqname start end gene
141 8527 gene7

chr10

Then, the previous information can be used to specify a genomic region and plot its read count proﬁle using
the plotRegion method. Since a large number of little changes at nucleotide level could be coused by the
sequencing process, the method provides a way to ﬁlter out those noisy variants of the read proﬁle. The
minAAF speciﬁes the minimum alternative allele frequency need to call a SNP and its default value is 0.05.
The other parameter is called minRD and speciﬁes the minimum read depth of the alternative allele (defult
value = 10). For each position of the speciﬁed region, the method computes a threshold that the SNPs
should be exceed to be plotted. To compute this threshold the minAAF is traduced at the read count scale
by multplication of it with the total counts of the genomic position. Then, the threshold is deﬁned as the
maximum value between minAAF (in read counts scale) and minRD. To avoid these ﬁlters both should be set
to 0. For instance, the call of the plotRegion avoiding these ﬁlters is:

25

> g<-plotRegion(myPanel, region=c(4500,6800), seqname="chr10", SNPs=TRUE,
+
> x11(type="cairo")
> g

minAAF = 0, minRD = 0, xlab="", title="gene7 amplicons",size=0.5)

Figure 14: Read counts proﬁle for the gene7 genomic region.

Another method, plotFeature, allows exploring the read proﬁle of a particular feature. In this case,it is
only necessary to specify the feature name that should be explored. This method internally calls the plotRe-
gion, thus it also could use the minAAF and minRD parameters. For instance, the R code below illustrates the
way to explore the “AMPL20” amplicon of the “gene7”, considering only those genomics variations exceed
minAAF =0.05 and minRD=10, which are the default values of these parameters.

> g<-plotFeature(myPanel, featureID="AMPL20")
> x11(type="cairo")
> g

As can be seen in both Figure 14 and Figure 15, the gray shadow corresponds to the total counts that
were obtained at each genomic position insight the selected amplicon. The violet line indicates read counts
matching with the reference sequence. In order to distinguish how many read counts could correspond to a
genomic variation, it is crucial that the pileupP deﬁnition contains the distinguish nucleotide parameter
as TRUE, which is its default value. In the previous plots, the green, blue, red and brown lines illustrate the
read counts that do not match with the reference and inform about a possible nucleotide variation. In the
Figure 15 can be appreciated that the selected amplicon shows a variation changing the reference nucleotide
for a “T”.
The proportion of read counts that match and no match against the reference can be displayed using the
plotNtdPercentage method as:

> plotNtdPercentage(myPanel, featureID="AMPL20")

26

010020030040050045005000550060006500countsProfilesref_consensusACTGcountsgene7 ampliconsFigure 15: Read counts proﬁle for the ”20” gene7 amplicon.

Figure 16: Nucleotide percentages for each genomic position on the “AMPL20” gene7 amplicon.

In Figure 16 can be observed that between 4910 and 4920 positions there is a nucleotide showing diﬀerences
between reference and read sequences. This information can be also extracted using the previous read counts
data frame, myCounts and the featurePanel slot of the TargetExperimentobject. To do this only the feature
name is necessary:

> getFeaturePanel(myPanel)["AMPL20"]

GRanges object with 1 range and 6 metadata columns:
gene

seqnames
<Rle>
chr10 [4866, 4928]

gc coverage sdCoverage
<IRanges> <Rle> | <character> <numeric> <numeric> <numeric>
1

ranges strand |

0.587

gene7

* |

142

AMPL20

medianCounts IQRCounts
<numeric> <numeric>

27

050100150488049004920CountsProfilesref_consensuscountsACTGAMPL200255075100AACCTGCTCTGTGCTGCATTTCAGAGAACGCCTCCCCGAGTGAGCTGCGAGACCTGCTGTCAGNtd %NucleotidesACTGNtd percentages of AMPL20AMPL20
-------
seqinfo: 4 sequences from an unspecified genome; no seqlengths

143

1

Using this information, you could select a subset in the myCounts object containing only those nucleotide
rows corresponding to the feature:

> featureCounts<-myCounts[myCounts[, "seqnames"] =="chr10" &
+

myCounts[,"pos"] >= 4866 & myCounts[,"pos"] <= 4928,]

Then, the position having the lowest value in the “=” column can be found. The position with the minimum
value of read counts matching against the reference is the same position that has the higher variation:

> featureCounts[which.min(featureCounts[,"="]),]

pos seqnames seq A C G

T N = -

1423 4912

chr10

G 0 0 0 134 0 0 0 chr10:4866-4928

which_label counts
134

As can be observed, in the position 4912 the reference genome indicates that there should be a “G”, and the
read counts indicate that in this position there is a “T”, showing a possible nucleotide variation. Remember
that the presented analysis is only an exploratory tool. Thus, the possible nucleotide variations detected in
this stage should be conﬁrmed or rejected in more speciﬁc downstream analysis. In the same way, a variant
identiﬁed in variant analysis can be easily explored and conﬁrmed using our tool.

3.4 Quality Control Report

The TarSeqQC R package provides a method that generates an .xlsx report in which Quality Control relevant
information is contained. This ﬁle has three sheets. In the ﬁrst, a summary is presented, containing the
results of summary and summaryIntervals methods. This sheet also includes a plot characterizing the
experiment. Any graphic could be chosen, but if its name is not speciﬁed, the method calls the TarSeqQC
plot method to build it. The second and third sheets store the panel information at a gene and a feature
level respectively. Only the information corresponding to the selected attribute will be stored. Then, if only
the report generation is desired, the buildReport method can be called after the object construction. In
the present example, the image ﬁle that should be included in the report and the report creation is speciﬁed,
using the code below:

> imageFile<-system.file("extdata", "plot.pdf", package="TarSeqQC",
+
mustWork=TRUE)
> buildReport(myPanel, attributeThres, imageFile ,file="Results.xlsx")

4 The TargetExperimentList class

The TargetExperimentList class was built in order to allow the joint analysis of several TargetExperiment
objects. Figure 17 shows the TargetExperimentList class structure.

The TargetExperimentList class has four slots:

28

(cid:136) bedFile: a GRanges object that models the Bed File

(cid:136) panels: a GRanges object that contains information related to several feature panels and related

statistics.

(cid:136) attribute: a character indicating which attribute coverage or medianCounts will be used to the

analysis.

(cid:136) feature: a character indicating the name of the analyzed features, e.g.: “amplicon”, “exon”, “tran-

script”.

TargetExperimentList has implemented several methods that are an extension of previously described meth-
ods for TargetExperiment class. The next sections will illustrate the employment of TargetExperimentList
methods using a TargetExperimentList object provided with the package. This dataset contains information
of two synthetic amplicon sequencing experiments using 29 amplicons of 8 genes in 4 chromosomes and
sequenced using two PCR pools.

4.1 Input Data

The TargetExperimentList allows the joint analysis of several TS experiments performed using the same Bed
File that can be involved in several situations such as a disease characterization study, patient monitoring
or system calibration process.
As a ﬁrst step, one TargetExperiment object for each of the TS experiments should be built. Then, a list
object, called panelList, should be deﬁned where each of its elements will be a TargetExperiment object.
For instance, having deﬁned two TargetExperiment objects, te1 and te2, the list must be deﬁned as:

> panelList<-list(panel1=te1, panel2=te2)

After that, the TargetExperimentList constructor can be called passing three parameters: panelList, fea-
ture and attribute. The las two are the same previously used in panels deﬁnitions. It is worth highlighting

Figure 17: TargetExperimentList class diagram.

29

that in this case attribute cannot be speciﬁed after object deﬁnition. When the constructor is called, the
resultant object only conserves information of the selected attribute. For instance, if the attribute is equal
to ‘coverage’, the ‘medianCounts’ information will not be stored in the TargetExperimentList object. Thus,
if the user wants to change the selected attribute, the TargetExperimentList constructor must be called
again.

4.2 Creating a TargetExperimentList object

4.2.1 Constructor call

TargetExperimentList constructor can be now called using:

> TEList<-TargetExperimentList(TEList=ampliList, feature="amplicon",
+

attribute="coverage")

This object is provided with the TarSeqQC package and can be loaded doing:

> data(TEList, package = "TarSeqQC")

4.2.2 Early exploration

As TargetExperiment, the TargetExperimentList class has also implemented typical R methods such as show,
print, and summary. They can be used as:

> # show/print
> TEList

TargetExperimentList
amplicon panels:

GRanges object with 3 ranges and 5 metadata columns:
pool
seqnames
<Rle>

ranges strand |

chr1 [ 463, 551]
chr1 [1553, 1603]
chr1 [3766, 3814]

<IRanges> <Rle> | <character> <numeric> <numeric>
0.674
0.451
0.531

gene1
gene2
gene2

* |
* |
* |

gene

2
2
2

gc coverage_panel_1
<numeric>
320
550
455

AMPL1
AMPL2
AMPL3

coverage_panel_2
<numeric>
0
202
152

AMPL1
AMPL2
AMPL3
-------
seqinfo: 4 sequences from an unspecified genome; no seqlengths

selected attribute:

coverage

30

> # summary
> summary(TEList)

$panel_1

amplicon coverage

$panel_2

amplicon coverage

‘

$

‘

pool 1

amplicon coverage

‘

$

‘

pool 2

amplicon coverage

Min. 1st Qu. Median Mean 3rd Qu. Max.
472 931

288 316

143

0

Min. 1st Qu. Median Mean 3rd Qu. Max.
135 260
38

74

8

0

Min. 1st Qu. Median Mean 3rd Qu. Max.
316 931

164 246

67

3

Min. 1st Qu. Median Mean 3rd Qu. Max.
208 550

113 153

10

0

The summary method returns a list where each element is a statistic summary table computed in each feature
panel. In particular, if the TS involves several PCR primer pools, then the method will display statistics
summaries for each panel/sample and for each pool as can be seen in the example presented here. This
basic exploration allows the identiﬁcation of the panel 2 as a poor performance panel in wich the mean
coverage was just 74 whereas, in panel 1, amplicons achieved a mean coverage of 316. It is also observed
that amplicons in pool 1 achieved higher mean coverage in contrast of amplicons in pool 2 in both panels.
A simple way to observe the described situation is provided by the previously used plotAttrExpl method
but now in the TargetExperimentList object. Now, the use of the method is:

> x11(type="cairo")
> plotAttrExpl(TEList, dens=TRUE, join=FALSE, log=FALSE, pool=TRUE)

The previous method provides several options allowing diﬀerent conﬁgurations of the displayed plot. The
parameter dens is a logical that indicates if density plot should be included and, if it is set to TRUE, then
the join ﬂag indicates if density and box-plots should be plot together or not. The pool parameter is also a
logical and if it indicates PCR pool presence (pool = TRUE), then the plot are built for each pool separately
using the ggplot2 facets facility. The last case is the showed in Figure 18.
In order to allow the same exploration but at a pool level, TargetExperimentList class implements the plot-
PoolPerformance method. This has the same parameters speciﬁcations that the previous method excepting,
obviously, the pool ﬂag.

> x11(type="cairo");
> plotPoolPerformance(TEList, dens=TRUE, join=FALSE, log=FALSE)

4.3 Comparative analysis and Quality Control

As in the case of the TargetExperiment class, attribute intervals such the listed in Table 1 can be included in
the panel comparative analysis. For instance, the two previous TargetExperimentList methods could accept

31

Figure 18: Attribute distribution and density plots for the two studied panels and separated by PCR pools.

Figure 19: Attribute distribution and density plots for the two PCR pools.

32

12l0250500750SampleCoverage120250500750CoverageSamplepanel_1panel_2ll025050075012Coverage02505007500.0000.0010.002CoveragePool12a parameter attributeThres specifying the attribute intervals. If this parameter is speciﬁed, then the plots
will be colored according to the interval in which fall the corresponding median value. The two previous
ﬁgures were built without using this parameter and consequently, the plots shows one color for each sample.
If in the corresponding methods calling attributeThres is added, then the resultant plots are showed in
Figure 20 and Figure 21.

Figure 20: Attribute distribution and density plots for the two PCR pools.

The plot method was also implemented for TargetExperimentList class. In this case, the resultant gg-
plot2 graph is a heatmap where rows represent features, columns represent samples and each cell is colored
according to the attribute value for the feature in the corresponding sample. The method also allows the
incorporation of pool information using ggplot2 facets facilities. In the example case the follow lines generates
this plot:

> plot(TEList, attributeThres = attributeThres, sampleLabs = TRUE,
+

featureLabs = TRUE)

The displayed heatmap conﬁrms the behavior previously observed in summary results and in Figure 18 where
panel 2 shows a boxplot with lower median compared with panel 1.
In panel 2, more than 50 % of the
amplicons have a coverage lower than 50 related to low sequencing coverage interval. Thus, if downstream
analysis involves nucleotide variant identiﬁcation, this panel should be discarded or re-sequenced in order to
achieve higher coverage values that provide more credibility in variant identiﬁcation.
When featureLabs is set to ‘TRUE’, the plot method allows the identiﬁcation of features with low attribute
value by simple inspection of x-axis ticks. If user wants to know not only who are the features with low
attribute value but also what attribute value achieved each of these, thus getLowCtsFeatures can be used
again as:

33

12l0250500750panel_1panel_2panel_1panel_2SampleCoveragecoverage interval1  <=  coverage  <  5050  <=  coverage  <  200200  <=  coverage  <  500Figure 21: Attribute distribution and density plots for the two PCR pools.

Figure 22: Panels overview: amplicons in rows and samples in columns. Colors according to preﬁxed coverage
intervals

34

ll025050075012PoolCoverageCoverage intervals50  <=  coverage  <  200panel_1panel_2AMPL1AMPL2AMPL3AMPL4AMPL5AMPL6AMPL7AMPL8AMPL9AMPL10AMPL11AMPL12AMPL13AMPL14AMPL15AMPL16AMPL17AMPL18AMPL19AMPL20AMPL21AMPL22AMPL23AMPL24AMPL25AMPL26AMPL27AMPL28AMPL29AmpliconSamplesCoverage_intervals0  <=  coverage  <  11  <=  coverage  <  5050  <=  coverage  <  200200  <=  coverage  <  500coverage  >=  500> getLowCtsFeatures(TEList, level="feature", threshold=50)

AMPL4
AMPL1
AMPL5
AMPL6
AMPL7
AMPL11
AMPL12
AMPL13
AMPL14
AMPL15
AMPL16
AMPL18
AMPL20
AMPL22
AMPL24
AMPL25
AMPL29

AMPL4
AMPL1
AMPL5
AMPL6
AMPL7
AMPL11
AMPL12
AMPL13
AMPL14
AMPL15
AMPL16
AMPL18
AMPL20
AMPL22
AMPL24
AMPL25
AMPL29

end width strand gene pool

seqnames start
59
1
chr3
551
463
chr1
1125
1062
chr3
5788
5720
chr3
chr3 12149 12204
chr7 10823 10893
chr7 21989 22080
chr7 30671 30744
chr7 31443 31567
chr7 38026 38098
chr7 49567 49670
141
233
chr10
4928
4866
chr10
chr10
8527
8475
chr10 70550 70644
chr10 97170 97220
chr10 106083 106172

59
89
64
69
56
71
92
74
125
73
104
93
63
53
95
51
90

* gene3
* gene1
* gene4
* gene4
* gene4
* gene5
* gene5
* gene5
* gene5
* gene5
* gene6
* gene7
* gene7
* gene7
* gene8
* gene8
* gene8

gc coverage_panel_1
0
320
222
143
67
203
495
318
158
111
229
104
142
402
115
126
184

2 0.492
2 0.674
1 0.359
2 0.304
2 0.268
2 0.606
2 0.598
1 0.473
1 0.464
2 0.685
2 0.356
2 0.656
1 0.587
1 0.377
2 0.263
1 0.392
2 0.278

coverage_panel_2
0
0
3
23
2
40
25
46
38
10
8
1
14
31
10
6
0

The returned object is a data.frame containing those features or genes (depending on the value of the level
parameter) that have attribute values lower than a threshold in at least one of the analyzed samples. For
instance, the ﬁrst amplicon appearing is ‘AMPL4’ having 0 coverage in both panels and the second amplicon
is ‘AMPL1’ having coverage lower than 50 only in the second panel (0).
A more detailed view of the achieved attribute values per features is given for the plotGlobalAttrExpl
TargetExperimentList method.

> x11(type="cairo")
> plotGlobalAttrExpl(TEList, attributeThres=attributeThres, dens=FALSE,
+

pool=TRUE, featureLabs=FALSE)

35

Figure 23: Amplicon performance. Each box-plot represents an amplicon, the values are the coverage
achieved in the samples and its color is according to preﬁxed coverage intervals. Each facet represents a
diﬀerent PCR pool

36

120250500750AMPL5AMPL8AMPL9AMPL10AMPL13AMPL14AMPL17AMPL20AMPL21AMPL22AMPL25AMPL26AMPL27AMPL1AMPL2AMPL3AMPL4AMPL6AMPL7AMPL11AMPL12AMPL15AMPL16AMPL18AMPL19AMPL23AMPL24AMPL28AMPL29AmpliconCoverageCoverage_intervals0  <=  coverage  <  11  <=  coverage  <  5050  <=  coverage  <  200200  <=  coverage  <  500coverage  >=  500Figure 23 shows the performance for each feature, in terms of achieved attribute, and allows the separa-
tion of them according to the PCR pool. Thus, the identiﬁcation of poor performance pools is also allowed.
In this case, both pool performances are similar and ‘AMPL4’ and ‘AMPL7’ show the worst performance.

5 Troubleshoot

TargetExperiment constructor in older TarSeqQC versions could result in an error message if the analyzed
BAM ﬁle contains at least one unmapped read. For this, the BAM ﬁle section specify that the sorted
alignment results should be used. Thus, unmapped reads need to be ﬁltered before to theTarSeqQC use. To
do this, the user could use the scanBamP parameter in the TargetExperiment constructor. The scanBamP
is a ScanBamParam object that has several attributes. One of these is the flag which is a scanBamFlag
that speciﬁes the typical samtools ﬂags used to scan a BAM ﬁle. Among the diﬀerent options oﬀered by
the scanBamFlag constructor, the user can ﬁnd the isUnmappedQuery. This is particularly useful to specify
if the unmapped reads should be considered when the BAM ﬁle is scanned. Thus, if the user’s BAM ﬁle
could have any unmapped reads, we suggest the use of this parameter to ensure that those reads will not
be considered when the TargetExperiment constructor is called. For instance, if it is suspected that the
example BAM ﬁle contains some unmapped reads, the R code to successfully call the TargetExperiment
constructor :

mustWork=TRUE)

> bedFile<-system.file("extdata", "mybed.bed", package="TarSeqQC", mustWork=TRUE)
> fastaFile<-system.file("extdata", "myfasta.fa", package="TarSeqQC",
+
> bamFile<-system.file("extdata", "mybam.bam", package="TarSeqQC", mustWork=TRUE)
> flag<-scanBamFlag(isUnmappedQuery = FALSE)
> scanBamP<-ScanBamParam(flag=flag)
> myPanel<-TargetExperiment(bedFile, bamFile, fastaFile, feature="amplicon",
+
>

attribute="coverage", scanBamP=scanBamP,BPPARAM=BPPARAM)

Remember that all TargetExperiment methods that need read count information at a nucleotide level work
over the Bed File, BAM File and the FASTA File. For this reason, in order to use some of them, please
make sure that the corresponding TargetExperiment slots have the ﬁle names well deﬁned. For example, if
the TarSeqQC example data is loading as follows:

> data(ampliPanel, package="TarSeqQC")
> ampliPanel

TargetExperiment
amplicon panel:

ranges strand |

GRanges object with 3 ranges and 6 metadata columns:
seqnames
<Rle>

gc coverage sdCoverage
<IRanges> <Rle> | <character> <numeric> <numeric> <numeric>
19
90
12

chr1 [ 463, 551]
chr1 [1553, 1603]
chr1 [3766, 3814]

gene1
gene2
gene2

0.674
0.451
0.531

320
550
455

* |
* |
* |

gene

AMPL1
AMPL2
AMPL3

medianCounts IQRCounts
<numeric> <numeric>

37

AMPL1
AMPL2
AMPL3
-------
seqinfo: 4 sequences from an unspecified genome; no seqlengths

326
574
463

24
14
27

gene panel:

GRanges object with 3 ranges and 4 metadata columns:
seqnames
<Rle>

ranges strand | medianCounts IQRCounts coverage sdCoverage
<numeric> <numeric> <numeric> <numeric>
0
67
0

<IRanges> <Rle> |
* |
* |
* |

gene1
gene2
gene3
-------
seqinfo: 4 sequences from an unspecified genome; no seqlengths

chr1 [ 463, 551]
chr1 [1553, 3814]
59]
chr3 [

320
502
0

326
518
0

0
56
0

1,

selected attribute:

coverage

and you want to explore a feature using the plotFeature method, the execution will cause an error because
the method cannot ﬁnd the ﬁles.

plotFeature(ampliPanel, featureID="AMPL1")
[1] "The index of your BAM file doesn
[1] "Building BAM file index"
open: No such file or directory
Error in FUN(X[[i]], ...) : failed to open SAM/BAM file
file:

./mybam.bam

t exist"

’

’

’

To solve the previous error, the next code should be executed before:

> setBamFile(ampliPanel)<-system.file("extdata", "mybam.bam", package="TarSeqQC",
+
> setFastaFile(ampliPanel)<-system.file("extdata", "myfasta.fa",
+

package="TarSeqQC", mustWork=TRUE)

mustWork=TRUE)

and then:

> plotFeature(ampliPanel, featureID="AMPL1")

38

Session Info

> sessionInfo()

R version 3.4.1 (2017-06-30)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[4] LC_COLLATE=C
[7] LC_PAPER=en_US.UTF-8

[10] LC_TELEPHONE=C

LC_NUMERIC=C
LC_MONETARY=en_US.UTF-8
LC_NAME=C
LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_TIME=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_ADDRESS=C

attached base packages:
[1] parallel stats4
[9] base

stats

graphics grDevices utils

datasets methods

other attached packages:

[1] BiocParallel_1.10.1 TarSeqQC_1.6.2
[5] ggplot2_2.2.1
[9] GenomicRanges_1.28.4 GenomeInfoDb_1.12.2 IRanges_2.10.2

openxlsx_4.0.17
Biostrings_2.44.2

Rsamtools_1.28.0

plyr_1.8.4
XVector_0.16.0
S4Vectors_0.14.3

[13] BiocGenerics_0.22.0

loaded via a namespace (and not attached):

[1] Rcpp_0.12.12
[4] bitops_1.0-6
[7] zlibbioc_1.22.0
[10] checkmate_1.8.3
[13] gtable_0.2.0
[16] Matrix_1.2-11
[19] GenomeInfoDbData_0.99.0
[22] cluster_2.0.6
[25] grid_3.4.1
[28] data.table_1.10.4
[31] latticeExtra_0.6-28
[34] magrittr_1.5
[37] htmltools_0.3.6
[40] Hmisc_4.0-3
[43] colorspace_1.3-2
[46] RCurl_1.95-4.8

compiler_3.4.1
base64enc_0.1-3
digest_0.6.12
htmlTable_1.9
lattice_0.20-35
DelayedArray_0.2.7
stringr_1.2.0
htmlwidgets_0.9
nnet_7.3-12
survival_2.41-3
Formula_1.2-2
matrixStats_0.52.2
backports_1.1.0
splines_3.4.1
stringi_1.1.5
lazyeval_0.2.0

RColorBrewer_1.1-2
tools_3.4.1
rpart_4.1-11
tibble_1.3.4
rlang_0.1.2
gridExtra_2.2.1
knitr_1.17
cowplot_0.8.0
Biobase_2.36.2
foreign_0.8-69
reshape2_1.4.2
GenomicAlignments_1.12.2
scales_0.4.1
SummarizedExperiment_1.6.3
acepack_1.4.1
munsell_0.4.3

39

References

Lawrence, M., Huber, W., Pag`es, H., Aboyoun, P., Carlson, M., Gentleman, R., Morgan, M., and Carey, V.

(2013). Software for computing and annotating genomic ranges. PLoS Computational Biology, 9.

Lee, H. C., Lai, K., Lorenc, M. T., Imelfort, M., Duran, C., and Edwards, D. (2012). Bioinformatics tools and
databases for analysis of next-generation sequence data. Brieﬁngs in functional genomics, 11(1):12–24.

Li, H., Handsaker, B., Wysoker, A., Fennell, T., Ruan, J., Homer, N., Marth, G., Abecasis, G., Durbin, R.,

et al. (2009). The sequence alignment/map format and samtools. Bioinformatics, 25(16):2078–2079.

Metzker, M. L. (2010). Sequencing technologiesˆa ˘AˇTthe next generation. Nature Reviews Genetics, 11(1):31–

46.

Morgan, M., Obenchain, V., Lang, M., and Thompson, R. (2015a). BiocParallel: Bioconductor facilities for

parallel evaluation. R package version 1.3.51.

Morgan, M., Pag`es, H., Obenchain, V., and Hayden, N. (2015b). Rsamtools: Binary alignment (BAM),

FASTA, variant call (BCF), and tabix ﬁle import. R package version 1.18.3.

Technologies, L. (2014a). Ion ampliseq cancer panel primer pool.

Technologies, L. (2014b). Ion ampliseq comprehensive cancer panel.

40

