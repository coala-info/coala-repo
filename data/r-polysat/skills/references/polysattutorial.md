polysat version 1.7 Tutorial Manual

Lindsay V. Clark <lvclark@illinois.edu>
University of Illinois, Urbana-Champaign
Department of Crop Sciences
https://github.com/lvclark/polysat/wiki

August 23, 2022

Contents

1 Introduction

2 Obtaining and installing polysat

3 Work(cid:29)ow overview

2

3

3

4 Getting Started: A Tutorial

. . . . . . . . . . . . . . . . . . . . . . . .

6
6
4.1 Creating a dataset
4.2 Data analysis and export . . . . . . . . . . . . . . . . . . . . . 11
4.2.1 Genetic distances between individuals . . . . . . . . . . 11
4.2.2 Working with subsets of the data . . . . . . . . . . . . 13
. . . . . . . . . . . . . . . . . . . 15
4.2.3 Population statistics
. . . . . . . . . . . . . . . . . . 21
4.2.4 Genotype data export

5 How data are stored in polysat

21
5.1 The (cid:16)genambig(cid:17) class . . . . . . . . . . . . . . . . . . . . . . . 21
5.2 How ploidy data is stored: (cid:16)ploidysuper(cid:17) and subclasses . . . . 28
. . . . . . . . . . . . . 31
5.3 The (cid:16)gendata(cid:17) and (cid:16)genbinary(cid:17) classes

6 Functions for autopolyploid data

34
6.1 Data import
. . . . . . . . . . . . . . . . . . . . . . . . . . . 34
6.2 Data export . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37

1

6.3

Individual-level statistics . . . . . . . . . . . . . . . . . . . . . 40
6.3.1 Estimating and exporting ploidies . . . . . . . . . . . . 40
6.3.2
Inter-individual distances . . . . . . . . . . . . . . . . . 40
6.3.3 Determining groups of asexually-related samples . . . . 44
. . . . . . . . . . . . . . . . . . . . . . . 45
6.4.1 Allele diversity and frequencies
. . . . . . . . . . . . . 45
6.4.2 Genotype frequencies . . . . . . . . . . . . . . . . . . . 47

6.4 Population statistics

7 Functions for allopolyploid data

49
. . . . . . . . . . . . . . . . . . . . . 49
Individual-level and population statistics . . . . . . . . . . . . 50

7.1 Data import and export
7.2

8 Treating microsatellite alleles as dominant markers

9 How to cite polysat

1

Introduction

51

53

The R package polysat provides useful tools for working with microsatel-
lite data of any ploidy level, including populations of mixed ploidy. It can
convert genotype data between di(cid:27)erent formats, including Applied Biosys-
tems GeneMapperﬁ, binary presence/absence data, ATetra, Tetra/Tetrasat,
GenoDive, SPAGeDi, Structure, POPDIST, and STRand. It can also calcu-
late pairwise genetic distances between samples, assist the user in estimating
ploidy based on allele number, and estimate allele frequencies, population
di(cid:27)erentiation statistics such as FST , and polymorphic information content.
Due to the versatility of the R programming environment and the simplicity
of how genotypes are stored by polysat, the user may (cid:28)nd many ways to
interface other R functions with this package, such as Principal Coordinate
Analysis or AMOVA.

This manual is written to be accessible to beginning users of R. If you
are a complete novice to R, it is recommended that you read through An
Introduction to R ( http://cran.r-project.org/manuals.html ) before
reading this manual or at least have both open at the same time. If you have
the console open while reading the manual you can also look at the help (cid:28)les
for base R functions (for example by typing ?save or ?%in%) and also get
more detailed information on polysat functions (e.g. ?read.GeneMapper).

2

The examples will be easiest to understand if you follow along with them
and think about the purpose of each line of code. A (cid:28)le called (cid:16)polysattuto-
rial.R(cid:17) in the (cid:16)doc(cid:17) subdirectory of the package installation can be opened
with a text editor and contains all of the R input found in this manual.

2 Obtaining and installing polysat

The R console and base system can be obtained at http://www.r-project.
org/. Once R is installed, polysat can be installed and loaded by typing
the following commands into the R console:

> install.packages("polysat")
> library("polysat")

If you quit and restart R, you will not have to re-install the package but
you will need to load it again (using the library function as shown above).

3 Work(cid:29)ow overview

The (cid:29)owcharts on the next two pages give an overview of the steps required
for the most common analyses performed in polysat. The (cid:28)rst steps will
always be importing or inputing the genotype data and making sure that
the dataset contains information about populations and microsatellite repeat
lengths. Di(cid:27)erent analysis and export functions are then available depending
on whether the ploidy is known, whether the organism is autopolyploid or
allopolyploid, and whether the sel(cid:28)ng rate is known.

3

Import genotype
data using a read
function, or start from
scratch using new
and editGenotypes.

Run
alleleDiversity,
and/or convert to
presence/absence
(genbinary class) for
analysis or export.

Check dataset
with summary.

Analysis with
assignClones or
genotypeDiversity

Add population
and locus informa-
tion (PopNames,
PopInfo, Usatnts).

Calculate genetic
distances between
individuals with
meandistance.matrix.

Do you know
the ploidies?

no

Were ploidies
imported with
the dataset?

yes

reformatPloidies
if necessary, then
add ploidy info with
Ploidies function.

no

yes

Downstream analysis
such as Principal
Coordinate Analysis
or Neighbor Joining.

Is organism
allopolyploid?

yes

no

Use estimatePloidy
function.

Export tetraploid data
to ATetra, Tetra, or
Tetrasat software.

Use
alleleCorrelations,
testAlGroups, and
recodeAllopoly
functions to re-
code the dataset as
diploid or polysomic.

See Flowchart 2.

Flowchart 1. Functions for allopolyploid or autopolyploid data.

4

Continued from
Flowchart 1.

Export to Structure,
SPAGeDi, GenoDive,
or POPDIST software.

Calculate Polymor-
phic Information
Content (PIC)

Use simpleFreq
to estimate al-
lele frequencies.

no

Export allele frequen-
cies to adegenet.

Get distances between
populations with
calcPopDiff.

Calculate genetic
distances between
individuals using
meandistance.matrix2.

Downstream analysis.

Does each
population have
one, even
numbered
ploidy, and is
the self
fertilization
rate known?

yes

Use deSilvaFreq
to estimate al-
lele frequencies.

Export allele frequen-
cies to SPAGeDi.

Analysis with
assignClones or
genotypeDiversity

Flowchart 2. Functions for polysomic or diploid data only.

5

4 Getting Started: A Tutorial

4.1 Creating a dataset

As with any genetic software, the (cid:28)rst thing you want to do is import your
data. For this tutorial, go into the (cid:16)extdata(cid:17) directory of the polysat package
installation, and (cid:28)nd a (cid:28)le called (cid:16)GeneMapperExample.txt(cid:17). Open this (cid:28)le
in a text editor and inspect its contents. This (cid:28)le contains simulated geno-
types of 300 diploid and tetraploid individuals at three loci. Move this text
(cid:28)le into the R working directory. The working directory can be changed with
the setwd function, or identi(cid:28)ed with the getwd function:

> getwd()

[1] "C:/Users/Lindsay/AppData/Local/Temp/RtmpAVdmgy/Rbuildd08a9e75cd/polysat/vignettes"

Then read the (cid:28)le using the read.GeneMapper function, and assign the

dataset a name of your choice (simgen in this example) by typing:

> simgen <- read.GeneMapper("GeneMapperExample.txt")

The dataset now exists as an object in R. The following commands dis-
play, respectively, some basic information about the dataset, the sample and
locus names, a subset of the genotypes, and a list of which genotypes are
missing.

> summary(simgen)

Dataset with allele copy number ambiguity.
Insert dataset description here.
Number of missing genotypes: 5
300 samples, 3 loci.
1 populations.
Ploidies: NA
Length(s) of microsatellite repeats: NA

> Samples(simgen)

6

[1] "A1"
[8] "A8"
[15] "A15"
[22] "A22"
[29] "A29"
[36] "A36"
[43] "A43"
[50] "A50"
[57] "A57"
[64] "A64"
[71] "A71"
[78] "A78"
[85] "A85"
[92] "A92"
[99] "A99"

"A3"
"A10"
"A17"
"A24"
"A31"
"A38"
"A45"
"A52"
"A59"
"A66"
"A73"
"A80"
"A87"
"A94"

"A2"
"A9"
"A16"
"A23"
"A30"
"A37"
"A44"
"A51"
"A58"
"A65"
"A72"
"A79"
"A86"
"A93"
"A100" "B1"
"B8"
"B7"
"B15"
"B22"
"B29"
"B36"
"B43"
"B50"
"B57"
"B64"
"B71"
"B78"
"B85"
"B92"
"B99"
"C6"
"C13"
"C20"
"C27"
"C34"
"C41"
"C48"

[106] "B6"
[113] "B13" "B14"
[120] "B20" "B21"
[127] "B27" "B28"
[134] "B34" "B35"
[141] "B41" "B42"
[148] "B48" "B49"
[155] "B55" "B56"
[162] "B62" "B63"
[169] "B69" "B70"
[176] "B76" "B77"
[183] "B83" "B84"
[190] "B90" "B91"
[197] "B97" "B98"
[204] "C4"
[211] "C11" "C12"
[218] "C18" "C19"
[225] "C25" "C26"
[232] "C32" "C33"
[239] "C39" "C40"
[246] "C46" "C47"

"C5"

"A6"
"A13"
"A20"
"A27"
"A34"
"A41"
"A48"
"A55"
"A62"
"A69"
"A76"
"A83"
"A90"
"A97"
"B4"
"B11"
"B18"
"B25"
"B32"
"B39"
"B46"
"B53"
"B60"
"B67"
"B74"
"B81"
"B88"
"B95"
"C2"
"C9"
"C16"
"C23"
"C30"
"C37"
"C44"
"C51"

"A7"
"A14"
"A21"
"A28"
"A35"
"A42"
"A49"
"A56"
"A63"
"A70"
"A77"
"A84"
"A91"
"A98"
"B5"
"B12"
"B19"
"B26"
"B33"
"B40"
"B47"
"B54"
"B61"
"B68"
"B75"
"B82"
"B89"
"B96"
"C3"
"C10"
"C17"
"C24"
"C31"
"C38"
"C45"
"C52"

"A5"
"A12"
"A19"
"A26"
"A33"
"A40"
"A47"
"A54"
"A61"
"A68"
"A75"
"A82"
"A89"
"A96"
"B3"
"B10"
"B17"
"B24"
"B31"
"B38"
"B45"
"B52"
"B59"
"B66"
"B73"
"B80"
"B87"
"B94"

"A4"
"A11"
"A18"
"A25"
"A32"
"A39"
"A46"
"A53"
"A60"
"A67"
"A74"
"A81"
"A88"
"A95"
"B2"
"B9"
"B16"
"B23"
"B30"
"B37"
"B44"
"B51"
"B58"
"B65"
"B72"
"B79"
"B86"
"B93"
"B100" "C1"
"C8"
"C7"
"C15"
"C14"
"C22"
"C21"
"C29"
"C28"
"C36"
"C35"
"C43"
"C42"
"C50"
"C49"

7

[253] "C53" "C54"
[260] "C60" "C61"
[267] "C67" "C68"
[274] "C74" "C75"
[281] "C81" "C82"
[288] "C88" "C89"
[295] "C95" "C96"

"C55"
"C62"
"C69"
"C76"
"C83"
"C90"
"C97"

"C56"
"C63"
"C70"
"C77"
"C84"
"C91"
"C98"

"C57"
"C64"
"C71"
"C78"
"C85"
"C92"
"C99"

"C59"
"C66"
"C73"
"C80"
"C87"
"C94"

"C58"
"C65"
"C72"
"C79"
"C86"
"C93"
"C100"

> Loci(simgen)

[1] "loc1" "loc2" "loc3"

> viewGenotypes(simgen, samples=paste("A", 1:20, sep=""), loci="loc1")

Locus

Alleles

Sample
A1
A2
A3
A4
A5
A6
A7
A8
A9
A10
A11
A12
A13
A14
A15
A16
A17
A18
A19
A20

loc1
loc1
loc1
loc1
loc1
loc1
loc1
loc1
loc1

loc1
loc1
loc1
loc1
loc1
loc1
loc1
loc1
loc1
loc1
loc1

110
114
114
110
106
100
112
102
112

102
114
106
110
100
100
112
102
102
114
106

> find.missing.gen(simgen)

106
118
100
106

106

110
112

106
114
100

110
108

110
106
100

112

118

112
106
102
102
112
110
108
106

106
100
118
112
112
112
102
106
106
102
100

8

Locus Sample
B54
B80
B48
A42
C22

loc1
loc1
loc2
loc3
loc3

1
2
3
4
5

Additional information that isn’t in (cid:16)GeneMapperExample.txt(cid:17) can be
added directly to the dataset in R. The commands below add a description
to the dataset, name three populations and assign 100 individuals to each,
and indicate the length of the microsatellite repeats.

> Description(simgen) <- "Dataset for the tutorial"
> PopNames(simgen) <- c("PopA", "PopB", "PopC")
> PopInfo(simgen) <- rep(1:3, each = 100)
> Usatnts(simgen) <- c(2, 3, 2)

If you need help understanding what the PopInfo assignment means, type

the following commands (results are hidden here for the sake of space):

> rep(1:3, each = 100)
> PopInfo(simgen)

Samples can now be retrieved by population. (Results hidden as above.)

> Samples(simgen, populations = "PopA")

The Usatnts assignment function above indicates that loc1 and loc3 have
dinucleotide repeats, while loc2 has trinucleotide repeats. The alleles are
recorded here in terms of fragment length in nucleotides. If the alleles were
instead recorded in terms of repeat number, the Usatnts values should be 1.
These repeat lengths can be examined by typing:

> Usatnts(simgen)

loc1 loc2 loc3
2

2

3

To edit genotypes after importing the data:

9

> simgen <- editGenotypes(simgen, maxalleles = 4)

Edit the alleles, then close the data editor window.

You can also add ploidy information to the dataset. The estimatePloidy
function allows you to add or edit the ploidy information, using a table that
shows you the mean and maximum number of alleles per sample. The samples
in this dataset should be diploid or tetraploid, although many of them may
have fewer alleles. Therefore, in the data editor that is generated by the
command below, you should change new.ploidy values to 2 if the sample
has a maximum of one allele per locus, and to 4 if a sample has a maximum
of three alleles per locus. See ?Ploidies or page 25 for a di(cid:27)erent way to
edit ploidy values if they are already known.

> simgen <- estimatePloidy(simgen)

Edit the new.ploidy values, then close the data editor window.

Take another look at the summary now that you have added this extra

data.

> summary(simgen)

Dataset with allele copy number ambiguity.
Dataset for the tutorial
Number of missing genotypes: 5
300 samples, 3 loci.
3 populations.
Ploidies: 4 2
Length(s) of microsatellite repeats: 2 3

Now that you have your dataset completed, it is not a bad idea to save
a copy of it.
It will be automatically saved in your R workspace for use
in subsequent R sessions. However, the save function creates a separate
(cid:28)le containing a copy of the dataset (or any other R object), which can be
useful as a backup against accidental changes or a copy to open on another
computer. The (cid:28)le containing the dataset can be opened again at a later
date using the load function.

> save(simgen, file="simgen.RData")

10

4.2 Data analysis and export

4.2.1 Genetic distances between individuals

The code below calculates a pairwise distance matrix between all samples
(using the default distance measure Bruvo.distance), performs Principal
Coordinate Analysis (PCA) on the matrix, and plots the (cid:28)rst two principal
coordinates, with each population represented by a di(cid:27)erent color.

> testmat <- meandistance.matrix(simgen)

> pca <- cmdscale(testmat)
> mycol <- c("red", "green", "blue")
> plot(pca[,1], pca[,2], col=mycol[PopInfo(simgen)],
+

main = "PCA with Bruvo distance")

To conduct a PCA using the Lynch.distance measure, type:

11

−0.4−0.20.00.20.4−0.3−0.2−0.10.00.10.20.3PCA with Bruvo distancepca[, 1]pca[, 2]> testmat2 <- meandistance.matrix(simgen, distmetric=Lynch.distance)

> pca2 <- cmdscale(testmat2)
> plot(pca2[,1], pca2[,2], col=rep(c("red", "green", "blue"), each=100),
+

main = "PCA with Lynch distance")

Bruvo.distance takes mutation into account, while Lynch.distance
does not. (See ?Bruvo.distance, ?Lynch.distance, and section 6.3.) Since
mutation was not part of the simulation that generated this dataset, the
latter measure works better here for distinguishing populations.

If your data are autopolyploid and you want to use the Bruvo distance, I
recommend using meandistance.matrix2 rather than meandistance.matrix.
meandistance.matrix2 will take longer to process, but will be more accu-
rate because it models allele copy number. Additionally, if you have a mixed
ploidy system in which the mechanism(s) for changes in ploidy are known,
also see ?Bruvo2.distance.

12

−0.4−0.20.00.20.4−0.4−0.20.00.20.4PCA with Lynch distancepca2[, 1]pca2[, 2]4.2.2 Working with subsets of the data

It is likely that you will want to perform some analyses on just a subset
of your data. There are several ways to accomplish this in polysat. The
deleteSamples and deleteLoci functions are designed to be fairly intuitive.

> simgen2 <- deleteSamples(simgen, c("B59", "C30"))
> simgen2 <- deleteLoci(simgen2, "loc2")
> summary(simgen2)

Dataset with allele copy number ambiguity.
Dataset for the tutorial
Number of missing genotypes: 4
298 samples, 2 loci.
3 populations.
Ploidies: 4 2
Length(s) of microsatellite repeats: 2

There are also a couple methods that involve using vectors of samples and
loci that you do want to use. Let’s make a vector of samples in populations
A and B that are tetraploid, and then exclude a few samples that we don’t
want to analyze.

> samToUse <- Samples(simgen2, populations=c("PopA", "PopB"), ploidies=4)
> exclude <- c("A50", "A78", "B25", "B60", "B81")
> samToUse <- samToUse[!samToUse %in% exclude]
> samToUse

"A2"

[1] "A1"
[8] "A14" "A15"
"A29"
"A41"
"A57"
"A68"
"A83"
"A97"
"B10"
"B23"

[15] "A28"
[22] "A39"
[29] "A51"
[36] "A66"
[43] "A82"
[50] "A94"
[57] "B6"
[64] "B22"

"A6"
"A20"
"A36"
"A46"
"A62"
"A76"
"A89"
"B2"
"B18"
"B28"

"A10" "A11"
"A26"
"A24"
"A38"
"A37"
"A49"
"A48"
"A64"
"A63"
"A81"
"A79"
"A92"
"A90"
"B5"
"B3"
"B21"
"B19"
"B31"
"B29"

"A3"
"A16"
"A33"
"A42"
"A60"
"A69"
"A85"
"A98"
"B11"
"B24"

"A4"
"A19"
"A34"
"A43"
"A61"
"A70"
"A86"
"A99"
"B12"
"B26"

13

[71] "B33"
[78] "B45"
[85] "B56"
[92] "B75"
[99] "B90"

"B37"
"B46"
"B63"
"B76"
"B91"

"B38"
"B47"
"B66"
"B78"
"B92"

"B40"
"B48"
"B67"
"B79"
"B95"

"B42"
"B51"
"B69"
"B83"
"B100"

"B43"
"B53"
"B70"
"B87"

"B44"
"B55"
"B71"
"B88"

You can subscript the dataset with square brackets, like you can with
many other R objects. Note, however, that in this case you can’t use square
brackets to replace a subset of the dataset, just to access a subset of the
dataset. A vector of samples should be placed (cid:28)rst in the brackets, followed
by a vector of loci.

> summary(simgen2[samToUse, "loc1"])

Dataset with allele copy number ambiguity.
Dataset for the tutorial
Number of missing genotypes: 0
103 samples, 1 loci.
2 populations.
Ploidies: 4
Length(s) of microsatellite repeats: 2

The analysis and data export functions all have optional samples and
loci arguments where vectors of sample and locus names can indicate that
only a subset of the data should be used.

> testmat3 <- meandistance.matrix(simgen2, samples = samToUse,
distmetric = Lynch.distance,
+
+
progress= FALSE)
> pca3 <- cmdscale(testmat3)
> plot(pca3[,1], pca3[,2], col=c("red", "blue")[PopInfo(simgen2)[samToUse]])

14

(If you are confused about how I got the color vector, I would encourage

dissecting it: See what PopInfo(simgen2) gives you, what PopInfo(simgen2)[samToUse]
gives you, and lastly what the result of c("red", "blue")[PopInfo(simgen2)[samToUse]]
is.)

4.2.3 Population statistics

Allele frequencies are estimated in the example below. The example then
uses these allele frequencies to calculate pairwise Wright’s FST [15], Nei’s
GST [15, 16], Jost’s D [9], and RST [20] values, (cid:28)rst using all loci and then
just two of the loci. See Section 6.4.1 for important information about allele
frequency estimation.

> simfreq <- deSilvaFreq(simgen, self = 0.1, initNull = 0.01,
+

samples = Samples(simgen, ploidies = 4))

15

−0.6−0.4−0.20.00.20.4−0.4−0.20.00.20.4pca3[, 1]pca3[, 2]Starting loc1
Starting loc1 PopA
64 repetitions for loc1 PopA
Starting loc1 PopB
106 repetitions for loc1 PopB
Starting loc1 PopC
84 repetitions for loc1 PopC
Starting loc2
Starting loc2 PopA
54 repetitions for loc2 PopA
Starting loc2 PopB
94 repetitions for loc2 PopB
Starting loc2 PopC
89 repetitions for loc2 PopC
Starting loc3
Starting loc3 PopA
104 repetitions for loc3 PopA
Starting loc3 PopB
117 repetitions for loc3 PopB
Starting loc3 PopC
105 repetitions for loc3 PopC

> simfreq

Genomes

loc1.102

loc1.100

loc1.106
212 0.1202992 0.12041013 0.00000000 0.2196366
208 0.0000000 0.16964161 0.09127732 0.0666518
180 0.1546742 0.01733696 0.24074235 0.0000000

loc1.104

PopA
PopB
PopC

loc1.108

loc1.110 loc1.112

loc1.116
PopA 0.03591695 0.14287772 0.1542292 0.1251016 0.00000000
PopB 0.00000000 0.12865007 0.0000000 0.1251792 0.09286717
PopC 0.10203928 0.03436444 0.1477607 0.0749076 0.18553453

loc1.114

loc1.118

loc1.null

loc2.149
PopA 0.07118362 0.01034496 0.00000000 0.16292064 0.0000000
PopB 0.30132333 0.02440948 0.39112389 0.05846641 0.1964645
PopC 0.02862591 0.01401403 0.09199651 0.12284567 0.1100339

loc2.143

loc2.146

loc2.152

loc2.155

loc2.158

loc2.161

loc2.164

16

PopA 0.01937013 0.2277736 0.2318032 0.2269041 0.1208905
PopB 0.00000000 0.0000000 0.1737714 0.1586404 0.0000000
PopC 0.30329792 0.1475359 0.0000000 0.0000000 0.2080345

loc3.210

loc2.null

loc3.216
PopA 0.01033780 0.08777834 0.00000000 0.1171561 0.07825934
PopB 0.02153341 0.00000000 0.15664870 0.0000000 0.00000000
PopC 0.01625563 0.21567201 0.06139389 0.0000000 0.13814503

loc3.212

loc3.214

loc3.220

loc3.218

loc3.226
PopA 0.27813128 0.0000000 0.15201002 0.00000000 0.0000000
PopB 0.37855398 0.0000000 0.15477761 0.15861852 0.0000000
PopC 0.09445973 0.1538148 0.06183346 0.08256635 0.1684937

loc3.222

loc3.224

loc3.228

loc3.230 loc3.null
PopA 0.05675610 0.20737987 0.02252894
PopB 0.02972989 0.08606954 0.03560175
PopC 0.00000000 0.00000000 0.02362112

> simFst <- calcPopDiff(simfreq, metric = "Fst")
> simFst

PopA

PopC
PopA 0.00000000 0.05068795 0.05453103
PopB 0.05068795 0.00000000 0.07098261
PopC 0.05453103 0.07098261 0.00000000

PopB

> simFst12 <- calcPopDiff(simfreq, metric = "Fst", loci=c("loc1", "loc2"))
> simFst12

PopA

PopC
PopA 0.00000000 0.06004514 0.05597902
PopB 0.06004514 0.00000000 0.07356898
PopC 0.05597902 0.07356898 0.00000000

PopB

> simGst <- calcPopDiff(simfreq, metric = "Gst")
> simGst

PopA

PopC
PopB
5.240348e-02
PopA 0.00000000 4.831976e-02
PopB 0.04831976 -4.761517e-17
6.878140e-02
PopC 0.05240348 6.878140e-02 -8.650758e-17

17

> simGst12 <- calcPopDiff(simfreq, metric = "Gst", loci=c("loc1", "loc2"))
> simGst12

PopC
PopB
PopA
5.393073e-02
PopA 0.00000000 0.05807343
PopB 0.05807343 0.00000000
7.151228e-02
PopC 0.05393073 0.07151228 -6.545712e-17

> simD <- calcPopDiff(simfreq, metric = "Jost
> simD

’

s D")

PopA

PopB

PopC
PopA 0.0000000 0.4219188 0.5640714
PopB 0.4219188 0.0000000 0.6381204
PopC 0.5640714 0.6381204 0.0000000

> simD12 <- calcPopDiff(simfreq, metric = "Jost
> simD12

’

s D", loci=c("loc1", "loc2"))

PopB

PopA

PopC
PopA 0.0000000 0.5118056 0.5604966
PopB 0.5118056 0.0000000 0.6487600
PopC 0.5604966 0.6487600 0.0000000

> simRst <- calcPopDiff(simfreq, metric = "Rst", object = simgen)
> simRst

PopC
PopA
9.085165e-02 3.612000e-02
PopA 4.239168e-17
PopB 9.085165e-02 -1.206474e-16 4.063042e-02
4.063042e-02 1.403716e-16
PopC 3.612000e-02

PopB

> simRst12 <- calcPopDiff(simfreq, metric = "Rst", object = simgen, loci=c("loc1", "loc2"))
> simRst12

PopC
PopA
PopA 6.358752e-17
1.370264e-01 3.723488e-02
PopB 1.370264e-01 -1.809712e-16 4.575589e-02
4.575589e-02 1.025220e-16
PopC 3.723488e-02

PopB

18

We can also calculate polymorphic information content (PIC) of each
locus in order to gauge which loci will be most informative for future studies
(higher numbers = more informative).

> PIC(simfreq)

loc2

loc1

loc3
0.8398759 0.7709120 0.8033700
PopA
0.8057640 0.7127163 0.7445749
PopB
PopC
0.8245357 0.7810601 0.8424778
Overall 0.8886356 0.8616563 0.8623154

We can get a global estimate, rather than a pairwise estimate, of any

population di(cid:27)erentiation statistic, for example for GST :

> calcPopDiff(simfreq, metric = "Gst", global = TRUE)

[1] 0.07401125

For either pairwise or global population di(cid:27)erentiation statistics, we can
get bootstrapped estimates in order to determine a 95% con(cid:28)dence interval:

> gbootstrap <- calcPopDiff(simfreq, metric = "Gst", global = TRUE,
+
> quantile(gbootstrap, c(0.025, 0.975))

bootstrap = TRUE)

2.5%

97.5%
0.05972216 0.09994173

bootstrap = TRUE)

> gbootstrap_pairwise <- calcPopDiff(simfreq, metric = "Gst",
+
> pairwise_CIs <- lapply(gbootstrap_pairwise,
+
> names(pairwise_CIs) <- paste(rep(PopNames(simgen),
+
+
+
+
> pairwise_CIs

rep(PopNames(simgen),

sep = ".")

function(x) quantile(x, c(0.025,0.975)))

each = length(PopNames(simgen))),

times = length(PopNames(simgen))),

19

$PopA.PopA

2.5% 97.5%
0

0

$PopA.PopB
2.5%

97.5%
0.02881243 0.07977158

$PopA.PopC
2.5%

97.5%
0.04584374 0.06201772

$PopB.PopA
2.5%

97.5%
0.02881243 0.07977158

$PopB.PopB

2.5%
-1.428455e-16

97.5%
0.000000e+00

$PopB.PopC
2.5%

97.5%
0.05408831 0.08893625

$PopC.PopA
2.5%

97.5%
0.04584374 0.06201772

$PopC.PopB
2.5%

97.5%
0.05408831 0.08893625

$PopC.PopC

2.5%
-1.309142e-16

97.5%
0.000000e+00

20

4.2.4 Genotype data export

Lastly, you may want to export your data for use in another program. Below
is a simple example of data export for the software Structure. Additional
export functions are described in sections 6.2 and 7.1. More details on the
options for all of these functions are found in their respective help (cid:28)les.

In this example, both dipliod and tetraploid samples are included in the
(cid:28)le. The ploidy argument indicates how many lines per individual the (cid:28)le
should have.

> write.Structure(simgen, ploidy = 4, file="simgenStruct.txt")

5 How data are stored in polysat

In the tutorial above, you learned some ways of creating, viewing, and editing
a dataset in polysat. This section goes into more details of the underlying
data structure in polysat. This is particularly useful to understand if you
want to extend the functionality of the package, but it may clear up some
confusion for basic polysat users as well.

polysat uses the S4 class system in R. (cid:16)Class(cid:17) and (cid:16)object(cid:17) are two
computer science terms that are introduced in Section 3 of An Introduction
to R. Whenever you create a vector, data frame, matrix, list, etc. you are
creating an object, and the class of the object de(cid:28)nes which of these the
object is. Furthermore, a class has certain (cid:16)methods(cid:17) de(cid:28)ned for it so that
the user can interact with the object in pre-speci(cid:28)ed ways. For example, if
you use mean on a matrix, you will get the mean of all elements of the matrix,
while if you use mean on a data frame, you will get the mean of each column;
mean is a generic function with di(cid:27)erent methods for these two classes. S4
classes in R have (cid:16)slots(cid:17), where each slot can hold an object of a certain class.
Methods de(cid:28)ne how the user can access, replace, and manipulate the data in
these slots.

5.1 The (cid:16)genambig(cid:17) class

The object that you created with the read.GeneMapper function in the tu-
torial is of the class "genambig". This class has the slots Description (a
character string or character vector describing the dataset), Genotypes (a
two-dimensional list of vectors, where each vector contains all unique alleles

21

for a particular sample at a particular locus), Missing (the symbol for a
missing genotype), Usatnts (a vector containing the repeat length of each
locus, or 1 if alleles for that locus are already in terms of repeat number
rather than nucleotides), Ploidies (an object of the class "ploidysuper",
which can contain a single value, a vector indexed by sample or locus, or
a matrix indexed by sample and locus, any of which can contain integers
to indicate ploidy), PopNames (the name of each population), and PopInfo
(the population identity of each sample, using integers that correspond to
the position of the population name in PopNames). You’ll notice that there
aren’t slots to hold sample or locus names, which are stored as the names
and dimnames of the objects in the other slots.

> showClass("genambig")

Class "genambig" [package "polysat"]

Slots:

Name:
Class:

Genotypes Description
character

array

Missing
ANY

Usatnts
integer

Ploidies
Name:
Class: ploidysuper

PopInfo
integer

PopNames
character

Extends: "gendata"

To create a "genambig" object from scratch without using one of the
data import functions, (cid:28)rst create two character vectors to contain sample
and locus names, respectively. These vectors are then used as arguments to
the new function.

> mysamples <- c("indA", "indB", "indC", "indD", "indE", "indF")
> myloci <- c("loc1", "loc2", "loc3")
> mydataset <- new("genambig", samples=mysamples, loci=myloci)

An object has now been created with all of the appropriate slots named

according to sample and locus names.

> mydataset

22

Insert dataset description here.
Missing values: -9

Genotypes:

loc1 loc2 loc3

indA -9
indB -9
indC -9
indD -9
indE -9
indF -9

-9
-9
-9
-9
-9
-9

-9
-9
-9
-9
-9
-9

SSR motif lengths:

none

Ploidies:

none

PopNames:

none

PopInfo:

none

In the tutorial you used some of the accessor and replacement functions

for the "genambig" class. You can see a full list of them by typing:

> ?Samples

(Present and Absent are just for the "genbinary" class. More on that
later.) Let’s use some of these functions to (cid:28)ll in and examine the dataset.

> Loci(mydataset)

[1] "loc1" "loc2" "loc3"

> Loci(mydataset) <- c("L1", "L2", "L3")
> Loci(mydataset)

23

[1] "L1" "L2" "L3"

> Samples(mydataset)

[1] "indA" "indB" "indC" "indD" "indE" "indF"

> Samples(mydataset)[3] <- "indC1"
> Samples(mydataset)

[1] "indA" "indB"

"indC1" "indD"

"indE"

"indF"

> PopNames(mydataset) <- c("Yosemite", "Sequoia")
> PopInfo(mydataset) <- c(1,1,1,2,2,2)
> PopInfo(mydataset)

indA
1

indB indC1
1

1

indD
2

indE
2

indF
2

> PopNum(mydataset, "Yosemite")

[1] 1

> PopNum(mydataset, "Sequoia") <- 3
> PopNames(mydataset)

[1] "Yosemite" NA

"Sequoia"

> PopInfo(mydataset)

indA
1

indB indC1
1

1

indD
3

indE
3

indF
3

> Ploidies(mydataset) <- c(4,4,4,4,4,6)
> Ploidies(mydataset)

L1 L2 L3
4
4
4
4
4
4
4
4
4
4
6
6

4
4
4
4
4
6

indA
indB
indC1
indD
indE
indF

24

> Ploidies(mydataset)["indC1",] <- 6
> Ploidies(mydataset)

L1 L2 L3
4
4
4
4
6
6
4
4
4
4
6
6

4
4
6
4
4
6

indA
indB
indC1
indD
indE
indF

> Usatnts(mydataset) <- c(2,2,2)
> Usatnts(mydataset)

L1 L2 L3
2
2

2

> Description(mydataset) <- "Tutorial, part 2."
> Description(mydataset)

[1] "Tutorial, part 2."

> Genotypes(mydataset, loci="L1") <- list(c(122, 124, 128), c(124,126),
+
+
> Genotype(mydataset, "indB", "L3") <- c(150, 154, 160)
> Genotypes(mydataset)

c(120,126,128,130), c(122,124,130), c(128,130,132),
c(126,130))

L2 L3
L1
numeric,3 -9 -9
numeric,2 -9 numeric,3

indA
indB
indC1 numeric,4 -9 -9
numeric,3 -9 -9
indD
numeric,3 -9 -9
indE
numeric,2 -9 -9
indF

> Genotype(mydataset, "indD", "L1")

[1] 122 124 130

25

> Missing(mydataset)

[1] -9

> Missing(mydataset) <- -1
> Genotypes(mydataset)

L2 L3
L1
numeric,3 -1 -1
numeric,2 -1 numeric,3

indA
indB
indC1 numeric,4 -1 -1
numeric,3 -1 -1
indD
numeric,3 -1 -1
indE
numeric,2 -1 -1
indF

If you know a little bit more about S4 classes, you know that you can

access the slots directly using the @ symbol, for example:

> mydataset@Genotypes

L1
L2 L3
numeric,3 -1 -1
numeric,2 -1 numeric,3

indA
indB
indC1 numeric,4 -1 -1
numeric,3 -1 -1
indD
numeric,3 -1 -1
indE
numeric,2 -1 -1
indF

> mydataset@Genotypes[["indB","L1"]]

[1] 124 126

However, I STRONGLY recommend against accessing the slots in this
way in order to replace (edit) the data. The replacement functions are de-
signed to prevent multiple types of errors that could happen if the user edited
the slots directly.

In section 4.1 you were introduced to the find.missing.gen function.
There is a related function called isMissing that may be more useful from
a programming standpoint.

26

> isMissing(mydataset, "indA", "L2")

[1] TRUE

> isMissing(mydataset, "indA", "L1")

[1] FALSE

> isMissing(mydataset)

L1

L3
L2
FALSE TRUE
TRUE
FALSE TRUE FALSE
TRUE
TRUE
TRUE
TRUE

indA
indB
indC1 FALSE TRUE
FALSE TRUE
indD
FALSE TRUE
indE
FALSE TRUE
indF

To add more samples or loci to your dataset, you can create a second

"genambig" object and then use the merge function to join them.

> moredata <- new("genambig", samples=c("indG", "indH"), loci=Loci(mydataset))
> Usatnts(moredata) <- Usatnts(mydataset)
> Description(moredata) <- Description(mydataset)
> PopNames(moredata) <- "Kings Canyon"
> PopInfo(moredata) <- c(1,1)
> Ploidies(moredata) <- c(4,4)
> Missing(moredata) <- Missing(mydataset)
> Genotypes(moredata, loci="L1") <- list(c(126,130,136,138), c(124,126,128))
> mydataset2 <- merge(mydataset, moredata)
> mydataset2

Tutorial, part 2.
Missing values: -1

Genotypes:

L1
122/124/128

indA

L2 L3
-1 -1

27

-1 150/154/160

124/126

indB
indC1 120/126/128/130 -1 -1
-1 -1
indD
122/124/130
-1 -1
indE
128/130/132
126/130
indF
-1 -1
126/130/136/138 -1 -1
indG
-1 -1
124/126/128
indH

SSR motif lengths:
L1 L2 L3
2
2

2

Ploidies:

L1 L2 L3
4
4
4
4
6
6
4
4
4
4
6
6
4
4
4
4

4
4
6
4
4
6
4
4

indA
indB
indC1
indD
indE
indF
indG
indH

PopNames:
[1] "Yosemite"
[4] "Kings Canyon"

NA

PopInfo:

"Sequoia"

indA
1

indB indC1
1

1

indD
3

indE
3

indF
3

indG
4

indH
4

5.2 How ploidy data is stored: (cid:16)ploidysuper(cid:17) and sub-

classes

You may have noticed that in the above example, ploidy information was
stored in a matrix, whereas in section 4.1 it was stored in a vector following

28

the use of the estimatePloidy function.
In fact, ploidy can be stored in
four formats: a single value if the entire dataset has uniform ploidy, a vector
indexed by sample if ploidy varies by sample, a vector indexed by locus if
ploidy varies by locus (e.g. if the species is polyploid undergoing diploidiza-
tion), or a matrix indexed by sample and locus (e.g if some of your loci are
on sex chromosomes, or if some individuals are aneuploid). The object in the
Ploidies slot of the dataset is one of four subclasses of the "ploidysuper"
class (see table below), and this in turn has a slot called pld that contains
the ploidy data. To make things simple from the user’s perspective, the
Ploidies accessor and replacement functions interact directly with this pld
slot.

Class

ploidyone

ploidysample

ploidylocus

ploidymatrix

indexed

Format
unnamed vector
of length one
vector
by sample
vector
by locus
matrix indexed
by sample, then
locus

indexed

Use
uniform ploidy for entire
dataset

samples vary in ploidy

loci vary in copy number

di(cid:27)erent samples have dif-
ferent numbers of copies of
di(cid:27)erent loci

Note that most analyses that use ploidy information assume completely ran-
dom segregation of alleles. If you are going to specify ploidy as varying by
locus, make sure that random segregation is actually the case for all loci.
(See sections on working with autopolyploid vs. allopolyploid data.) For
example, if a locus is present on two homeologous chromosome pairs, you
may record the ploidy for that locus as being four. However, since these
chromosomes do not pair with each other at meiosis, many of the analyses
in polysat that utilize ploidy do not apply.

Many of the data import functions for polysat will detect the ploidies
of genotypes and automatically create a "genambig" object with the sim-
plest ploidy format possible. Additionally, when the estimatePloidies
function is used, ploidy is automatically changed to being indexed by sam-
ple. However, the user may also want to manually switch formats, and the
reformatPloidies function exists for this purpose.

> ploidyexample <- new("genambig")

29

> Samples(ploidyexample)

[1] "ind1" "ind2"

> Loci(ploidyexample)

[1] "loc1" "loc2"

> Ploidies(ploidyexample)

loc1 loc2
NA
NA

NA
NA

ind1
ind2

> ploidyexample <- reformatPloidies(ploidyexample, output="locus")
> Ploidies(ploidyexample)

loc1 loc2
NA

NA

> ploidyexample <- reformatPloidies(ploidyexample, output="sample")
> Ploidies(ploidyexample)

ind1 ind2
NA

NA

> ploidyexample <- reformatPloidies(ploidyexample, output="one")
> Ploidies(ploidyexample)

[1] NA

> Ploidies(ploidyexample) <- 4
> ploidyexample <- reformatPloidies(ploidyexample, output="matrix")
> Ploidies(ploidyexample)

loc1 loc2
4
4

4
4

ind1
ind2

30

See ?reformatPloidies for more information on how to change formats

when there is already data in the Ploidies slot.

Ploidy may be indexed using square brackets, like normal vectors and

matrices:

> Ploidies(ploidyexample)["ind1", "loc1"]

[1] 4

However, for programming purposes, ploidy can also be indexed by pass-
ing samples and loci arguments to the Ploidies accessor function. This
allows new functions to be robust to the ploidy format that is being used.

> Ploidies(ploidyexample, "ind1", "loc1")

loc1
4

ind1

> ploidyexample <- reformatPloidies(ploidyexample, output="one")
> Ploidies(ploidyexample, "ind1", "loc1")

[1] 4

5.3 The (cid:16)gendata(cid:17) and (cid:16)genbinary(cid:17) classes

The "genambig" class is actually a subclass of another class called "gendata".
The Description, PopInfo, PopNames, Ploidies, Missing, and Usatnts
slots, and their access and replacement methods, are all de(cid:28)ned for "gendata",
and are inherited by "genambig". The "genambig" class adds the Genotypes
slot and the methods for interacting with it.

A second subclass of "gendata" is "genbinary". This class also has a
Genotypes slot, but formatted as a matrix indicating the presence and ab-
sence of alleles. (See ?genbinary-class for more details.) It also adds a
slot called Present and one called Absent to indicate the symbols used to
represent the presence or absence of the alleles, the same way the Missing
slot holds the symbol used to indicate missing data. Like "genambig",
"genbinary" inherits all of the slots from "gendata", as well as the methods
for accessing them.

The code below creates a "genbinary" object using a conversion function,
then demonstrates how the genotypes are stored di(cid:27)erently and how the
functions from "gendata" remain the same.

31

> simgenB <- genambig.to.genbinary(simgen)
> Genotypes(simgenB, samples=paste("A", 1:20, sep=""), loci="loc1")

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
1
1
0
1
0
0
0
0
1
0
0
1
1
1
0
0
0
1

0
0
1
1
0
0
0
1
0
1
0
0
0
0
0
1
1
1
1
0

0
0
0
0
0
0
1
0
0
0
0
0
0
0
0
0
0
0
0
1

loc1.100 loc1.102 loc1.104 loc1.106 loc1.108 loc1.110
1
1
0
1
0
1
0
0
0
1
0
0
1
0
0
0
0
0
1
0

1
1
1
1
1
1
0
1
0
1
0
1
0
1
0
0
1
1
0
1
loc1.112 loc1.114 loc1.116 loc1.118
0
1
0
0
0
0
0
0
0
0
0
1

0
1
1
0
0
0
0
0
0
0
1
0

1
0
0
0
1
0
1
0
1
1
1
0

0
0
0
0
0
0
0
0
0
0
0
0

A1
A2
A3
A4
A5
A6
A7
A8
A9
A10
A11
A12
A13
A14
A15
A16
A17
A18
A19
A20

A1
A2
A3
A4
A5
A6
A7
A8
A9
A10
A11
A12

32

A13
A14
A15
A16
A17
A18
A19
A20

1
1
1
1
0
0
0
0

0
0
1
0
0
0
1
0

0
0
0
0
0
0
0
0

0
0
0
0
0
0
1
0

> PopInfo(simgenB)[Samples(simgenB, ploidies=2)]

A5
1
A27
1
A54
1
A77
1
B4
2
B30
2
B58
2
B82
2
C3
3
C23
3
C46
3
C74
3
C90
3

A7
1
A30
1
A55
1
A78
1
B7
2
B32
2
B59
2
B84
2
C4
3
C25
3
C47
3
C75
3
C92
3

A8
1
A31
1
A56
1
A80
1
B8
2
B34
2
B61
2
B85
2
C6
3
C27
3
C48
3
C76
3
C93
3

A9
1
A32
1
A58
1
A84
1
B9
2
B35
2
B62
2
B86
2
C7
3
C28
3
C50
3
C77
3
C95
3

A12
1
A35
1
A59
1
A87
1
B13
2
B36
2
B64
2
B89
2

A13
1
A40
1
A65
1
A88
1
B14
2
B39
2
B65
2
B93
2
C8 C10
3
C32
3
C57
3
C80
3
C98
3

3
C31
3
C56
3
C79
3
C96
3

A17
1
A44
1
A67
1
A91
1
B15
2
B41
2
B68
2
B94
2
C11
3
C36
3
C59
3
C82
3

33

2

1

1

A18
1

1
B16
2

A21
1
A45 A47
1
A71 A72
1
A93 A95
1
B17
2
B49 B50
2
B72 B73
2
B96 B97
2
C16
3
C37 C38
3
C61 C64
3
C83 C84
3

2
C14
3

3

3

3

2

A22
1
A50
1
A73
1

A23
1
A52
1
A74
1
A96 A100
1
B25
2
B54
2
B77
2
B99
2
C20
3
C40
3
C68
3
C86
3

1
B20
2
B52
2
B74
2
B98
2
C17
3
C39
3
C67
3
C85
3

A25
1
A53
1
A75
1
B1
2
B27
2
B57
2
B80
2
C1
3
C21
3
C44
3
C71
3
C87
3

The "genbinary" class exists to facilitate the import and export of geno-

type data formatted in a binary presence/absence format, for example:

> write.table(Genotypes(simgenB), file="simBinaryData.txt")

The "genbinary" class is also used by polysat to make some of the allele
frequency calculations easier. simpleFreq internally converts a "genambig"
object to a "genbinary" object in order to tally allele counts in populations.
The class system in polysat is set up so that anyone can extend it
to better suit their needs. There seem to be as many ways of formatting
genotype data as their are population genetic software, and so a new subclass
of "gendata" could be created with genotypes formatted in a di(cid:27)erent way.
A user could also create a subclass of "genambig", for example to hold GPS
or phenotypic data in addition to the data already stored in a "genambig"
object. (See ?setClass, ?setMethod, and [2].)

6 Functions for autopolyploid data

In order to properly utilize polysat (and other software for polyploid data)
it is important to understand the inheritance mode in your system.
In
an autopolyploid (excluding ancient autopolyploids that have undergone
diploidization), all homologous chromosomes are equally capable of pairing
with each other at meiosis, and thus at a given microsatellite locus, gametes
can receive any combination of alleles from the parent. The same is not true
of allopolyploids. This a(cid:27)ects the distribution of genotypes in the population,
and as a result a(cid:27)ects all aspects of population genetic analysis.

The functions described below are speci(cid:28)cally for autopolyploid data.
Their potential (or lack thereof) for use on allopolyploid data is described
in the next section. If you have data from an allopolyploid or diploidized
autopolyploid organism, you may also want to see the vignette (cid:16)Assigning
alleles to isoloci in polysat(cid:17).

6.1 Data import

Four other population genetic programs that I am aware of can handle poly-
ploid microsatellite data with allele copy number ambiguity under polysomic
inheritance (autopolyploidy): Structure [5, 4, 17, 8], SPAGeDi [7], GenoDive

34

[14] (http://www.bentleydrummer.nl/software/software/GenoDive.html),
and POPDIST [6][21].

In the (cid:16)extdata(cid:17) directory of the polysat installation there are (cid:28)les called
(cid:16)structureExample.txt(cid:17), (cid:16)spagediExample.txt(cid:17), (cid:16)genodiveExample.txt(cid:17), (cid:16)POPDIS-
Texample1.txt(cid:17) and (cid:16)POPDISTexample2.txt(cid:17). To import these into "genambig"
objects, (cid:28)rst copy them into your working directory, then perform the assign-
ments:

> GDdata <- read.GenoDive("genodiveExample.txt")
> Structdata <- read.Structure("structureExample.txt", ploidy = 8)
> Spagdata <- read.SPAGeDi("spagediExample.txt")
> PDdata <- read.POPDIST(c("POPDISTexample1.txt", "POPDISTexample2.txt"))

Use summary, viewGenotypes, and the accessor functions (section 5.1)
to examine the contents of the three "genambig" objects that you have just
created. All four of these import functions take population information from
the (cid:28)le and put it into the object. The Structure, SPAGeDi, and POPDIST
(cid:28)les are coded in a way that indicates the ploidy of each individual, so this
information is written to the "genambig" object as well.

The data import functions have some additional options for input and
output, which are described in more detail in the help (cid:28)les. In particular,
any extra columns can optionally be extracted from a Structure (cid:28)le, and the
spatial coordinates can optionally be extracted from a SPAGeDi (cid:28)le. There
are also several options for how ploidy should be interpreted from Structure
(cid:28)les.

> ?read.Structure
> ?read.SPAGeDi

polysat also supports three genotype formats that work for either au-
topolyploids or allopolyploids, but do not contain any population, ploidy,
or other information: GeneMapper, STRand, and binary presence/absence.
The tutorial in the beginning of this manual uses read.GeneMapper to import
data. The (cid:16)GenaMapperExample.txt(cid:17) (cid:28)le contains the minimum amount
of information needed in order to be read by the function. Full (cid:16)Geno-
types Table(cid:17) (cid:28)les as exported from ABI GeneMapperﬁcan also be read by
read.GeneMapper, and further, the function can take a vector of (cid:28)le names
rather than a single (cid:28)le name if the data are spread across multiple (cid:28)les.

35

There are three additional GeneMapper example (cid:28)les in the (cid:16)doc(cid:17) directory,
which can be read into a "genambig" object in this way:

> GMdata <- read.GeneMapper(c("GeneMapperCBA15.txt",
"GeneMapperCBA23.txt",
+
"GeneMapperCBA28.txt"))
+

read.STRand takes a slightly modi(cid:28)ed version of the BTH format output
by the allele-calling software STRand [22]. Since this format uses one row per
individual, the modi(cid:28)ed format for polysat includes a column to contain
population information.

> # view the format
> read.table("STRandExample.txt", sep="\t", header=TRUE)

Pop Ind

1 NC1
2 NC1
3 NC1
4 VA1
5 VA1
6 VA1
7 VA1

140/154 107/136/145/158*

GSSR76
135/144/158*

GSSR90
GSSR28
a 134/140/154*
201/211
b 140/154/172* 106/135/144/158* 205/211/213*
c
199/207
0
145/149 199/207/211*
a
154
201/207
106/145
b
107/136/149* 207/211/213*
c
138/172
207/213
d 138/140/154*

135/158

> # import the data
> STRdata <- read.STRand("STRandExample.txt")
> Samples(STRdata)

[1] "NC1a" "NC1b" "NC1c" "VA1a" "VA1b" "VA1c" "VA1d"

> PopNames(STRdata)

[1] "NC1" "VA1"

A binary presence/absence matrix can be read into R using the base
function read.table. Arguments to this function give options about how
the (cid:28)le is delimited and whether it has headers and/or row labels. The
example (cid:28)le in the (cid:16)extdata(cid:17) directory can be read in the following way:

36

> domdata <- read.table("dominantExample.txt", header=TRUE,
+

sep="\t", row.names=1)

Examine the data frame produced, and notice in particular that the col-
umn names are formatted as the locus and allele separated by a period.
After this data frame is converted to a matrix, it can be used to create a
"genbinary" object.

> domdata

0
1
0

1
0
0

ABC1.123 ABC1.126 ABC1.129 ABC1.132 ABC1.135 ABC2.201
0
1
0

0
0
0
ABC2.203 ABC2.205 ABC2.207 ABC2.209
0
0
1

0
1
0

1
1
0

1
1
0

1
1
1

0
1
0

ind1
ind2
ind3

ind1
ind2
ind3

> domdata <- as.matrix(domdata)
> PAdata <- new("genbinary", samples=c("ind1", "ind2", "ind3"),
+
> Genotypes(PAdata) <- domdata

loci=c("ABC1", "ABC2"))

A few functions in polysat will work directly on a "genbinary" object,
but for most functions you will want to convert to a "genambig" object.
Addition of population and other information can be done either before or
after the conversion.

> PopInfo(PAdata) <- c(1,1,2)
> PAdata <- genbinary.to.genambig(PAdata)

6.2 Data export

Autopolyploid data can also be exported in the same formats that are avail-
able for import, except STRand. Additionally, data can be exported to the R
package adegenet’s (cid:16)genind(cid:17) presence/absence format (see ?gendata.to.genind).

37

The write.Structure function requires that an overall ploidy for the
(cid:28)le be speci(cid:28)ed, to indicate how many rows per individual to write. Indi-
viduals with higher ploidy than the overall ploidy will have alleles randomly
removed, and individuals with lower ploidy will have the missing data symbol
inserted in the extra rows. Additional arguments give the options to specify
extra columns to include, to omit or include population information, and to
specify the missing data symbol. The row of missing data symbols that is au-
tomatically written underneath marker names is the RECESSIVEALLELES
row in Structure, indicating that allele copy number is ambiguous.

write.Structure was used in the tutorial in section 4.2.4, but below is
another example with some of the options changed (see ?write.Structure
for more information). Here, myexcol is an array of data to be written into
extra columns in the (cid:28)le.

> myexcol <- array(c(rep(0:1, each=150), seq(0.1, 30, by=0.1)), dim=c(300,2),
+
> myexcol[1:10,]

dimnames = list(Samples(simgen), c("PopFlag", "Something")))

PopFlag Something
0.1
0.2
0.3
0.4
0.5
0.6
0.7
0.8
0.9
1.0

0
0
0
0
0
0
0
0
0
0

A1
A2
A3
A4
A5
A6
A7
A8
A9
A10

> write.Structure(simgen, ploidy=4, file="simgenStruct2.txt",
+
+

writepopinfo = FALSE, extracols = myexcol,
missingout = -1)

The write.GenoDive function is fairly straightforward, with the only
option being whether to code alleles as two or three digits. All alleles are
converted to repeat number, using the information contained in the Usatnts
slot of the "genambig" object.

38

> write.GenoDive(simgen, file="simgenGD.txt")

write.SPAGeDi has options for the number of digits used to code alleles
as well as the character (or lack thereof) used to separate alleles. Alleles are
converted to repeat numbers as in write.GenoDive. Additionally, a data
frame of spatial coordinates can be supplied to the function to be written to
the (cid:28)le. By default, the function will create two dummy columns for spatial
coordinates, which the user can then (cid:28)ll in using a text editor or spreadsheet
software. (See ?write.SPAGeDi)

> write.SPAGeDi(simgen, file="simgenSpag.txt")

If you are using SPAGeDi to calculate relationship and kinship coe(cid:30)-
cients, also see the function write.freq.SPAGeDi for exporting allele fre-
quencies from polysat to SPAGeDi for use in these calculations.

The write.POPDIST function does not have any options for formatting.
In the example below, the samples argument is used to ensure that each
population has uniform ploidy, which is a requirement of the POPDIST soft-
ware.

> write.POPDIST(simgen, samples = Samples(simgen, ploidies=4),
+

file = "simgenPOPDIST.txt")

write.GeneMapper is very straightforward, without any special format-
ting options. This function was used to create the (cid:16)GeneMapperExample.txt(cid:17)
(cid:28)le that is provided with the package. I do not know of any other software
that will read the GeneMapper format, but it may be a convenient way for
the user to store and edit genotypes.

> write.GeneMapper(simgen, file="simgenGM.txt")

To export a table of genotypes in binary presence/absence format, (cid:28)rst
convert the "genambig" object to a "genbinary" object, then write the
Genotypes slot to a text (cid:28)le, adjusting the options of write.table to suit
your needs. (See ?write.table.)

> simgenPA <- genambig.to.genbinary(simgen)
> write.table(Genotypes(simgenPA), file="simgenPA.txt", quote=FALSE,
+

sep = ",")

39

6.3

Individual-level statistics

6.3.1 Estimating and exporting ploidies

The estimatePloidy function, which was demonstrated in section 4.1, is
equally appropriate for autopolyploid and allopolyploid data. If you want to
export the ploidy data, one method is the following:

> write.table(data.frame(Ploidies(simgen), row.names=Samples(simgen)),
+

file="simgenPloidies.txt")

6.3.2

Inter-individual distances

A matrix of pairwise distances between individuals can be generated us-
ing the meandistance.matrix function, which was demonstrated in sec-
tion 4.2.1. The most important argument is distmetric, or the distance
measure that is used. The three options that are provided with polysat
are Bruvo.distance and Bruvo2.distance, which take mutational distance
between alleles into account [1], and Lynch.distance, which is a simple
band-sharing measure [12]. (The user can create functions to serve as addi-
tional distance measures, as long as the arguments are the same as those for
Bruvo.distance and Lynch.distance.) The progress argument can be set
to TRUE or FALSE to indicate whether the progress of the computation should
be printed to the screen. The all.distances argument can also be set to
TRUE or FALSE to indicate whether, in addition to the mean distance matrix,
a three-dimensional array of distances by locus should be returned. There is
also a maxl argument to indicate the threshold for Bruvo.distance to skip
calculations that are too computationally intensive (see ?Bruvo.distance).
The function Bruvo2.distance has two additional arguments called add and
loss, which when set to TRUE indicate that the models of genome addition
and/or genome loss should be used, respectively.

A second means of calculating inter-individual distances was introduced in

polysat 1.2 and is called meandistance.matrix2. Whereas meandistance.matrix
passes genotypes directly to distmetric with each allele present in only one
copy, meandistance.matrix2 uses ploidy, sel(cid:28)ng rate, and allele frequen-
cies to calculate the probabilities that a given ambiguous genotype repre-
sents any possible unambiguous genotype. Unambiguous genotypes are then
passed to distmetric. The distance is a weighted average across all possible
combinations of unambiguous genotypes. There is no advantage to using

40

Lynch.distance with this function, but it may give improved results for
Bruvo.distance, Bruvo2.distance, or a user-de(cid:28)ned distance measure.

> testmat4 <- meandistance.matrix2(simgen, samples=samToUse, freq=simfreq,
+

self=0.2)

> pca4 <- cmdscale(testmat4)
> plot(pca4[,1], pca4[,2], col=c("red", "blue")[PopInfo(simgen)[samToUse]],
+

main="Bruvo distance with meandistance.matrix2")

Besides the cmdscale function for performing Principal Coordinate Anal-
ysis on the resulting matrix, you may want to create a histogram to view the
distribution of distances, or you may want to export the distance matrix for
use in other software.

> hist(as.vector(testmat))

41

−0.4−0.20.00.20.4−0.3−0.2−0.10.00.10.20.3Bruvo distance with meandistance.matrix2pca4[, 1]pca4[, 2]> hist(as.vector(testmat2))

42

Histogram of as.vector(testmat)as.vector(testmat)Frequency0.00.20.40.60.81.00200040006000800012000> write.table(testmat2, file="simgenDistMat.txt")

meandist.from.array can take a three-dimensional array such as that
produced when all.distances=TRUE and recalculate a mean distance matrix
from it. This could be useful, for example, if you want to try omitting loci
from your analysis. If Bruvo.distance skips some calculations because maxl
is exceeded, you may also want to estimate these distances and (cid:28)ll them into
the array manually, then recalculate the mean distance matrix. See the help
(cid:28)le for meandist.from.array for some additional functions that can help to
locate missing values in the three-dimensional distance array.

The following example (cid:28)rst creates a vector indicating the subset of sam-
ples to use, both to save on computation time for the example and because
missing data can be a problem for Principal Coordinate Analysis if fewer
than three loci are used. An array of distances is then calculated, followed
by the mean distance matrix for each combination of two loci.

43

Histogram of as.vector(testmat2)as.vector(testmat2)Frequency0.00.20.40.60.81.0020004000600080001000014000> subsamples <- Samples(simgen, populations=1)
> subsamples <- subsamples[!isMissing(simgen, subsamples, "loc1") &
!isMissing(simgen, subsamples, "loc2") &
+
!isMissing(simgen, subsamples, "loc3")]
+
> Larray <- meandistance.matrix(simgen, samples=subsamples,
+
+
> mdist1.2 <- meandist.from.array(Larray, loci=c("loc1","loc2"))
> mdist2.3 <- meandist.from.array(Larray, loci=c("loc2","loc3"))
> mdist1.3 <- meandist.from.array(Larray, loci=c("loc1","loc3"))

progress=FALSE,

distmetric=Lynch.distance, all.distances=TRUE)[[1]]

As before, you can use cmdscale to perform Principal Coordinate Anal-
ysis and plot to visualize the results. Di(cid:27)erences between plots re(cid:29)ect the
e(cid:27)ects of excluding loci.

6.3.3 Determining groups of asexually-related samples

Very similarly to the software GenoType [14], polysat can use a matrix
of inter-individual distances to assign samples to groups of asexually-related
individuals. This analysis can be performed on any matrix of distances calcu-
lated with meandistance.matrix, meandistance.matrix2, or a user-de(cid:28)ned
function that produces matrices in the same format. As in GenoType, a
histogram such as those produced above may be useful for determining a
distance threshold for distinguishing sexually- and asexually-related pairs of
individuals. The data in simgen were simulated in a sexually-reproducing
population, but let’s pretend for the moment that there was some asexual
reproduction, and we saw a bimodal distribution of distances with a cuto(cid:27)
of 0.2 between modes.

> clones <- assignClones(testmat, samples=paste("A", 1:100, sep=""),
+
> clones

threshold=0.2)

A1
1
A13
13
A25

A2
2
A14
14
A26

A3
3
A15
15
A27

A4
4
A16
16
A28

A5
5
A17
17
A29

A6
6
A18
18
A30

A7
7
A19
19
A31

44

A8
8

A9
9
A20 A21
21
A32 A33

20

A10
10
A22
22
A34

A11
11
A23
23
A35

A12
12
A24
24
A36

25
A37
36
A49
44
A61
52
A73
61
A85
70
A97
78

26
A38
37
A50
45
A62
53
A74
22
A86
36
A98
37

27
A39
38
A51
46
A63
36
A75
62
A87
71

28
A40
39
A52
47
A64
54
A76
63
A88
72
A99 A100
80

79

15
A41
40
A53
48
A65
55
A77
64
A89
35

29
A42
37
A54
49
A66
56
A78
65
A90
24

30
A43
36
A55
27
A67
31
A79
66
A91
73

7

50

31

32
A44 A45
21
A56 A57
14
A68 A69
58
A80 A81
68
A92 A93
74

67

26

57

33
A46
41
A58
51
A70
59
A82
69
A94
75

34
A47
42
A59
17
A71
60
A83
3
A95
76

35
A48
43
A60
28
A72
22
A84
55
A96
77

Some of the individuals with similar genotypes have been assigned to the

same clonal group.

Diversity statistics based on genotype frequencies are also available; see

section 6.4.2.

6.4 Population statistics

6.4.1 Allele diversity and frequencies

Allele diversity, i.e.
calculated in polysat.

the number of alleles found at each locus, is easily

> simal <- alleleDiversity(simgen)
> simal$counts

PopA
PopB
PopC
overall

loc1 loc2 loc3
7
6
8
11

8
7
9
10

6
5
6
8

> simal$alleles[["PopA","loc1"]]

[1] 100 102 106 108 110 112 114 118

45

There are two functions in polysat for estimating allele frequencies. If
all of your individuals are the same, even-numbered ploidy and if you have
a reasonable estimate of the sel(cid:28)ng rate in your system, deSilvaFreq will
give the most accurate estimate. For mixed ploidy systems, the simpleFreq
function is available, but will be biased toward underestimating common al-
lele frequencies and overestimating rare allele frequencies, which will cause
an underestimation of FST . deSilvaFreq uses an iterative algorithm to esti-
mate genotype frequencies based on allele frequencies and (cid:16)allelic phenotype(cid:17)
frequencies, then recalculate allele frequencies from genotype frequencies [3].
simpleFreq simply assumes that in a partially heterozygous genotype, all
alleles have an equal chance of being present in more than one copy.

Both allele frequency estimators take as the (cid:28)rst argument a "genambig"
or "genbinary" object, which must have the PopInfo and Ploidies slots
(cid:28)lled in. The self argument for supplying the sel(cid:28)ng rate is only applicable
for deSilvaFreq. (See ?deSilvaFreq for some other arguments that can be
adjusted.) Both functions produce a data frame of allele frequencies, with
populations in rows and alleles in columns. deSilvaFreq adds a null allele
for each locus, while simpleFreq does not. In both cases the data frame will
also have a column indicating the population size in number of genomes (e.g.
four hexaploid individuals = 24 genomes).

The function calcPopDiff takes the data frame produced by either allele
frequency estimation, and produces a matrix containing pairwise FST values
according to the original calculation by Wright [15]. Population sizes are
weighted by number of genomes, rather than number of individuals.

Continuing the example from section 4.2.3, and comparing the results of

deSilvaFreq and simpleFreq:

> simFst

PopA

PopC
PopA 0.00000000 0.05068795 0.05453103
PopB 0.05068795 0.00000000 0.07098261
PopC 0.05453103 0.07098261 0.00000000

PopB

> simfreqSimple <- simpleFreq(simgen, samples = Samples(simgen, ploidies=4))
> simFstSimple <- calcPopDiff(simfreqSimple, metric = "Fst")
> simFstSimple

46

PopC
PopB
PopA
5.088305e-02
PopA 0.00000000 0.04738346
PopB 0.04738346 0.00000000
6.492718e-02
PopC 0.05088305 0.06492718 -1.323838e-16

Average allele frequencies can also be used by SPAGeDi for the calculation
of relationship and kinship coe(cid:30)cients. SPAGeDi v1.3 can estimate allele
frequencies using the same method as simpleFreq. However, if your data
are appropriate for allele frequency estimation using deSilvaFreq, exporting
the estimated allele frequencies to SPAGeDi should improve the accuracy of
the relationship and kinship calculations. The write.freq.SPAGeDi function
creates a (cid:28)le of allele frequencies in the format that is read by SPAGeDi.

> write.freq.SPAGeDi(simfreq, usatnts=Usatnts(simgen), file="SPAGfreq.txt")

The R package adegenet[10] can perform a number of calculations from
allele frequencies, including (cid:28)ve inter-population distance measures as well as
Correspondance Analysis. The allele frequency tables produced by polysat
can be converted to a format that can be read by adegenet.

> gpsimfreq <- freq.to.genpop(simfreq)

The object gpsimfreq that you just created can now be passed to the
function genpop as the tab argument. See ?freq.to.genpop for example
code.

6.4.2 Genotype frequencies

For asexual organisms, you many want to calculate statistics based on the
frequencies of genotypes in your populations. Two popular statistics for
this, the Shannon index [18] and Simpson index [19], are provided with
polysat. The function genotypeDiversity calculates either of these statis-
tics or any user-de(cid:28)ned statistic that can be calculated from a vector of
counts. genotypeDiversity uses the function assignClones internally, so
the same threshold argument may be set to allow for mutation or scoring
error, or to group individuals by a larger distance threshold. This function
examines loci individiually as well as the mean distance across all loci. Where
ordinary allelic diversity statistics are not available due to allele copy number
ambiguity, genotype diversity statistics for individual loci may be useful.

47

> testmat5 <- meandistance.matrix(simgen, all.distances=TRUE)

> simdiv <- genotypeDiversity(simgen, d=testmat5, threshold=0.2, index=Shannon)
> simdiv

loc1

overall
loc2
PopA 3.304798 2.654090 3.379927 4.303583
PopB 3.269491 2.582981 2.913112 4.002176
PopC 3.373131 3.009567 3.415639 4.521993

loc3

> simdiv2 <- genotypeDiversity(simgen, d=testmat5, threshold=0.2, index=Simpson)
> simdiv2

loc1

overall
loc2
PopA 0.03737374 0.08303030 0.03360132 0.005050505
PopB 0.03702924 0.08884766 0.05696970 0.020000000
PopC 0.03272727 0.05373737 0.03112760 0.001212121

loc3

The variance of the Simpson index may also be calculated, enabling the

calculation of upper and lower bounds for a 95% con(cid:28)dence interval.

> simdiv2var <- genotypeDiversity(simgen, d=testmat5, threshold=0.2,
+
> simdiv2 - 2*simdiv2var^0.5

index=Simpson.var)

loc1

overall
loc3
0.0004028381
PopA 0.02438289 0.05915117 0.02113944
0.0049848529
PopB 0.02295020 0.06115142 0.04216782
PopC 0.02133522 0.03403932 0.02007475 -0.0020469696

loc2

> simdiv2 + 2*simdiv2var^0.5

loc1

overall
loc2
PopA 0.05036458 0.10690944 0.04606320 0.009698172
PopB 0.05110829 0.11654391 0.07177158 0.035015147
PopC 0.04411932 0.07343543 0.04218045 0.004471212

loc3

48

7 Functions for allopolyploid data

In order to properly analyze microsatellites as codominant markers in al-
lopolyploids, knowledge is required about which alleles belong to which genome.
In an autopolyploid, all alleles for a given marker will segregate according
to Mendelian laws. In an allopolyploid, a microsatellite marker represents
two or more loci that are behaving in a Mendelian fashion, but if treated as
one locus will not appear to behave according to random segregation. For
example, an autotetraploid with the genotype ABCD that self fertilizes can
produce o(cid:27)spring with the genotype AABB. An allotetraploid with the same
four alleles, but distributed as AB and CD across two genomes, cannot self to
produce an AABB individual as both of these alleles come from one genome.
If you have knowledge from other analyses about which alleles belong to
which genomes, when importing your data you can code each microsatellite
marker as multiple loci. As long as each (cid:16)locus(cid:17) in the "genambig" object is
behaving according to random segregation, the analysis and export functions
for autopolyploid data described in the previous section are appropriate.
See the separate vignette (cid:16)Assigning alleles to isoloci in polysat(cid:17) to
learn more about how to determine which alleles belong to which genomes.
The functions processDatasetAllo and recodeAllopoly can, respectively,
assign alleles to isoloci and recode the dataset so that each marker is split
into multiple isoloci according to allele assignments.

If you are not able split microsatellite markers into independently-segregating

isoloci, the following functionality is available for allopolyploids in polysat:

7.1 Data import and export

Data can be formatted for the software Tetrasat [13], Tetra [11], and ATetra
[23] using polysat. These programs are intended to be robust to lack of
knowledge of inheritance patterns of alleles in allotetraploids and will esti-
mate allele frequencies and other statistics. See the help (cid:28)les for write.Tetrasat
and write.ATetra.

read.Tetrasat (which produces a format readable by both Tetrasat and
Tetra) and read.ATetra both take, as their only argument, the (cid:28)le name to
be read. To import data from the example (cid:28)les (cid:16)ATetraExample.txt(cid:17) and
(cid:16)tetrasatExample.txt(cid:17), use the commands:

> ATdata <- read.ATetra("ATetraExample.txt")

49

> Tetdata <- read.Tetrasat("tetrasatExample.txt")

The functions for writing these two (cid:28)le formats only require a "genambig"
object and a (cid:28)le name. Ploidies and PopInfo are required in the object
for both functions. write.Tetrasat additionally requires information in
the Usatnts slot. Since ATetra does not allow missing data, any missing
genotypes that are encountered by write.ATetra are written to the console.

> write.ATetra(simgen, samples=Samples(simgen, ploidies=4), file="simgenAT.txt")

Missing data: B48 loc2
Missing data: A42 loc3
Missing data: C22 loc3

> write.Tetrasat(simgen, samples=Samples(simgen, ploidies=4),
+

file="simgenTet.txt")

Data for allopolyploids can also be imported and exported in GeneMap-
per, STRand, adegenet genind, and binary presence/absence formats, as de-
scribed in the sections 6.1 and 6.2.

7.2

Individual-level and population statistics

The Bruvo.distance measure of inter-individual distances is best suited
to autopolyploids but may work for allopolyploids under a special case.
Bruvo.distance measures distances between all alleles at a locus for the
two individuals being compared, under the premise that these alleles could
be closely related to each other by mutation. If two alleles belong to two
di(cid:27)erent allopolyploid genomes, it is not possible for them to be be closely
related to each other even if their sizes are similar, since they are derived
from di(cid:27)erent ancestral species.
In the case where no allele from one al-
lopolyploid genome is within three or four mutation steps of any allele from
the other genome, it is possible for the value produced by Bruvo.distance
to accurately re(cid:29)ect the genetic similarity of two allopolyploid individuals.
Along the same logic, Lynch.distance will only be appropriate if the two
homeologous genomes have no alleles in common at a given locus. If either
of these distance measures are appropriate for your data, see the descrip-
tion of the meandistance.matrix function in sections 4.2.1 and 6.3.2. The

50

meandistance.matrix2 function is never appropriate under allopolyploid
inheritance, since it assumes random segregation of alleles when calculating
genotype probabilities. Bruvo2.distance is unlikely to be appropriate for
an allopolyploid system, although I would encourage reading the paper[1]
and thinking about it for yourself.

Assuming a distance matrix can be calculated using meandistance.matrix,

all downstream analyses (principal coordinate analysis, clone assignment,
genotype diversity) are appropriate.

The estimatePloidy, assignClones, genotypeDiversity, and alleleDiversity

functions work equally well on autopolyploids and allopolyploids.

Both simpleFreq and deSilvaFreq work under the assumption of polysomic

inheritance and should therefore not be used on allopolyploid data.

8 Treating microsatellite alleles as dominant mark-

ers

Both autopolyploid and allopolyploid microsatellite data can be converted to
(cid:16)allelic phenotypes(cid:17) based on the presence and absence of alleles. Although
much information is lost using this method, it can enable the user to perform
a wider range of analyses, such as parentage analysis or AMOVA.

The Lynch.distance measure, described earlier, essentially treats alleles
in this way. Alleles are assumed to be present in only one copy, and two
alleles from two individuals are either identical or not. However, alleles are
still grouped by locus and distances are averaged across all loci.

The "genbinary" class stores data in a binary presence/absence format,
the same way that dominant data is typically coded. (See earlier description
of the genambig.to.genbinary function in section 6.2.) This is intended to
facilitate further analysis in R or other software that takes such a format. By
default, 1 indicates that an allele is present, 0 indicates that an allele is ab-
sent, and -9 indicates that the data point is missing. There are replacement
functions to change these symbols, for example (continuing from section 5.3):

> Present(simgenB) <- "P"
> Absent(simgenB) <- 2
> Missing(simgenB) <- 0
> Genotypes(simgenB)[1:10, 1:6]

51

loc1.100 loc1.102 loc1.104 loc1.106 loc1.108 loc1.110
"2"
A1
"2"
A2
"P"
A3
"P"
A4
"2"
A5
"P"
A6
"2"
A7
"2"
A8
A9
"2"
A10 "2"

"P"
"P"
"2"
"P"
"2"
"P"
"2"
"2"
"2"
"P"

"2"
"2"
"P"
"P"
"2"
"2"
"2"
"P"
"2"
"P"

"2"
"2"
"2"
"2"
"2"
"2"
"2"
"2"
"2"
"2"

"P"
"P"
"P"
"P"
"P"
"P"
"2"
"P"
"2"
"P"

"2"
"2"
"2"
"2"
"2"
"2"
"P"
"2"
"2"
"2"

If you want to further manipulate the format of the genotype matrix, you

can assign it to a new object name and then make the desired edits.

> genmat <- Genotypes(simgenB)
> dimnames(genmat)[[2]] <- paste("M", 1:dim(genmat)[2], sep="")
> genmat[1:10, 1:10]

M3

M5

M2

M4

M6

M7 M8 M9

M1
M10
"2" "2" "2" "P" "2" "P" "P" "2" "2" "2"
A1
"2" "2" "2" "P" "2" "P" "2" "P" "2" "P"
A2
"P" "P" "2" "P" "2" "2" "2" "P" "2" "2"
A3
"P" "P" "2" "P" "2" "P" "2" "2" "2" "2"
A4
"2" "2" "2" "P" "2" "2" "P" "2" "2" "2"
A5
"P" "2" "2" "P" "2" "P" "2" "2" "2" "2"
A6
"2" "2" "2" "2" "P" "2" "P" "2" "2" "2"
A7
"2" "P" "2" "P" "2" "2" "2" "2" "2" "2"
A8
A9
"2" "2" "2" "2" "2" "2" "P" "2" "2" "2"
A10 "2" "P" "2" "P" "2" "P" "P" "2" "2" "2"

As demonstrated previously, the write.table function can write the ma-
trix to a text (cid:28)le for use in other software. The arguments for write.table
allow the user to control which character is used to delimit (cid:28)elds, whether
row and column names should be written to the (cid:28)le, and whether quotation
marks should be used for character strings.

52

9 How to cite polysat

(cid:136) Clark, LV and Jasieniuk, M. 2011. polysat: an R package for poly-
ploid microsatellite analysis. Molecular Ecology Resources 11(3):562(cid:21)
566.

(cid:136) Clark, LV and Drauch Schreier, A. 2017. Resolving microsatellite
genotype ambiguity in populations of allopolyploid and diploidized au-
topolyploid organisms using negative correlations between allelic vari-
ables. Molecular Ecology Resources 17(5): 1090(cid:21)1103. DOI: 10.1111/1755-
0998.12639

Feel free to email me at lvclark@illinois.edu with any questions, com-

ments, or bug reports!

References

[1] BRUVO, R., MICHIELS, N. K., D’SOUZA, T. G. and SCHULEN-
BURG, H. 2004. A simple method for the calculation of microsatellite
genotype distances irrespective of ploidy level. Molecular Ecology, 13,
2101-2106.

[2] CHAMBERS, J. M. 2008. Software for Data Analysis: Programming

with R Springer.

[3] DE SILVA, H. N, HALL, A. J., RIKKERINK, E., MCNEILAGE, M. A.,
and FASER, L. G. 2005. Estimation of allele frequencies in polyploids
under certain patterns of inheritance. Heredity, 95, 327-334.

[4] FALUSH, D., STEPHENS, M. and PRITCHARD, J. K. 2003. Inference
of population structure using multilocus genotype data: Linked loci and
correlated allele frequencies. Genetics, 164, 1567-1587.

[5] FALUSH, D., STEPHENS, M. and PRITCHARD, J. K. 2007. Infer-
ence of population structure using multilocus genotype data: dominant
markers and null alleles. Molecular Ecology Notes, 7, 574-578.

[6] GULDBRANDTSEN, B., TOMIUK, J. AND LOESCHCKE, B. 2000.
POPDIST version 1.1.1: A program to calculate population genetic dis-
tance and identity measures. Journal of Heredity, 91, 178-179.

53

[7] HARDY, O. J. and VEKEMANS, X. 2002. SPAGEDi: a versatile com-
puter program to analyse spatial genetic structure at the individual or
population levels. Molecular Ecology Notes, 2, 618-620.

[8] HUBISZ, M. J., FALUSH, D., STEPHENS, M. and PRITCHARD, J. K.
2009. Inferring weak population structure with the assistance of sample
group information. Molecular Ecology Resources, 9, 1322-1332.

[9] JOST, L. 2008. GST and its relatives do not measure di(cid:27)erentiation.

Molecular Ecology 17, 4015-4026.

[10] JOMBART, T. 2008. adegenet: a R package for the multivariate analysis

of genetic markers. Bioinformatics, 24, 1403-1405.

[11] LIAO, W. J., ZHU, B. R., ZENG, Y. F. and ZHANG, D. Y. 2008.
TETRA: an improved program for population genetic analysis of allote-
traploid microsatellite data. Molecular Ecology Resources, 8, 1260-1262.

[12] LYNCH, M. 1990. THE SIMILARITY INDEX AND DNA FINGER-

PRINTING. Molecular Biology and Evolution, 7, 478-484.

[13] MARKWITH, S. H., STEWART, D. J. and DYER, J. L. 2006.
TETRASAT: a program for the population analysis of allotetraploid
microsatellite data. Molecular Ecology Notes, 6, 586-589.

[14] MEIRMANS, P. G. and VAN TIENDEREN, P. H. 2004. GENOTYPE
and GENODIVE: two programs for the analysis of genetic diversity of
asexual organisms. Molecular Ecology Notes, 4, 792-794.

[15] NEI, M. 1973. Analysis of gene diversity in subdivided populations. Pro-
ceedings of the National Academy of Sciences of the United States of
America 70, 3321-3323.

[16] NEI, M. and CHESSER, R. 1983. Estimation of (cid:28)xation indices and

gene diversities. Annals of Human Genetics 47, 253-259.

[17] PRITCHARD, J. K., STEPHENS, M. and DONNELLY, P. 2000. Infer-
ence of population structure using multilocus genotype data. Genetics,
155, 945-959.

[18] SHANNON, C. E. 1948. A mathematical theory of communication. Bell

System Technical Journal, 27, 379-423 and 623-656.

54

[19] SIMPSON, E. H. 1949. Measurement of diversity. Nature, 163, 688.

[20] SLATKIN, M. 1995. A measure of population subdivision based on mi-

crosatellite allele frequencies. Genetics, 139, 457-462.

[21] TOMIUK, J. GULDGRANDTSEN, B. AND LOESCHCKE, B. 2009.
Genetic similarity of polyploids: a new version of the computer program
POPDIST (version 1.2.0) considers intraspeci(cid:28)c genetic di(cid:27)erentiation.
Molecular Ecology Resources, 9, 1364-1368.

[22] TOONEN, R. J. and HUGHES, S. 2001. Increased Throughput for Frag-
ment Analysis on ABI Prism 377 Automated Sequencer Using a Mem-
brane Comb and STRand Software. Biotechniques, 31, 1320-1324.

[23] VAN PUYVELDE, K., VAN GEERT, A. and TRIEST, L. 2010. ATE-
TRA, a new software program to analyse tetraploid microsatellite data:
comparison with TETRA and TETRASAT. Molecular Ecology Re-
sources, 10, 331-334.

55

