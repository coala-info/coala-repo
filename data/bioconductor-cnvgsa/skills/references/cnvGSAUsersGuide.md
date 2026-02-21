cnvGSA: Gene-Set Analysis of (Rare) Copy Number
Variants

Joseph Lugo, Daniele Merico and Robert Ziman
The Centre for Applied Genomics
joseph.r.lugo@gmail.com, daniele.merico@gmail.com,
robert.ziman@gmail.com

June 7, 2015

Contents

1 Overview

2 Workﬂow outline

2.1 Data import . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Statistical analysis
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Visualizing the results
. . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Exporting to other applications

3 Loading input data

3.1 CNV data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Gene ID ﬁle . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Known Loci and Genes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Phenotype/Covariate Data . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 Gene sets
3.6 Parameters and settings (conﬁgFile) . . . . . . . . . . . . . . . . . . . . . . .
conﬁg.ls conﬁguration . . . . . . . . . . . . . . . . . . . . . . . . . .
3.6.1
params.ls conﬁguration . . . . . . . . . . . . . . . . . . . . . . . . . .
3.6.2
3.6.3 Visualization conﬁguration . . . . . . . . . . . . . . . . . . . . . . . .
3.6.4 Enrichment conﬁguration . . . . . . . . . . . . . . . . . . . . . . . . .
3.6.5 Loading test parameters from a ﬁle . . . . . . . . . . . . . . . . . . .

4 Interpreting the results from the statistical analysis

4.1 Description of res.ls results . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3

3
4
5
6
7

7
7
10
11
12
14
16
16
17
20
21
22

23
23

1

5 Full workﬂow example: case-control analysis of rare CNV from the Pinto

et al. 2014 ASD study
5.1 Loading the data and running the association test . . . . . . . . . . . . . . .
5.2 Reviewing the results . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.1 Association test results . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.2 Detailed analysis of gene-set CNV and genes . . . . . . . . . . . . . .
5.2.3 Visualizations . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.4 Enrichment Map pre-processing . . . . . . . . . . . . . . . . . . . . .

6 References

26
26
27
27
27
28
31

33

2

1 Overview

cnvGSA is an R package for testing the rare gene-set variant burden in case-control studies of
copy number variation (CNV). Earlier versions of cnvGSA, or highly similar burden tests, have
been used in several high proﬁle studies of rare CNV in neuropsychiatric disorders [1][2][3][4].

Only rare CNV (e.g. at frequency <1%) should be present in the input data: burden
tests are not an appropriate method for gene-set analysis of common variants. Gene-sets
need to be pre-compiled based on user-curated data or publicly available gene annotations
like Gene Ontology or pathways.

”Competitive” gene-set over-representation tests are commonly used to analyze diﬀeren-
tially gene expressed genes (e.g. Fisher’s Exact Test, GSEA), but they are not suitable for
rare CNV [1][5]; the most appropriate choice for rare CNV is a ”self-contained” burden test
with global burden correction implemented by cnvGSA or other tools [1].

Global burden correction is very important. For many disorders (including autism and
cases) are enriched in large, recurrent
schizophrenia), the disease-aﬀected subjects (i.e.
CNV [2][3][4][6]. Those CNV are not observed (or observed at very low frequency) in con-
trols and only a minority of their genes may contribute to disease risk. In the absence of
global burden correction, many gene-sets would present a biologically unspeciﬁc burden,
uniquely driven by those larger and recurrent CNV [1]. Global burden correction thus helps
to identify speciﬁc pathways and functional categories implicated in disease risk by rare CNV.

In cnvGSA, subjects are treated as statistical sampling units. Subject-level covariates that
may act as confounders can be provided by the user (e.g. sex, ethnicity, CNV genotyping
platform, CNV genotyping site, array quality metrics, etc.). The gene-set burden is tested
using a logistic regression approach. Two logistic regression models are ﬁt: model A includes
the subject-level covariates and a variable quantifying global CNV burden for each subject
(total CNV length, or total number of CNV-overlapped genes per subject, etc.); model B
includes all variables present in model A, plus the number of CNV-overlapped genes that
are members of the gene-set being tested. Presence of signiﬁcantly higher burden in cases
compared to controls for the gene-set of interest is then tested by comparing the two models
using a deviance chi-square test, as implemented by anova.glm.

In addition, cnvGSA provides functions to visualize gene-set burden results and also to export
them to the Cytoscape plugin Enrichment Map [7].

2 Workﬂow outline

The typical analysis workﬂow consists of:

1. Data import and internal formatting

3

2. Running the statistical analysis
3. Visualizing the results
4. Exporting to other applications

In the next sections there will be an overview of these steps and associated objects. More
detailed documentation can be found in the following sections.

2.1 Data import

Data are typically imported from text ﬁles into the object CnvGSAInput. Of course directly
constructing the objects, or loading them from a R workspace is also possible. The following
is a brief description of all the text ﬁles that are required.

• cnvFile - This ﬁle contains all the CNV. Each row contains data for one CNV.
• geneIDFile - This ﬁle contains primary and secondary geneIDs (e.g. Entrez-gene ID,

oﬃcial symbols).

• klLociFile - This ﬁle contains all the loci with CNV known to be contributing to

disease risk. Used for ﬁltering the data-set before the statistical analysis.

• klGeneFile - This ﬁle contains genes with CNV known to be contributing to disease

risk.

• phFile - This ﬁle contains the subject information including covariates. Each row

contains data for one subject.

• gsFile - This ﬁle contains a list containing all the gene-sets and their corresponding

genes.

• configFile - This ﬁle contains all parameters for the pre-processing and statistical

analysis.

The cnvGSAIn function provides a convenient wrapper to import data from text ﬁles. A
conﬁgFile is ﬁrst loaded; the conﬁgFile contains paths to the other ﬁles; these paths are
read by cnvGSAIn, the corresponding ﬁles are loaded, tested for consistency, and internal
formatting is performed. Here is an example of the usage of cnvGSAIn where cnvGSA.in is
and object of class CnvGSAInput. A more detailed example can be found in section 5.1.

Note: cnvGSA.in is expecting to ﬁnd all the required ﬁles with their full paths in the
conﬁgFile.

> configFile <- "INPUT PATH TO UPDATED configFile"
> cnvGSA.in
> cnvGSA.in

<- CnvGSAInput()
<- cnvGSAIn(configFile,cnvGSA.in)

CnvGSAInput is a S4 class acting as a container data structure with slots for each of these
required inputs:

4

> library("cnvGSA")
> library("cnvGSAdata")
> slotNames("CnvGSAInput")
[1] "cnvData.ls" "phData.ls" "gsData.ls" "config.ls" "params.ls" "geneID.ls"

The input slots should hold the following:

• cnvData.ls - CNV data
• phData.ls - Phenotype/Covariate data
• gsData.ls - Gene-set data
• config.ls - paths and ﬁle names
• params.ls - Test parameters
• geneID.ls - Gene ID data

An example input object is available in the companion data package for this vignette:

> library("cnvGSA")
> library("cnvGSAdata")
> data("cnvGSA_input_example")
> ls()

[1] "cnvGSA.in"

> class(cnvGSA.in)

[1] "CnvGSAInput"
attr(,"package")
[1] "cnvGSA"

> slotNames(cnvGSA.in)
[1] "config.ls"

"params.ls" "cnvData.ls" "phData.ls" "gsData.ls" "geneID.ls"

Each of the slots can be accessed using an accessor function with the same name (e.g.
cnvData.ls(cnvGSA.in) gets cnvData.ls, gsData.ls(cnvGSA.in) gets gsData.ls, etc.).

2.2 Statistical analysis

The input object is used by cnvGSA’s main function, cnvGSAlogRegTest, to perform the
case-control gene-set burden test and populate the CnvGSAOutput object. A full example is
shown in section 5:

> cnvGSA.out <- CnvGSAOutput()
> cnvGSAlogRegTest(cnvGSA.in,cnvGSA.out)

5

There are many parameters that are mentioned in section 3.6, here are the few that are
essential to the statistical analysis:

• covariates - The covariates the user would like to include in the regression model.
This will be a string listing all the desired covariates with commas in between (ex.
SEX,CNV platform). The user can choose to not include covariates by putting NONE.
• corrections -The correction models that the user would like to include in the test.
Each correction model will provide diﬀerent results and comparisons can be made to
see the diﬀerence between all the corrections. More than one correction can be included
in the analysis. The corrections included in cnvGSA are no corr, uni gc, tot l, and
cnvn ml which are all explained in 3.6.2.

• KL - Whether or not the user would like to include subjects with CNV overlapping
known loci and genes in the statistical analysis. If the user chooses ALL, the test will
be run twice: once including the subjects with CNV overlapping known loci, and once
without them.

• cnvType - The type of CNV that the user would like to use for testing.

Note: larger gene-sets have more statistical power; this can be taken into account by sepa-
rately testing gene-sets with diﬀerent sizes.

2.3 Visualizing the results

cnvGSAlogRegTest produces an object of class CnvGSAOutput as its output – likewise a
simple S4 class that has slots for each of the output elements.

> library(cnvGSA)
> library(cnvGSAdata)
> data("cnvGSA_output_example")
> ls()

[1] "cnvGSA.in" "cnvGSA.out"

> class(cnvGSA.out)

[1] "CnvGSAOutput"
attr(,"package")
[1] "cnvGSA"

> slotNames(cnvGSA.out)
[1] "res.ls"

"gsTables.ls" "gsData.ls"

"phData.ls"

The output slots contain the following:

6

• res.ls - List with the results from the statistical test; depending on the parameters
in the conﬁgFile, this may hold either one data frame, or two data frames, with results
including all subjects and/or only subjects without CNV overlapping known loci.
• gsTables.ls - Detailed information about the CNV (and their gene annotations) in

each tested gene-set.

• gsData.ls - Gene-set data, identical to gsData.ls in CnvGSAInput , except it does

not include gene-set that were ﬁltered based on the parameters in the conﬁgFile.

• phData.ls - Phenotype/covariate data, identical to phData.ls in CnvGSAInput, except
it does not include subjects that were ﬁltered based on the parameters in the conﬁgFile.

As with the slots in the input object, each of these can likewise be accessed using an accessor
function of the same name (gsTables.ls() gets gsTables.ls, etc.).

Once the main function (cnvGSAlogRegTest) is run, the object res.ls will contain all of
the results from logistic regression tests (deviance p-values & regression coeﬃcients) along
with other useful summary statistics. For a more detailed explanation, see section 4.

2.4 Exporting to other applications

Using the results in CnvGSAOutput, you can format and export the output to other appli-
cations using functions in the cnvGSA package. One application that can be used to aid
in the interpretation of the results is the Enrichment Map plugin in Cytoscape. This is
used to create network maps and observe clusters of gene-sets. See section 5.2.4 for more
information.

3 Loading input data

This section describes the components of the object CnvGSAInput in more detail and the
text ﬁles from which they can be imported. As previously described, the components of
the CnvGSAInput object – i.e. cnvData.ls, phData.ls, gsData.ls, config.ls, params.ls,
and geneID.ls – can be easily ﬁlled using the function cnvGSAIn:

# Create input object
> cnvGSA.in <- CnvGSAInput()
> cnvGSA.in <- cnvGSAIn(configFile,cnvGSA.in)

3.1 CNV data

The input CNV data for cnvGSAIn relies on providing data with the correct structure and
following the speciﬁcations described in this section. The text ﬁle for the CNV data should
have the following columns and should be named accordingly; SID, Chr, BP1, BP2, TYPE, and
geneID. All text ﬁles that are input should be tab separated. Order does not matter as long

7

as all the columns are named appropriately. The code generates a data frame in which the
columns are named after the columns in the text ﬁle.

The following is an example of what the CNV data frame will look like. Here are the
columns of the data frame in more detail:

• $cnv.df - A data frame containing the CNV. Each row contains data for one CNV:

◦ SID - ID assigned to the subject in which the CNV was found. It is assumed that

the correspondence for each is always 1-to-1 with a subject.

◦ Chr - Chromosome on which the CNV is located.
◦ BP1 - Start position of the CNV on the chromosome. Genome coordinates should

be 1-based.

◦ BP2 - End position of the CNV on the chromosome. Genome coordinates should

be 1-based.

◦ TYPE - CNV type ("1" or "3" used in example, but can be any other label indi-

cating deletions and gains).

◦ geneID - Genes overlapped by the CNV, stored in a delimited format inside a
character string; e.g. "54777;255352;84435" for semicolon-delimited Entrez-
Gene identiﬁers (recommended gene ID system). The gene ID system needs to
match the Gene ID object and corresponding ﬁle. CNV that are not genic should
have an empty string (i.e. "") in this column. The user can specify the value
separator in $params.ls(3.6.2).

For demonstration purposes, the following code will bypass the automated loader and only
load the single ﬁle. This will also be done for the other required ﬁles.

> cnvFile <- system.file("extdata","cnv_AGP_demo.txt",package = "cnvGSAdata")
> cnv.df <- read.table (cnvFile, header = T, sep = "\t", quote = "\"",
+ stringsAsFactors = F)
> str(cnv.df,strict.width="cut")
’data.frame’: 10666 obs. of

6 variables:

: chr "1020_4" "1020_4" "1020_4" "1030_3" ...
: chr "4" "6" "3" "10" ...
: int 34802932 35606076 4110452 56265896 64316996 24115481 83206919..
: int 35676439 35673400 4145874 56361311 64593616 24202712 83239473..

$ SID
$ CHR
$ BP1
$ BP2
$ TYPE : int 3 3 1 1 1 3 1 3 3 3 ...
$ geneID: chr NA "2289" NA NA ...

After running cnvGSAIn, existing components of $cnvData.ls are updated and some new
components are created:

• $cnv.df - Existing data frame containing the CNV. The following columns are added:

◦ CnvKey - Made from combining CHR, BP1, BP2, TYPE with @ as separator.

8

◦ OlpKL CNV - Marks what CNV overlap known loci or genes (see section 3.3), using
the package GenomicRanges to ﬁnd the overlaps. For overlap with known loci, it
will only mark those CNV that have overlap above the threshold named $klOlp,
which is described in more detail in section 3.6.2.

◦ OlpKL SID - Using the information from $OlpKL CNV, marks the subjects that

have at least one CNV overlapping a known locus or gene.

◦ SubjCnvKey - Unique identiﬁer of a subject’s CNV made from combining $SID

and $Cnvkey using @@ as the separator.

◦ CnvLength ALL - Total CNV length for all CNV types for each $SID.
◦ CnvLength TYPE - Total CNV length for the user-speciﬁed CNV type for each

$SID.

◦ CnvCount TYPE - CNV count for the user-speciﬁed CNV type for each $SID.

• $cnv2gene.df - A data frame mapping the CNV to the corresponding genes.

:’data.frame’: 10666 obs. of 15 variables:

# cnvData.ls after running cnvGSAIn
> str(cnvData.ls(cnvGSA.in),strict.width="cut")
List of 2
$ cnv.df
..$ SID
..$ CHR
..$ BP1
..$ BP2
..$ TYPE
..$ geneID
..$ CnvKey
..$ SEX
..$ Condition
..$ OlpKL_CNV
..$ OlpKL_SID
..$ SubjCnvKey
..$ CnvLength_ALL : num [1:10666] 873508 67325 35423 95416 276621 ...
..$ CnvLength_TYPE: num [1:10666] 0 0 35423 95416 276621 ...
..$ CnvCount_TYPE : num [1:10666] 0 0 1 1 1 0 1 0 0 0 ...

: chr [1:10666] "1020_4" "1020_4" "1020_4" "1030_3" ...
: chr [1:10666] "4" "6" "3" "10" ...
: int [1:10666] 34802932 35606076 4110452 56265896 6431699..
: int [1:10666] 35676439 35673400 4145874 56361311 64593616..
: int [1:10666] 3 3 1 1 1 3 1 3 3 3 ...
: chr [1:10666] NA "2289" NA NA ...
: chr [1:10666] "4@34802932@35676439@3" "6@35606076@35673400@3"..
: chr [1:10666] "Male" "Male" "Male" "Male" ...
: int [1:10666] 1 1 1 1 1 1 1 1 1 1 ...
: num [1:10666] 0 0 0 0 0 0 0 0 0 0 ...
: num [1:10666] 0 0 0 0 0 0 0 0 0 0 ...
: chr [1:10666] "1020_4@@4@34802932@35676439@3" "1020_4@@6@356..

$ cnv2gene.df:data.frame: 22322 obs. of 9 variables:

..$ SubjCnvKey : Factor w/ 10666 levels "1020_4@@3@4110452@4145874@1",..: 1 2 3 4 5 5
..$ geneID
..$ SEX
..$ CHR
..$ BP1
..$ BP2
..$ SID
..$ TYPE
..$ geneID_TYPE: chr [1:22322] NA NA NA NA ...

: chr [1:22322] NA NA "2289" NA ...
: chr [1:22322] "Male" "Male" "Male" "Male" ...
: chr [1:22322] "3" "4" "6" "10" ...
: int [1:22322] 4110452 34802932 35606076 56265896 64316996 ...
: int [1:22322] 4145874 35676439 35673400 56361311 64593616 ...
: chr [1:22322] "1020_4" "1020_4" "1020_4" "1030_3" ...
: int [1:22322] 1331113333...

9

3.2 Gene ID ﬁle

One convenient feature of this package is that the user can use any gene ID system. The
user just has to provide a gene ID ﬁle that will specify primary identiﬁers (e.g. EntrezGene
IDs) and secondary identiﬁers (e.g. oﬃcial symbols); the secondary identiﬁers are just used
as human-readable labels in the output ﬁles, but all data-matching operations rely on the
primary identiﬁers.

• $ann eg.df - A data frame with primary and secondary gene identiﬁers:

◦ geneID - The gene identiﬁer for the user speciﬁed system.
◦ Symbol - Symbol for the gene.
◦ Name - Full gene name.

Here is an example of how to make the gene ID ﬁle with the Entrez ID system for humans
and how to save the data as a tab delimited text ﬁle:

> library (org.Hs.eg.db)

> ann_eg2sy.df
> names (ann_eg2sy.df)
> ann_eg2sy.df
+ stringsAsFactors = F)

<- stack (as.list (org.Hs.egSYMBOL));

<- c ("Symbol", "geneID");

<- as.data.frame (lapply (ann_eg2sy.df,

as.character),

> ann_eg2name.df <- stack (as.list (org.Hs.egGENENAME));
> names (ann_eg2name.df) <- c ("Name",
> ann_eg2name.df <- as.data.frame (lapply (ann_eg2name.df, as.character),
+ stringsAsFactors = F)

"geneID");

> ann_eg.df <- merge (ann_eg2sy.df, ann_eg2name.df, by = "geneID", all = T)

> str(ann_eg.df,strict.width="cut")
’data.frame’: 47721 obs. of

3 variables:
$ geneID: chr "1" "10" "100" "1000" ...
$ Symbol: chr "A1BG" "NAT2" "ADA" "CDH2" ...
$ Name : chr "alpha-1-B glycoprotein" "N-acetyltransf"..

## Create text file and place path in configFile
> write.table (ann_eg.df, col.names=T, row.names=F, quote=F, sep="\t",
+ file = "geneID_demo.txt")

## There is also a pre-made object found in the data package
> geneIDFile <- system.file( "extdata", "gene_ID_demo.txt", package="cnvGSAdata" )

10

3.3 Known Loci and Genes

This object provides a list of CNV loci in the genome that have a known implication in
disease risk, and a list of genes for which CNV has a known implication in disease risk. This
object is used to mark CNV and subjects, so that subjects with at least one CNV marked
can be removed from the analysis, based on the parameter settings (see $KL in section 3.6.2);
CNV are marked when they have a matching type and at least one gene in the known genes
set, and/or when they have a matching type and a minimum overlap with a locus in the
known loci set. Removing marked subjects from the analysis is useful to evalute the ”strictly
novel” burden signal. This object can be alternatively used as a general purpose mask for
genomic loci and genes.

Two text ﬁles are required to mark CNV overlapping known loci and known genes. The text
ﬁles should both be tab separated. One ﬁle describes all the loci known to have CNV im-
plicated in disease risk and it should have the following columns and be named accordingly;
CHR, BP1, BP2, TYPE. The second ﬁle contains the genes that are known to be implicated
in disease risk. This ﬁle should include the following columns and be named accordingly;
geneID, TYPE. Both of these text ﬁles will be used to generate data frames with the same
columns.

Here is a more detailed explanation of the columns for both of the data frames that will be
created:

• $kl loci.df - Data frame that contains all the loci with CNV known to be implicated

in disease risk. It should include the following columns:

◦ CHR - Chromosome on which the CNV is located.
◦ BP1 - Start position of the CNV on the chromosome. Genome coordinates should

be 1-based.

◦ BP2 - End position of the CNV on the chromosome. Genome coordinates should

be 1-based.

◦ TYPE - CNV type (example data uses ”1” to represent deletions and ”0” to rep-
resent gains, but be any other label indicating deletions and gains can be used).

> klLociFile <- system.file("extdata","kl_loci_AGP_demo.txt",package = "cnvGSAdata")
> kl_loci.df <- read.table (klLociFile, sep = "", header = T, comment.char = "",
+ quote = "\"", stringsAsFactors = F)
> str(kl_loci.df,strict.width="cut")
’data.frame’: 56 obs. of

4 variables:

$ CHR
$ BP1
$ BP2
$ TYPE : int 1 1 3 1 1 1 1 3 1 3 ...

: chr "2" "2" "15" "9" ...
: int 50539877 51002576 21190624 98998 50990306 50968208 28705540..
: int 50730546 51157742 26203954 3682923 51222043 51214171 30436163..

11

• $kl gene.df - Data frame that contains the genes known to be implicated in disease

risk:

◦ geneID - The gene IDs for the genes known to be implicated in disease risk.
◦ TYPE - CNV type (example data uses ”1” to represent deletions and ”0” to rep-
resent gains, but be any other label indicating deletions and gains can be used).

> klGeneFile <- system.file("extdata","kl_gene_AGP_demo.txt",package = "cnvGSAdata")
> kl_gene.df <- read.table (klGeneFile, sep = "", header = T, comment.char = "",
+ quote = "\"", stringsAsFactors = F)
> str(kl_gene.df,strict.width="cut")
’data.frame’: 1 obs. of

2 variables:

$ geneID: int 9378
$ TYPE : int 1

3.4 Phenotype/Covariate Data

After the CNV data has been loaded the next data structure that needs to be loaded is
phData, which contains the phenotype/covariate data. Just like the CNV data there is an
example of this type of ﬁle in the package cnvGSAdata.

The text ﬁle for the phenotype/covariate data should include the following columns and
be named accordingly; SID, Covariates, and Condition. The Covariates will depend on
what the user includes in the input data. These column names can be whatever is in the
data as long as the user speciﬁes them in the conﬁgFile. The covariate found in the example
data cnvGSA.in is ”SEX” which describes the biological sex of the subject. This should be
a tab separated ﬁle and will be used to generate a data frame with the same columns.

Here is a look at the data frame that will be generated as well as a more detailed explanation
of the columns that will be included:

• $ph.df - A data frame containing the subject information including covariates. Each

row contains data for one subject:

◦ SID - ID assigned to the subject in which the CNV was found. It is assumed that

the correspondence for each is always 1-to-1 with a subject.

◦ Covariates - The covariates that will be included in the analysis. A set of

columns, of type character, numeric, integer or factor.

◦ Condition - Identiﬁes the sample as a case(1) or control(0).

> phFile <- system.file("extdata","ph_AGP_demo.txt",package = "cnvGSAdata")
> ph.df <- read.table (phFile, header = T, sep = "\t", quote = "\"",
+ stringsAsFactors = F)
> str(ph.df)

12

’data.frame’: 10666 obs. of

3 variables:
: chr "1020_4" "1020_4" "1020_4" "1030_3" ...
: chr "Male" "Male" "Male" "Male" ...

$ SID
$ SEX
$ Condition: int 1 1 1 1 1 1 1 1 1 1 ...

After running cnvGSAIn, existing components of $ph.df are updated and some new compo-
nents are created:

• $ph.df - Existing data frame containing the subject information including covariates.

Additional covariates are generated at corresponding columns:

◦ OlpKL SID - Marks the subjects that have at least one CNV overlapping a known

locus or gene..

◦ CnvCount TYPE - Count for the number of CNV of the user speciﬁed type that

has occurred for each $SID.

◦ CnvTotLength TYPE - Total length of all the CNV of the user speciﬁed type that

occurred for each $SID.

◦ CnvMeanLength TYPE - Mean length of all the CNV of the user speciﬁed type that

occurred for each $SID.

• $ph TYPE.df - A data frame with the same columns as $ph.df plus columns corre-
sponding to gene-set gene counts (each of these columns will show how many genes
from the gene-set are overlapped by a CNV of the user-selected type).

> str(cnvGSA.in@phData.ls,max.level=2,list.len=10)
List of 2

$ ph.df:’data.frame’: 4227 obs. of 7 variables:

..$ SID
..$ SEX
..$ Condition
..$ OlpKL_SID
..$ CnvCount_TYPE
..$ CnvTotLength_TYPE : num [1:4227] 35423 372037 32555 41098 0 ...
..$ CnvMeanLength_TYPE: num [1:4227] 11808 186018 10852 6850 0 ...

: chr [1:4227] "1020_4" "1030_3" "1045_3" "1050_3" ...
: chr [1:4227] "Male" "Male" "Male" "Female" ...
: int [1:4227] 1 1 1 1 0 0 0 0 0 0 ...
: num [1:4227] 0 0 0 0 0 0 0 0 0 0 ...
: num [1:4227] 1 2 1 1 0 0 2 1 3 0 ...

$ ph_TYPE.df:’data.frame’: 4227 obs. of 59 variables:

: chr [1:4227] "1020_4" "1030_3" "1045_3" "1050_3" ...
: chr [1:4227] "Male" "Male" "Male" "Female" ...
: int [1:4227] 1 1 1 1 0 0 0 0 0 0 ...
: num [1:4227] 0 0 0 0 0 0 0 0 0 0 ...
: num [1:4227] 1 2 1 1 0 0 2 1 3 0 ...

..$ SID
..$ SEX
..$ Condition
..$ OlpKL_SID
..$ CnvCount_TYPE
..$ CnvTotLength_TYPE : num [1:4227] 35423 372037 32555 41098 0 ...
..$ CnvMeanLength_TYPE: num [1:4227] 11808 186018 10852 6850 0 ...
..$ GS1
..$ GS10
..$ GS11
.. [list output truncated]

: int [1:4227] 0 1 0 1 0 0 1 0 1 0 ...
: int [1:4227] 0 1 0 0 0 0 1 0 1 0 ...
: int [1:4227] 0 0 0 1 0 0 0 0 2 0 ...

13

3.5 Gene sets

The gene-set data should be one list containing all the gene sets that the user wants to
include in the analysis. This list should have gene-set names, which will act as the $GsIDs
for the later tables and will be the IDs for a certain gene set.

Instead of using a text ﬁle to read in the data, it is recommended to save the data as
an .RData ﬁle. This is because the gene-sets will not be equal in length and cannot be read
as a normal data frame. The object containing the gene-sets must be called gs all.ls and
will be a list with each entry being the gene-set named and a vector or the corresponding
genes in the gene-set. There should also be a separate object that will contain the gene set
names. This object must be named gsid2name.chv and will be a vector simply containing
all the gene-set names.

To create these ﬁles it is common to read a Gene Matrix Transposed ﬁle format (GMT
ﬁle). The GMT ﬁle format is a tab delimited ﬁle format that describes gene-sets. In the
GMT format, each row represents a gene-set. Here the user can see how to create the gene-set
objects using a GMT ﬁle:

<- read.table(filename, sep = "@", comment.char = "", quote = "",

<- gsub("%KEGG%", "\tKEGG:", tmp$V1)
<- gsub("Reactome Pathway", "REACT:", tmp$V1)
<- gsub("http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_

> tmp
+ stringsAsFactors = F)
> tmp$V1
> tmp$V1
> tmp$V1
+ |BIOCARTA_", "BIOC:", tmp$V1)
<- lapply(1:nrow(tmp), function(x) unlist(strsplit(tmp[x,], "\t")))
> tmp
<- unlist(lapply(1:length(tmp), function(x) tmp[[x]][1]))
> names.v
<- unlist(lapply(1:length(tmp), function(x) tmp[[x]][2]))
> IDs
<- lapply(1:length(tmp), function(x) tmp[[x]][-c(1,2)])
> genes.ls
<- lapply(genes.ls, setdiff, NA)
> genes.ls
<- lapply(genes.ls, unique)
> genes.ls
> gs_demo.ls
<- list()
> gs_demo.ls$gsid2name.chv <- names.v
> gs_demo.ls$gs_all.ls
> names(gs_demo.ls$gsid2name.chv) <- IDs
<- IDs
> names(gs_demo.ls$gs_all.ls)
> gsid2name.chv <- gs_demo.ls$gsid2name.chv
> gs_all.ls

<- gs_demo.ls$gs_all.ls

<- genes.ls

Here is an example of pre-compiled gene-set lists found in the data package:

> library(cnvGSAdata)
> data("gs_data_example") # gs_all.ls and gsid2name.chv will be loaded

14

> str(gs_all.ls,max.level=1,list.len=5)
List of 51

$ BspanVHM_PreNat
$ BspanVHM_EqlNat
$ BspanVHM_PstNat
$ BspanVH_lg2rpkm4.74
$ BspanHM_lg2rpkm3.21

[list output truncated]

> str(gsid2name.chv)

: int [1:3038] 7105 4800 81887 6405 1595 3927 ...
: int [1:3038] 8813 54467 9957 23072 8379 56603 ...
: int [1:3131] 2519 2729 90529 57185 22875 572 ...
: int [1:4600] 7105 4800 57185 1595 572 9957 3927 ...
: int [1:4605] 8813 2519 2729 90529 81887 22875 ...

Named chr [1:51] "BspanVHM_PreNat" "BspanVHM_EqlNat" "BspanVHM_PstNat" ...
- attr(*, "names")= chr [1:51] "BspanVHM_PreNat" "BspanVHM_EqlNat" ...

## Location of the pre-compiled gene-set file
> gsFile <- system.file( "data", "gs_data_example.RData", package="cnvGSAdata" )

After cnvGSAIn is run the gsData.ls slot will have components added to it. To see an
example of gsData.ls, load the CnvGSAInput object included in the data package. The list
elements are:

• $gs info.df - A data frame with the columns $GsKey, $GsID ,$GsName, $GsSize;
$GsID is the primary gene-set identiﬁer outside cnvGSA, while $GsKey is the primary
gene-set identiﬁer inside cnvGSA.

• $gs sel U.df - A data frame with the columns $GsKey, $geneID, $GsName mapping
each gene-set $GsKey with the corresponding $geneID. It splits all the genes apart so
that there is a one to one relationship. This data frame is derived from $gs all.ls.

• $gs colnames TYPE.chv - A single character vector that contains all the $GsKey of the

gene-set selected by the user for the statistical test.

• $geneCount.tab - A table object, with gene counts for subjects with diﬀerent $Condition

(e.g. cases and controls).

• $gs all.ls - A list containing all the gene-sets and their corresponding genes. The
names for this list are the $GsIDs. This list is identical to the list found in the gene-set
data the user inputs.

> library(cnvGSAdata)
> data("cnvGSA_input_example")
> str(cnvGSA.in@gsData.ls,strict.width="cut",list.len = 10)
List of 5

$ gs_info.df

:’data.frame’: 52 obs. of 4 variables:

..$ GsKey : chr [1:52] "GS1" "GS2" "GS3" "GS4" ...
: chr [1:52] "BspanVHM_PreNat" "BspanVHM_EqlNat" "BspanVHM_PstNat" ..
..$ GsID
..$ GsName: chr [1:52] "BspanVHM_PreNat" "BspanVHM_EqlNat" "BspanVHM_PstNat" ..

15

..$ GsSize: int [1:52] 3037 3037 3131 4600 4605 4596 4601 4131 4185 4190 ...

$ gs_sel_U.df

:’data.frame’: 120486 obs. of 4 variables:

..$ GsKey : Factor w/ 52 levels "GS1","GS10","GS11",..: 1 1 1 1 1 1 1 1 1 1 ...
..$ geneID
..$ GsID
: chr [1:120486] "BspanVHM_PreNat" "BspanVHM_PreNat" "BspanVHM_PreNat" ..
..$ GsName: chr [1:120486] "BspanVHM_PreNat" "BspanVHM_PreNat" "BspanVHM_PreNat" ..

: chr [1:120486] "7105" "4800" "81887" "6405" ...

$ gs_colnames_TYPE.chv: chr [1:51] "GS1" "GS10" "GS11" "GS12" ...
$ geneCount.tab

: ’table’ int [1:6203, 1:2] 1 1 0 0 0 0 0 0 0 0 ...

..- attr(*, "dimnames")=List of 2
.. ..$ geneID
.. ..$ Condition: chr [1:2] "0" "1"

: chr [1:6203] "1" "10" "10003" "100033413" ...

$ gs_all.ls

:List of 51

..$ BspanVHM_PreNat
..$ BspanVHM_EqlNat
..$ BspanVHM_PstNat
..$ BspanVH_lg2rpkm4.74
..$ BspanHM_lg2rpkm3.21
..$ BspanML_lg2rpkm0.93
..$ BspanLA_lg2rpkm.MIN
..$ GI_q4
..$ GI_q3
..$ GI_q2
.. [list output truncated]

: int [1:3038] 7105 4800 81887 6405 1595 3927 ...
: int [1:3038] 8813 54467 9957 23072 8379 56603 ...
: int [1:3131] 2519 2729 90529 57185 22875 ...
: int [1:4600] 7105 4800 57185 1595 572 9957 ...
: int [1:4605] 8813 2519 2729 90529 81887 ...
: int [1:4596] 57147 55732 2268 3075 889 5893 ...
: int [1:4601] 64102 1080 26 51384 6542 ...
: chr [1:4131] "1" "8086" "65985" "343066" ...
: chr [1:4185] "29974" "53947" "13" "344752" ...
: chr [1:4190] "2" "195827" "79719" "14" ...

3.6 Parameters and settings (conﬁgFile)

Running the association tests requires that the user provide a conﬁgFile to control how the
tests will be run. The script will go through the conﬁgFile that the user inputs and use he
parameters to specify how diﬀerent functions in the package will run. There are four blocks
in the conﬁgFile that serve diﬀerent purposes. The following section will go through each
block and explain how to ﬁll in each value.

3.6.1

conﬁg.ls conﬁguration

The config.ls() accessor function can be used to access the data in the slot. The main
association test procedure accepts several ﬁles and this list will contain all the paths to the
necessary input data.

The ﬁelds for config.ls are as follows:

• cnvFile - File name for the CNV ﬁle user would like to read in.

• phFile - File name for the phenotype/covariate ﬁle user would like to read in.

16

• geneIDFile - File name for the ﬁle describing the ID system used for the data.

• klGeneFile - File name for the ﬁle containing the genes with CNV known to be

implicated in disease risk.

• klLociFile - File name for the ﬁle with containing the loci with CNV known to be

implicated in disease risk.

• gsFile - File name for the gene-set data the user would like to read in.

• outputPath - Path for the folder where the user would like to output all the results.

• geneListFile - Path for the ﬁle containing the list of genes that the user would like
to restrict the statistical burden analysis to. All genes are used if this is not provided.

> str( config.ls(cnvGSA.in) )
List of 9

$ cnvFile

: chr "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/

$ phFile

: chr "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/

cnv_AGP_demo.txt"

ph_AGP_demo.txt"

$ geneIDFile

: chr "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/

geneID_demo.txt"

$ klGeneFile

: chr "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/

kl_gene_AGP_demo.txt"

$ klLociFile

: chr "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/

kl_loci_AGP_demo.txt"

$ gsFile

: chr "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/

gs_data_demo.RData"

$ outputPath

: chr "/Users/josephlugo/Documents/R/PGC2_test/Restructure_

Results/8.5/testResults/"

$ geneListFile: chr ""
$ config.df

:’data.frame’: 37 obs. of 2 variables:

..$ param: chr [1:37] "cnvFile" "phFile" "geneIDFile" "klGeneFile" ...
..$ value: chr [1:37] "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/ ...

3.6.2 params.ls conﬁguration

The params.ls() accessor function can be used to access the data in the slot. The main
association test procedure accepts several parameters which will specify how the user would
like to run the logistic regression tests.

The ﬁelds for params.ls are as follows:

17

• Kl - Whether or not the user would like to include subjects marked for known loci and
genes in the statistical analysis. If the user chooses ALL, the test will be run twice: once
including the subjects marked for known loci, and once without them. The default
value for this parameter is ALL. Possible values are:

◦ YES - Include subjects marked as having CNV overlapping known loci or known

genes

◦ NO - Do not include subjects marked as having CNV overlapping known loci or

known genes

◦ ALL - Produce results from both YES and NO. Will create two separate data frames.

• projectName - Suﬃx used in the output ﬁle names.

• gsUset - Gene-set representing the universe-set for the corresponding global burden
correction. If not provided, all genes mapped at least once to a CNV are used to deﬁne
this set.

• cnvType - The type of CNV that the user would like to use for testing. Possible values

are:

◦ Any value in the $TYPE column which may include (”1”, ”0”, ”LOSS”, ”GAIN”,
etc.). The user may have multiple levels for $TYPE but they should only choose
one for the analysis.

◦ ALL - Includes all types of CNV in the data.

• covariates - The covariates the user would like to include in the regression model.
This will be a character vector listing all the desired covariates with commas in between
(ex. ”SEX,CNV platform”). The user can choose not to include covariates by putting
NONE.

• klOlp - The minimum percentage overlap between an observed CNV and the interval

corresponding to a known locus.

• corrections - The correction models that the user would like to include in the logistic
regression tests. Each correction model will provide diﬀerent results and comparisons
can be made to see the diﬀerence between all the diﬀerent corrections. More than one
correction can be included in the analysis. Enter as a list of corrections with commas
in between (ex. ”no corr,uni gc”). The default value for this is to use all the correction
models. Possible values are:

◦ no corr - Do not include any correction in the analysis.
◦ uni gc - Add the universe gene count correction model.
◦ tot l - Add the CNV total length correction model.
◦ cnvn ml - Add the mean CNV length and CNV count correction model.
◦ ALL - Include all the correction models.

18

• geneSep - The separator that will be used to separate the gene identiﬁers in the

$geneID column of the cnv.df object. The default value for this is ”;”.

• geneSetSizeMax - The maximum number of genes that the gene sets are allowed to

have. The default value for this is 1500.

• geneSetSizeMin - The minimum number of genes that the gene sets are allowed to

have. The default value for this is 25.

• filtGs - Once the $geneSetSizeMax and $geneSetSizeMax parameter’s have been set
the user can choose whether or not to include this ﬁlter in the analysis. The default
value for this is NO. Possible values are:

◦ YES - Include the ﬁlter in the analysis.
◦ NO - Do not include the ﬁlter in the analysis.

• covInterest - What covariate will be used to report stratiﬁed case and control subject

counts.

• eventThreshold - When reporting subject counts split by covariate value and condi-
tion, what is the minimum number of genes of the gene-set that need to be overlapped
by a type-matched CNV for the subject to be counted. The default value for this is 1.

• flevels - The maximum number of levels the factor $covInterest is allowed to have.

The default value for this is 10.

• cores - User will set the number of cores they want to use for the parallelization. The

default value for this is the maximum number of cores on the machine.

• parallel - Option to run the association test in parallel or not. The default value is

YES. The options include:

◦ YES - Allow parallelization in the logistic regression tests.
◦ NO - Do not allow parallelization in logistic regression tests.

• CNVevents - The minimum number of overlapped genes that a gene-set needs to be
included in the analysis. Checks for gene-sets that have at least this many (user
speciﬁed) overlapped genes.

NOTE: Parallelization is known to have issues on Windows machines. If there are errors, the
user must run the logistic regression tests sequentially (i.e choose NO for parallel parame-
ter).

> str( params.ls(cnvGSA.in) )
List of 17

$ Kl
$ projectName

: chr "ALL"
: chr "NS"

19

: chr ""
: chr "1"
: chr "SEX"
: num 0.5
: chr [1:4] "no_corr" "uni_gc" "tot_l" "cnvn_ml"
: chr ";"

$ gsUSet
$ cnvType
$ covariates
$ klOlp
$ corrections
$ geneSep
$ geneSetSizeMin: num 25
$ geneSetSizeMax: num 1500
: chr "NO"
$ filtGs
$ covInterest
: chr "SEX"
$ eventThreshold: num 1
$ fLevels
$ cores
$ parallel
$ CNVevents

: num 10
: num 4
: chr "YES"
: chr "5"

3.6.3 Visualization conﬁguration

This package includes the ability to create visualizations from the output of the main as-
sociation test. It is recommended to use this functionality for a small number of selected
gene-sets (i.e. 5-20). The function f.makeViz is described in the workﬂow example and it
takes in these ﬁelds:

• FDRThreshold - Will only include those gene-sets that have a FDR below this threshold

• plotHeight - Sets the bottom margin of the plot by using the mar option in the par
function included in R. This is useful to ensure that the gene-set names ﬁt in the plot.
The default value is 13.

• gsList - Text ﬁle containing list of gene-sets that the user is interested in looking at

plotting. Should be comma separated with no space in between (ex. ”PSD BayesGrant fullset,
FMR1 Targets Darnell”).

• outputPathViz - Path for the output of the visualization script.

• labelSize - How long the user would like the labels to be on the plots. This is the
expansion factor for the axis names that uses the cex function in R. The default value
is 0.7.

• correctionViz - Corrections used in creating the plots. Multiple corrections may be
selected and additional plots will be created accordingly. The default value for this is
ALL. The valid options include:

◦ no corr - Do not include any correction model.
◦ uni gc - Add the universe count correction model.

20

◦ tot l - Add the total count correction model.
◦ cnvn ml - Add the mean length and number correction model.
◦ ALL - Include all the correction models.

• cnvGSAViz also takes in some ﬁelds that are deﬁned in params.ls. It is not necessary

to restate the following ﬁelds:

◦ Kl - Look at description in previous section 3.6.2.
◦ cnvType - Look at description in previous section 3.6.2.

3.6.4 Enrichment conﬁguration

Along with the visualization function, there is also a function that will create the ﬁles
necessary to create an Enrichment Map. This function takes in these ﬁelds:

• pVal - The p-value the user would like to use for the enrichment map. The default

value is Pvalue U dev.

• FDR - The FDR value the user would like to use for the enrichment map. The default

value is FDR BH U.

• coeff - The coeﬃcient the user would like to use for the enrichment map. The default

value is Coeff U.

• keepCoeff - Whether or not the user would like to keep the gene-sets with negative
regression coeﬃcients. Without global burden correction, negative regression coeﬃ-
cients are present when gene-sets have a higher burden in controls than cases; after
global burden correction negative regression coeﬃcients can just indicate ”unspeciﬁc”
burden. The default value is YES.

• outputPathEnr - Path for the output of the f.enrFiles function.

• minCaseCount - The minimum number of cse subjects that must have a CNV overlap-

ping the gene. The default value is 1.

• maxControlCount - The maximum number of controls each gene is allowed to have.

The default value is 0.

• minRatio - The minimum case/control ratio each gene is allowed to have. The default

value is 0.

• filtGsEnr - Whether or not the user would like to ﬁlter the gene-sets allowed in the

GMT ﬁle created. The default value is YES.

• f.enrFiles also takes in some ﬁelds that are deﬁned in params.ls. It is not necessary

to restate the following ﬁelds:

◦ Kl - Look at description in previous section 3.6.2.
◦ cnvType - Look at description in previous section 3.6.2.

21

3.6.5 Loading test parameters from a ﬁle

To make it easier to integrate the association test into a larger bioinformatics pipeline, it
is convenient to read in the parameters from an external source such as a text ﬁle. There
is a template ﬁle that the user can look at which is included in the package. One such
implementation is to record each parameter on its own line using the tab separated syntax:

param value
###############
# LogReg Config
###############
## CONFIG.LS ##
cnvFile "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/cnv_AGP_demo.txt"
phFile "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/ph_AGP_demo.txt"
geneIDFile "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/geneID_demo.txt"
klGeneFile "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/kl_gene_AGP_demo.txt"
klLociFile "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/kl_loci_AGP_demo.txt"
gsFile "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/gs_data_demo.RData"
outputPath "/Users/josephlugo/Documents/R/PGC2_test/Restructure_Results/8.5/testResults/"
geneListFile ""
## PARAMS.LS ##
Kl "ALL"
projectName "NS"
gsUSet ""
cnvType 1
covariates "SEX"
klOlp 0.5
corrections "no_corr,uni_gc,tot_l,cnvn_ml"
geneSep ";"
keySep "@"
geneSetSizeMax 1500
geneSetSizeMin 25
filtGs "NO"
covInterest "SEX"
eventThreshold 1
fLevels 10
cores
parallel
CNVevents
############
# Viz Config
############
FDRThreshold 0.1
plotHeight 13

"YES"
5

4

22

"uni_gc,tot_l,cnvn_ml"

gsList "/Users/josephlugo/Documents/R/PGC2_test/cnvGSAData/gsList.txt"
outputPathViz "/Users/josephlugo/Documents/R/PGC2_test/Restructure_Results/8.5/Viz/"
labelSize 0.7
correctionViz
############
# ENR Config
############
pVal "Pvalue_U_dev"
FDR "FDR_BH_U"
coeff "Coeff_U"
keepCoeff "YES"
filtGsEnr "NO"
outputPathEnr "/Users/josephlugo/Documents/R/PGC2_test/Restructure_Results/8.5/enr/"
minCaseCount 0
minControlCount 0
minRatio 0

## Find a template of the configFile
> configFileTmp <- system.file( "extdata", "configFile.txt", package="cnvGSA" )

To update the parameters in the input object CnvGSAInput the user simply needs to change
the conﬁgFile and then run the function below. Once the function is run, all the changed
parameters will be updated in the input object CnvGSAInput.

> cnvGSA.in <- f.readConfig(configFile,cnvGSA.in)

4

Interpreting the results from the statistical analysis

4.1 Description of res.ls results

After the main function cnvGSAlogRegTest is run, there will either be one data frame in
res.ls, or two data frames in res.ls. There will be one data frame if the user sets $KL to
YES or NO. There will be two data frames if the user sets $KL to ALL. As previously described
in section 3.6.2, the $KL value will specify whether or not the user would like to include
subjects marked for known loci and genes in the statistical analysis.

For the example data that is included in this cnvGSAdata, the $KL parameter was set to
ALL so there are two objects in the list. Taking a look ﬁrst at res.ls:

> library(cnvGSAdata)
> data(cnvGSA_output_example)
> str(cnvGSA.out@res.ls,max.level=1,list.len = 2)
List of 2

23

$ covAll_chipAll_1_KLy.df:’data.frame’: 50 obs. of 39 variables:

.. [list output truncated]

$ covAll_chipAll_1_KLn.df:’data.frame’: 50 obs. of 39 variables:

.. [list output truncated]

The data frames $covAll chipAll 1 KLy.df and $covAll chipAll 1 KLn.df contain the
actual logistic regression results. $covAll chipAll 1 KLy.df has the results for the tests in-
cluding subjects that are marked for known loci and genes, whereas $covAll chipAll 1 KLn.df
has the results without subjects that are marked for known loci and genes. The CNV type
is speciﬁed by the user and will vary for diﬀerent data sets. The types used in the sample
data are ”1”(LOSS) and ”3”(GAIN).

Each row contains results for a single gene-set. The columns are as follows:

• GsID, GsName, and GsSize show the gene-set’s identiﬁer, name, and number of member

genes respectively.

• Coeff, Coeff U, Coeff TL, and Coeff CNML show the gene-set’s regression coeﬃcients
for each of the diﬀerent correction models used. This represents the log odds of being a
case in the exposed vs. unexposed, adjusted for the covariates and whichever correction
models were speciﬁed.

• Pvalue glm, Pvalue U glm, Pvalue TL glm, and Pvalue CNML glmL show the gene-
set’s p-values for each of the diﬀerent correction models used. These p-values were
obtained using the coeﬃcient signiﬁcance from the default test of the function glm in
R.

• Pvalue dev, Pvalue U dev, Pvalue TL dev, and Pvalue CNML dev show the gene-set’s
p-values for each of the diﬀerent correction models used.These p-values were obtained
using a chi-square deviance test.

• Pvalue dev s, Pvalue U dev s, Pvalue TL dev s, and Pvalue CNML dev s are obtained
by taking the log of the deviance p-values and multiplying them by the sign of the co-
eﬃcient (these are useful for sorting).

• FDR BH, FDR BH U, FDR BH TL, and FDR BH CNML show FDR values using four methods.
FDR BH is the Benjamini-Hochberg (BH) false discovery rate (FDR) for the p-values
calculated using the no correction model. FDR BH U, FDR BH TL, and FDR BH CNML are
the same FDR but with the uni gc, tot l, and cnvn ml correction respectively.

• CASE g1n, CASE g2n, CASE g3n, CASE g4n, and CASE g5n show the percentage of sam-

ples from the cases that each gene-set has at least 1,2,3,4 and 5 events in.

• CTRL g1n, CTRL g2n, CTRL g3n, CTRL g4n, and CTRL g5n show the percentage of sam-

ples from the controls that each gene-set has at least 1,2,3,4 and 5 events in.
• CASE gTT and CTRL gTT show the total number of cases and controls there are.
• CASE Female and CASE male show the percentage of samples from the cases that must
be >= a user speciﬁed number of events and also is part of the SEX covariate. This
will change depending on which covariate the user would like to see in the output.

24

The structure of both data frames is shown in the listing below:

> str( cnvGSA.out@res.ls$covAll_chipAll_1_KLy.df )
’data.frame’: 50 obs. of

39 variables:

4.33e-11 5.19e-11 7.41e-09 7.62e-08 2.29e-08 ...

: num 2.31e-08 4.99e-08 8.85e-06 5.44e-05 2.32e-05 ...
: num 1.375 0.967 0.366 0.753 0.353 ...

: chr "FMR1_Targets_Darnell" "PSD_BayesGrant_fullset" ...
"FMR1_Targets_Darnell" "PSD_BayesGrant_fullset" ...
: chr
: int
840 1407 4600 1230 3131 4605 927 1424 3037 116 ...
: num 1.461 1.03 0.41 0.821 0.392 ...
: num 9.19e-09 2.15e-08 5.92e-07 2.09e-07 8.70e-07 ...
: num 8.67e-13 2.08e-12 4.45e-10 9.15e-09 1.96e-09 ...
: num 12.06 11.68 9.35 8.04 8.71 ...
: num
: num 1.328 0.935 0.366 0.647 0.337 ...
: num 9.33e-07 2.81e-06 2.93e-04 2.88e-04 6.15e-04 ...
: num 4.19e-08 1.73e-07 7.35e-05 1.71e-04 2.82e-04 ...
: num 7.38 6.76 4.13 3.77 3.55 ...
: num 2.09e-06 4.33e-06 9.19e-04 1.71e-03 1.91e-03 ...
: num 1.349 0.944 0.358 0.71 0.344 ...
: num 2.33e-07 7.15e-07 4.46e-05 2.49e-05 3.67e-05 ...
: num 4.63e-10 2.00e-09 5.31e-07 6.53e-06 1.86e-06 ...

$ GsID
$ GsName
$ GsSize
$ Coeff
$ Pvalue_glm
$ Pvalue_dev
$ Pvalue_dev_s
$ FDR_BH
$ Coeff_U
$ Pvalue_U_glm
$ Pvalue_U_dev
$ Pvalue_U_dev_s
$ FDR_BH_U
$ Coeff_TL
$ Pvalue_TL_glm
$ Pvalue_TL_dev
$ Pvalue_TL_dev_s : num 9.33 8.7 6.27 5.19 5.73 ...
$ FDR_BH_TL
$ Coeff_CNML
$ Pvalue_CNML_glm : num 9.72e-08 2.55e-07 1.66e-05 5.06e-06 1.20e-05 ...
$ Pvalue_CNML_dev : num 8.52e-11 2.51e-10 1.02e-07 8.20e-07 3.03e-07 ...
$ Pvalue_CNML_dev_s: num 10.07 9.6 6.99 6.09 6.52 ...
$ FDR_BH_CNML
$ CASE_g1n
$ CTRL_g1n
$ CASE_g2n
$ CTRL_g2n
$ CASE_g3n
$ CTRL_g3n
$ CASE_g4n
$ CTRL_g4n
$ CASE_g5n
$ CTRL_g5n
$ CASE_gTT
$ CTRL_gTT
$ CASE_Female
$ CASE_Male
$ CTRL_Female
$ CTRL_Male

: num
: num 3.86 5.34 9.25 4.92 7.24 ...
: num 0.899 1.627 4.88 2.269 4.409 ...
: num 0.74 1.16 2.7 1.22 2.7 ...
: num 0.0428 0.1284 0.8134 0.0856 0.8134 ...
: num 0.529 0.687 1.639 0.687 1.745 ...
: num 0 0 0.342 0 0.171 ...
: num 0.37 0.582 1.163 0.106 1.322 ...
: num 0 0 0.1712 0 0.0856 ...
: num 0.106 0.423 0.793 0.106 1.005 ...
: num 0 0 0.1284 0 0.0856 ...
: num 1891 1891 1891 1891 1891 ...
: num 2336 2336 2336 2336 2336 ...
: num
: num 3.45 5.18 9.07 4.87 7.28 ...
: num
0.962 1.603 4.567 2.484 5.048 ...
: num 0.827 1.654 5.239 2.022 3.676 ...

4.26e-09 6.27e-09 1.70e-06 6.83e-06 3.79e-06 ...

6.3 6.3 10.37 5.19 7.04 ...

25

5 Full workﬂow example: case-control analysis of rare

CNV from the Pinto et al. 2014 ASD study

5.1 Loading the data and running the association test

The following code performs an analysis of approximately 5500 CNV from 2000 subjects.
The CNV data-set consists of rare CNV as described in Pinto et al., AJHG 2014 [4], and
the gene-sets are a collection imported from the Gene Ontology, Biocarta, KEGG, NCI,
Reactome.

The workﬂow is based on the data found in the data package, refer to section 3 to ﬁnd the
paths to the example data. The user can use these paths to ﬁll in the template conﬁgFile
found in this package.

> library( "cnvGSA" )
> library( "cnvGSAdata" )

##
## Update the configFile
##

## Find a template of the configFile
> configFileTmp <- system.file( "extdata", "configFile.txt", package="cnvGSA" )

##
## Create the input object
##

> configFile <- "INPUT PATH TO UPDATED configFile"
> cnvGSA.in
> cnvGSA.in

<- CnvGSAInput()
<- cnvGSAIn(configFile,cnvGSA.in)

## If this error is seen:
> Error in scan(file, what, nmax, sep, dec, quote, skip, nlines, na.strings, :

line 2 did not have 2 elements

## Check the configFile to make sure that everything but the comments are tab
## separated.

##
## Run association test and save the output
##

> cnvGSA.out <- CnvGSAOutput()

26

> cnvGSA.out <- cnvGSAlogRegTest(cnvGSA.in, cnvGSA.out)

5.2 Reviewing the results

As stated in the workﬂow outline, the output object is a simple S4 class containing a slot
for each output data structure:

> slotNames(cnvGSA.out)
[1] "res.ls"

"gsTables.ls" "gsData.ls"

"phData.ls"

Similar to the input, each of components are a list structure containing further data struc-
tures: res.ls contains the the results of the logistic regression tests, and gsTables.ls
contains the gene-set tables for each gene-set. gsData.ls contains all the gene-set data, and
phData.ls contains all the phenotype/covariate data.

5.2.1 Association test results

All the results from the association test are stored in the res.ls object after the main
function cnvGSAlogRegTest is run. For an in depth look at the res.ls object results, refer
to section 4.1.

5.2.2 Detailed analysis of gene-set CNV and genes

As a further aid in understanding the CNV and genes contributing to the association results,
there exists gsTables.ls – a list of data frames, one for each of the gene-sets, containing
information about the CNV and corresponding genes aﬀecting the gene-set:

## There is a pre-made object available in the data package
> gsTables.ls <- gsTables.ls(cnvGSA.out)
> str( gsTables.ls(cnvGSA.out), max.level=1, list.len=5 )
List of 52

$ BspanHM_lg2rpkm3.21

:’data.frame’: 1409 obs. of 11 variables:

.. [list output truncated]

$ BspanLA_lg2rpkm.MIN

:’data.frame’: 2700 obs. of 11 variables:

.. [list output truncated]

$ BspanML_lg2rpkm0.93

:’data.frame’: 2107 obs. of 11 variables:

.. [list output truncated]

$ BspanVH_lg2rpkm4.74

:’data.frame’: 955 obs. of 11 variables:

.. [list output truncated]

$ BspanVHM_EqlNat

:’data.frame’: 834 obs. of 11 variables:

.. [list output truncated]
[list output truncated]

27

To see gsTables.ls the user can either look at the data included in the cnvGSAdata package
or run the cnvGSAgsTables function provided in this package. This function will create all
the gene-set tables for each gene-set:

## This will populate the gsTables.ls slot in cnvGSA.out
> cnvGSA.out
> gsTables.ls <- cnvGSA.out@gsTables.ls

<- cnvGSAgsTables(cnvGSA.in,cnvGSA.out)

The structure of the data frame for a particular gene-set is similar to that of cnvData.ls$cnv.df
in the input with the exception of the $Symbol and $Symbol TYPE columns, which show the
gene symbols that match the primary identiﬁer:

> str(gsTables.ls[[2]],strict.width="cut",max.level=2)
’data.frame’: 2700 obs. of

11 variables:

: chr "110036001873_" "110036001873_" "110036001873_" ...
: chr "1" "17" "2" "13" ...
: int 1193801 30708148 87214673 69378175 14286493 335515 13523286..
: int 1295424 30792312 87801158 69546838 14373337 428662 13903204..
: int 3 1 3 1 1 3 1 1 3 1 ...
: chr "116983;118424;126789;1855;54587;54973;6339;80772;83756"..

$ SID
$ CHR
$ BP1
$ BP2
$ TYPE
$ geneID
$ geneID_TYPE: chr NA "146857;55106;91607" NA "57626" ...
$ Symbol
$ Symbol_TYPE: chr NA "SLFN13;SLFN12;SLFN11" NA "KLHL1" ...
$ GsID
$ GsName

: chr "BspanLA_lg2rpkm.MIN" "BspanLA_lg2rpkm.MIN" "BspanLA_"..
: chr "BspanLA_lg2rpkm.MIN" "BspanLA_lg2rpkm.MIN" "BspanLA_"..

: chr "ACAP3;UBE2J2;PUSL1;DVL1;MXRA8;CPSF3L;SCNN1D;CPTP;TAS1R3"..

Examining the data frame for a particular gene-set may reveal that its association due to
certain genes may actually be better explained by other genes (those that have a clearer
functional impact or that have previously been associated with the cases under considera-
tion).

5.2.3 Visualizations

Once the CnvGSAOutput and CnvGSAInput objects are made, the user can run f.makeViz to
create a collection of visualizations. An example is shown below:

> f.makeViz(cnvGSA.in,cnvGSA.out)

There are three diﬀerent types of plots that will be made by this function. They show the
signiﬁcance, eﬀect, and support of the gene-sets that are input by the user. Depending on
which corrections the user chooses to include there can be up to 9 plots made. Only the
support plots do not vary with the correction choice. The gene-sets that will be displayed on
the plots should only include ones that are particularly interesting. Valid gene-set choices
include all those that are in the gene-sets in the $res.ls data frame list elements. The user
must input a comma separated ﬁle with no spaces containing all the gene-sets that they
would like to look at. The ﬁle should resemble this:

28

PSD_BayesGrant_fullset,FMR1_Targets_Darnell,PhMm_Aggr_Sensory_all,
Neurof_UnionStringent,Neurof_UnionInclusive,Neurof_GoNervSysDev,BspanVHM_PreNat,
BspanHM_lg2rpkm3.21,PhMm_Aggr_CardvascMuscle_all,HI_q4

For the plots, anything with an FDR below the user speciﬁed cut oﬀ will have a brown
border. This way the user can easily see how reliable the results are. An example of one of
the plots with an FDR cut oﬀ of 0.1, the universe correction, and the gene-sets mentioned
above is included below:

29

PSD_BayesGrant_fullset: 1407FMR1_Targets_Darnell: 840PhMm_Aggr_Sensory_all: 1293Neurof_UnionStringent: 1424Neurof_UnionInclusive: 2874Neurof_GoNervSysDev: 1874BspanVHM_PreNat: 3038BspanHM_lg2rpkm3.21: 4605PhMm_Aggr_CardvascMuscle_all: 2059HI_q4: 39851: Significance: U−Log (Dev P−value) * sign (Coeff)024685.2.4 Enrichment Map pre-processing

To conduct further analysis of the results, this package has the function f.enrFiles that will
do all the pre-processing for the ﬁles necessary to make an enrichment map. The enrichment
map is created using Cytoscape and displays a network of gene-sets and how they overlap
with one another. It will produce clusters that will convey the data in a meaningful way.
The $MinCaseCount, $MinControlCount, and $MinRatio parameters in the conﬁgFile will
inﬂuence the generation of the ﬁles produced by the f.enrFiles function. They provide
cuttoﬀs that specify the minimum amount of case/control events each gene is allowed to
have and the minimum case/control ratio each gene is allowed to have.

The f.enrFiles function will create two ﬁles (GMT and generic) needed to make the enrich-
ment map. For more information on these types of ﬁles, see the Enrichment Map User
Guide. Once the function is run, these two ﬁles will be output and will be available to use
with the Cytoscape software. It is recommended to use the Jaccard+Overlap combined
option when creating the map. There is a basic example below.

## To create the two files, simply run this function
> f.enrFiles(cnvGSA.in,cnvGSA.out)

The output will allow the user to use Cytoscape to create a network map that will look
similar to this:

The map represents the gene-sets as nodes (circles) and links them together with edges
(lines connecting circles). The closer the gene-sets are, the more similar the gene-sets are
with one another. This creates clusters which make it easy to determine how the gene-sets
compare to one another. The size of the node represents the size of the gene-set and the
thickness of the edges is proportional to the overlap between the gene-sets. This overlap

31

refers to the number of genes two gene-sets share with one another. In a two-class experi-
ment such as this one, red nodes display high enrichment in one class and blue nodes display
high enrichment in the second class. For a more in depth look into how to interpret these
Enrichment Maps, refer to the Enrichment Map paper [7].

If the user would like to use their own ﬁles to make the enrichment map they should follow
the examples below. This can be found on the Enrichment Map User Guide as described
above.

The GMT ﬁle should follow somehthing like this:

• Each row of the geneset ﬁle represents one gene-set and consists of:

◦ gene-set name (–tab–) description (–tab–) a list of tab-delimited genes that are

part of that gene-set.

The generic ﬁle should follow this format:

• The generic results ﬁle is a tab delimited ﬁle with enriched gene-sets and their corre-

sponding p-values (and optionally, FDR corrections)

• The Generic Enrichment Results ﬁle needs:

◦ gene-set ID (must match the gene-set ID in the GMT ﬁle),
◦ gene-set name or description
◦ p-value
◦ FDR correction value
◦ Phenotype: +1 or -1, to identify enrichment in up- and down-regulation, or,
more in general, in either of the two phenotypes being compared in the two-class
analysis (+1 maps to red and -1 maps to blue).

32

6 References

[1] Raychaudhuri S et al. Accurately assessing the risk of schizophrenia conferred by rare
copy-number variation aﬀecting genes with brain function. PLoS Genet. 2010 Sep 9;
6(9): e1001097.

[2] Pinto, D et al. Functional impact of global rare copy number variation in autism spec-

trum disorders. Nature. 2010 Jul 15; 466(7304): 368–72.

[3] Kirov G et al. De novo CNV analysis implicates speciﬁc abnormalities of postsynaptic
signalling complexes in the pathogenesis of schizophrenia. Mol Psychiatry. 2012 Feb;
17(2): 142–53.

[4] Pinto, D et al. Convergence of Genes and Cellular Pathways Dysregulated in Autism

Spectrum Disorders. Am J Hum Genet. 2014 May 1; 94(5): 677–694.

[5] Goeman JJ, Bhlmann P. Analyzing gene expression data in terms of gene sets: method-

ological issues. Bioinformatics. 2007 Apr 15; 23(8): 980–7.

[6] Marshall C. R. et al. Structural Variation of Chromosomes in Autism Spectrum Disor-

der. Am J Hum Genet. 2008 Feb 8; 82(2): 477–488.

[7] Merico D et al. Enrichment map: a network-based method for gene-set enrichment

visualization and interpretation. PLoS One. 2010 Nov 15; 5(11): e13984.

33

