# cliProfiler Vignettes

You Zhou1 and Kathi Zarnack1

1Buchmann Institute for Molecular Life Sciences, Frankfurt am Main, Germany

#### October 29, 2025

#### Package

cliProfiler 1.16.0

# 1 Introduction

Cross-linking immunoprecipitation (CLIP) is a technique that combines UV
cross-linking and immunoprecipitation to analyse protein-RNA interactions or to
pinpoint RNA modifications (e.g. m6A). CLIP-based methods, such as iCLIP and
eCLIP, allow precise mapping of RNA modification sites or RNA-binding protein
(RBP) binding sites on a genome-wide scale. These techniques help us to unravel
post-transcriptional regulatory networks. In order to make the visualization of
CLIP data easier, we develop *[cliProfiler](https://bioconductor.org/packages/3.22/cliProfiler)* package. The
*[cliProfiler](https://bioconductor.org/packages/3.22/cliProfiler)* includes seven functions which allow users easily
make different profile plots.

The *[cliProfiler](https://bioconductor.org/packages/3.22/cliProfiler)* package is available at
<https://bioconductor.org> and can be
installed via `BiocManager::install`:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("cliProfiler")
```

A package only needs to be installed once. Load the package into an
R session with

```
library(cliProfiler)
```

# 2 The Requirement of Data and Annotation file

The input data for using all the functions in *[cliProfiler](https://bioconductor.org/packages/3.22/cliProfiler)* should
be the peak calling result or other similar object that represents the RBP
binding sites or RNA modification position. Moreover, these `peaks/signals` be
stored in the **GRanges** object. The **GRanges** is an S4 class which defined
by *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*. The GRanges class is a container for the
genomic locations and their associated annotations. For more information about
GRanges objects please check *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* package. An example
of GRanges object is shown below:

```
testpath <- system.file("extdata", package = "cliProfiler")
## loading the test GRanges object
test <- readRDS(file.path(testpath, "test.rds"))
## Show an example of GRanges object
test
```

```
## GRanges object with 100 ranges and 0 metadata columns:
##         seqnames              ranges strand
##            <Rle>           <IRanges>  <Rle>
##     [1]    chr17   28748198-28748218      +
##     [2]    chr10 118860137-118860157      -
##     [3]     chr2 148684461-148684481      +
##     [4]     chr2   84602546-84602566      -
##     [5]    chr18     6111874-6111894      -
##     ...      ...                 ...    ...
##    [96]     chr7 127254692-127254712      +
##    [97]     chr2   28833830-28833850      -
##    [98]     chr9   44607255-44607275      +
##    [99]     chr1 133621331-133621351      -
##   [100]     chr4 130316598-130316618      -
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

The annotation file that required by functions `exonProfile`,
`geneTypeProfile`, `intronProfile`, `spliceSiteProfile` and `metaGeneProfile`
should be in the `gff3` format and download from
<https://www.gencodegenes.org/>. In the
*[cliProfiler](https://bioconductor.org/packages/3.22/cliProfiler)* package, we include a test `gff3` file.

```
## the path for the test gff3 file
test_gff3 <- file.path(testpath, "annotation_test.gff3")
## the gff3 file can be loaded by import.gff3 function in rtracklayer package
shown_gff3 <- rtracklayer::import.gff3(test_gff3)
## show the test gff3 file
shown_gff3
```

```
## GRanges object with 3068 ranges and 23 metadata columns:
##          seqnames              ranges strand |   source            type
##             <Rle>           <IRanges>  <Rle> | <factor>        <factor>
##      [1]     chr1   72159442-72212307      - |   HAVANA     transcript
##      [2]     chr1   72212017-72212307      - |   HAVANA     exon
##      [3]     chr1   72212017-72212111      - |   HAVANA     CDS
##      [4]     chr1   72212109-72212111      - |   HAVANA     start_codon
##      [5]     chr1   72192043-72192202      - |   HAVANA     exon
##      ...      ...                 ...    ... .      ...             ...
##   [3064]     chrX 153392866-153392868      + |   HAVANA stop_codon
##   [3065]     chrX 153237748-153238092      + |   HAVANA five_prime_UTR
##   [3066]     chrX 153308852-153308924      + |   HAVANA five_prime_UTR
##   [3067]     chrX 153370845-153370846      + |   HAVANA five_prime_UTR
##   [3068]     chrX 153392869-153396132      + |   HAVANA three_prime_UTR
##              score     phase                     ID               gene_id
##          <numeric> <integer>            <character>           <character>
##      [1]        NA      <NA>   ENSMUST00000048860.8  ENSMUSG00000039395.8
##      [2]        NA      <NA> exon:ENSMUST00000048..  ENSMUSG00000039395.8
##      [3]        NA         0 CDS:ENSMUST000000488..  ENSMUSG00000039395.8
##      [4]        NA         0 start_codon:ENSMUST0..  ENSMUSG00000039395.8
##      [5]        NA      <NA> exon:ENSMUST00000048..  ENSMUSG00000039395.8
##      ...       ...       ...                    ...                   ...
##   [3064]        NA         0 stop_codon:ENSMUST00.. ENSMUSG00000041649.13
##   [3065]        NA      <NA> UTR5:ENSMUST00000112.. ENSMUSG00000041649.13
##   [3066]        NA      <NA> UTR5:ENSMUST00000112.. ENSMUSG00000041649.13
##   [3067]        NA      <NA> UTR5:ENSMUST00000112.. ENSMUSG00000041649.13
##   [3068]        NA      <NA> UTR3:ENSMUST00000112.. ENSMUSG00000041649.13
##               gene_type   gene_name       level      mgi_id
##             <character> <character> <character> <character>
##      [1] protein_coding        Mreg           2 MGI:2151839
##      [2] protein_coding        Mreg           2 MGI:2151839
##      [3] protein_coding        Mreg           2 MGI:2151839
##      [4] protein_coding        Mreg           2 MGI:2151839
##      [5] protein_coding        Mreg           2 MGI:2151839
##      ...            ...         ...         ...         ...
##   [3064] protein_coding        Klf8           2 MGI:2442430
##   [3065] protein_coding        Klf8           2 MGI:2442430
##   [3066] protein_coding        Klf8           2 MGI:2442430
##   [3067] protein_coding        Klf8           2 MGI:2442430
##   [3068] protein_coding        Klf8           2 MGI:2442430
##                   havana_gene               Parent        transcript_id
##                   <character>      <CharacterList>          <character>
##      [1] OTTMUSG00000049069.1 ENSMUSG00000039395.8 ENSMUST00000048860.8
##      [2] OTTMUSG00000049069.1 ENSMUST00000048860.8 ENSMUST00000048860.8
##      [3] OTTMUSG00000049069.1 ENSMUST00000048860.8 ENSMUST00000048860.8
##      [4] OTTMUSG00000049069.1 ENSMUST00000048860.8 ENSMUST00000048860.8
##      [5] OTTMUSG00000049069.1 ENSMUST00000048860.8 ENSMUST00000048860.8
##      ...                  ...                  ...                  ...
##   [3064] OTTMUSG00000019377.5 ENSMUST00000112574.8 ENSMUST00000112574.8
##   [3065] OTTMUSG00000019377.5 ENSMUST00000112574.8 ENSMUST00000112574.8
##   [3066] OTTMUSG00000019377.5 ENSMUST00000112574.8 ENSMUST00000112574.8
##   [3067] OTTMUSG00000019377.5 ENSMUST00000112574.8 ENSMUST00000112574.8
##   [3068] OTTMUSG00000019377.5 ENSMUST00000112574.8 ENSMUST00000112574.8
##          transcript_type transcript_name transcript_support_level
##              <character>     <character>              <character>
##      [1]  protein_coding        Mreg-201                        1
##      [2]  protein_coding        Mreg-201                        1
##      [3]  protein_coding        Mreg-201                        1
##      [4]  protein_coding        Mreg-201                        1
##      [5]  protein_coding        Mreg-201                        1
##      ...             ...             ...                      ...
##   [3064]  protein_coding        Klf8-202                        1
##   [3065]  protein_coding        Klf8-202                        1
##   [3066]  protein_coding        Klf8-202                        1
##   [3067]  protein_coding        Klf8-202                        1
##   [3068]  protein_coding        Klf8-202                        1
##                                                     tag    havana_transcript
##                                         <CharacterList>          <character>
##      [1]                  basic,appris_principal_1,CCDS OTTMUST00000125321.1
##      [2]                  basic,appris_principal_1,CCDS OTTMUST00000125321.1
##      [3]                  basic,appris_principal_1,CCDS OTTMUST00000125321.1
##      [4]                  basic,appris_principal_1,CCDS OTTMUST00000125321.1
##      [5]                  basic,appris_principal_1,CCDS OTTMUST00000125321.1
##      ...                                            ...                  ...
##   [3064] alternative_5_UTR,basic,appris_principal_1,... OTTMUST00000046245.1
##   [3065] alternative_5_UTR,basic,appris_principal_1,... OTTMUST00000046245.1
##   [3066] alternative_5_UTR,basic,appris_principal_1,... OTTMUST00000046245.1
##   [3067] alternative_5_UTR,basic,appris_principal_1,... OTTMUST00000046245.1
##   [3068] alternative_5_UTR,basic,appris_principal_1,... OTTMUST00000046245.1
##                    protein_id      ccdsid   trans_len exon_number
##                   <character> <character> <character> <character>
##      [1] ENSMUSP00000041878.7 CCDS15032.1        2284        <NA>
##      [2] ENSMUSP00000041878.7 CCDS15032.1        2284           1
##      [3] ENSMUSP00000041878.7 CCDS15032.1        2284           1
##      [4] ENSMUSP00000041878.7 CCDS15032.1        2284           1
##      [5] ENSMUSP00000041878.7 CCDS15032.1        2284           2
##      ...                  ...         ...         ...         ...
##   [3064] ENSMUSP00000108193.2 CCDS30481.1        4752           7
##   [3065] ENSMUSP00000108193.2 CCDS30481.1        4752           1
##   [3066] ENSMUSP00000108193.2 CCDS30481.1        4752           2
##   [3067] ENSMUSP00000108193.2 CCDS30481.1        4752           3
##   [3068] ENSMUSP00000108193.2 CCDS30481.1        4752           7
##                       exon_id
##                   <character>
##      [1]                 <NA>
##      [2] ENSMUSE00000600755.2
##      [3] ENSMUSE00000600755.2
##      [4] ENSMUSE00000600755.2
##      [5] ENSMUSE00000262166.1
##      ...                  ...
##   [3064] ENSMUSE00000692289.2
##   [3065] ENSMUSE00000745002.1
##   [3066] ENSMUSE00000692290.1
##   [3067] ENSMUSE00000253395.2
##   [3068] ENSMUSE00000692289.2
##   -------
##   seqinfo: 19 sequences from an unspecified genome; no seqlengths
```

The function `windowProfile` allows users to find out the enrichment of peaks
against the customized annotation file. This customized annotation file should
be stored in the **GRanges** object.

# 3 metaGeneProfile

`metaGeneProfile()` outputs a meta profile, which shows the location of binding
sites or modification sites `( peaks/signals)` along transcript regions
(5’UTR, CDS and 3’UTR). The input of this function should be a `GRanges`
object.

Besides the `GRanges` object, a path to the `gff3` annotation file which
download from [Gencode](https://www.gencodegenes.org/) is required by
`metaGeneProfile`.

The output of `metaGeneProfile` is a `List` objects. The `List` one contains
the GRanges objects with the calculation result which can be used in different
ways later.

```
meta <- metaGeneProfile(object = test, annotation = test_gff3)
meta[[1]]
```

```
## GRanges object with 100 ranges and 5 metadata columns:
##         seqnames              ranges strand |    center    location
##            <Rle>           <IRanges>  <Rle> | <integer> <character>
##     [1]    chr10 118860137-118860157      - | 118860147         CDS
##     [2]     chr2   84602546-84602566      - |  84602556        UTR3
##     [3]    chr18     6111874-6111894      - |   6111884         CDS
##     [4]    chr11   33213145-33213165      - |  33213155        UTR3
##     [5]    chr11   96819422-96819442      - |  96819432         CDS
##     ...      ...                 ...    ... .       ...         ...
##    [96]     chr8   72222842-72222862      + |  72222852          NO
##    [97]    chr18   36648184-36648204      + |  36648194         CDS
##    [98]     chr8 105216021-105216041      + | 105216031        UTR3
##    [99]     chr7 127254692-127254712      + | 127254702        UTR3
##   [100]     chr9   44607255-44607275      + |  44607265        UTR5
##                       Gene_ID         Transcript_ID  Position
##                   <character>           <character> <numeric>
##     [1]  ENSMUSG00000028630.9  ENSMUST00000004281.9  0.674444
##     [2] ENSMUSG00000034101.14  ENSMUST00000067232.9  0.122384
##     [3] ENSMUSG00000041225.16 ENSMUST00000077128.12  0.199836
##     [4] ENSMUSG00000040594.19  ENSMUST00000102815.9  0.159303
##     [5] ENSMUSG00000038615.17  ENSMUST00000107658.7  0.889039
##     ...                   ...                   ...       ...
##    [96]                   Nan                  <NA> 5.0000000
##    [97]  ENSMUSG00000117942.1  ENSMUST00000140061.7 0.1694561
##    [98] ENSMUSG00000031885.14  ENSMUST00000109392.8 0.0457421
##    [99]  ENSMUSG00000054716.4  ENSMUST00000052509.5 0.3978495
##   [100] ENSMUSG00000032097.10  ENSMUST00000217034.1 0.5779817
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

Here is an explanation of the metaData columns of the output GRanges objects:

* **center** The center position of each peaks. This center position is used
  for calculating the position of peaks within the assigned genomic regions.
* **location** The genomic region to which this `peak/signal` belongs to.
* **Gene ID** The gene to which this `peak/signal` belongs.
* **Position** The relative position of each `peak/signal` within the genomic
  region. This value close to 0 means this peak located close to the 5’ end of
  the genomic feature. The position value close to 1 means the peak close to the
  3’ end of the genomic feature. Value 5 means this peaks can not be mapped to
  any annotation.

The `List` two is the meta plot which in the `ggplot` class. The user can use
all the functions from `ggplot2` to change the detail of this plot.

```
library(ggplot2)
## For example if user want to have a new name for the plot
meta[[2]] + ggtitle("Meta Profile 2")
```

![](data:image/png;base64...)

For the advance usage, the `metaGeneProfile` provides two methods to calculate
the relative position. The first method return a relative position of the
`peaks/signals` in the genomic feature without the introns. The second method
return a relative position value of the peak in the genomic feature with the
introns. With the parameter `include_intron` we can easily shift between these
two methods. If the data is a polyA plus data, we will recommend you to set
`include_intron = FALSE`.

```
meta <- metaGeneProfile(object = test, annotation = test_gff3,
                        include_intron = TRUE)
meta[[2]]
```

![](data:image/png;base64...)

The `group` option allows user to make a meta plot with multiple conditions.
Here is an example:

```
test$Treat <- c(rep("Treatment 1",50), rep("Treatment 2", 50))
meta <- metaGeneProfile(object = test, annotation = test_gff3,
                        group = "Treat")
meta[[2]]
```

![](data:image/png;base64...)

Besides, we provide an annotation filtering option for making the meta plot.
The `exlevel` and `extranscript_support_level` could be used for specifying
which *level* or *transcript support level* should be excluded. For excluding
the *transcript support level* NA, user can use *6* instead of NA. About more
information of *level* and *transcript support level* you can check the
[Gencode data format](https://www.gencodegenes.org/pages/data_format.html).

```
metaGeneProfile(object = test, annotation = test_gff3, exlevel = 3,
                extranscript_support_level = c(4,5,6))
```

The `split` option could help to make the meta profile for the `peaks/signals`
in 5’UTR, CDS and 3’UTR separately. The grey dotted line represents the peaks’s
distribution across all region.

```
meta <- metaGeneProfile(object = test, annotation = test_gff3, split = TRUE)
meta[[2]]
```

![](data:image/png;base64...)

# 4 intronProfile

The function `intronProfile` generates the profile of `peaks/signals` in the
intronic region. Here is an example for a quick use of `intronProfile`.

```
intron <-  intronProfile(test, test_gff3)
```

Similar to metaGeneProfile, the output of `intronProfile` is a `List` object
which contains two `Lists`. `List` one is the input GRanges objects with the
calculation result.

```
intron[[1]]
```

```
## GRanges object with 100 ranges and 7 metadata columns:
##         seqnames              ranges strand |       Treat    center  Intron_S
##            <Rle>           <IRanges>  <Rle> | <character> <integer> <numeric>
##     [1]    chr17   28748198-28748218      + | Treatment 1  28748208         0
##     [2]     chr2 148684461-148684481      + | Treatment 1 148684471         0
##     [3]     chr7     5097955-5097975      + | Treatment 1   5097965         0
##     [4]     chr4 139648373-139648393      + | Treatment 1 139648383 139645102
##     [5]     chr7   27580623-27580643      + | Treatment 1  27580633         0
##     ...      ...                 ...    ... .         ...       ...       ...
##    [96]    chr17   46148089-46148109      - | Treatment 2  46148099         0
##    [97]    chr11   78074094-78074114      - | Treatment 2  78074104         0
##    [98]     chr2   28833830-28833850      - | Treatment 2  28833840         0
##    [99]     chr1 133621331-133621351      - | Treatment 2 133621341         0
##   [100]     chr4 130316598-130316618      - | Treatment 2 130316608         0
##          Intron_E Intron_length Intron_transcript_id Intron_map
##         <numeric>     <numeric>          <character>  <numeric>
##     [1]         0             0                   NO   3.000000
##     [2]         0             0                   NO   3.000000
##     [3]         0             0                   NO   3.000000
##     [4] 139653534          8433 ENSMUST00000178644.1   0.389067
##     [5]         0             0                   NO   3.000000
##     ...       ...           ...                  ...        ...
##    [96]         0             0                   NO          3
##    [97]         0             0                   NO          3
##    [98]         0             0                   NO          3
##    [99]         0             0                   NO          3
##   [100]         0             0                   NO          3
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

The explanation of meta data in the output of `intronProfile` list one is
pasted down below:

* **center** The center position of each peaks. This center position is used
  for calculating the position of peaks within the genomic regions.
* **Intron\_S and Intron\_E** The start and end coordinates of the intron
  to which the peak is assigned.
* **Intron\_length** The length of the intron to which the peak is assigned.
* **Intron\_transcript\_id** The transcript ID for the intron.
* **Intron\_map** The relative position of each peak within the assigned intron.
  This value close to 0 means this peak located close to the 5’ SS. The position
  value close to one means the peak close to the 3’ SS. Value 3 means this peaks
  can not map to any intron.

The `List` two includes a *ggplot* object.

```
intron[[2]]
```

![](data:image/png;base64...)

Similar to metaGeneProfile, in intronProfile, we provide options , such as
`group`, `exlevel` and `extranscript_support_level`. The `group` function could
be used to generate the comparison plot.

```
intron <-  intronProfile(test, test_gff3, group = "Treat")
intron[[2]]
```

![](data:image/png;base64...)

The parameter `exlevel` and `extranscript_support_level` could be used for
specifying which *level* or *transcript support level* should be excluded.
For excluding the *transcript support level* NA, you can use *6*. About more
information of *level* and *transcript support level* you can check the
[Gencode data format](https://www.gencodegenes.org/pages/data_format.html).

```
intronProfile(test, test_gff3, group = "Treat", exlevel = 3,
    extranscript_support_level = c(4,5,6))
```

```
## $Peaks
## GRanges object with 100 ranges and 7 metadata columns:
##         seqnames              ranges strand |       Treat    center  Intron_S
##            <Rle>           <IRanges>  <Rle> | <character> <integer> <numeric>
##     [1]    chr17   28748198-28748218      + | Treatment 1  28748208         0
##     [2]     chr2 148684461-148684481      + | Treatment 1 148684471         0
##     [3]     chr7     5097955-5097975      + | Treatment 1   5097965         0
##     [4]     chr4 139648373-139648393      + | Treatment 1 139648383         0
##     [5]     chr7   27580623-27580643      + | Treatment 1  27580633         0
##     ...      ...                 ...    ... .         ...       ...       ...
##    [96]    chr17   46148089-46148109      - | Treatment 2  46148099         0
##    [97]    chr11   78074094-78074114      - | Treatment 2  78074104         0
##    [98]     chr2   28833830-28833850      - | Treatment 2  28833840         0
##    [99]     chr1 133621331-133621351      - | Treatment 2 133621341         0
##   [100]     chr4 130316598-130316618      - | Treatment 2 130316608         0
##          Intron_E Intron_length Intron_transcript_id Intron_map
##         <numeric>     <numeric>          <character>  <numeric>
##     [1]         0             0                   NO          3
##     [2]         0             0                   NO          3
##     [3]         0             0                   NO          3
##     [4]         0             0                   NO          3
##     [5]         0             0                   NO          3
##     ...       ...           ...                  ...        ...
##    [96]         0             0                   NO          3
##    [97]         0             0                   NO          3
##    [98]         0             0                   NO          3
##    [99]         0             0                   NO          3
##   [100]         0             0                   NO          3
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
##
## $Plot
```

![](data:image/png;base64...)

Moreover, in the intronProfile we provide parameters `maxLength` and
`minLength` to filter the maximum and minimum length of the intron.

```
intronProfile(test, test_gff3, group = "Treat", maxLength = 10000,
    minLength = 50)
```

```
## $Peaks
## GRanges object with 100 ranges and 7 metadata columns:
##         seqnames              ranges strand |       Treat    center  Intron_S
##            <Rle>           <IRanges>  <Rle> | <character> <integer> <numeric>
##     [1]    chr17   28748198-28748218      + | Treatment 1  28748208         0
##     [2]     chr2 148684461-148684481      + | Treatment 1 148684471         0
##     [3]     chr7     5097955-5097975      + | Treatment 1   5097965         0
##     [4]     chr4 139648373-139648393      + | Treatment 1 139648383 139645102
##     [5]     chr7   27580623-27580643      + | Treatment 1  27580633         0
##     ...      ...                 ...    ... .         ...       ...       ...
##    [96]    chr17   46148089-46148109      - | Treatment 2  46148099         0
##    [97]    chr11   78074094-78074114      - | Treatment 2  78074104         0
##    [98]     chr2   28833830-28833850      - | Treatment 2  28833840         0
##    [99]     chr1 133621331-133621351      - | Treatment 2 133621341         0
##   [100]     chr4 130316598-130316618      - | Treatment 2 130316608         0
##          Intron_E Intron_length Intron_transcript_id Intron_map
##         <numeric>     <numeric>          <character>  <numeric>
##     [1]         0             0                   NO   3.000000
##     [2]         0             0                   NO   3.000000
##     [3]         0             0                   NO   3.000000
##     [4] 139653534          8433 ENSMUST00000178644.1   0.389067
##     [5]         0             0                   NO   3.000000
##     ...       ...           ...                  ...        ...
##    [96]         0             0                   NO          3
##    [97]         0             0                   NO          3
##    [98]         0             0                   NO          3
##    [99]         0             0                   NO          3
##   [100]         0             0                   NO          3
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
##
## $Plot
```

![](data:image/png;base64...)

# 5 exonProfile

The `exonProfile` could help to generate a profile of `peaks/signals` in the
exons which **surrounded by introns**. The output of exonProfile is a `List`
object. The `List` one is the `GRanges` objects of input data with the
calculation result.

```
## Quick use
exon <- exonProfile(test, test_gff3)
exon[[1]]
```

```
## GRanges object with 100 ranges and 7 metadata columns:
##         seqnames              ranges strand |       Treat    center    exon_S
##            <Rle>           <IRanges>  <Rle> | <character> <integer> <numeric>
##     [1]    chr17   28748198-28748218      + | Treatment 1  28748208  28746271
##     [2]     chr2 148684461-148684481      + | Treatment 1 148684471 148683594
##     [3]     chr7     5097955-5097975      + | Treatment 1   5097965   5097572
##     [4]     chr4 139648373-139648393      + | Treatment 1 139648383 139648158
##     [5]     chr7   27580623-27580643      + | Treatment 1  27580633  27580337
##     ...      ...                 ...    ... .         ...       ...       ...
##    [96]    chr17   46148089-46148109      - | Treatment 2  46148099         0
##    [97]    chr11   78074094-78074114      - | Treatment 2  78074104         0
##    [98]     chr2   28833830-28833850      - | Treatment 2  28833840  28833550
##    [99]     chr1 133621331-133621351      - | Treatment 2 133621341 133619940
##   [100]     chr4 130316598-130316618      - | Treatment 2 130316608         0
##            exon_E exon_length    exon_transcript_id  exon_map
##         <numeric>   <numeric>           <character> <numeric>
##     [1]  28748406        2136 ENSMUST00000004990.13  0.906835
##     [2] 148684968        1375  ENSMUST00000028928.7  0.637818
##     [3]   5098178         607  ENSMUST00000098845.9  0.647446
##     [4] 139649690        1533  ENSMUST00000039818.9  0.146771
##     [5]  27582099        1763 ENSMUST00000067386.13  0.167896
##     ...       ...         ...                   ...       ...
##    [96]         0           0                    NO  3.000000
##    [97]         0           0                    NO  3.000000
##    [98]  28835373        1824  ENSMUST00000037117.5  0.840461
##    [99] 133621801        1862  ENSMUST00000186476.6  0.247046
##   [100]         0           0                    NO  3.000000
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

Here is the explanation of the meta data column that output from
`exonProfile`:

* **center** The center position of each peaks. This center position is used
  for calculating the position of peaks within the genomic regions.
* **exon\_S and exon\_E** The start and end coordinates of the exon to which the
  peak is assigned.
* **exon\_length** The length of the exon to which the peak is assigned.
* **exon\_transcript\_id** The transcript ID for the assigned exon.
* **exon\_map** The relative position of each peak within the assigned exon.
  This value close to 0 means this peak located close to the 3’ SS. The position
  value close to one means the peak close to the 5’ SS. Value 3 means this peaks
  can not be assigned to any annotation.

The `List` two is a *ggplot* object which contains the exon profile.

```
exon[[2]]
```

![](data:image/png;base64...)

The usage of all parameters of `exonProfile` is similar to `intronProfile`. For
more detail of parameter usage please check the `intronProfile` section.

# 6 windowProfile

Since the `metaGeneProfile`, `intronProfile` and `exonProfile` require a
annotation file in `gff3` format and downloaded from
<https://www.gencodegenes.org/>. These functions
could only be used for *human* and *mouse*. For the user who works on other
species or has a customized annotation file (not in gff3 format), we develop
the function `windowProfile`.

`windowProfile` requires GRanges object as input and annotation. And
`windowProfile` output the relative position of each peak within the given
annotation GRanges. For example, if user would like to make a profile against
all the exons with `windowProfile`, you just need to first extract all the
exonic region as a GRanges object then run the `windowProfile`. Here is an
example about using `windowProfile` to generate the profile.

```
library(rtracklayer)
## Extract all the exon annotation
test_anno <- rtracklayer::import.gff3(test_gff3)
test_anno <- test_anno[test_anno$type == "exon"]
## Run the windowProfile
window_profile <- windowProfile(test, test_anno)
```

The output of `windowProfile` is a `List` objects. In the `List` one, you will
find the GRanges object of input peaks and calculation result. And the `List`
two contains the *ggplot* of `windowProfile`.

```
window_profile[[1]]
```

```
## GRanges object with 100 ranges and 6 metadata columns:
##         seqnames              ranges strand |       Treat    center  window_S
##            <Rle>           <IRanges>  <Rle> | <character> <integer> <numeric>
##     [1]    chr17   28748198-28748218      + | Treatment 1  28748208  28746271
##     [2]     chr2 148684461-148684481      + | Treatment 1 148684471 148683594
##     [3]     chr7     5097955-5097975      + | Treatment 1   5097965   5097572
##     [4]     chr4 139648373-139648393      + | Treatment 1 139648383 139648158
##     [5]     chr7   27580623-27580643      + | Treatment 1  27580633  27580337
##     ...      ...                 ...    ... .         ...       ...       ...
##    [96]    chr17   46148089-46148109      - | Treatment 2  46148099  46147387
##    [97]    chr11   78074094-78074114      - | Treatment 2  78074104  78073376
##    [98]     chr2   28833830-28833850      - | Treatment 2  28833840  28833550
##    [99]     chr1 133621331-133621351      - | Treatment 2 133621341 133619940
##   [100]     chr4 130316598-130316618      - | Treatment 2 130316608 130315383
##          window_E window_length window_map
##         <numeric>     <numeric>  <numeric>
##     [1]  28748406          2136   0.906835
##     [2] 148684968          1375   0.637818
##     [3]   5098178           607   0.647446
##     [4] 139649690          1533   0.146771
##     [5]  27582099          1763   0.167896
##     ...       ...           ...        ...
##    [96]  46148284           898  0.2060134
##    [97]  78074174           799  0.0876095
##    [98]  28835373          1824  0.8404605
##    [99] 133621801          1862  0.2470462
##   [100] 130316808          1426  0.1402525
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

Here is an explanation of the output of `windowProfile`:

* **center** The center position of each peaks. This center position is used
  for calculating the position of peaks within the genomic regions.
* **window\_S and window\_E** The boundary of the annotation to which the peak is
  assigned.
* **window\_length** The length of the annotation feature.
* **window\_map** The relative position of each peak. This value close to 0
  means this peak located close to the 5’ end of the annotation. The position
  value close to one means the peak close to the 3’ end. Value 3 means this
  peaks can not map to any annotation.

```
window_profile[[2]]
```

![](data:image/png;base64...)

# 7 motifProfile

`motifProfile` generates the motif enrichment profile around the center of the
input peaks. The [IUPAC code](https://www.bioinformatics.org/sms/iupac.html)
could be used for the `motif` parameter. The `IUPAC` code includes: A, T, C, G,
R, Y, S, W, K, M, B, D, H, V, N. The parameter `flanking` represents to the
size of window that user would like to check around the center of peaks. The
parameter `fraction` could be used to change the y-axis from *frequency* to
*fraction*.

For using the `motifProtile`, the `BSgenome` with the sequence information of
the species that you are working with is required.

```
## Example for running the motifProfile
## The working species is mouse with mm10 annotation.
## Therefore the package 'BSgenome.Mmusculus.UCSC.mm10' need to be installed in
## advance.
motif <- motifProfile(test, motif = "DRACH",
    genome = "BSgenome.Mmusculus.UCSC.mm10",
    fraction = TRUE, title = "Motif Profile",
    flanking = 10)
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

The output of `motifProfile` is a `List` object. `List` 1 contains the
`data.frame` of the motif enrichment information for each position around the
center of the input `peaks/signals`. `List` 2 is the *ggplot* object of the
plot of motif enrichment.

```
motif[[1]]
```

```
##    Position Fraction
## 5       -10     0.02
## 6        -9     0.04
## 7        -8     0.04
## 8        -7     0.02
## 9        -6     0.01
## 10       -5     0.01
## 11       -4     0.00
## 12       -3     0.00
## 13       -2     0.94
## 14       -1     0.00
## 15        0     0.00
## 16        1     0.00
## 17        2     0.06
## 18        3     0.02
## 19        4     0.03
## 20        5     0.02
## 21        6     0.01
## 22        7     0.02
## 23        8     0.00
## 24        9     0.03
## 25       10     0.03
```

Each bar in the plot of `motifProfile` represents for the start site of the
motif that is defined by the user.

```
motif[[2]]
```

![](data:image/png;base64...)

# 8 geneTypeProfile

The `geneTypeProfile` could give users the information of the gene type of the
input peaks. The input peaks for `geneTypeProfile` should be stored in the
GRanges objects. The annotation file should be a `gff3` file and downloaded
from <https://www.gencodegenes.org/>.

```
## Quick use of geneTypeProfile
geneTP <- geneTypeProfile(test, test_gff3)
```

The output of `geneTypeProfile` is an `List` object. `List` one includes a
GRanges object with the input peaks and the assignment information.

```
geneTP[[1]]
```

```
## GRanges object with 100 ranges and 4 metadata columns:
##         seqnames              ranges strand |       Treat    center
##            <Rle>           <IRanges>  <Rle> | <character> <integer>
##     [1]    chr17   28748198-28748218      + | Treatment 1  28748208
##     [2]    chr10 118860137-118860157      - | Treatment 1 118860147
##     [3]     chr2 148684461-148684481      + | Treatment 1 148684471
##     [4]     chr2   84602546-84602566      - | Treatment 1  84602556
##     [5]    chr18     6111874-6111894      - | Treatment 1   6111884
##     ...      ...                 ...    ... .         ...       ...
##    [96]     chr7 127254692-127254712      + | Treatment 2 127254702
##    [97]     chr2   28833830-28833850      - | Treatment 2  28833840
##    [98]     chr9   44607255-44607275      + | Treatment 2  44607265
##    [99]     chr1 133621331-133621351      - | Treatment 2 133621341
##   [100]     chr4 130316598-130316618      - | Treatment 2 130316608
##               geneType               Gene_ID
##            <character>           <character>
##     [1] protein_coding ENSMUSG00000053436.15
##     [2] protein_coding  ENSMUSG00000028630.9
##     [3] protein_coding  ENSMUSG00000027439.9
##     [4] protein_coding ENSMUSG00000034101.14
##     [5] protein_coding ENSMUSG00000041225.16
##     ...            ...                   ...
##    [96] protein_coding  ENSMUSG00000054716.4
##    [97] protein_coding ENSMUSG00000035666.14
##    [98] protein_coding ENSMUSG00000032097.10
##    [99] protein_coding  ENSMUSG00000094410.7
##   [100] protein_coding ENSMUSG00000028772.19
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

Here is an explanation of the output GRanges object from the
`geneTypeProfile`.

* **center** The center position of each peaks. This center position is used
  for calculating the position of peaks within the genomic regions.
* **geneType** The gene type of the gene to which the peak is assigned.
* **Gene\_ID** The gene ID to which the peak is assigned.

```
geneTP[[2]]
```

```
## Warning: The dot-dot notation (`..count..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(count)` instead.
## ℹ The deprecated feature was likely used in the cliProfiler package.
##   Please report the issue at <https://github.com/Codezy99/cliProfiler/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

# 9 spliceSiteProfile

The `spliceSiteProfile` gives users the information of the enrichment of peaks
around the 5’ and 3’ splice site (SS) in the absolute distance.

```
SSprofile <- spliceSiteProfile(test, test_gff3, flanking=200, bin=40)
```

The output of `spliceSiteProfile` is a `List` object. The `List` one includes
the GRanges object of input peaks and the position information of this peak
around the SS.

```
SSprofile[[1]]
```

```
## GRanges object with 100 ranges and 4 metadata columns:
##         seqnames              ranges strand |       Treat    center Position5SS
##            <Rle>           <IRanges>  <Rle> | <character> <integer>   <integer>
##     [1]    chr10 118860137-118860157      - | Treatment 1 118860147        <NA>
##     [2]     chr2   84602546-84602566      - | Treatment 1  84602556        <NA>
##     [3]    chr18     6111874-6111894      - | Treatment 1   6111884        -200
##     [4]    chr11   33213145-33213165      - | Treatment 1  33213155        <NA>
##     [5]    chr11   96819422-96819442      - | Treatment 1  96819432        <NA>
##     ...      ...                 ...    ... .         ...       ...         ...
##    [96]     chr8   72222842-72222862      + | Treatment 2  72222852        <NA>
##    [97]    chr18   36648184-36648204      + | Treatment 2  36648194        <NA>
##    [98]     chr8 105216021-105216041      + | Treatment 2 105216031        <NA>
##    [99]     chr7 127254692-127254712      + | Treatment 2 127254702        <NA>
##   [100]     chr9   44607255-44607275      + | Treatment 2  44607265        <NA>
##         Position3SS
##           <integer>
##     [1]        <NA>
##     [2]        <NA>
##     [3]        <NA>
##     [4]        <NA>
##     [5]        <NA>
##     ...         ...
##    [96]        <NA>
##    [97]        <NA>
##    [98]        <NA>
##    [99]        <NA>
##   [100]        <NA>
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

Here is an explanation of output of `spliceSiteProfile`.

* **center** The center position of each peaks. This center position is used
  for calculating the position of peaks to the splice site.
* **Position5SS** The absolute distance between peak and 5’SS. Negative value
  means the peak locates in the exonic region. Positive value means the peaks
  located in the intron.
* **Position3SS** The absolute distance between peak and 3’SS. Negative value
  means the peak locates in the intronic region. Positive value means the peaks
  located in the exon.

```
SSprofile[[2]]
```

![](data:image/png;base64...)

Similar to `metaProfile`, The parameter `exlevel` and
`extranscript_support_level` could be used for
specifying which *level* or *transcript support level* should be excluded.
For excluding the *transcript support level* NA, you can use *6*. About more
information of *level* and *transcript support level* you can check the
[Gencode data format](https://www.gencodegenes.org/pages/data_format.html).

```
spliceSiteProfile(test, test_gff3, flanking=200, bin=40, exlevel=3,
                        extranscript_support_level = 6,
                        title = "Splice Site Profile")
```

# 10 SessionInfo

The following is the session info that generated this vignette:

```
sessionInfo()
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Mmusculus.UCSC.mm10_1.4.3 BSgenome_1.78.0
##  [3] BiocIO_1.20.0                      Biostrings_2.78.0
##  [5] XVector_0.50.0                     rtracklayer_1.70.0
##  [7] GenomicRanges_1.62.0               Seqinfo_1.0.0
##  [9] IRanges_2.44.0                     ggplot2_4.0.0
## [11] cliProfiler_1.16.0                 S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0                generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
##  [3] rjson_0.2.23                xfun_0.53
##  [5] bslib_0.9.0                 Biobase_2.70.0
##  [7] lattice_0.22-7              vctrs_0.6.5
##  [9] tools_4.5.1                 bitops_1.0-9
## [11] curl_7.0.0                  parallel_4.5.1
## [13] tibble_3.3.0                pkgconfig_2.0.3
## [15] Matrix_1.7-4                RColorBrewer_1.1-3
## [17] cigarillo_1.0.0             S7_0.2.0
## [19] lifecycle_1.0.4             compiler_4.5.1
## [21] farver_2.1.2                Rsamtools_2.26.0
## [23] tinytex_0.57                codetools_0.2-20
## [25] htmltools_0.5.8.1           sass_0.4.10
## [27] RCurl_1.98-1.17             yaml_2.3.10
## [29] pillar_1.11.1               crayon_1.5.3
## [31] jquerylib_0.1.4             BiocParallel_1.44.0
## [33] cachem_1.1.0                DelayedArray_0.36.0
## [35] magick_2.9.0                abind_1.4-8
## [37] tidyselect_1.2.1            digest_0.6.37
## [39] dplyr_1.1.4                 restfulr_0.0.16
## [41] bookdown_0.45               labeling_0.4.3
## [43] fastmap_1.2.0               grid_4.5.1
## [45] cli_3.6.5                   SparseArray_1.10.0
## [47] magrittr_2.0.4              S4Arrays_1.10.0
## [49] dichromat_2.0-0.1           XML_3.99-0.19
## [51] withr_3.0.2                 scales_1.4.0
## [53] rmarkdown_2.30              httr_1.4.7
## [55] matrixStats_1.5.0           evaluate_1.0.5
## [57] knitr_1.50                  rlang_1.1.6
## [59] Rcpp_1.1.0                  glue_1.8.0
## [61] BiocManager_1.30.26         jsonlite_2.0.0
## [63] R6_2.6.1                    MatrixGenerics_1.22.0
## [65] GenomicAlignments_1.46.0
```