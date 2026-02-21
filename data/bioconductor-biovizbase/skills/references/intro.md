An Introduction to biovizBase

Tengfei Yin, Michael Lawrence, Dianne Cook

October 29, 2025

1

Contents

1 Introduction

2 Color Schemes

2.1 Colorblind Safe Palette . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Cytobands Color . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Strand Color
2.4 Nucleotides Color . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.5 Amino Acid Color and Other Schemes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.6 Future Schemes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Utilities

3.1 GRanges Related Manipulation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.1 Adding Disjoint Levels . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Shrink the Gaps
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 GC content . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Mismatch Summary . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 Get an Ideogram . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.6 Other Utilities and Data Sets . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Bugs Report and Features Request

5 Acknowledgement

6 Session Information

3

3
3
6
9
10
10
10

12
12
12
14
15
18
19
21

21

21

22

2

1

Introduction

The biovizBase package is designed to provide a set of utilities and color schemes serving as the basis for
visualizing biological data, especially genomic data. Two other packages are currently built on this package, a
static version of graphics is provided by the package ggbio, and an interactive version of graphics is provided
by visnab(Currently not released).

In this vignette, we will introduce those color schemes and different utilities functions using simple
examples and data sets. Utilities includes functions that precess the raw data, validate names, add attributes,
and generate summaries such as fragment length, GC content, and mismatch information.

2 Color Schemes

The biovizBase package aims to provide a set of default color schemes for biological data, based on the
following principles.

• Make biological sense. Data is displayed in a way that is similar to observed results under the micro-

scope. (Example: giemsa stain results)

• Generate aesthetically pleasing colors based on well-defined color sets like color brewer 1. Produce the

appropriate color for sequential, diverging, and qualitative color schemes.

• Accommodate colorblind vision by creating color pallets that pass the color blind check on the Vis-
check website 2 or use palette from package dichromat or use color-blind safe color palette checked by
ColorBrewer website3. There are three types of colorblind checking strategy defined on these website.

Deuteranope a form of red/green color deficit;
Protanope another form of red/green color deficit;
Tritanope a blue/yellow deficit- very rare.

Our color scheme try to pass color-blind checking points to make sure all the users can tell the difference
between groups of data displayed. To make the implementation easy, we most time just use dichromat to
check this, dichromat collapses red-green color distinctions to approximate the effect of the two common
forms of red/green color blindness, protanopia and deuteranopia. Or we could simply implement proved
color-blind safe palette from dichromat or RColorBrewer .

All color schemes have a general color generating function and a default color generating function. They
are automatically stored in options as default when loading the package. Other packages built on biovizBase
can use the default color scheme, ensuring consistent color themes across all static and interactive graphics.
Users may also change the default color in the options to personalize the global color scheme to fit their
needs.

> library(biovizBase)
> ## library(scales)
>

2.1 Colorblind Safe Palette

For graphics, it’s important to make sure most people can tell the difference between colors on the plots,
even for people with deficient or anomalous red-green vision.

1http://colorbrewer2.org/
2http://www.vischeck.com/
3http://colorbrewer2.org/

3

We will add more and more colorblind safe palette gradually, now we only supported palettes from two
packages, dichromat or RColorBrewer . However, RColorBrewer doesn’t provide information about color-
blind palette. So we need to check manually on ColorBrewer website, and add this information with the
palette information. For dichromat package, it doesn’t have a palette information like brewer.pal.info,
which contains three different types, qual, div, seq representing quality, divergent and sequential respec-
tively, and also missing max colors information, so we integrate all these information and generate three
palette information.

• brewer.pal.blind.info provides only colorblind safe palette subset.

• dichromat.pal.blind.info provides colorblind safe palette with category information and max color

allowed.

• blind.pal.info integrate first two, provides a general palette information with extra column like
pal.id, which used for function colorBlindSafePal as index for arguments palette or maxcolors for
allowed number of color. pkg providing information about which package it is defined.

> head(blind.pal.info)

BluetoGray.8
BluetoOrange.8
BrowntoBlue.10
BluetoOrange.10
PiYG
PRGn

maxcolors category
dichromat
div
8
dichromat
div
8
dichromat
div
10
div
10
dichromat
div RColorBrewer
11
div RColorBrewer
11

pkg pal.id
1
2
3
4
5
6

Then we defined a color generating function colorBlindSafePal, this function reading in a palette
argument which could be a index number or names for palette defined in blind.pal.info. And return a
color generating function, a repeatable argument will control, for number over max color numbers required,
does it simply repeat it or just providing limited number of colors.

> ## with no arguments, return blind.pal.info
> head(colorBlindSafePal())

BluetoGray.8
BluetoOrange.8
BrowntoBlue.10
BluetoOrange.10
PiYG
PRGn

maxcolors category
dichromat
div
8
dichromat
div
8
dichromat
div
10
div
10
dichromat
div RColorBrewer
11
div RColorBrewer
11

pkg pal.id
1
2
3
4
5
6

> ##
> mypalFun <- colorBlindSafePal("Set2")
> ## mypalFun(12, repeatable = FALSE) #only three
> mypalFun(11, repeatable = TRUE) #repeat

[1] "#66C2A5" "#FC8D62" "#8DA0CB" "#66C2A5" "#FC8D62" "#8DA0CB"
[7] "#66C2A5" "#FC8D62" "#8DA0CB" "#66C2A5" "#FC8D62"

To Collapses red-green color distinctions to approximate the effect of the two common forms of red- green
color blindness, protanopia and deuteranopia, we can use function dichromat from package dichromat, this
save us the time to

We only show this as an examples and won’t compare all other color schemes in the following sections.

Please notice that

4

> ## for palette "Paried"
> mypalFun <- colorBlindSafePal(21)
> par(mfrow = c(1, 3))
> showColor(mypalFun(4))
> library(dichromat)
> showColor(dichromat(mypalFun(4), "deutan"))
> showColor(dichromat(mypalFun(4), "protan"))

Figure 1: Checking colors with two common type of color blindness. The first one is normal perception,
second one for deuteranopia and last one for protanopia. Since we are using selected color palettes in this
package, it should be fine with those types of blindness.

5

#A6CEE3#B2DF8A#1F78B4#33A02C#C3C3E2#D2D28E#6C6CB5#8D8D43#CACAE3#DADA8A#7272B4#989831• If the categorical data contains many levels like amino acid, people cannot easily tell the difference
anyway, we did the trick to simply repeat the colors. This might be useful for many other cases like
grand linear view for chromosomes, since if the viewed orders of chromosomes is fixed it’s OK to use
repeated colors since they are not going to be layout as neighbors anyway.

• For schemes like cytobands, we try to follow the biological sense, in this case, we don’t really check the

color blindness.

2.2 Cytobands Color

Chemically staining the metaphase chromosomes results in a alternating dark and light banding pattern,
which could provide information about abnormalities for chromosomes. Cytogenetic bands could also provide
potential predictions of chromosomal structural characteristics, such as repeat structure content, CpG island
density, gene density, and GC content.

biovizBase package provides utilities to get ideograms from the UCSC genome browser, as a wrapper
around some functionality from rtracklayer . It gets the table for cytoBand and stores the table for certain
species as a GRanges object.

We found a color setting scheme in package geneplotter , and we implemented it in biovisBase.
The function .cytobandColor will return a default color set. You could also get it from options after

you load biovizBase package.

And we recommended function getBioColor to get the color vector you want, and names of the color is
biological categorical data. This function hides interval color genenerators and also the complexity of getting
color from options. You could specify whether you want to get colors by default or from options, in this
way, you can temporarily edit colors in options and could change or all the graphics. This give graphics a
uniform color scheme.

> getOption("biovizBase")$cytobandColor

gvar

gneg

gpos1

gpos8

gpos3

gpos7

gpos22

gpos15

gpos31

gpos24

gpos17

gpos10

gpos32

gpos27

gpos25

gpos26

gpos20

gpos18

gpos13

gpos19

gpos11

gpos12

gpos28

gpos21

gpos14

gpos
"grey0"
gpos6

acen
"brown4"
gpos5

stalk
"grey100" "brown3"
gpos4

gpos2
"grey0" "#FFFFFF" "#FCFCFC"
gpos9
"#F9F9F9" "#F7F7F7" "#F4F4F4" "#F2F2F2" "#EFEFEF" "#ECECEC" "#EAEAEA"
gpos16
"#E7E7E7" "#E5E5E5" "#E2E2E2" "#E0E0E0" "#DDDDDD" "#DADADA" "#D8D8D8"
gpos23
"#D5D5D5" "#D3D3D3" "#D0D0D0" "#CECECE" "#CBCBCB" "#C8C8C8" "#C6C6C6"
gpos30
"#C3C3C3" "#C1C1C1" "#BEBEBE" "#BCBCBC" "#B9B9B9" "#B6B6B6" "#B4B4B4"
gpos37
"#B1B1B1" "#AFAFAF" "#ACACAC" "#AAAAAA" "#A7A7A7" "#A4A4A4" "#A2A2A2"
gpos44
"#9F9F9F" "#9D9D9D" "#9A9A9A" "#979797" "#959595" "#929292" "#909090"
gpos51
"#8D8D8D" "#8B8B8B" "#888888" "#858585" "#838383" "#808080" "#7E7E7E"
gpos58
"#7B7B7B" "#797979" "#767676" "#737373" "#717171" "#6E6E6E" "#6C6C6C"
gpos65
"#696969" "#676767" "#646464" "#616161" "#5F5F5F" "#5C5C5C" "#5A5A5A"
gpos72
"#575757" "#545454" "#525252" "#4F4F4F" "#4D4D4D" "#4A4A4A" "#484848"
gpos79
"#454545" "#424242" "#404040" "#3D3D3D" "#3B3B3B" "#383838" "#363636"

gpos35

gpos42

gpos49

gpos56

gpos63

gpos77

gpos70

gpos33

gpos34

gpos40

gpos39

gpos47

gpos41

gpos48

gpos46

gpos54

gpos53

gpos61

gpos55

gpos62

gpos60

gpos75

gpos76

gpos74

gpos38

gpos45

gpos52

gpos59

gpos73

gpos67

gpos68

gpos69

gpos66

gpos29

gpos36

gpos43

gpos50

gpos57

gpos64

gpos78

gpos71

6

gpos87

gpos80

gpos81

gpos83

gpos82

gpos86
"#333333" "#303030" "#2E2E2E" "#2B2B2B" "#292929" "#262626" "#242424"
gpos93
"#212121" "#1E1E1E" "#1C1C1C" "#191919" "#171717" "#141414" "#121212"
gpos100
"#0F0F0F" "#0C0C0C" "#0A0A0A" "#070707" "#050505" "#020202" "#000000"

gpos84

gpos90

gpos91

gpos97

gpos98

gpos88

gpos95

gpos94

gpos96

gpos89

gpos85

gpos92

gpos99

> getBioColor("CYTOBAND")

gneg

gvar

gpos8

gpos1

gpos3

gpos7

gpos15

gpos22

gpos19

gpos12

gpos17

gpos10

gpos18

gpos11

gpos36

gpos29

gpos20

gpos14

gpos13

gpos21

gpos26

gpos33

gpos40

gpos31

gpos38

gpos24

gpos45

gpos25

gpos32

gpos39

gpos27

gpos28

gpos34

gpos35

gpos41

gpos
"grey0"
gpos6

acen
"brown4"
gpos5

stalk
"grey100" "brown3"
gpos4

gpos2
"grey0" "#FFFFFF" "#FCFCFC"
gpos9
"#F9F9F9" "#F7F7F7" "#F4F4F4" "#F2F2F2" "#EFEFEF" "#ECECEC" "#EAEAEA"
gpos16
"#E7E7E7" "#E5E5E5" "#E2E2E2" "#E0E0E0" "#DDDDDD" "#DADADA" "#D8D8D8"
gpos23
"#D5D5D5" "#D3D3D3" "#D0D0D0" "#CECECE" "#CBCBCB" "#C8C8C8" "#C6C6C6"
gpos30
"#C3C3C3" "#C1C1C1" "#BEBEBE" "#BCBCBC" "#B9B9B9" "#B6B6B6" "#B4B4B4"
gpos37
"#B1B1B1" "#AFAFAF" "#ACACAC" "#AAAAAA" "#A7A7A7" "#A4A4A4" "#A2A2A2"
gpos44
"#9F9F9F" "#9D9D9D" "#9A9A9A" "#979797" "#959595" "#929292" "#909090"
gpos51
"#8D8D8D" "#8B8B8B" "#888888" "#858585" "#838383" "#808080" "#7E7E7E"
gpos58
"#7B7B7B" "#797979" "#767676" "#737373" "#717171" "#6E6E6E" "#6C6C6C"
gpos65
"#696969" "#676767" "#646464" "#616161" "#5F5F5F" "#5C5C5C" "#5A5A5A"
gpos72
"#575757" "#545454" "#525252" "#4F4F4F" "#4D4D4D" "#4A4A4A" "#484848"
gpos79
"#454545" "#424242" "#404040" "#3D3D3D" "#3B3B3B" "#383838" "#363636"
gpos86
"#333333" "#303030" "#2E2E2E" "#2B2B2B" "#292929" "#262626" "#242424"
gpos93
"#212121" "#1E1E1E" "#1C1C1C" "#191919" "#171717" "#141414" "#121212"
gpos100
"#0F0F0F" "#0C0C0C" "#0A0A0A" "#070707" "#050505" "#020202" "#000000"

gpos62

gpos63

gpos49

gpos48

gpos56

gpos55

gpos42

gpos69

gpos70

gpos76

gpos77

gpos83

gpos84

gpos90

gpos91

gpos60

gpos46

gpos53

gpos67

gpos74

gpos81

gpos88

gpos66

gpos59

gpos52

gpos73

gpos80

gpos87

gpos97

gpos98

gpos68

gpos47

gpos54

gpos61

gpos82

gpos75

gpos89

gpos95

gpos94

gpos96

gpos92

gpos64

gpos50

gpos57

gpos71

gpos43

gpos78

gpos85

gpos99

> ## differece source from default or options.
> opts <- getOption("biovizBase")
> opts$DNABasesNColor[1] <- "red"
> options(biovizBase = opts)
> ## get from option(default)
> getBioColor("DNA_BASES_N")

A

N
"red" "#2C7BB6" "#D7191C" "#FDAE61" "#FFFFBF"

G

T

C

> ## get default fixed color
> getBioColor("DNA_BASES_N", source = "default")

7

N
"#ABD9E9" "#2C7BB6" "#D7191C" "#FDAE61" "#FFFFBF"

G

T

A

C

> seqs <- c("A", "C", "T", "G", "G", "G", "C")
> ## get colors for a sequence.
> getBioColor("DNA_BASES_N")[seqs]

A

C
"red" "#FDAE61" "#2C7BB6" "#D7191C" "#D7191C" "#D7191C" "#FDAE61"

T

C

G

G

G

You can check the color scheme by calling the plotColorLegend function. or the showColor.

> cols <- getBioColor("CYTOBAND")
> plotColorLegend(cols, title

= "cytoband")

Figure 2: Legend for cytoband color

8

cytobandgnegstalkacengposgvargpos1gpos2gpos3gpos4gpos5gpos6gpos7gpos8gpos9gpos10gpos11gpos12gpos13gpos14gpos15gpos16gpos17gpos18gpos19gpos20gpos21gpos22gpos23gpos24gpos25gpos26gpos27gpos28gpos29gpos30gpos31gpos32gpos33gpos34gpos35gpos36gpos37gpos38gpos39gpos40gpos41gpos42gpos43gpos44gpos45gpos46gpos47gpos48gpos49gpos50gpos51gpos52gpos53gpos54gpos55gpos56gpos57gpos58gpos59gpos60gpos61gpos62gpos63gpos64gpos65gpos66gpos67gpos68gpos69gpos70gpos71gpos72gpos73gpos74gpos75gpos76gpos77gpos78gpos79gpos80gpos81gpos82gpos83gpos84gpos85gpos86gpos87gpos88gpos89gpos90gpos91gpos92gpos93gpos94gpos95gpos96gpos97gpos98gpos99gpos1002.3 Strand Color

In the GRanges object, we have strand which contains three levels, +, -, *. We are using a qualitative color
set from Color Brewer and check with dichromat as Figure3 shows, and we can see that this color set passes
all three types of colorblind test. Therefore it should be a safe color set to use to color strand.

@

> par(mfrow = c(1, 3))
> cols <- getBioColor("STRAND")
> showColor(cols)
> showColor(dichromat(cols, "deutan"))
> showColor(dichromat(cols, "protan"))

Figure 3: Colorblind vision check for color of strand

9

#1B9E77#D95F02#7570B3#8A8A7C#92921D#7676B3#969677#76761A#7171B32.4 Nucleotides Color

We start with the five most used nucleotides, A,T,C,G,N, most genome browsers have their own color
scheme to represent nucleotides, We chose our color scheme based on the principles introduced above. Since
in genetics, GC-content usually has special biological significance because GC pair is bound by three hydrogen
bonds instead of two like AT pairs. So it has higher thermostability which could result in different significance,
like higher annealing temperature in PCR. So we hope to choose warm colors for G,C and cold colors for
A,T, and a color in between to represent N. They are chosen from a diverging color set of color brewer. So
we should be able to easily tell the GC enriched region. Figure 4 shows the results from dichromat, and we
can see this color set passes all two types of the colorblind test. It should be a safe color set to use to color
the five most used nucleotides.

> getBioColor("DNA_BASES_N")

A

N
"red" "#2C7BB6" "#D7191C" "#FDAE61" "#FFFFBF"

T

G

C

>

2.5 Amino Acid Color and Other Schemes

We also include some other color schemes created based on existing object in package Biostrings and other
customized color scheme. Please notice that the object name is not the same as the name in the options.
On the left of =, it’s name of object, most of them are defined in Biostrings and on the right, it’s the name
in options.

DNA_BASES_N = "DNABasesNColor"
DNA_BASES = "DNABasesColor"
DNA_ALPHABET = "DNAAlphabetColor"
RNA_BASES_N = "RNABasesNColor"
RNA_BASES = "RNABasesColor"
RNA_ALPHABET = "RNAAlphabetColor"
IUPAC_CODE_MAP = "IUPACCodeMapColor"
AMINO_ACID_CODE = "AminoAcidCodeColor"
AA_ALPHABET = "AAAlphabetColor"
STRAND = "strandColor"
CYTOBAND = "cytobandColor"

They all could be retrieved by calling function getBioColor.

2.6 Future Schemes

Current color schemes are most generated based on known object in R, which has a clear definition and
classification. But we do have more interesting events or biological significance need to be color coded. Like
most genome browser, they try to color code many events, for instance, color the insertion size which is
larger/smaller than the estimated size; for paired RNA-seq data, we may color the paired reads mapped to
a different chromosome.

We may include more color coded events in this package in next release.

10

> par(mfrow = c(1, 3))
> cols <- getBioColor("DNA_BASES_N", "default")
> showColor(cols, "name")
> cols.deu <- dichromat(cols, "deutan")
> names(cols.deu) <- names(cols)
> cols.pro <- dichromat(cols, "protan")
> names(cols.pro) <- names(cols)
> showColor(cols.deu, "name")
> showColor(cols.pro, "name")

Figure 4: Colorblind vision check for color of nucleotide

11

ACTNGACTNGACTNG3 Utilities

biovizBase serves as a basis for the visualization of biological data, especially for genomic data. IRanges
and GenomicRanges are the two most important infrastructure packages to manipulate genomic data. They
already have lots of useful and fast utilities for processing genomic data. Some other package such as
rtracklayer , Rsamtools, ShortRead , GenomicFeatures provide common I/O for certain types of biological
data and utilities for processing those raw data. Most of our utilities to be introduced in this section only
manipulate the data in a simple and different way to get them ready for visualization. Most cases are only
useful for visualization work, like adding brush color attributes to a GRanges object. Some of the other
utilities are responsible for summarizing certain types of raw data, getting it ready to be visualized. Some
of those utilities may be moved to a separate package later.

3.1 GRanges Related Manipulation

biovizBase mainly focuses on visualizing the genomic data, so we have some utilities for manipulating GRanges
object. We are going to introduce these functions in the flow wing sub-sections. Overall, we hope to reduce
people’s work through these common utilities.

3.1.1 Adding Disjoint Levels

IRanges(

> library(GenomicRanges)
> set.seed(1)
> N <- 500
> gr <- GRanges(seqnames =
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

sample(c("chr1", "chr2", "chr3", "chrX", "chrY"),

size = N, replace = TRUE),

start = sample(1:300, size = N, replace = TRUE),
width = sample(70:75, size = N,replace = TRUE)),

strand = sample(c("+", "-", "*"), size = N,

replace = TRUE),

value = rnorm(N, 10, 3), score = rnorm(N, 100, 30),
group = sample(c("Normal", "Tumor"),

size = N, replace = TRUE),

pair = sample(letters, size = N,

replace = TRUE))

This is a tricky question. For example, for pair-end RNA-seq data, we may want to put the reads with
the same qname on the same level, with nothing falling in between. For better visualization of the data, we
may hope that adding invisible extensions to the reads will prevent closely neighbored reads from showing
up on the same level.

addStepping function takes a GenomicRanges object and will add an extra column called .levels to the
object. This function is essentially a wrapper around a function disjointBins but allows a more flexible
way to assign levels to each entry. For example, if the arguments group.name is specified to one of the
column in elementMetadata, the function will make sure

• Grouped intervals are in the same levels( if they are not overlapped each other).

• No entry is following between the grouped intervals.

• If extend.size is provided, it buffers the intervals and then computes the disjoint levels, thus ensuring
that two closely positioned intervals will be assigned to different levels, a good practice for visualization.

For now, this function is only useful for visualization purposes.

12

> head(addStepping(gr))

GRanges object with 6 ranges and 5 metadata columns:
ranges strand |

seqnames

value

score

group
<Rle> <IRanges> <Rle> | <numeric> <numeric> <character>
Tumor
+ | 11.46229
Tumor
+ |
13.37479
Normal
* | 10.22369
Tumor
+ |
9.82206
Normal
* | 13.30008
Tumor
9.50643
* |

58.8187
87.8879
73.4545
138.4521
118.0667
87.4475

113-182
2-76
109-180
102-176
57-131
160-234

chr1
chr1
chr1
chr1
chr1
chr1

chr1
chr1
chr1
chr1
chr1
chr1

pair

stepping
<character> <numeric>
8
q
1
r
18
m
5
c
13
p
28
w

chr1
chr1
chr1
chr1
chr1
chr1
-------
seqinfo: 5 sequences from an unspecified genome; no seqlengths

> head(addStepping(gr, group.name = "pair"))

GRanges object with 6 ranges and 5 metadata columns:
ranges strand |

seqnames

value

score

group
<Rle> <IRanges> <Rle> | <numeric> <numeric> <character>
Tumor
+ | 11.46229
Tumor
13.37479
+ |
Normal
* | 10.22369
Tumor
+ |
9.82206
Normal
* | 13.30008
Tumor
9.50643
* |

58.8187
87.8879
73.4545
138.4521
118.0667
87.4475

113-182
2-76
109-180
102-176
57-131
160-234

chr1
chr1
chr1
chr1
chr1
chr1

chr1
chr1
chr1
chr1
chr1
chr1

pair

stepping
<character> <numeric>
17
q
18
r
13
m
3
c
16
p
23
w

chr1
chr1
chr1
chr1
chr1
chr1
-------
seqinfo: 5 sequences from an unspecified genome; no seqlengths

> gr.close <- GRanges(c("chr1", "chr1"), IRanges(c(10, 20), width = 9))
> addStepping(gr.close)

GRanges object with 2 ranges and 1 metadata column:

seqnames

ranges strand | stepping
<Rle> <IRanges> <Rle> | <numeric>
1
1

10-18
20-28

chr1
chr1

* |
* |

chr1
chr1

13

-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

> addStepping(gr.close, extend.size = 5)

GRanges object with 2 ranges and 1 metadata column:

seqnames

ranges strand | stepping
<Rle> <IRanges> <Rle> | <numeric>
1
2

chr1
chr1
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

10-18
20-28

chr1
chr1

* |
* |

3.2 Shrink the Gaps

Sometime, in a gene centric view, we hope to truncate or shrink the gaps to better visualize the short reads
or annotation data. It’s DANGEROUS to shrink the gaps, since it only make sense in visualization. And
even in the visualization the x-scale will be discontinued, and labels became somehow meaningless. Make
sure you are not using the shrunk version of data when performing the down stream analysis.

This is a tricky question too, we hope to provide a flexible way to shrink the gaps. When we have multiple
tracks, users would be responsible to shrink all the tracks based on the common gaps, otherwise there will
be mis-aligned tracks.

maxGap computes a suitable estimated gap based on passed GenomicRanges

> gr.temp <- GRanges("chr1", IRanges(start = c(100, 250),
+
> maxGap(gaps(gr.temp, start = min(start(gr.temp))))

end = c(200, 300)))

[1] 0.1225

> maxGap(gaps(gr.temp, start = min(start(gr.temp))), ratio = 0.5)

[1] 24.5

shrinkageFun function will read in a GenomicRanges object which represents the gaps, and returns a
function which alters a different GenomicRanges object, to shrink that object based on previously specified
gaps shrinking information. You could use this function to treat multiple tracks(e.g. GRanges) to make sure
they are shrunk based on the common gaps and the same ratio.

Be careful in the following situations.

• When use the same shrinkage function to shrink multiple tracks, make sure the gaps passed to
shrinkageFun function is the common gaps across all tracks, otherwise, it doesn’t make sense to
cut a overlapped gap within one of the tracks.

• The default max gap is not 0, just for visualization purpose. If for estimation purpose, you might want

to make sure you cut all the gaps.

And notice, after shrinking, the x-axis labes only provide approximate position as shown in Figure 5 and

6, because it’s clipped. It’s just for visualization purpose.

> gr1 <- GRanges("chr1", IRanges(start = c(100, 300, 600),
+
> shrink.fun1 <- shrinkageFun(gaps(gr1), max.gap = maxGap(gaps(gr1), 0.15))
> shrink.fun2 <- shrinkageFun(gaps(gr1), max.gap = 0)
> head(shrink.fun1(gr1))

end = c(200, 400, 800)))

14

GRanges object with 3 ranges and 1 metadata column:
ranges strand |
<Rle> |

seqnames

<Rle> <IRanges>
91-191
282-382
473-673

chr1
chr1
chr1

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

.ori
<GRanges>
* | chr1:100-200
* | chr1:300-400
* | chr1:600-800

> head(shrink.fun2(gr1))

GRanges object with 3 ranges and 1 metadata column:
ranges strand |
<Rle> |

seqnames

<Rle> <IRanges>
1-101
102-202
203-403

chr1
chr1
chr1

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

.ori
<GRanges>
* | chr1:100-200
* | chr1:300-400
* | chr1:600-800

> gr2 <- GRanges("chr1", IRanges(start = c(100, 350, 550),
+
> gaps.gr <- intersect(gaps(gr1, start = min(start(gr1))),
gaps(gr2, start = min(start(gr2))))
+
> shrink.fun <- shrinkageFun(gaps.gr, max.gap = maxGap(gaps.gr))
> head(shrink.fun(gr1))

end = c(220, 500, 900)))

GRanges object with 3 ranges and 1 metadata column:
ranges strand |
<Rle> |

seqnames

<Rle> <IRanges>
100-200
222-322
474-674

chr1
chr1
chr1

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

.ori
<GRanges>
* | chr1:100-200
* | chr1:300-400
* | chr1:600-800

> head(shrink.fun(gr2))

GRanges object with 3 ranges and 1 metadata column:
ranges strand |
<Rle> |

seqnames

<Rle> <IRanges>
100-220
272-422
424-774

chr1
chr1
chr1

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

.ori
<GRanges>
* | chr1:100-220
* | chr1:350-500
* | chr1:550-900

3.3 GC content

As mentioned before, GC content is an interesting variable which may be related to various biological
questions. So we need a way to compute GC content in a certain region of a reference genome.

15

Figure 5: Shrink single GRanges. The first track is original GRanges, the second one use a ratio which
shrink the GRanges a little bit, and default is to remove all gaps shown as the third track

16

Genomic Coordinates0200400600800Figure 6: shrinkageFun demonstration for multiple GRanges, the top two tracks are the original tracks,
please note how we clipped common gaps for those two tracks and shown as bottom two tracks.

17

Genomic Coordinates200400600800GCcontent function is a wrapper around getSeq function in BSgenome package and letterFrequency
in Biostrings package. It reads a BSgenome object and returns count/probability for GC content in specified
region.

> library(BSgenome.Hsapiens.UCSC.hg19)
> GCcontent(Hsapiens, GRanges("chr1", IRanges(1e6, 1e6 + 1000)))
> GCcontent(Hsapiens, GRanges("chr1", IRanges(1e6, 1e6 + 1000)), view.width = 300)

3.4 Mismatch Summary

Compared to short-read alignment visualization, it’s more useful to just show the summary of nucleotides
of short reads per base and compare with the reference genome. We need a way to show the mismatched
nucleotides, coverage at each position and proportion of mismatched nucleotides, and use the default color
to indicate the type of nucleotide.

pileupAsGRanges function summarizes reads from bam files for nucleotides on single base units in a given
region, which allows the downstream mismatch summary analysis. It’s a wrapper around applyPileup func-
tion in Rsamtools package and more detailed control could be found under manual of ApplyPileupsParam
function in Rsamtools. pileupAsGRanges function returns a GRanges object which includes a summary of
nucleotides, depth, and bam file path. This object could be read directly into the pileupGRangesAsVariantTable
function for a mismatch summary.

This function returns a GRanges object with extra elementMetadata, counts for A,C,T,G,N and depth

for coverage. bam indicates the bam file path. Each row is single base unit.

pileupGRangesAsVariantTable performs comparisons to the reference genome(a BSgenome object) and
computes the mismatch summary for a certain region of reads. User need to make sure to pass the right
reference genome to this function to get the right summary. This function drops the positions that have no
reads and only keeps the regions with coverage in the summary. The result could be used to show stacked
barchart for the mismatch summary.

This function returns a GRanges with the following elementMetadata information.

ref Reference base.

read Sequenced read at that position. Each type of A,C,T,G,N summarize counts at one position, if no

counts detected, will not show it.

count Count for each nucleotide.

depth Coverage at that position.

match A logical value, indicate it’s matched or not.

bam Indicate bam file path.

Sample raw data is from SRA(Short Read Archive), Accession: SRR027894 and subset the gene at

chr10:6118023-6137427, which within gene RBM17. contains junction reads.

> library(Rsamtools)
> data(genesymbol)
> library(BSgenome.Hsapiens.UCSC.hg19)
> bamfile <- system.file("extdata", "SRR027894subRBM17.bam", package="biovizBase")
> test <- pileupAsGRanges(bamfile, region = genesymbol["RBM17"])
> test.match <- pileupGRangesAsVariantTable(test, Hsapiens)
> head(test[,-7])
> head(test.match[,-5])

18

3.5 Get an Ideogram

getIdeogram function is a wrapper of some functionality from rtracklayer to get certain table like cytoBand.
A full table schema can be found here at UCSC genome browser. Please click describe table schema.

This function requires a network connection and will parse the data on the fly. The first argument of
getIdeogram is species.
If missing, the function will give you a choice hint, so you will not have to
remember the name for the database you want, or you can simply get the database name for a different
genome using the ucscGenomes function in Rtracklayer . The second argument subchr is used to subset
the result by chromosome name. The third argument cytoband controls if you want to get the gieStain
information/band information or not, which is useful for the visualization of the whole genome or single
chromosome. You can see some examples in ggbio.

> library(rtracklayer)
> hg19IdeogramCyto <- getIdeogram("hg19", cytoband = TRUE)
> hg19Ideogram <- getIdeogram("hg19", cytoband = FALSE)
> unknowIdeogram <- getIdeogram()

Please specify genome

4: hg16
9: panTro3

1: hg19
6: felCat3

2: hg18
7: galGal3
11: panTro1 12: bosTau4
16: canFam1 17: loxAfr3
21: equCab2 22: equCab1
26: calJac3 27: calJac1
31: mm7
36: ailMel1 37: susScr2
41: rn3
46: tetNig1 47: xenTro2
51: danRer6 52: danRer5
56: ci1
61: apiMel1 62: anoGam1
66: droGri1 67: dm3
71: droMoj1 72: droPer1
76: droSim1 77: droVir2
81: caePb2
86: ce4
91: priPac1 92: aplCal1

3: hg17
8: galGal2
13: bosTau3
18: fr2
23: petMar1
28: oryLat2
32: monDom5 33: monDom4
38: ornAna1
42: rheMac2 43: oviAri1
48: xenTro1
53: danRer4
57: braFlo1 58: strPur2
63: droAna2
68: dm2
73: dp3
78: droVir1
83: cb3
88: caeJap1 89: caeRem3
94: sacCer1
93: sacCer2

5: felCat4
10: panTro2
14: bosTau2 15: canFam2
19: fr1
20: cavPor3
24: anoCar2 25: anoCar1
29: mm9
34: monDom1
39: oryCun2 40: rn4
44: gasAcu1
45: tetNig2
49: taeGut1 50: danRer7
54: danRer3 55: ci2
59: strPur1
60: apiMel2
64: droAna1 65: droEre1
69: dm1
70: droMoj2
75: droSec1
74: dp2
79: droYak2 80: droYak1
84: cb1

30: mm8
35: ponAbe2

85: ce6
90: caeRem2

82: caePb1
87: ce2

Selection:

Here is the example on how to get the genome names.

> head(ucscGenomes()$db)

[1] hg19
122 Levels: ailMel1 anoCar1 anoCar2 anoGam1 apiMel1 apiMel2 ...

felCat4 felCat3

hg16

hg18

hg17

We put the most used hg19 ideogram as our default data set, so you can simply load it and see what
they look like. They are all returned by the getIdeogram function. The one with cytoband information has
two special columns.

name Name of cytogenetic band

19

gieStain Giemsa stain results

> data(hg19IdeogramCyto)
> head(hg19IdeogramCyto)

GRanges object with 6 ranges and 2 metadata columns:

ranges strand |

seqnames
<IRanges>
<Rle>
0-2300000
chr1
2300000-5400000
chr1
5400000-7200000
chr1
7200000-9200000
chr1
chr1
9200000-12700000
chr1 12700000-16200000

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 24 sequences from an unspecified genome; no seqlengths

name gieStain
<Rle> | <factor> <factor>
p36.33
p36.32
p36.31
p36.23
p36.22
p36.21

gneg
gpos25
gneg
gpos25
gneg
gpos50

* |
* |
* |
* |
* |
* |

> data(hg19Ideogram)
> head(hg19Ideogram)

GRanges object with 6 ranges and 0 metadata columns:

seqnames
<Rle>

<IRanges>
chr1 1-249250621
1-106433
1-547496
chr2 1-243199373
chr3 1-198022430
chr4 1-191154276

[1]
[2] chr1_gl000191_random
[3] chr1_gl000192_random
[4]
[5]
[6]
-------
seqinfo: 93 sequences from hg19 genome

ranges strand
<Rle>
*
*
*
*
*
*

There are two simple functions to test if the ideogram is valid or not. isIdeogram simply tests if the
result came from the getIdeogram function, making sure it’s a GenomicRanges object with an extra column.
isSimpleIdeogram only tests if it’s GenomicRanges and does not require cytoband information. But it
double checks to make sure there is only one entry per chromosome. This is useful to show stacked overview
for genomes. Please check some examples in ggbio to draw stacked overview and single chromosome.

> isIdeogram(hg19IdeogramCyto)

[1] TRUE

> isIdeogram(hg19Ideogram)

[1] FALSE

> isSimpleIdeogram(hg19IdeogramCyto)

[1] FALSE

> isSimpleIdeogram(hg19Ideogram)

[1] TRUE

20

3.6 Other Utilities and Data Sets

We are not going to introduce other utilities in this vignette, please refer to the manual for more details, we
have other function to transform a GRanges to a special format only for graphic purpose, such as function
transformGRangesForEvenSpace and transformGRangesToDfWithTicks could be used for grand linear view
or linked view as introduced in package ggbio.

We have introduced data sets like hg19IdeogramCyto and hg19Ideogram in the previous sections. We
also have a data set called genesymbol, which is extracted from human annotation package and stored as
GRanges object, with extra columns symbol and ensembl_id. For fast mapping, we use symbol as row names
too.

This could be used for convenient overlapped subset with other annotation, and has potential use in a

auto-complement drop list for gene search bar like most gene browsers have.

> data(genesymbol)
> head(genesymbol)

GRanges object with 6 ranges and 2 metadata columns:

ranges strand |

symbol
<Rle> | <character>

seqnames
<Rle>
<IRanges>
chr19 58858174-58864865
9220304-9268558
chr12
chr8 18027971-18081197
chr8 18067618-18081197
chr8 18079177-18081197
chr8 18248755-18258723

A1BG
A2M
NAT1
NAT1
NAT1
NAT2
-------
seqinfo: 45 sequences from an unspecified genome; no seqlengths

ensembl_id
<character>
A1BG ENSG00000121410
A2M ENSG00000175899
NAT1 ENSG00000171428
NAT1 ENSG00000171428
NAT1 ENSG00000171428
NAT2 ENSG00000156006

- |
- |
+ |
+ |
+ |
+ |

> genesymbol["RBM17"]

GRanges object with 1 range and 2 metadata columns:

seqnames
<Rle>
chr10 6130949-6159420

ranges strand |

symbol
<IRanges> <Rle> | <character>

ensembl_id
<character>
RBM17 ENSG00000134453

RBM17
-------
seqinfo: 45 sequences from an unspecified genome; no seqlengths

+ |

>

4 Bugs Report and Features Request

Latest code are available on github https://github.com/tengfei/biovizBase

Please file bug/request on issue page, this is preferred way. or email me at yintengfei <at> gmail dot

com.

It’s a new package and under active development.
Thanks in advance for any feedback.

5 Acknowledgement

I wish to thank all those who helped me. Without them, I could not have started this project.

Genentech Sponsorship and valuable feed back and help for this project and my other project.

Jennifer Chang Feedback on this package

21

6 Session Information

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[7] methods

stats
base

graphics

grDevices utils

datasets

other attached packages:
[1] GenomicRanges_1.62.0 Seqinfo_1.0.0
[4] S4Vectors_0.48.0
[7] dichromat_2.0-0.1

BiocGenerics_0.56.0
biovizBase_1.58.0

IRanges_2.44.0
generics_0.1.4

loaded via a namespace (and not attached):

[1] tidyselect_1.2.1
[3] farver_2.1.2
[5] Biostrings_2.78.0
[7] bitops_1.0-9
[9] lazyeval_0.2.2

[11] VariantAnnotation_1.56.0
[13] XML_3.99-0.19
[15] rpart_4.1.24
[17] cluster_2.1.8.1
[19] KEGGREST_1.50.0
[21] magrittr_2.0.4
[23] rlang_1.1.6
[25] tools_4.5.1
[27] data.table_1.17.8
[29] knitr_1.50
[31] htmlwidgets_1.6.4
[33] bit_4.6.0
[35] RColorBrewer_1.1-3
[37] BiocParallel_1.44.0

dplyr_1.1.4
blob_1.2.4
S7_0.2.0
RCurl_1.98-1.17
fastmap_1.2.0
GenomicAlignments_1.46.0
digest_0.6.37
lifecycle_1.0.4
ProtGenerics_1.42.0
RSQLite_2.4.3
compiler_4.5.1
Hmisc_5.2-4
yaml_2.3.10
rtracklayer_1.70.0
S4Arrays_1.10.0
curl_7.0.0
DelayedArray_0.36.0
abind_1.4-8
foreign_0.8-90

22

[39] nnet_7.3-20
[41] colorspace_2.1-2
[43] scales_1.4.0
[45] cli_3.6.5
[47] crayon_1.5.3
[49] rjson_0.2.23
[51] DBI_1.2.3
[53] stringr_1.5.2
[55] AnnotationDbi_1.72.0
[57] AnnotationFilter_1.34.0
[59] matrixStats_1.5.0
[61] vctrs_0.6.5
[63] jsonlite_2.0.0
[65] Formula_1.2-5
[67] ensembldb_2.34.0
[69] glue_1.8.0
[71] stringi_1.8.7
[73] GenomeInfoDb_1.46.0
[75] UCSC.utils_1.6.0
[77] pillar_1.11.1
[79] BSgenome_1.78.0
[81] evaluate_1.0.5
[83] Biobase_2.70.0
[85] backports_1.5.0
[87] cigarillo_1.0.0
[89] gridExtra_2.3
[91] checkmate_2.3.3
[93] MatrixGenerics_1.22.0

grid_4.5.1
ggplot2_4.0.0
SummarizedExperiment_1.40.0
rmarkdown_2.30
rstudioapi_0.17.1
httr_1.4.7
cachem_1.1.0
parallel_4.5.1
restfulr_0.0.16
XVector_0.50.0
base64enc_0.1-3
Matrix_1.7-4
bit64_4.6.0-1
htmlTable_2.4.3
GenomicFeatures_1.62.0
codetools_0.2-20
gtable_0.3.6
BiocIO_1.20.0
tibble_3.3.0
htmltools_0.5.8.1
R6_2.6.1
lattice_0.22-7
png_0.1-8
Rsamtools_2.26.0
memoise_2.0.1
SparseArray_1.10.0
xfun_0.53
pkgconfig_2.0.3

23

