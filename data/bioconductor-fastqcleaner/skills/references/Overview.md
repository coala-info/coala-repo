Code

* Show All Code
* Hide All Code

# An Introduction to FastqCleaner

Leandro Roser1\*, Fernán Agüero1 and Daniel Sánchez1

1IIB-INTECH - UNSAM

\*learoser@gmail.com

#### Feb 15, 2020

#### Abstract

*[FastqCleaner](https://bioconductor.org/packages/3.22/FastqCleaner)* is an interactive application
for both quality control and pre-processing of FASTQ files.
The interface, based on a Bioconductor back-end,
provides diagnostic information for the input and output
data and a series of filtering and trimming operations in
an interactive framework.

#### Package

FastqCleaner 1.28.0

# 1 Launching the application

The interactive application can be launched in R with the following command:

```
library('FastqCleaner')
launch_fqc()
```

As an alternative method, an RStudio addin
(RStudio version 0.99.878 or higher required) installed with the package
can be found in the Addins menu (Figure 1).
This button allows the direct launch of the application with a single click.

![](data:image/png;base64...)
**Figure 1**: addin of the app in RStudio (RStudio version >= 0.99.878 required)

# 2 Description of the application

The application contains three main panels, as described below.

## 2.1 First panel

The first panel includes two elements: a dashboard for selection
of trimming and filtering operations, and a menu for selection
of the input file/s (Fig. 2).

![](data:image/png;base64...)

**Figure 2**: Panel 1, with each compontent indicated with a number.
See explanation for each element below

### 2.1.1 Selecting operations

The “operations menu” (Fig. 2, elements 1 to 8) shows
the available operations for file processing:

1. **Remove by N(s)**: removes sequences with a number of Ns
   (non identified bases) above a selected threshold value
2. **Remove low complexity sequences**: remove sequences with a value of
   complexity above a threshold value
3. **Remove adapters**: removes adapters and partial adapters.
   Adapter sequences from both ends of single or paired read reads
   can be selected. Sequences can be reverse-complemented before processing.
   The program also allows to consider indels
   and/or anchored adapters.
4. **Filter by average quality**: computes the average quality of sequences
   and removes those with a value below a given threshold
5. **Trim low quality 3’ tails**: removes the 3’ tails of sequences that
   are below a given threshold
6. **Trim 3’ or 5’ by a fixed number**: removes a fixed number of bases
   from the 3’ and/or 5’ ends in the complete set of sequences
7. **Filter sequences by length**: removes all the sequences with a number
   of bases below a threshold value
8. **Remove duplicated sequences**: removes duplicated reads, conserving
   only one copy of each sequence present in the file

### 2.1.2 Loading files

The “file selection menu” (Fig. 2, elements 9 to 17)
contains options to handle the input file (type of file, file selection),
buttons to run, clear and reset the aplication, and the “advanced” submenu:

9. **Single-end reads / paired-end reads**: type of input files
10. **“FILE” button**: to select an input file
11. **“RUN!” button**: to run the program
12. **Output format**: to select whether the output file should be compressed
    (.gz) or not
13. **“CLEAR” button**: to clear the configuration of the operations menu
    that have been selected in the first panel, but keeping the input file(s)
14. **“RESET” button**: to restart the application, removing the
    input file(s) and the selected configurations
15. **Selection notificator**: information of the path of the selected file/s
16. **Encoding notificator**: information of the input file/s encoding
17. **Advanced options button**: to select a custom encoding and set
    the number of reads included in each chunk for processing, as described below

### 2.1.3 Advanced options

The “advanced options submenu” (Fig. 3) allows to customize some fine aspects
of the trimming and filtering process:

![](data:image/png;base64...)

**Figure 3**: Advanced options submenu

18. **Encoding menu**: in addition to the default approach used by the
    program (auto-detection of file encoding), users can select a standard encoding
    from a list
19. **Chunk size**: the program takes this number of reads at random from
    the file (default: 1000000), for encoding detection

## 2.2 Second panel

The second panel (“file operations” panel, Fig. 4) shows the operations
that were sucessfuly performed on the input file after running the program.

![](data:image/png;base64...)

**Figure 4**: File operations panel, with its elements

The panel contains the following elements:

20. **Files location**: location of input and output files
21. **Operations performed**: operations perfomed on the input file.
    Each individual display indicates the number of reads that
    passed the corresponding filter

## 2.3 Third panel

The third panel ( “live results” panel, Fig. 5) shows
interactive diagnostics plots for both input and output files.
The program takes a random sample of reads for
construction of the plots (default: 10000 reads).

![](data:image/png;base64...)

**Figure 5**: Live results panel

The panel includes the following options in the menu located on the left:

22. **Sample size**: the sample size used for construction of the plots.
    Default: 10000 reads
23. **Input / output**: show diagnostics plots for input or output files?
24. **Diagnostics plots**: the plot to be shown, that can be one of the
    following:

    * *Per cycle quality*: quality plots across reads for each cycle
      (i.e., sequence position)
    * *Per cycle mean quality*: average quality across reads per base,
      for each cycle (i.e., sequence position)
    * *Mean quality distribution*: Quality distribution, using for
      the construction of the histogram the mean quality of each read
    * *% reads with Phred scores > threshold*: % of reads with all
      the quality values > threshold
    * *Per cycle base proportion*: Proportion of each base
      (average across reads) in each cycle. It also shows the proporion of N’s
    * *CG content*: % CG and % AT (average across reads) for each cycle
    * *CG content distribution over all reads*: histogram for % reads with
      a given % CG
    * *Read length distribution*: % reads vs read length (bp)
    * *Read ocurrence distribution*: % reads that ocurr at different
      frequencies values in the file. The plot also includes a table
    * *Relative k-mer diversity*: unique k-mers / all posible
      kmers for each cycle
25. **Select k-mer size**: k-mer size for the k-mers frequency plot
26. **Top sequences in duplication level analysis**: a list of duplicated
    sequences, ordered from high to low duplication level,
    can be desplegated from the “read ocurrence distribution” plot.
    The number selected here indicates how many sequences should be shown.
    Note that the frequency of reads are relative to the sample size selected
    (i.e., fold-times in relation to those reads present only once in the sample)
27. **Plot panel**

# 3 A worked example: FASTQ processing in a nutshell

A sample FASTQ (gz-compressed) file ‘example.fastq.gz’ can
be downloaded with the following command in R:

```
download.file("https://goo.gl/hb4Kr9", "example_fastq.gz")
```

A direct download is provided in [this link](https://goo.gl/hb4Kr9) .

A tipical *[FastqCleaner](https://bioconductor.org/packages/3.22/FastqCleaner)* workflow starts with the input file/s
upload (Fig. 6).

![](data:image/png;base64...)

**Figure 6**: File input menu. The example shows a single-end reads case
(sample file ‘example.fastq.gz’). For paired-end reads, the selection of the
corresponding library type generates an additional button to upload the
second file.

The file encoding is automatically detected by the program, but it can also be
manually specified in the advanced submenu (Fig. 7). This menu also offers an
option to customize the chunk size used for processing.

![](data:image/png;base64...)

**Figure 7**: Advanced submanu

Next, the operations to be performed on the input file are selected from the
operations menu (Fig. 8).

![](data:image/png;base64...)

**Figure 8**: Selection of operations. A dialog box shows the input expected
for the program. To use a filter, the “Use filter?” checkbox must
be checked. A filter in use is indicated with a checkmark in the filter box

The program then starts to run after pressing the “RUN!” button (Fig. 9).

![](data:image/png;base64...)

**Figure 9**: “RUN!” button action

Post-processing results are shown in the second panel (Fig. 10).

![](data:image/png;base64...)

**Figure 10**: Second panel of the app, showing the operations performed and
the paths of the input and output files

The type of plot to be displayed and the options for the construction of the
plot are available in the third panel (Fig. 11). This panel also show the
selected plot/s.

![](data:image/png;base64...)

**Figure 11**: Third panel, showing as example a “CG” content plot.
for the output file

To clean the operations, for example to run a different
configuration, the “CLEAN” i(Fig. 11) must be pressed. The “RESET” button
(Fig. 11) restarts the interface.

Additional help can be found in the “help” button located at the top-right
of the app (Fig. 12).

![](data:image/png;base64...)

**Figure 12**: help button. A webpage with information will be open

# 4 Advanced use of the package

*[FastqCleaner](https://bioconductor.org/packages/3.22/FastqCleaner)* separates the interface from the implementation.
In consequence, the processing functions of the package can be used
as standard functions from the command line.
Most of the functions make intensive
use of *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* and *[ShortRead](https://bioconductor.org/packages/3.22/ShortRead)*. Trimming
and filtering is performed on ShortReadQ objects. A complete documentation
for the functions is available in [this link](docs/reference/index.html)

The functions included in the package are described in the following section.

## 4.1 Main functions

* **adapter\_filter**

Based on the *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* trimLRPatterns functions.
It can remove adapters and partial adapters
from the 3’ and 5’ sequence ends. Adapters can be anchored or not.
When indels are allowed, the method is based on the “edit distance” of
the sequences.

```
### Examples
```

```
require("Biostrings")
require("ShortRead")
require("FastqCleaner")
```

```
# create sequences
set.seed(15)
# nota that the use of set.seed before the call to the
# random generators allows reproducibility of the
# examples

input <- random_seq(6, 43)
input
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    43 TCATGAAGTACTTTAAGACAAAGCTTCCAGGGGCTTCTGAAGA
## [2]    43 GGGGAACTTAACATAAGGATTAAAGAATTGTATGCCTTAAAAA
## [3]    43 CAGAACCCACAGACAAACGTAATGCACCTTATGTTGGCGCCGC
## [4]    43 TCTGATCCTATCGCTCGGATTGATAATCAATTTAATTGTGAGA
## [5]    43 GATATAGGCGCCACTTGAACGCAGCACGGTGACTAAATGGTTA
## [6]    43 TCATCCGTTTATTTGTTCAGCACGAGCTTGCTGCCTTACTGGA
```

```
# create qualities of width 50
set.seed(10)
input_q <- random_qual(c(30,40), slength = 6, swidth = 50,
encod = "Sanger")

# create names
input_names <- seq_names(length(input))

### FULL ADAPTER IN 3'
adapter <- "ATCGACT"

# Create sequences with adapter
my_seqs <- paste0(input, adapter)
my_seqs <- DNAStringSet(my_seqs)
my_seqs
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    50 TCATGAAGTACTTTAAGACAAAGCTTCCAGGGGCTTCTGAAGAATCGACT
## [2]    50 GGGGAACTTAACATAAGGATTAAAGAATTGTATGCCTTAAAAAATCGACT
## [3]    50 CAGAACCCACAGACAAACGTAATGCACCTTATGTTGGCGCCGCATCGACT
## [4]    50 TCTGATCCTATCGCTCGGATTGATAATCAATTTAATTGTGAGAATCGACT
## [5]    50 GATATAGGCGCCACTTGAACGCAGCACGGTGACTAAATGGTTAATCGACT
## [6]    50 TCATCCGTTTATTTGTTCAGCACGAGCTTGCTGCCTTACTGGAATCGACT
```

```
# create ShortReadQ object
my_read <- ShortReadQ(sread = my_seqs, quality = input_q, id = input_names)

# trim adapter
filtered <- adapter_filter(my_read, Lpattern = adapter)
sread(filtered)
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    50 TCATGAAGTACTTTAAGACAAAGCTTCCAGGGGCTTCTGAAGAATCGACT
## [2]    50 GGGGAACTTAACATAAGGATTAAAGAATTGTATGCCTTAAAAAATCGACT
## [3]    50 CAGAACCCACAGACAAACGTAATGCACCTTATGTTGGCGCCGCATCGACT
## [4]    50 TCTGATCCTATCGCTCGGATTGATAATCAATTTAATTGTGAGAATCGACT
## [5]    50 GATATAGGCGCCACTTGAACGCAGCACGGTGACTAAATGGTTAATCGACT
## [6]    50 TCATCCGTTTATTTGTTCAGCACGAGCTTGCTGCCTTACTGGAATCGACT
```

```
### PARTIAL ADAPTER IN 5'
adapter <- "ATCGACT"
subadapter <- subseq(adapter, 1, 4)

# Create sequences with adapter
my_seqs <- paste0(input, subadapter)
my_seqs <- DNAStringSet(my_seqs)
my_seqs
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    47 TCATGAAGTACTTTAAGACAAAGCTTCCAGGGGCTTCTGAAGAATCG
## [2]    47 GGGGAACTTAACATAAGGATTAAAGAATTGTATGCCTTAAAAAATCG
## [3]    47 CAGAACCCACAGACAAACGTAATGCACCTTATGTTGGCGCCGCATCG
## [4]    47 TCTGATCCTATCGCTCGGATTGATAATCAATTTAATTGTGAGAATCG
## [5]    47 GATATAGGCGCCACTTGAACGCAGCACGGTGACTAAATGGTTAATCG
## [6]    47 TCATCCGTTTATTTGTTCAGCACGAGCTTGCTGCCTTACTGGAATCG
```

```
# create ShortReadQ object
my_read <- ShortReadQ(sread = my_seqs, quality = subseq(input_q, 1, 47),
id = input_names)

# trim adapter
filtered <- adapter_filter(my_read, Rpattern = adapter)
sread(filtered)
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    43 TCATGAAGTACTTTAAGACAAAGCTTCCAGGGGCTTCTGAAGA
## [2]    43 GGGGAACTTAACATAAGGATTAAAGAATTGTATGCCTTAAAAA
## [3]    43 CAGAACCCACAGACAAACGTAATGCACCTTATGTTGGCGCCGC
## [4]    43 TCTGATCCTATCGCTCGGATTGATAATCAATTTAATTGTGAGA
## [5]    43 GATATAGGCGCCACTTGAACGCAGCACGGTGACTAAATGGTTA
## [6]    43 TCATCCGTTTATTTGTTCAGCACGAGCTTGCTGCCTTACTGGA
```

[Documentation of the function](docs/reference/adapter_filter.html)

* **complex\_filter**

Removes low complexity sequences, computing the entropy with the
dinucleotide frequency:
\[H\_i = -\sum d\_i \* log\_2(d\_i)\]

where: \(d\_i = D\_i/ \sum\_i^n D\_i\) represents the frequency of
dinucleotides of the sequence \(i\) relative to the frequency
in the whole pool of sequences.

The relation \(H\_i/H\_r\) between \(H\_i\) and a reference entropy value \(H\_r\)
is computed, and the obtained relations are compared with a given complexity
threshold. By default the program uses a reference entropy
of 3.908, that corresponds to the entropy of the human genome in bits,
and a complexity threshold of 0.5.

```
# create  sequences of different width
set.seed(10)
input <- lapply(c(0, 6, 10, 16, 20, 26, 30, 36, 40),
            function(x) random_seq(1, x))

# create repetitive "CG" sequences with length adequante
# for a total length input +  CG = 40

CG <- lapply(c(20, 17, 15, 12, 10, 7, 5, 2, 0),
            function(x) paste(rep("CG", x), collapse = ""))

# concatenate input and CG
input  <- mapply("paste", input, CG, sep = "")
input <- DNAStringSet(input)
input
```

```
## DNAStringSet object of length 9:
##     width seq
## [1]    40 CGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCG
## [2]    40 TGGTCCCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCG
## [3]    40 GGTGTTCTGGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCG
## [4]    40 CGGAATAGGTACAGTCCGCGCGCGCGCGCGCGCGCGCGCG
## [5]    40 CAGTAATTGCCTCCCGCAGACGCGCGCGCGCGCGCGCGCG
## [6]    40 CGCTGGGTCCGGAATGCCCTTTCTGACGCGCGCGCGCGCG
## [7]    40 GCAGCTCCAGCCGTTTGACTTCGCGGAAAGCGCGCGCGCG
## [8]    40 TGAACTTAGATTCGGTCCTGAAACACGGTACTTCCACGCG
## [9]    40 CAGTCAACCCGCCGACTTGGAGAATTTATTAGCCGGGCGG
```

```
# plot relative entropy (E, Shannon 1948)
H_plot <- function(x, H_max = 3.908135) {
    freq <- dinucleotideFrequency(x)
    freq  <- freq /rowSums(freq)
    H <- -rowSums(freq  * log2(freq), na.rm = TRUE)
    plot(H/H_max, type="l", xlab = "Sequence", ylab= "E")
    points(H/H_max, col = "#1a81c2", pch = 16, cex = 2)
}

H_plot(input)
```

![](data:image/png;base64...)

**Figure 13**: Relative entropy plot for the sequences before the operation

```
# create qualities of widths 40
set.seed(10)
input_q <- random_qual(c(30,40), slength = 9, swidth = 40,
    encod = "Sanger")

# create names
input_names <- seq_names(9)

# create ShortReadQ object
my_read <- ShortReadQ(sread = input, quality = input_q, id = input_names)

# apply the filter,
filtered <- complex_filter(my_read)
sread(filtered)
```

```
## DNAStringSet object of length 7:
##     width seq
## [1]    40 GGTGTTCTGGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCG
## [2]    40 CGGAATAGGTACAGTCCGCGCGCGCGCGCGCGCGCGCGCG
## [3]    40 CAGTAATTGCCTCCCGCAGACGCGCGCGCGCGCGCGCGCG
## [4]    40 CGCTGGGTCCGGAATGCCCTTTCTGACGCGCGCGCGCGCG
## [5]    40 GCAGCTCCAGCCGTTTGACTTCGCGGAAAGCGCGCGCGCG
## [6]    40 TGAACTTAGATTCGGTCCTGAAACACGGTACTTCCACGCG
## [7]    40 CAGTCAACCCGCCGACTTGGAGAATTTATTAGCCGGGCGG
```

```
H_plot(sread(filtered))
```

![](data:image/png;base64...)
**Figure 14**: Relative entropy plot for the sequences after the operation

[Documentation of the function](docs/reference/complex_filter.html)

* **fixed\_filter**

Removes the specified number of bases from 3’ or 5’.

```
# create sequences, qualities and names of width 20
set.seed(10)
input <- random_seq(6, 20)
input
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    20 TGGTCCGGTGTTCTGGCGGA
## [2]    20 ATAGGTACAGTCCAGTAATT
## [3]    20 GCCTCCCGCAGACGCTGGGT
## [4]    20 CCGGAATGCCCTTTCTGAGC
## [5]    20 AGCTCCAGCCGTTTGACTTC
## [6]    20 GCGGAAAGTGAACTTAGATT
```

```
set.seed(10)
input_q <- random_qual(c(30,40), slength = 6, swidth = 20,
    encod = "Sanger")

input_names <- seq_names(6)

# create ShortReadQ object
my_read <- ShortReadQ(sread = input, quality = input_q, id = input_names)

# apply the filter
filtered3 <- fixed_filter(my_read, trim5 = 5)
sread(filtered3)
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    15 TGGTCCGGTGTTCTG
## [2]    15 ATAGGTACAGTCCAG
## [3]    15 GCCTCCCGCAGACGC
## [4]    15 CCGGAATGCCCTTTC
## [5]    15 AGCTCCAGCCGTTTG
## [6]    15 GCGGAAAGTGAACTT
```

```
filtered5 <- fixed_filter(my_read, trim3 = 5)
sread(filtered5)
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    15 CGGTGTTCTGGCGGA
## [2]    15 TACAGTCCAGTAATT
## [3]    15 CCGCAGACGCTGGGT
## [4]    15 ATGCCCTTTCTGAGC
## [5]    15 CAGCCGTTTGACTTC
## [6]    15 AAGTGAACTTAGATT
```

```
filtered3and5 <- fixed_filter(my_read, trim3 = 10, trim5 = 5)
sread(filtered3and5)
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]     5 TTCTG
## [2]     5 TCCAG
## [3]     5 GACGC
## [4]     5 CTTTC
## [5]     5 GTTTG
## [6]     5 AACTT
```

[Documentation of the function](docs/reference/fixed_filter.html)

* **length\_filter**

Removes sequences with a length lower than
minimum threshold value or/and higher than a maximum threshold value.

```
# create  ShortReadQ object width widths between 1 and 60
set.seed(10)
input <- random_length(10, widths = 1:60)
sread(input)
```

```
## DNAStringSet object of length 10:
##      width seq
##  [1]    43 TCTGGCGGAATAGGTACAGTCCAGTAATTGCCTCCCGCAGACG
##  [2]     9 CTGGGTCCG
##  [3]    10 GAATGCCCTT
##  [4]    48 TCTGAGCAGCTCCAGCCGTTTGACTTCGCGGAAAGTGAACTTAGATTC
##  [5]    12 GGTCCTGAAACA
##  [6]    55 CGGTACTTCCACAGTCAACCCGCCGACTTGGAGAATTTATTAGCCGGGCGGTTAT
##  [7]     8 TCCCCTAG
##  [8]    54 TGATCTTACTAAGATTTGCAATACCTAAGCGAAGTGACAGATATGTTCGTCATT
##  [9]    39 CATCCAGGCAAGTGCGCGGACATCAATTACCACACAATT
## [10]    19 AAATATGACTCGCGTATCG
```

```
# apply the filter, removing sequences with length < 5 or length> 30
filtered <- length_filter(input, rm.min = 5, rm.max = 30)
sread(filtered)
```

```
## DNAStringSet object of length 5:
##     width seq
## [1]     9 CTGGGTCCG
## [2]    10 GAATGCCCTT
## [3]    12 GGTCCTGAAACA
## [4]     8 TCCCCTAG
## [5]    19 AAATATGACTCGCGTATCG
```

[Documentation of the function](docs/reference/length_filter.html)

* **n\_filter**

Wrapper of the *[ShortRead](https://bioconductor.org/packages/3.22/ShortRead)* nFilter function. Removes
all those sequences with a number of N’s > a given threshold.

```
# create 10 sequences of width 20
set.seed(10)
input <- random_seq(10, 20)
input
```

```
## DNAStringSet object of length 10:
##      width seq
##  [1]    20 TGGTCCGGTGTTCTGGCGGA
##  [2]    20 ATAGGTACAGTCCAGTAATT
##  [3]    20 GCCTCCCGCAGACGCTGGGT
##  [4]    20 CCGGAATGCCCTTTCTGAGC
##  [5]    20 AGCTCCAGCCGTTTGACTTC
##  [6]    20 GCGGAAAGTGAACTTAGATT
##  [7]    20 CGGTCCTGAAACACGGTACT
##  [8]    20 TCCACAGTCAACCCGCCGAC
##  [9]    20 TTGGAGAATTTATTAGCCGG
## [10]    20 GCGGTTATTCCCCTAGTGAT
```

```
# inject N's
set.seed(10)
input <- inject_letter_random(input, how_many_seqs = 1:5,
    how_many = 1:10)
input
```

```
## DNAStringSet object of length 10:
##      width seq
##  [1]    20 TGGTCCGGTGTTCTGGCGGA
##  [2]    20 ATAGGTACAGTCCAGTAATT
##  [3]    20 GCCTCCCGCAGACGCTGGGT
##  [4]    20 CCGGAATGCCCTTTCTGAGC
##  [5]    20 AGCTCCAGCCGTTTGACTTC
##  [6]    20 GCGGAAAGTGAACTTAGATT
##  [7]    20 CNGTCNNNAANCNNNNTACN
##  [8]    20 NCCANANTCAACNCGCCNAC
##  [9]    20 TTGGAGNATNTATTNGCNNN
## [10]    20 GCGGTTATTCCCCTAGTGAT
```

```
#'
hist(letterFrequency(input, "N"), breaks = 0:10,
    main  = "Ns Frequency", xlab = "# Ns",
    col = "#1a81c2")
```

![](data:image/png;base64...)
**Figure 15**: N’s histogram for the sequences before the filtering operation

```
# Create qualities, names and ShortReadQ object
set.seed(10)
input_q <- random_qual(10, 20)
input_names <- seq_names(10)
my_read <- ShortReadQ(sread = input, quality = input_q, id = input_names)

# Apply the filter
filtered <- n_filter(my_read, rm.N = 3)
sread(filtered)
```

```
## DNAStringSet object of length 7:
##     width seq
## [1]    20 TGGTCCGGTGTTCTGGCGGA
## [2]    20 ATAGGTACAGTCCAGTAATT
## [3]    20 GCCTCCCGCAGACGCTGGGT
## [4]    20 CCGGAATGCCCTTTCTGAGC
## [5]    20 AGCTCCAGCCGTTTGACTTC
## [6]    20 GCGGAAAGTGAACTTAGATT
## [7]    20 GCGGTTATTCCCCTAGTGAT
```

```
hist(letterFrequency(sread(filtered), "N"),
    main = "Ns distribution", xlab = "",
    col = "#1a81c2")
```

![](data:image/png;base64...)

**Figure 16**: N’s histogram for the sequences after the filtering operation

[Documentation of the function](docs/reference/n_filter.html)

* **qmean\_filter**

Removes those sequences with quality < a give threshold.

```
# create 30 sequences of width 20, 15 with low quality and 15 with high quality
set.seed(10)
input <- random_seq(30, 20)

set.seed(10)
my_qual_H <- random_qual(c(30,40), slength = 15, swidth = 20,
    encod = "Sanger")

set.seed(10)
my_qual_L <- random_qual(c(5,30), slength = 15, swidth = 20,
    encod = "Sanger")
input_q<- c(my_qual_H, my_qual_L)

input_names <- seq_names(30)
my_read <- ShortReadQ(sread = input, quality = input_q, id = input_names)

# Plot of average qualities
qual_plot <- function(x, cutoff) {
q <- alphabetScore(x) / width(x)
plot(q, type="l", xlab = "Sequence", ylab= "Average quality", ylim = c(0, 40))
points(q, col = "#1a81c2", pch = 16, cex = 2)
lines(seq_along(q), rep(cutoff, length(q)), type="l", col = "red", lty=2)
text(length(q), cutoff+2, cutoff)
}

#' Average qualities before
qual_plot(my_read, cutoff = 30)
```

![](data:image/png;base64...)

**Figure 17**: Average qualities before the filtering operation

```
# Apply the filter
filtered <- qmean_filter(my_read, minq = 30)

# Average qualities after
qual_plot(filtered, cutoff = 30)
```

![](data:image/png;base64...)
**Figure 18**: Average qualities after the filtering operation

[Documentation of the function](docs/reference/qmean_filter.html)

* **seq\_filter**

Removes sequences that match those passed as argument.

```
# Generate random sequences
set.seed(10)
input <- random_length(30, 3:7)

# Remove sequences that contain the following patterns:
rm.seq  = c("TGGTC", "CGGT", "GTTCT", "ATA")
match_before <- unlist(lapply(rm.seq, function(x) grep(x,
as.character(sread(input)))))
match_before
```

```
## [1] 14 17 27
```

```
filtered <- seq_filter(input,rm.seq =  rm.seq)

# Verify that matching sequences were removed
match_after <- unlist(lapply(rm.seq, function(x) {
                grep(x, as.character(sread(filtered)))}))
match_after
```

```
## [1] 14 26
```

[Documentation of the function](docs/reference/seq_filter.html)

* **trim3q\_filter**

Removes from the 3’ ends in-tandem nucleotides with a quality
< a threshold value.

```
# Create 6 sequences of width 20
set.seed(10)
input <- random_seq(6, 20)
input
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    20 TGGTCCGGTGTTCTGGCGGA
## [2]    20 ATAGGTACAGTCCAGTAATT
## [3]    20 GCCTCCCGCAGACGCTGGGT
## [4]    20 CCGGAATGCCCTTTCTGAGC
## [5]    20 AGCTCCAGCCGTTTGACTTC
## [6]    20 GCGGAAAGTGAACTTAGATT
```

```
# Create Phred+33 qualities of width 15 and paste to qualities of length
# 5 used for the tails.
# for three of the sequences, put low qualities in tails
set.seed(10)
my_qual <- random_qual(c(30,40), slength = 6, swidth = 15,
    encod = "Sanger")
set.seed(10)
tails <-   random_qual(c(30,40), slength = 6, swidth = 5,
    encod = "Sanger")

# Low quality tails in sequences 2, 3 & 4
set.seed(10)
tails[2:4] <- random_qual(c(3, 20), slength = 3, swidth = 5,
    encod = "Sanger")
my_qual <- paste0(my_qual, tails)
input_q <- BStringSet(my_qual)
input_q
```

```
## BStringSet object of length 6:
##     width seq
## [1]    20 ECDG@BCBFDGFAFCECDG@
## [2]    20 D@BDIIFHCDGIBHC.*,1&
## [3]    20 EAAIDHI?GECB@HB)))0,
## [4]    20 A@EAHC?BEBFEEDE0/'/+
## [5]    20 @AEDIHFD@B@EGE@IFHCD
## [6]    20 FD?BBIEBFB@HCAAGIBHC
```

```
# Watch qualities before filtering
as.matrix(PhredQuality(input_q))
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
## [1,]   36   34   35   38   31   33   34   33   37    35    38    37    32    37
## [2,]   35   31   33   35   40   40   37   39   34    35    38    40    33    39
## [3,]   36   32   32   40   35   39   40   30   38    36    34    33    31    39
## [4,]   32   31   36   32   39   34   30   33   36    33    37    36    36    35
## [5,]   31   32   36   35   40   39   37   35   31    33    31    36    38    36
## [6,]   37   35   30   33   33   40   36   33   37    33    31    39    34    32
##      [,15] [,16] [,17] [,18] [,19] [,20]
## [1,]    34    36    34    35    38    31
## [2,]    34    13     9    11    16     5
## [3,]    33     8     8     8    15    11
## [4,]    36    15    14     6    14    10
## [5,]    31    40    37    39    34    35
## [6,]    32    38    40    33    39    34
```

```
# Create names and ShortReadQ object
input_names <- seq_names(6)
my_read <- ShortReadQ(sread = input, quality = input_q, id = input_names)

# Apply the filter
filtered <- trim3q_filter(my_read, rm.3qual = 28)
sread(filtered)
```

```
## DNAStringSet object of length 6:
##     width seq
## [1]    20 TGGTCCGGTGTTCTGGCGGA
## [2]    15 ATAGGTACAGTCCAG
## [3]    15 GCCTCCCGCAGACGC
## [4]    15 CCGGAATGCCCTTTC
## [5]    20 AGCTCCAGCCGTTTGACTTC
## [6]    20 GCGGAAAGTGAACTTAGATT
```

[Documentation of the function](docs/reference/trim3q_filter.html)

* **unique\_filter**

Wrapper of the *[ShortRead](https://bioconductor.org/packages/3.22/ShortRead)* occurrenceFilter function.
that removes duplicated sequences.

```
# Create duplicated sequences
s <- random_seq(10, 10)
s <- sample(s, 30, replace = TRUE)

# Create a ShortReadQ object
q <- random_qual(30, 10)
n <- seq_names(30)
my_read <- ShortReadQ(sread = s, quality = q, id = n)

# Check presence of duplicates
isUnique(as.character(sread(my_read)))
```

```
##  [1] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [25] FALSE FALSE FALSE FALSE FALSE FALSE
```

```
# Apply the filter
filtered <- unique_filter(my_read)
isUnique(as.character(sread(filtered)))
```

```
## [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

[Documentation of the function](docs/reference/unique_filter.html)

## 4.2 Auxiliary functions

* **random\_seq**

Create a vector of random sequences, for a set of specificied parameters.

[Documentation of the function](docs/reference/random_seq.html)

* **random\_qual**

Create a vector of random qualities for a given encoding and a set
of specified parameters.

[Documentation of the function](docs/reference/random_qual.html)

* **seq\_names**

Create a vector of names for a set of sequences.

[Documentation of the function](docs/reference/seq_names.html)

* **random\_length**

Create a set of sequences with random lengths.

[Documentation of the function](docs/reference/seq_names.html)

* **inject\_letter\_random**

Inject a character (e.g., ‘N’) at random positions, given a set of parameters.

[Documentation of the function](docs/reference/inject_letter_random.html)

* **check\_encoding**

The function allows to check quality encoding. It detects encodings with
the following formats:

| Format | Expected range |
| --- | --- |
| Sanger | [0, 40] |
| Illumina 1.8 | [0, 41] |
| Illumina 1.5 | [0, 40] |
| Illumina 1.3 | [3, 40] |
| Solexa | [-5, 40] |

[Documentation of the function](docs/reference/check_encoding.html)

# 5 Contact information

Mantainer: Leandro Roser - learoser@gmail.com