# SynMut: Tools for Designing Synonymously Mutated Sequences

### Haogao Gu, Leo L.M. Poon

### School of Public Health, The University of Hong Kong

### 2025-10-30

---

* [Introduction](#introduction)
* [Getting started](#getting-started)
  + [Installation](#installation)
  + [Input data](#input-data)
  + [Access the data](#access-the-data)
* [Generating mutations](#generating-mutations)
  + [Random synonymous mutants](#random-synonymous-mutants)
  + [Synonymous mutants with maximal/minimal usage of specific codon](#synonymous-mutants-with-maximalminimal-usage-of-specific-codon)
  + [Synonymous mutants with maximal/minimal usage of specific dinucleotide](#synonymous-mutants-with-maximalminimal-usage-of-specific-dinucleotide)
  + [Synonymous mutants mimicking a specific codon usage pattern](#synonymous-mutants-mimicking-a-specific-codon-usage-pattern)
* [Output the results](#output-the-results)
* [Session information](#session-information)

## Introduction

Synonymous mutations refer to the mutations in DNA/RNA sequences that cause **no** modification in the translated amino acid sequence. Most of the synonymous mutations are also silent mutations as they do not have observable effects on the organism’s phenotype. Designing mutant sequences with synonymous mutations is often applied in many biological studies as a method to control some unwanted changes in the translated amino acid sequences.

The codon usage bias and dinucleotide usage bias are two genomic signatures in DNA/RNA sequences, even for synonymous sequences. Characterizing the functions of synonymous sequences with different codon usage bias or dinucleotide usage bias help to study their impacts on various biological functions. In fact, this method has been applied in many researches in virology.

`SynMut` provides tools for generating multiple synonymous DNA sequences of different genomic features (in particular codon / dinucleotide usage pattern). Users can also specify mutable regions in the sequences (this is particular useful as there are some conserved regions in the genome which we do not want to modify). This tool was originally designed for generating recombinant virus sequences in influenza A virus to study the effects of different dinucleotide usage and codon usage, yet these functions provided in this package can be generic to a variety of other biological researches.

Below is a flowchart illustrating how the components work togaether in this package.

![](data:text/plain; charset=utf-8...)

## Getting started

### Installation

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
if (!requireNamespace("SynMut"))
    BiocManager::install("SynMut")
```

### Input data

We use the below data in the package for example.

* `example.fasta`: The fasta file contains the segment 7 and segment 8 DNA sequences of *Influenza A/Brisbane/59/2007 (H1N1) (BR59)*.
* `target_regions.csv`: The region file in csv format reads as a `data.frame` specifying the user-defined mutable positions (in amino acid position) correspond to the DNA sequences.

```
library("SynMut")
filepath.fasta <- system.file("extdata", "example.fasta", package = "SynMut")
filepath.csv <- system.file("extdata", "target_regions.csv", package = "SynMut")
region <- read.csv(filepath.csv)
```

The `input_seq` function takes either a system fasta file or a DNAStringSet object as input, to construct a `regioned_dna` object that is used in the `SynMut` package.

*Important Notes*: if the `region` parameter is specified in the resulted regioned\_dna object, it will be automatically applied to all the downstream functions for mutations. Mutations will only performed in the specified mutable regions.

```
rgd.seq <- input_seq(filepath.fasta, region)
rgd.seq
#> An object of class regioned_dna
#> Number of sequences: 2
```

### Access the data

Various `get_` functions were used to get some useful information:

* `get_dna`: Access the DNA sequences. This will return a DNAStringSet object (from `Biostrings` package).

```
get_dna(rgd.seq)
#> DNAStringSet object of length 2:
#>     width seq                                               names
#> [1]   759 ATGAGTCTTCTAACCGAGGTCGA...TGCAGATGCAACGATTCAAGTGA A/Brisbane/59/200...
#> [2]   693 ATGGATTCCCACACTGTGTCAAG...GAACAACTAGGTCAGAAGTTTGA A/Brisbane/59/200...
```

* `get_region`: Access the user-defined mutable region. if there is no specified regions, this function will return a `list` of length 0.

```
str(get_region(rgd.seq))
#> List of 2
#>  $ M : logi [1:253] FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ NS: logi [1:231] FALSE FALSE FALSE FALSE FALSE FALSE ...
get_region(input_seq(filepath.fasta))
#> list()
```

* `get_cu`: Get the codon usage
* `get_du`: Get dinucleotide usage
* `get_nu`: Get nucleotide usage

```
get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   5   2   8   9   5   7   2   4   7   4   4   5   5   4  14   3   5   1
#> [2,]   8   3   5   6   6   2   0  10   4   3   4   2   3   3  10   5   4   1
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]  10   4   3   2   1   2   4   1   0   1   2   7   5   9   7   2  10   4
#> [2,]   5   2   3   2   0   3   2   2   4   0   5   3   4   7  10   5   6  10
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   8  10   0   9   5   2   7   2   2   3   5   3   0   2   0   3   3   1
#> [2,]   6   2   2   6   7   4   3   1   2   5   3   5   0   1   0   0   4   3
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   1   4   1   0   1   3   3   3   0   4
#> [2,]   1   3   1   1   4   2   1   7   2   3
get_du(rgd.seq)
#>      AA AC AG AT CA CC CG CT GA GC GG GT TA TC TG TT
#> [1,] 65 41 62 56 64 38 20 48 61 48 54 31 34 43 58 35
#> [2,] 69 40 51 45 51 29 20 47 64 34 49 27 21 44 54 47
get_nu(rgd.seq)
#>        A   C   G   T
#> [1,] 225 170 194 170
#> [2,] 206 147 174 166
```

* We also provide functions to:
  + get the codon usage frequency of synonymous codons: `get_freq`
  + get Relative Synonymous Codon Usage (rscu) of synonymous codons: `get_rscu`

## Generating mutations

### Random synonymous mutants

Generating random synonymous mutations (in specific region if provided in the `input_seq`), with optional keeping or not keeping the original codon usage bias.

```
# Random synonymous mutations
mut.seq <- codon_random(rgd.seq)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   3   3  -3  -3   0  -3   4  -1  -6  -2  -1  -2  -2   0   0   2   0   1
#> [2,]   0   2   0  -2  -2   4   5  -7  -1  -1  -3   2   2   3   0  -5   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]   0  -1  -3   1   2   0   1   2   3   1   2  -2  -2  -4   3   3  -3  -3
#> [2,]   0   0   2   0   0  -2   1   0  -1   4  -1   1  -3  -1  -8   2   8  -2
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   0  -1   2  -1   1   2  -4   1   0   4  -4   0   0   0   0   0   2   2
#> [2,]   0   1   0  -1  -2  -1  -2   5  -1  -2   3   0   0   0   0   0   0   1
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   3  -3   0   1   0  -1   1   2   5  -2
#> [2,]   0  -2   0   2   0  -2   3  -1   1   1

# Keeping the original codon usage pattern
mut.seq <- codon_random(rgd.seq, keep = TRUE)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0
```

We can also specify the `n` parameter to control the proportion of the codons to be mutated.

```
# Fifty percent of the codons were allowed for mutation
mut.seq <- codon_random(rgd.seq, n = 0.5)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   2   0  -2   0  -2  -2   4   0  -4  -1   0  -2   1   0   0  -1   1   0
#> [2,]  -2   3   2  -3  -2   0   3  -1  -1  -1   0   2  -1  -2   0   3   1   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]  -1   0   1   1   0  -2   2  -1   1   2   4  -2  -3  -2   1  -1  -1   1
#> [2,]  -1   0  -2   1   1   0   1   2  -2   0  -2   1   0  -4   2   1  -2  -1
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]  -3   1   2   0  -3   2   0   1  -1  -1   2   0   0   1   0  -1   0   2
#> [2,]  -1   1   3  -3   1  -1   1  -1   0  -1   0   1   0  -1   0   1  -1   1
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   1   0   0   0   0   0   0   1   3  -1
#> [2,]   1  -2   0   1   0  -1   3   0   2   0
```

### Synonymous mutants with maximal/minimal usage of specific codon

When studying the role of a particular codon, it would be useful to have the mutants with maximal/minimal usage of that codon. The `codon_to` function will do this job for you. Pass a string of codon to either the `max.codon` or `min.codon` argument to maximize or minimize the usage of certain codon in the sequence.

```
# Generate AAC-maximized mutations
mut.seq <- codon_to(rgd.seq, max.codon = "AAC")
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   0   8   0  -8   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   6   0  -6   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0

# Generate AAC-minimized mutations
mut.seq <- codon_to(rgd.seq, min.codon = "AAC")
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   0  -2   0   2   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0  -3   0   3   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0
```

### Synonymous mutants with maximal/minimal usage of specific dinucleotide

Use `dinu_to` to generate mutations with maximal/minimal usage of specific dinucleotide. This was done by a two-step heuristic greedy algorithm, details can be found at this [link](https://koohoko.github.io/SynMut/algorithm.html).

An alternative `keep = TRUE` argument allow retaining the original codon usage bias. This can be useful when in combination with `codon_mimic` in the [next section](#synonymous-mutants-mimicking-a-specific-codon-usage-pattern) to design mutant sequences with similar codon usage bias but distinct specific dinucleotide usage.

```
# Maximaize the usage of "CG" dinucleotide in the pre-defined region
mut.seq <- dinu_to(rgd.seq, max.dinu = "cg")
# Check the dinucelotide usage difference between the mutant and the original
get_du(mut.seq) - get_du(rgd.seq)
#>       AA AC  AG  AT  CA CC CG CT GA GC GG GT  TA TC  TG  TT
#> [1,] -32  5 -19 -27 -12  8 96 -8 -3 41  5  2 -26 30 -37 -23
#> [2,] -43  4 -11 -21  -7 12 86 -9 -2 41  2  4 -19 25 -32 -30

# Minimize the usage of "CA", and compare the dinucleotide usage.
mut.seq <- dinu_to(rgd.seq, min.dinu = "CA")
get_du(mut.seq) - get_du(rgd.seq)
#>      AA AC  AG AT  CA  CC CG CT  GA GC GG GT TA TC TG TT
#> [1,]  8 -9 -25  3 -40 -22 25 20 -16 -3  5 12 25 17 -7  7
#> [2,] -5 -9 -13  7 -35 -17 21  6 -15  4 10 15 35 -3 -4  3

# Maximize the usage of "CG" while keeping the original codon usage
mut.seq <- dinu_to(rgd.seq, max.dinu = "cg", keep = TRUE)
# Compare the dinucleotide usage
get_du(mut.seq) - get_du(rgd.seq)
#>      AA AC AG AT  CA CC CG CT GA GC GG GT TA TC  TG TT
#> [1,]  3  0 -5  2 -17 -6 26 -3  0  2 -2  0 14  4 -19  1
#> [2,]  2  2 -4  0 -14 -6 23 -3  1  2 -4  1 11  2 -15  2
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0
```

### Synonymous mutants mimicking a specific codon usage pattern

The function `codon_mimic` mutates the sequences to mimic a target codon usage patterns. Detail algorithm was provided at this [link](https://koohoko.github.io/SynMut/algorithm.html).

The `alt` argument specifies the target codon usage in either a codon usage vector (result from `get_cu`) or a DNAStringSet of length 1 representing the desired codon usage.

```
# Use a codon usage vector as a target
target <- get_cu(rgd.seq)[2,]
mut.seq <- codon_mimic(rgd.seq, alt = target)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   3   2  -3  -2   1  -5  -1   5  -2   0   0  -3  -1  -1   0   2   2   1
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]  -2  -1   0   0   0   0  -2   1   4  -1   4  -3   0  -1   4   0  -4   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   3  -7   3   1   3   2  -4  -1   0   1  -2   1   0   2   0  -2   2   2
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   0  -1   0   1   0  -1  -2   2   2  -2
#> [2,]   0   0   0   0   0   0   0   0   0   0

# Use a sequence as a target
target <- Biostrings::DNAStringSet("TTGAAAA-CTC-N--AAG")
mut.seq <- codon_mimic(rgd.seq, alt = target)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
#>      AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA CAC
#> [1,]   1   0  -1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]  -1   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC GAG GAT
#> [1,]   0   0   0   0   0   0   0   0   0   0  -1  -4  -5  -7   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0  -5  -3  -4  -6   0   0   0   0
#>      GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT
#> [1,]   0   0   0   0   0   0  -2   0  19   0
#> [2,]   0   0   0   0   0   0  -1   0  19   0
# Compare the synonymous codon usage frequency
get_freq(mut.seq) - get_freq(rgd.seq)
#>              AAA AAC         AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC
#> [1,]  0.07692308   0 -0.07692308   0   0   0   0   0   0   0   0   0   0   0
#> [2,] -0.07692308   0  0.07692308   0   0   0   0   0   0   0   0   0   0   0
#>      ATG ATT CAA CAC CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT         CTA
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0 -0.03846154
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0 -0.22727273
#>             CTC        CTG        CTT GAA GAC GAG GAT GCA GCC GCG GCT GGA GGC
#> [1,] -0.1538462 -0.1923077 -0.2692308   0   0   0   0   0   0   0   0   0   0
#> [2,] -0.1363636 -0.1818182 -0.2727273   0   0   0   0   0   0   0   0   0   0
#>      GGG GGT GTA GTC GTG GTT TAA TAC TAG TAT TCA TCC TCG TCT TGA TGC TGG TGT
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#>              TTA TTC       TTG TTT
#> [1,] -0.07692308   0 0.7307692   0
#> [2,] -0.04545455   0 0.8636364   0
# Compare the Relative Synonymous Codon Usage (RSCU)
get_rscu(mut.seq) - get_rscu(rgd.seq)
#>             AAA AAC        AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG
#> [1,]  0.1538462   0 -0.1538462   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,] -0.1538462   0  0.1538462   0   0   0   0   0   0   0   0   0   0   0   0
#>      ATT CAA CAC CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT        CTA        CTC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0 -0.2307692 -0.9230769
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0 -1.3636364 -0.8181818
#>            CTG       CTT GAA GAC GAG GAT GCA GCC GCG GCT GGA GGC GGG GGT GTA
#> [1,] -1.153846 -1.615385   0   0   0   0   0   0   0   0   0   0   0   0   0
#> [2,] -1.090909 -1.636364   0   0   0   0   0   0   0   0   0   0   0   0   0
#>      GTC GTG GTT TAA TAC TAG TAT TCA TCC TCG TCT TGA TGC TGG TGT        TTA TTC
#> [1,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 -0.4615385   0
#> [2,]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 -0.2727273   0
#>           TTG TTT
#> [1,] 4.384615   0
#> [2,] 5.181818   0
```

## Output the results

Output the DNA mutant sequences

```
Biostrings::writeXStringSet(get_dna(rgd.seq), "rgd.fasta")
```

## Session information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] SynMut_1.26.0
#>
#> loaded via a namespace (and not attached):
#>  [1] vctrs_0.6.5         crayon_1.5.3        cli_3.6.5
#>  [4] knitr_1.50          rlang_1.1.6         xfun_0.53
#>  [7] stringi_1.8.7       generics_0.1.4      seqinr_4.2-36
#> [10] jsonlite_2.0.0      glue_1.8.0          S4Vectors_0.48.0
#> [13] Biostrings_2.78.0   htmltools_0.5.8.1   sass_0.4.10
#> [16] stats4_4.5.1        rmarkdown_2.30      Seqinfo_1.0.0
#> [19] evaluate_1.0.5      jquerylib_0.1.4     prettydoc_0.4.1
#> [22] MASS_7.3-65         fastmap_1.2.0       yaml_2.3.10
#> [25] IRanges_2.44.0      lifecycle_1.0.4     stringr_1.5.2
#> [28] compiler_4.5.1      Rcpp_1.1.0          XVector_0.50.0
#> [31] digest_0.6.37       R6_2.6.1            magrittr_2.0.4
#> [34] bslib_0.9.0         tools_4.5.1         ade4_1.7-23
#> [37] BiocGenerics_0.56.0 cachem_1.1.0
```

---