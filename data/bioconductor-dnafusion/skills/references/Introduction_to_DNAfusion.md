# DNAfusion

### <https://github.com/CTrierMaansson/DNAfusion>

Christoffer Trier Maansson1\* and Emma Roger Andersen1

1Department of Clinical Biochemistry, Aarhus University Hospital, Denmark

\*ctm@clin.au.dk

#### 29 Oct 2025

#### Abstract

Circulating tumor DNA (ctDNA) containing somatic mutations can be found in blood plasma.
This includes DNA fusions, such as the EML4-ALK, which can be an oncogenic driver in non-small cell lung cancer. This is an introduction to the **DNAfusion** package for R, which can be used to evaluate whether EML4-ALK is present in blood plasma.

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Package data](#package-data)
* [4 Functions](#functions)
  + [4.1 `EML4_ALK_detection()`](#eml4_alk_detection)
  + [4.2 `EML4_sequence()`](#eml4_sequence)
  + [4.3 `ALK_sequence()`](#alk_sequence)
  + [4.4 `break_position()`](#break_position)
  + [4.5 `break_position_depth()`](#break_position_depth)
  + [4.6 `EML4_ALK_analysis()`](#eml4_alk_analysis)
  + [4.7 `introns_ALK_EML4()`](#introns_alk_eml4)
  + [4.8 `find_variants()`](#find_variants)
* [5 Session info](#session-info)

# 1 Introduction

![](data:image/png;base64...)

This package was created in order to increase the sensitivity of EML4-ALK
detection from commercially available NGS products such as the AVENIO (Roche)
pipeline.

Paired-end sequencing of cfDNA generated BAM files can be used as input to
discover EML4-ALK variants.
This package was developed using position deduplicated BAM files generated with
the AVENIO Oncology Analysis Software.
These files are made using the AVENIO ctDNA surveillance kit and
Illumina Nextseq 500 sequencing.
This is a targeted hybridization NGS approach and includes ALK-specific but not
EML4-specific probes.

The package includes eight functions.

The output of the first function, `EML4_ALK_detection()`, is used to determine
whether EML4-ALK is detected and serves as input for the next four exploratory
functions characterizing the EML4-ALK variant. The last function
`EML4_ALK_analysis()` combines the output of the exploratory functions.
The `introns_ALK_EML4()` function identifies the introns of EML4 and ALK
containing the breakpoint. This is used in the `find_variant()` function which
identifies the EML4-ALK variant.

To serve as examples, this package includes BAM files representing the EML4-ALK
positive cell line H3122 and the EML4-ALK negative cell line, HCC827.

# 2 Installation

Use **Bioconductor** to install the most recent version of
**DNAfusion**

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DNAfusion")
library(DNAfusion)
```

# 3 Package data

BAM files from the cell lines, H3122 and HCC827, are included in the package and
can be used as examples to explore the functions.

```
H3122_bam <- system.file("extdata",
                            "H3122_EML4.bam",
                            package = "DNAfusion")
HCC827_bam <-  system.file("extdata",
                            "HCC827_EML4.bam",
                            package = "DNAfusion")
```

# 4 Functions

## 4.1 `EML4_ALK_detection()`

This function looks for EML4-ALK mate pair reads in the BAM file.

**Input:**
\[\\[0.1in]\]

**`file`**

```
The name of the file which the data are to be read from.
```

\[\\[0.1in]\]

**`genome`**

```
character representing the reference genome.
Can either be "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**`mates`**

```
integer, the minimum number EML4-ALK mate pairs needed to be
detected in order to call a variant. Default = 2.
```

\[\\[0.1in]\]

**Output:**

A `GAlignments` object with soft-clipped reads representing
EML4-ALK is returned. If no EML4-ALK is detected the the `GAlignments`
is empty.

**Examples:**

```
H3122_result <- EML4_ALK_detection(file = H3122_bam,
                        genome = "hg38",
                        mates = 2)
head(H3122_result)
#> GAlignments object with 6 alignments and 2 metadata columns:
#>       seqnames strand       cigar    qwidth     start       end     width
#>          <Rle>  <Rle> <character> <integer> <integer> <integer> <integer>
#>   [1]     chr2      +       94M2S        96  42299657  42299750        94
#>   [2]     chr2      +       92M4S        96  42299659  42299750        92
#>   [3]     chr2      +       92M4S        96  42299659  42299750        92
#>   [4]     chr2      +       91M5S        96  42299660  42299750        91
#>   [5]     chr2      +       91M5S        96  42299660  42299750        91
#>   [6]     chr2      +       87M9S        96  42299664  42299750        87
#>           njunc |      mpos                     seq
#>       <integer> | <integer>          <DNAStringSet>
#>   [1]         0 |  29223479 TTGCTTCTTT...GCAGTGGTCT
#>   [2]         0 |  29223606 GCTTCTTTCA...AGTGGTCTGA
#>   [3]         0 |  29223573 GCTTCTTTCA...AGTGGTCTGA
#>   [4]         0 |  29223650 CTTCTTTCAC...GTGGTCTGAT
#>   [5]         0 |  29223601 CTTCTTTCAC...GTGGTCTGAT
#>   [6]         0 |  29223640 TTTCACTTAG...TCTGATTTTT
#>   -------
#>   seqinfo: 455 sequences from an unspecified genome
```

```
HCC827_result <- EML4_ALK_detection(file = HCC827_bam,
                    genome = "hg38",
                    mates = 2)
HCC827_result
#> GAlignments object with 0 alignments and 0 metadata columns:
#>    seqnames strand       cigar    qwidth     start       end     width
#>       <Rle>  <Rle> <character> <integer> <integer> <integer> <integer>
#>        njunc
#>    <integer>
#>   -------
#>   seqinfo: no sequences
```

## 4.2 `EML4_sequence()`

This function identifies the basepairs leading up to the EML4 breakpoint.

**Input:**
\[\\[0.1in]\]

**`reads`**

```
GAlignments object returned by EML4_ALK_detection().
```

\[\\[0.1in]\]

**`basepairs`**

```
integer, number of basepairs identified from the EML4-ALK fusion.
Default = 20.
```

\[\\[0.1in]\]

**`genome`**

```
character representing the reference genome.
Can either be "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**Output:**

If EML4-ALK is detected, returns a `table` of identified
EML4 basepairs with the number of corresponding reads for each sequence.
If no EML4-ALK is detected “No EML4-ALK was detected” is returned.

**Examples:**

```
EML4_sequence(H3122_result, genome = "hg38", basepairs = 20)
#> EML4_seq
#> CCAGGCTGGAGTGCAGTGGT GGAGTGCAGTGGTGTGATTT TCAGGCTGGAGTGCAGTGGT
#>                   24                    1                    1
EML4_sequence(HCC827_result, genome = "hg38", basepairs = 20)
#> [1] "No EML4-ALK was detected"
```

## 4.3 `ALK_sequence()`

This function identifies the basepairs following the ALK breakpoint.

**Input:**
\[\\[0.1in]\]

**`reads`**

```
GAlignments object returned by EML4_ALK_detection().
```

\[\\[0.1in]\]

**`basepairs`**

```
integer, number of basepairs identified from the EML4-ALK fusion.
Default = 20.
```

\[\\[0.1in]\]

**`genome`**

```
character representing the reference genome.
Can either be "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**Output:**

If EML4-ALK is detected, returns a `table` of identified
ALK basepairs with the number of corresponding reads for each sequence.
If no spanning reads in ALK is detected an empty `GAlignments` object
is returned. If no EML4-ALK is detected “No EML4-ALK was detected” is returned.

**Examples:**

```
ALK_sequence(H3122_result, genome = "hg38", basepairs = 20)
#> ALK_seq
#> AATGCAAAGCTAAAAATCAG ATGCAAAGCTAAAAATCAGA
#>                    1                   36
ALK_sequence(HCC827_result, genome = "hg38", basepairs = 20)
#> [1] "No EML4-ALK was detected"
```

## 4.4 `break_position()`

This function identifies the genomic position in EML4 or ALK,
where the breakpoint has happened.

**Input:**
\[\\[0.1in]\]

**`reads`**

```
GAlignments object returned by EML4_ALK_detection().
```

\[\\[0.1in]\]
**`genome`**

```
character representing the reference genome.
Can either be "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**`gene`**

```
Character string representing the gene. Can be either "ALK" or "EML4".
```

\[\\[0.1in]\]

**Output:**

If EML4-ALK is detected, it returns a `table` of genomic positions
with the number of corresponding reads for each sequence.
If no spanning reads in EML4 or ALK is detected an empty `GAlignments` object is
returned. If no EML4-ALK is detected “No EML4-ALK was detected” is returned.

**Examples:**

```
break_position(H3122_result, genome = "hg38", gene = "EML4")
#> break_pos
#> 42299750 42299757
#>       25        1
break_position(HCC827_result, genome = "hg38", gene = "EML4")
#> [1] "No EML4-ALK was detected"
```

## 4.5 `break_position_depth()`

This function identifies the read depth at the basepair
before the breakpoint in EML4 or ALK.

**Input:**
\[\\[0.1in]\]

**`file`**

```
The name of the file which the data are to be read from.
```

\[\\[0.1in]\]

**`reads`**

```
GAlignments returned by EML4_ALK_detection().
```

\[\\[0.1in]\]
**`genome`**

```
character representing the reference genome.
Can either be "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**`gene`**

```
Character string representing the gene. Can be either "ALK" or "EML4".
```

\[\\[0.1in]\]

**Output:**

If EML4-ALK is detected a single `integer` corresponding
to the read depth at the breakpoint is returned.
If no spanning reads in EML4 or ALK is detected an empty GAlignments object is
returned. If no EML4-ALK is detected “No EML4-ALK was detected” is returned.

**Examples:**

```
break_position_depth(H3122_bam, H3122_result, genome = "hg38", gene = "EML4")
#> [1] 30
break_position_depth(HCC827_bam, HCC827_result, genome = "hg38", gene = "EML4")
#> [1] "No EML4-ALK was detected"
```

## 4.6 `EML4_ALK_analysis()`

This functions collects the results from the other functions of the package.

**Input:**
\[\\[0.1in]\]

**`file`**

```
The name of the file which the data are to be read from.
```

\[\\[0.1in]\]

**`genome`**

```
character representing the reference genome.
Can be either "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**`mates`**

```
integer, the minimum number EML4-ALK mate pairs needed to be detected in
order to call a variant. Default = 2.
```

\[\\[0.1in]\]

**`basepairs`**

```
integer, number of basepairs identified from the EML4-ALK fusion.
Default = 20.
```

\[\\[0.1in]\]

**Output:**

A `list` object with clipped\_reads corresponding to `EML4_ALK_detection()`,
last\_EML4 corresponding to `EML4_sequence()`,
first\_ALK corresponding to `ALK_sequence()`,
breakpoint\_ALK corresponding to `break_position()`, gene = “ALK”,
breakpoint\_EML4 corresponding to `break_position()`, gene = “EML4”,
read\_depth\_ALK corresponding to `break_position_depth()`.gene = “ALK”,
and read\_depth\_EML4 corresponding to `break_position_depth()` gene = “EML4”.
If no EML4-ALK is detected an empty `GAlignments` is returned.

**Examples:**

```
H3122_results <- EML4_ALK_analysis(file = H3122_bam,
                                    genome = "hg38",
                                    mates = 2,
                                    basepairs = 20)
HCC827_results <- EML4_ALK_analysis(file = HCC827_bam,
                                    genome = "hg38",
                                    mates = 2,
                                    basepairs = 20)
```

```
head(H3122_results$clipped_reads)
#> GAlignments object with 6 alignments and 2 metadata columns:
#>       seqnames strand       cigar    qwidth     start       end     width
#>          <Rle>  <Rle> <character> <integer> <integer> <integer> <integer>
#>   [1]     chr2      +       94M2S        96  42299657  42299750        94
#>   [2]     chr2      +       92M4S        96  42299659  42299750        92
#>   [3]     chr2      +       92M4S        96  42299659  42299750        92
#>   [4]     chr2      +       91M5S        96  42299660  42299750        91
#>   [5]     chr2      +       91M5S        96  42299660  42299750        91
#>   [6]     chr2      +       87M9S        96  42299664  42299750        87
#>           njunc |      mpos                     seq
#>       <integer> | <integer>          <DNAStringSet>
#>   [1]         0 |  29223479 TTGCTTCTTT...GCAGTGGTCT
#>   [2]         0 |  29223606 GCTTCTTTCA...AGTGGTCTGA
#>   [3]         0 |  29223573 GCTTCTTTCA...AGTGGTCTGA
#>   [4]         0 |  29223650 CTTCTTTCAC...GTGGTCTGAT
#>   [5]         0 |  29223601 CTTCTTTCAC...GTGGTCTGAT
#>   [6]         0 |  29223640 TTTCACTTAG...TCTGATTTTT
#>   -------
#>   seqinfo: 455 sequences from an unspecified genome
```

```
H3122_results$last_EML4
#> EML4_seq
#> CCAGGCTGGAGTGCAGTGGT GGAGTGCAGTGGTGTGATTT TCAGGCTGGAGTGCAGTGGT
#>                   24                    1                    1

H3122_results$first_ALK
#> ALK_seq
#> AATGCAAAGCTAAAAATCAG ATGCAAAGCTAAAAATCAGA
#>                    1                   36

H3122_results$breakpoint_ALK
#> break_pos
#> 29223740 29223741
#>        1       36

H3122_results$breakpoint_EML4
#> break_pos
#> 42299750 42299757
#>       25        1

H3122_results$read_depth_ALK
#> [1] 827

H3122_results$read_depth_EML4
#> [1] 30

HCC827_results
#> GAlignments object with 0 alignments and 0 metadata columns:
#>    seqnames strand       cigar    qwidth     start       end     width
#>       <Rle>  <Rle> <character> <integer> <integer> <integer> <integer>
#>        njunc
#>    <integer>
#>   -------
#>   seqinfo: no sequences
```

## 4.7 `introns_ALK_EML4()`

This function identifies the introns of ALK and EML4 where
the breakpoint has happened.

**Input:**
\[\\[0.1in]\]
**`file`**

```
The name of the file which the data are to be read from.
```

\[\\[0.1in]\]

**`genome`**

```
character representing the reference genome.
Can be either "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**Output:**

A`dataframe`of the ALK- and EML4-intron of the breakpoint is returned
corresponding to the transcript ENST00000389048.8 for ALK and
ENST00000318522.10 for EML4.
If the breakpoint is not located in introns of ALK or EML4,
“Breakpoint not located in intron of ALK” or
“Breakpoint not located in intron of EML4” is returned.
If no EML4-ALK is detected “No EML4-ALK was detected” is returned.

**Examples:**

```
introns_ALK_EML4(file=H3122_bam,genome="hg38")
#>   intron_ALK intron_EML4
#> 1         19          13
introns_ALK_EML4(file=HCC827_bam,genome="hg38")
#> [1] "No ALK-EML4 was detected"
```

## 4.8 `find_variants()`

This function identifies the EML4-ALK variants as defined by
[Zhang et al. 2021](https://doi.org/10.1016/j.lungcan.2021.06.012)

**Input:**
\[\\[0.1in]\]
**`file`**

```
The name of the file which the data are to be read from.
```

\[\\[0.1in]\]

**`genome`**

```
character representing the reference genome.
Can be either "hg38" or "hg19".
Default = "hg38".
```

\[\\[0.1in]\]

**Output:**

A `dataframe`of the EML4-ALK variant is returned.
If no variant is detected, “No ALK-EML4 was detected” is returned.
If the variant is not defined a `list` with identified introns with
breakpoints is returned.
If the breakpoint could not be identified in either of the genes a `list`
with identified introns with breakpoints is returned.

**Examples:**

```
find_variants(file=H3122_bam,genome="hg38")
#>               Variant Intron_EML4 Intron_ALK
#> 1 Variant 1 (E13,A20)          13         19
find_variants(file=HCC827_bam,genome="hg38")
#> [1] "No ALK-EML4 was detected"
```

# 5 Session info

```
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package   * version date (UTC) lib source
#>  BiocStyle * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DNAfusion * 1.12.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>
#>  [1] /tmp/Rtmpohe4wp/Rinst1845c666d0aa9
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```