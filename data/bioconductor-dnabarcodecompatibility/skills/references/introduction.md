# Contents

* [1 Load the package](#load-the-package)
* [2 Define a helper function to save the raw dataset as a temporary text file](#define-a-helper-function-to-save-the-raw-dataset-as-a-temporary-text-file)
* [3 Design an experiment](#design-an-experiment)
  + [3.1 Examples for single indexing](#examples-for-single-indexing)
  + [3.2 Examples for dual indexing](#examples-for-dual-indexing)
* [4 Build your own workflow](#build-your-own-workflow)
  + [4.1 Load and check a dataset of barcodes](#load-and-check-a-dataset-of-barcodes)
  + [4.2 Examples of an exhaustive search of compatible barcode combinations](#examples-of-an-exhaustive-search-of-compatible-barcode-combinations)
  + [4.3 Examples of a random search of compatible barcode combinations](#examples-of-a-random-search-of-compatible-barcode-combinations)
  + [4.4 Constrain barcodes to be robust against one substitution error](#constrain-barcodes-to-be-robust-against-one-substitution-error)
  + [4.5 Optimize the set of compatible combinations to reduce barcode redundancy](#optimize-the-set-of-compatible-combinations-to-reduce-barcode-redundancy)
  + [4.6 The optimized result isn’t an optimum when filtering out too many barcodes](#the-optimized-result-isnt-an-optimum-when-filtering-out-too-many-barcodes)

This document gives an overview of the DNABarcodeCompatibility R package with a
brief description of the set of tools that it contains. The package includes
six main functions that are briefly described below with examples.
These functions allow one to load a list of DNA barcodes (such as the Illumina
TruSeq small RNA kits), to filter these barcodes according to distance and
nucleotide content criteria, to generate sets of compatible barcode
combinations out of the filtered barcode list, and finally to generate an
optimized selection of barcode combinations for multiplex sequencing
experiments. In particular, the package provides an optimizer function to
favour the selection of compatible barcode combinations with
**least heterogeneity in the frequencies of DNA barcodes**, and allows one to
keep barcodes that are **robust against substitution and insertion/deletion
errors**, thereby facilitating the demultiplexing step.

The DNABarcodeCompatibility package also contains:

* one workflow called `experiment_design()` allowing one to perform all steps
  in one go.
* two data sets called `IlluminaIndexesRaw` and `IlluminaIndexes` for running
  and testing examples.
* a series of API to build your own workflow.

The package deals with the three existing sequencing-by-synthesis chemistries
from Illumina:

* Four-Channel SBS Chemistry: MiSeq, HiSeq systems
* Two-Channel SBS Chemistry: MiniSeq, NextSeq, NovaSeq systems
* One-Channel SBS Chemistry: iSeq system

# 1 Load the package

```
library("DNABarcodeCompatibility")
```

# 2 Define a helper function to save the raw dataset as a temporary text file

```
# This function is created for the purpose of the documentation
export_dataset_to_file =
    function(dataset = DNABarcodeCompatibility::IlluminaIndexesRaw) {
        if ("data.frame" %in% is(dataset)) {
            write.table(dataset,
                        textfile <- tempfile(),
                        row.names = FALSE, col.names = FALSE, quote=FALSE)
            return(textfile)
        } else print(paste("The input dataset isn't a data.frame:",
                            "NOT exported into file"))
    }
```

# 3 Design an experiment

The function `experiment_design()` uses a Shannon-entropy maximization approach
to identify a set of compatible barcode combinations in which the frequencies
of occurrences of the various DNA barcodes are as uniform as possible.
The optimization can be performed in the contexts of single and dual barcoding.
It performs either an exhaustive or a random search of compatible DNA-barcode
combinations, depending on the size of the DNA-barcode set used, and on the
number of samples to be multiplexed.

## 3.1 Examples for single indexing

* 12 libraries sequenced in multiplex of 3 on a HiSeq (4 channels) platform

```
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                    sample_number=12,
                    mplex_level=3,
                    platform=4)
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##    sample Lane    Id sequence
## 1       1    1 RPI12   CTTGTA
## 2       2    1 RPI21   GTTTCG
## 3       3    1 RPI30   CACCGG
## 4       4    2 RPI08   ACTTGA
## 5       5    2 RPI11   GGCTAC
## 6       6    2 RPI22   CGTACG
## 7       7    3 RPI02   CGATGT
## 8       8    3 RPI10   TAGCTT
## 9       9    3 RPI20   GTGGCC
## 10     10    4 RPI01   ATCACG
## 11     11    4 RPI16   CCGTCC
## 12     12    4 RPI43   TACAGC
```

* 12 libraries sequenced in multiplex of 3 on a NextSeq (2 channels) platform

```
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                    sample_number=12,
                    mplex_level=3,
                    platform=2)
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##    sample Lane    Id sequence
## 1       1    1 RPI04   TGACCA
## 2       2    1 RPI07   CAGATC
## 3       3    1 RPI24   GGTAGC
## 4       4    2 RPI13   AGTCAA
## 5       5    2 RPI15   ATGTCA
## 6       6    2 RPI41   GACGAC
## 7       7    3 RPI19   GTGAAA
## 8       8    3 RPI22   CGTACG
## 9       9    3 RPI45   TCATTC
## 10     10    4 RPI06   GCCAAT
## 11     11    4 RPI35   CATTTT
## 12     12    4 RPI48   TCGGCA
```

* 12 libraries sequenced in multiplex of 3 on a iSeq (1 channels) platform

```
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                    sample_number=12,
                    mplex_level=3,
                    platform=1)
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##    sample Lane    Id sequence
## 1       1    1 RPI03   TTAGGC
## 2       2    1 RPI32   CACTCA
## 3       3    1 RPI39   CTATAC
## 4       4    2 RPI15   ATGTCA
## 5       5    2 RPI18   GTCCGC
## 6       6    2 RPI45   TCATTC
## 7       7    3 RPI02   CGATGT
## 8       8    3 RPI44   TATAAT
## 9       9    3 RPI48   TCGGCA
## 10     10    4 RPI08   ACTTGA
## 11     11    4 RPI10   TAGCTT
## 12     12    4 RPI43   TACAGC
```

* 12 libraries sequenced in multiplex of 3 on a HiSeq platform using barcodes
  robust against 1 substitution error

```
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                sample_number=12,
                mplex_level=3,
                platform=4,
                metric = "hamming",
                d = 3)
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##    sample Lane    Id sequence
## 1       1    1 RPI05   ACAGTG
## 2       2    1 RPI07   CAGATC
## 3       3    1 RPI20   GTGGCC
## 4       4    2 RPI04   TGACCA
## 5       5    2 RPI33   CAGGCG
## 6       6    2 RPI43   TACAGC
## 7       7    3 RPI01   ATCACG
## 8       8    3 RPI24   GGTAGC
## 9       9    3 RPI31   CACGAT
## 10     10    4 RPI09   GATCAG
## 11     11    4 RPI26   ATGAGC
## 12     12    4 RPI45   TCATTC
```

## 3.2 Examples for dual indexing

* 12 libraries sequenced in multiplex of 3 on a HiSeq platform

```
# Select the first half of barcodes from the dataset
txtfile1 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[1:24,]
)

# Select the second half of barcodes from the dataset
txtfile2 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[25:48,]
)

# Get compatibles combinations of least redundant barcodes
experiment_design(file1=txtfile1,
                sample_number=12,
                mplex_level=3,
                platform=4,
                file2=txtfile2)
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##       Id Lane
## 1  RPI01    1
## 2  RPI09    1
## 3  RPI12    1
## 4  RPI04    2
## 5  RPI07    2
## 6  RPI23    2
## 7  RPI05    3
## 8  RPI11    3
## 9  RPI19    3
## 10 RPI06    4
## 11 RPI08    4
## 12 RPI22    4
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##       Id Lane
## 1  RPI26    1
## 2  RPI31    1
## 3  RPI47    1
## 4  RPI34    2
## 5  RPI38    2
## 6  RPI46    2
## 7  RPI27    3
## 8  RPI42    3
## 9  RPI43    3
## 10 RPI37    4
## 11 RPI40    4
## 12 RPI45    4
##       Id Lane sequence
## 1  RPI01    1   ATCACG
## 2  RPI09    1   GATCAG
## 3  RPI12    1   CTTGTA
## 4  RPI04    2   TGACCA
## 5  RPI07    2   CAGATC
## 6  RPI23    2   GAGTGG
## 7  RPI05    3   ACAGTG
## 8  RPI11    3   GGCTAC
## 9  RPI19    3   GTGAAA
## 10 RPI06    4   GCCAAT
## 11 RPI08    4   ACTTGA
## 12 RPI22    4   CGTACG
##       Id Lane sequence
## 1  RPI26    1   ATGAGC
## 2  RPI31    1   CACGAT
## 3  RPI47    1   TCGAAG
## 4  RPI34    2   CATGGC
## 5  RPI38    2   CTAGCT
## 6  RPI46    2   TCCCGA
## 7  RPI27    3   ATTCCT
## 8  RPI42    3   TAATCG
## 9  RPI43    3   TACAGC
## 10 RPI37    4   CGGAAT
## 11 RPI40    4   CTCAGA
## 12 RPI45    4   TCATTC
##    sample Lane   Id1 sequence1   Id2 sequence2
## 1       1    1 RPI01    ATCACG RPI26    ATGAGC
## 2       2    1 RPI09    GATCAG RPI31    CACGAT
## 3       3    1 RPI12    CTTGTA RPI47    TCGAAG
## 4       4    2 RPI04    TGACCA RPI34    CATGGC
## 5       5    2 RPI07    CAGATC RPI38    CTAGCT
## 6       6    2 RPI23    GAGTGG RPI46    TCCCGA
## 7       7    3 RPI05    ACAGTG RPI27    ATTCCT
## 8       8    3 RPI11    GGCTAC RPI42    TAATCG
## 9       9    3 RPI19    GTGAAA RPI43    TACAGC
## 10     10    4 RPI06    GCCAAT RPI37    CGGAAT
## 11     11    4 RPI08    ACTTGA RPI40    CTCAGA
## 12     12    4 RPI22    CGTACG RPI45    TCATTC
```

* 12 libraries sequenced in multiplex of 3 on a HiSeq platform using barcodes
  robust against 1 substitution error

```
# Select the first half of barcodes from the dataset
txtfile1 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[1:24,]
)

# Select the second half of barcodes from the dataset
txtfile2 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[25:48,]
)

# Get compatibles combinations of least redundant barcodes
experiment_design(file1=txtfile1, sample_number=12, mplex_level=3, platform=4,
                    file2=txtfile2, metric="hamming", d=3)
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##       Id Lane
## 1  RPI01    1
## 2  RPI03    1
## 3  RPI09    1
## 4  RPI02    2
## 5  RPI04    2
## 6  RPI23    2
## 7  RPI07    3
## 8  RPI18    3
## 9  RPI21    3
## 10 RPI05    4
## 11 RPI06    4
## 12 RPI19    4
## [1] "Theoretical max entropy: 2.48491"
## [1] "Entropy of the optimized set: 2.48491"
##       Id Lane
## 1  RPI33    1
## 2  RPI37    1
## 3  RPI45    1
## 4  RPI27    2
## 5  RPI29    2
## 6  RPI48    2
## 7  RPI40    3
## 8  RPI42    3
## 9  RPI47    3
## 10 RPI26    4
## 11 RPI39    4
## 12 RPI44    4
##       Id Lane sequence
## 1  RPI01    1   ATCACG
## 2  RPI03    1   TTAGGC
## 3  RPI09    1   GATCAG
## 4  RPI02    2   CGATGT
## 5  RPI04    2   TGACCA
## 6  RPI23    2   GAGTGG
## 7  RPI07    3   CAGATC
## 8  RPI18    3   GTCCGC
## 9  RPI21    3   GTTTCG
## 10 RPI05    4   ACAGTG
## 11 RPI06    4   GCCAAT
## 12 RPI19    4   GTGAAA
##       Id Lane sequence
## 1  RPI33    1   CAGGCG
## 2  RPI37    1   CGGAAT
## 3  RPI45    1   TCATTC
## 4  RPI27    2   ATTCCT
## 5  RPI29    2   CAACTA
## 6  RPI48    2   TCGGCA
## 7  RPI40    3   CTCAGA
## 8  RPI42    3   TAATCG
## 9  RPI47    3   TCGAAG
## 10 RPI26    4   ATGAGC
## 11 RPI39    4   CTATAC
## 12 RPI44    4   TATAAT
##    sample Lane   Id1 sequence1   Id2 sequence2
## 1       1    1 RPI01    ATCACG RPI33    CAGGCG
## 2       2    1 RPI03    TTAGGC RPI37    CGGAAT
## 3       3    1 RPI09    GATCAG RPI45    TCATTC
## 4       4    2 RPI02    CGATGT RPI27    ATTCCT
## 5       5    2 RPI04    TGACCA RPI29    CAACTA
## 6       6    2 RPI23    GAGTGG RPI48    TCGGCA
## 7       7    3 RPI07    CAGATC RPI40    CTCAGA
## 8       8    3 RPI18    GTCCGC RPI42    TAATCG
## 9       9    3 RPI21    GTTTCG RPI47    TCGAAG
## 10     10    4 RPI05    ACAGTG RPI26    ATGAGC
## 11     11    4 RPI06    GCCAAT RPI39    CTATAC
## 12     12    4 RPI19    GTGAAA RPI44    TATAAT
```

# 4 Build your own workflow

This section guides you through the detailed API of the package with the aim to
help you build your own workflow. The package is designed to be flexible and
should be easily adaptable to most experimental contexts, using the
`experiment_design()` function as a template, or building your own workflow
from scratch.

## 4.1 Load and check a dataset of barcodes

The `file_loading_and_checking()` function loads the file containing the DNA
barcodes set and analyzes its content. In particular, it checks that each
barcode in the set is unique and uniquely identified (removing any repetition
that occurs). It also checks the homogeneity of size of the barcodes,
calculates their GC content and detects the presence of homopolymers of
length >= 3.

```
file_loading_and_checking(
    file = export_dataset_to_file(
        dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
    )
)
##       Id sequence GC_content homopolymer
## 1  RPI01   ATCACG      50.00       FALSE
## 2  RPI02   CGATGT      50.00       FALSE
## 3  RPI03   TTAGGC      50.00       FALSE
## 4  RPI04   TGACCA      50.00       FALSE
## 5  RPI05   ACAGTG      50.00       FALSE
## 6  RPI06   GCCAAT      50.00       FALSE
## 7  RPI07   CAGATC      50.00       FALSE
## 8  RPI08   ACTTGA      33.33       FALSE
## 9  RPI09   GATCAG      50.00       FALSE
## 10 RPI10   TAGCTT      33.33       FALSE
## 11 RPI11   GGCTAC      66.67       FALSE
## 12 RPI12   CTTGTA      33.33       FALSE
## 13 RPI13   AGTCAA      33.33       FALSE
## 14 RPI14   AGTTCC      50.00       FALSE
## 15 RPI15   ATGTCA      33.33       FALSE
## 16 RPI16   CCGTCC      83.33       FALSE
## 17 RPI17   GTAGAG      50.00       FALSE
## 18 RPI18   GTCCGC      83.33       FALSE
## 19 RPI19   GTGAAA      33.33        TRUE
## 20 RPI20   GTGGCC      83.33       FALSE
## 21 RPI21   GTTTCG      50.00        TRUE
## 22 RPI22   CGTACG      66.67       FALSE
## 23 RPI23   GAGTGG      66.67       FALSE
## 24 RPI24   GGTAGC      66.67       FALSE
## 25 RPI25   ACTGAT      33.33       FALSE
## 26 RPI26   ATGAGC      50.00       FALSE
## 27 RPI27   ATTCCT      33.33       FALSE
## 28 RPI28   CAAAAG      33.33        TRUE
## 29 RPI29   CAACTA      33.33       FALSE
## 30 RPI30   CACCGG      83.33       FALSE
## 31 RPI31   CACGAT      50.00       FALSE
## 32 RPI32   CACTCA      50.00       FALSE
## 33 RPI33   CAGGCG      83.33       FALSE
## 34 RPI34   CATGGC      66.67       FALSE
## 35 RPI35   CATTTT      16.67        TRUE
## 36 RPI36   CCAACA      50.00       FALSE
## 37 RPI37   CGGAAT      50.00       FALSE
## 38 RPI38   CTAGCT      50.00       FALSE
## 39 RPI39   CTATAC      33.33       FALSE
## 40 RPI40   CTCAGA      50.00       FALSE
## 41 RPI41   GACGAC      66.67       FALSE
## 42 RPI42   TAATCG      33.33       FALSE
## 43 RPI43   TACAGC      50.00       FALSE
## 44 RPI44   TATAAT       0.00       FALSE
## 45 RPI45   TCATTC      33.33       FALSE
## 46 RPI46   TCCCGA      66.67        TRUE
## 47 RPI47   TCGAAG      50.00       FALSE
## 48 RPI48   TCGGCA      66.67       FALSE
```

## 4.2 Examples of an exhaustive search of compatible barcode combinations

The total number of combinations depends on the number of available barcodes
and of the multiplex level. For 48 barcodes and a multiplex level of 3, the
total number of combinations (compatible or not) can be calculated using
`choose(48,3)`, which gives 17296 combinations. In many
cases the total number of combinations can become much larger (even gigantic),
and one cannot perform an exhaustive search
(see `get_random_combinations()` below).

* 48 barcodes, multiplex level of 2, HiSeq platform

```
# Total number of combinations
choose(48,2)
## [1] 1128

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for an exhaustive search
system.time(m <- get_all_combinations(index_df = barcodes,
                                    mplex_level = 2,
                                    platform = 4))
##    user  system elapsed
##   0.318   0.000   0.319

# Each line represents a compatible combination of barcodes
head(m)
##      [,1]    [,2]
## [1,] "RPI04" "RPI35"
## [2,] "RPI05" "RPI19"
## [3,] "RPI06" "RPI12"
## [4,] "RPI07" "RPI17"
## [5,] "RPI10" "RPI39"
## [6,] "RPI18" "RPI25"
```

* 48 barcodes, multiplex level of 3, HiSeq platform

```
# Total number of combinations
choose(48,3)
## [1] 17296

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for an exhaustive search
system.time(m <- get_all_combinations(index_df = barcodes,
                                    mplex_level = 3,
                                    platform = 4))
##    user  system elapsed
##   6.568   0.033   6.601

# Each line represents a compatible combination of barcodes
head(m)
##      [,1]    [,2]    [,3]
## [1,] "RPI01" "RPI02" "RPI48"
## [2,] "RPI01" "RPI03" "RPI07"
## [3,] "RPI01" "RPI03" "RPI08"
## [4,] "RPI01" "RPI03" "RPI09"
## [5,] "RPI01" "RPI03" "RPI10"
## [6,] "RPI01" "RPI03" "RPI16"
```

## 4.3 Examples of a random search of compatible barcode combinations

When the total number of combinations is too high, it is recommended to pick
combinations at random and then select those that are compatible.

* 48 barcodes, multiplex level of 3, HiSeq platform

```
# Total number of combinations
choose(48,3)
## [1] 17296

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for a random search
system.time(m <- get_random_combinations(index_df = barcodes,
                                        mplex_level = 2,
                                        platform = 4))
##    user  system elapsed
##   0.224   0.000   0.224

# Each line represents a compatible combination of barcodes
head(m)
##      [,1]    [,2]
## [1,] "RPI04" "RPI35"
## [2,] "RPI05" "RPI19"
## [3,] "RPI07" "RPI17"
## [4,] "RPI10" "RPI39"
## [5,] "RPI18" "RPI25"
## [6,] "RPI26" "RPI42"
```

* 48 barcodes, multiplex level of 4, HiSeq platform

```
# Total number of combinations
choose(48,4)
## [1] 194580

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for a random search
system.time(m <- get_random_combinations(index_df = barcodes,
                                        mplex_level = 4,
                                        platform = 4))
##    user  system elapsed
##   1.173   0.020   1.193

# Each line represents a compatible combination of barcodes
head(m)
##      [,1]    [,2]    [,3]    [,4]
## [1,] "RPI01" "RPI24" "RPI29" "RPI48"
## [2,] "RPI01" "RPI03" "RPI23" "RPI43"
## [3,] "RPI01" "RPI08" "RPI14" "RPI45"
## [4,] "RPI01" "RPI04" "RPI23" "RPI46"
## [5,] "RPI01" "RPI16" "RPI17" "RPI34"
## [6,] "RPI01" "RPI07" "RPI17" "RPI30"
```

* 48 barcodes, multiplex level of 6, HiSeq platform

```
# Total number of combinations
choose(48,6)
## [1] 12271512

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for a random search
system.time(m <- get_random_combinations(index_df = barcodes,
                                        mplex_level = 6,
                                        platform = 4))
##    user  system elapsed
##   1.955   0.000   1.955

# Each line represents a compatible combination of barcodes
head(m)
##      [,1]    [,2]    [,3]    [,4]    [,5]    [,6]
## [1,] "RPI01" "RPI18" "RPI23" "RPI28" "RPI43" "RPI46"
## [2,] "RPI01" "RPI17" "RPI21" "RPI26" "RPI41" "RPI47"
## [3,] "RPI01" "RPI12" "RPI17" "RPI23" "RPI33" "RPI35"
## [4,] "RPI01" "RPI03" "RPI09" "RPI21" "RPI27" "RPI39"
## [5,] "RPI01" "RPI14" "RPI24" "RPI26" "RPI42" "RPI45"
## [6,] "RPI01" "RPI08" "RPI16" "RPI18" "RPI22" "RPI32"
```

## 4.4 Constrain barcodes to be robust against one substitution error

```
# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Perform a random search of compatible combinations
m <- get_random_combinations(index_df = barcodes,
                            mplex_level = 3,
                            platform = 4)

# Keep barcodes that are robust against one substitution error
filtered_m <- distance_filter(index_df = barcodes,
                            combinations_m = m,
                            metric = "hamming",
                            d = 3)

# Each line represents a compatible combination of barcodes
head(filtered_m)
##      V1      V2      V3
## [1,] "RPI01" "RPI06" "RPI12"
## [2,] "RPI01" "RPI03" "RPI08"
## [3,] "RPI01" "RPI23" "RPI29"
## [4,] "RPI01" "RPI35" "RPI46"
## [5,] "RPI01" "RPI14" "RPI43"
## [6,] "RPI01" "RPI23" "RPI32"
```

## 4.5 Optimize the set of compatible combinations to reduce barcode redundancy

```
# Keep set of compatible barcodes that are robust against one substitution
# error
filtered_m <- distance_filter(
    index_df = DNABarcodeCompatibility::IlluminaIndexes,
    combinations_m = get_random_combinations(index_df = barcodes,
                                            mplex_level = 3,
                                            platform = 4),
    metric = "hamming", d = 3)

# Use a Shannon-entropy maximization approach to reduce barcode redundancy
df <- optimize_combinations(combination_m = filtered_m,
                            nb_lane = 12,
                            index_number = 48)
## [1] "Theoretical max entropy: 3.58352"
## [1] "Entropy of the optimized set: 3.58352"

# Each line represents a compatible combination of barcodes and each row a lane
# of the flow cell
df
##       V1      V2      V3
##  [1,] "RPI07" "RPI17" "RPI36"
##  [2,] "RPI21" "RPI33" "RPI43"
##  [3,] "RPI04" "RPI23" "RPI29"
##  [4,] "RPI03" "RPI19" "RPI31"
##  [5,] "RPI15" "RPI30" "RPI42"
##  [6,] "RPI24" "RPI28" "RPI41"
##  [7,] "RPI05" "RPI18" "RPI20"
##  [8,] "RPI06" "RPI12" "RPI34"
##  [9,] "RPI27" "RPI38" "RPI45"
## [10,] "RPI01" "RPI35" "RPI46"
## [11,] "RPI08" "RPI40" "RPI47"
## [12,] "RPI02" "RPI10" "RPI32"
```

## 4.6 The optimized result isn’t an optimum when filtering out too many barcodes

* Increased distance between barcode sequences: redundancy may become
  inevitable

```
# Keep set of compatible barcodes that are robust against multiple substitution
# and insertion/deletion errors
filtered_m <- distance_filter(
    index_df = DNABarcodeCompatibility::IlluminaIndexes,
    combinations_m = get_random_combinations(index_df = barcodes,
                                            mplex_level = 3,
                                            platform = 4),
    metric = "seqlev", d = 4)

# Use a Shannon-entropy maximization approach to reduce barcode redundancy
df <- optimize_combinations(combination_m = filtered_m,
                            nb_lane = 12,
                            index_number = 48)
## [1] "Theoretical max entropy: 3.58352"
## [1] "Entropy of the optimized set: 3.19844"

# Each line represents a compatible combination of barcodes and each row a
# lane of the flow cell
df
##       V1      V2      V3
##  [1,] "RPI02" "RPI10" "RPI36"
##  [2,] "RPI03" "RPI19" "RPI35"
##  [3,] "RPI06" "RPI24" "RPI33"
##  [4,] "RPI08" "RPI18" "RPI33"
##  [5,] "RPI11" "RPI35" "RPI47"
##  [6,] "RPI12" "RPI18" "RPI28"
##  [7,] "RPI12" "RPI28" "RPI46"
##  [8,] "RPI14" "RPI37" "RPI43"
##  [9,] "RPI14" "RPI17" "RPI30"
## [10,] "RPI17" "RPI34" "RPI46"
## [11,] "RPI20" "RPI30" "RPI47"
## [12,] "RPI27" "RPI29" "RPI48"
```