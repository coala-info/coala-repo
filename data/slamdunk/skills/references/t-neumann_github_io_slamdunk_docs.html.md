* [Home](index.html)
* Docs
* [GitHub](https://github.com/t-neumann/slamdunk)

![](images/slamdocs_logo_light.png)

### **Welcome to SlamDunk docs.**

SlamDunk also provides this documentation as package content for your convenience.

The documentation can also be compiled into various formats using the
[Sphinx documentation generator](http://www.sphinx-doc.org)
.

##

[Read the Docs](#docstart)

# Introduction

# SLAM-seq

SLAMseq is a novel sequencing protocol that directly uncovers 4-thiouridine incorporation events in RNA by high-throughput sequencing. When combined with metabolic labeling protocols, SLAM-seq allows to study the intracellular RNA dynamics, from transcription, RNA processing to RNA stability.

Original publication:
[Herzog et al., Nature Methods, 2017; doi:10.1038/nmeth.4435](https://www.nature.com/nmeth/journal/vaop/ncurrent/full/nmeth.4435.html)

[![images/slam.png](images/slam.png)](images/slam.png)

# SLAM-DUNK

Neumann, T., Herzog, V. A., Muhar, M., Haeseler, von, A., Zuber, J., Ameres, S. L., & Rescheneder, P. (2019).
**Quantification of experimentally induced nucleotide conversions in high-throughput sequencing datasets**
. BMC Bioinformatics, 20(1), 258.
[doi:10.1186/s12859-019-2849-7](http://doi.org/10.1186/s12859-019-2849-7)

# Installation

This section covers the installation of
*slamdunk*
. Alternatively one could also run
*slamdunk*
from out of the box
[*Docker*](docs.html#docker-label)
containers.

There are 3 different possibilities:

1. Installation with
   [conda](https://conda.io/docs/)
   from the
   [*Bioconda*](docs.html#conda-label)
   channel
   **(recommended)**
2. Installation with
   [pip](https://pypi.python.org/pypi/pip)
   from the
   [*Python Package Index*](docs.html#pip-label)
3. Manual installation from
   *source-label*

# Bioconda

We recommend using virtual environments to manage your Python installation. Our favourite is
[Anaconda](https://www.anaconda.com/)
, a cross-platform tool to manage Python environments. You can installation instructions for Anaconda
[here](http://conda.pydata.org/docs/install/quick.html)
.
Then you can directly install
[slamdunk](https://bioconda.github.io/recipes/slamdunk/README.html)
from the
[Bioconda channel](https://bioconda.github.io/)
.

## Requirements

* [Miniconda](https://conda.io/miniconda.html)
  or
  [Anaconda](https://www.anaconda.com/download/)

## Installation

Once Anaconda is installed, you can create an environment containing the
*slamdunk*
package with the following command:

```
conda create --name <name> -c bioconda slamdunk
```

# Python Package Index

[pip](https://pypi.python.org/pypi/pip)
is the recommended tool for installing Python packages. It allows a convenient and simple installation
of
*slamdunk*
from the
[Python Package Index PyPI](https://pypi.python.org/pypi)
.

## Requirements

* Python 2.7
* pip
* Java
* cmake
* [R](https://www.r-project.org/)
  3.2.2 for
  *alleyoop*
  and
  *splash*

## Installation

```
# Having root permissions

pip install slamdunk

# Latest development version

pip install git+https://github.com/t-neumann/slamdunk.git

# Local user only

pip install --user slamdunk
export PATH=$PATH:$HOME/.local/bin/
```

# Quickstart

To analyze a given SLAMSeq dataset with
*slamdunk*
using the default parameters which worked well on datasets during development,
call the
*all*
dunk using the recommended minimum set of default parameters:

```
slamdunk all -r <reference fasta> -b <bed file> -o <output directory> -5 12 -n 100
             -t <threads> -m -rl <maximum read length> --skip-sam files [files ...]
```

The input data you need and parameters you need to set yourself are the following:

| Parameter | Description |
| --- | --- |
| **-r** | The reference fasta file. |
| **-b** | BED-file containing coordinates for 3’ UTRs. |
| **-o** | The output directory where all output files of this dunk will be placed. |
| **-t** | The number of threads to use for this dunk. NextGenMap runs multi-threaded, so it is recommended to use more threads than available samples (default: 1). |
| **files** | Samplesheet (see [*Sample file format*](docs.html#sample-file) ) or a list of all sample BAM/FASTA(gz)/FASTQ(gz) files (wildcard \* accepted). |

This will run the entire
*slamdunk*
analysis with the most relevant output files being:

* Folder
  *count*
  : Tab-separated
  *tcount*
  files containing the SLAMSeq statistics per UTR (see
  [*Tcount file format*](docs.html#tcount-file)
  )
* Folder
  *filter*
  : BAM-files with the final mapped reads for visualization and further processing

---

If you want to have a very quick sanity check whether your desired conversion rates have been achieved, use this
*alleyoop*
command
to plot the UTR conversion rates in your sample:

```
alleyoop utrrates -o <output directory> -r <reference fasta> -t <threads>
                  -b <bed file> -l <maximum read length> bam [bam ...]
```

| Parameter | Description |
| --- | --- |
| **-o** | The output directory where the plots will be placed. |
| **-r** | The reference fasta file. |
| **-t** | The number of threads to use. All tools run single-threaded, so it is recommended to use as many threads as available samples. |
| **-b** | BED-file containing coordinates for 3’ UTRs. |
| **-l** | Maximum read length in all samples. |
| **bam** | BAM file(s) containing the final filtered reads from the *filter* folder (wildcard \* accepted). |

This will produce a plot like the following example where you can clearly see that individual conversions for a given starting base are balanced and unbiased,
except for the T->C conversions in this SLAMSeq sample with longer labelling times.

# Basics

# Conversion rates

The individual measured conversion rates within a 3’ UTR are highly dependent on the T-content of a given UTR and the number of reads that cover those Ts.
The more reads containing Ts, the more accurate the overall estimation of the conversion rate of T>Cs in this given 3’ UTR will be.

We have adressed this by using a 3’ UTR positions based view instead of a read based view: For each T-position in a given 3’ UTR, we record
the number of reads covering this position and the number of reads with T>C conversion at this position - the more reads, the more accurate the T>C conversion rate estimation will be.

Both values are summed over all T-positions in the UTR - this way, less reliable T-positions with little reads will have lower impact on the overall T>C conversion rate estimation than
T-positions with many reads.

[![images/conversionrates.png](images/conversionrates.png)](images/conversionrates.png)

**Note:**
Since QuantSeq is a strand-specific assay, only sense reads will be considered for the final analysis!

# Multimapper reconciliation

## Definition and importance

Multimappers are reads which align to more than one position in the genome with equal best alignment scores.

Such reads make up a substantial part of the alignment and are generally ignored, but can provide valuable information if they can be unequivocally
reassigned to a given location, enhancing the overall signal and thus heavily influencing the overall accuracy.

However, there are also several caveats: For genes with isoforms or homologous genes, simply taking all alignments into account will heavily distort
the signal, since the reads will likely not account equally for all regions, but rather originate mainly from a single region which cannot be unambiguously assigned.

## Reassignment strategy

We have settled for a very conservative multimapper reassignment strategy:

Since the QuantSeq technology specifically enriches for 3’ UTRs, we only consider alignments to annotated 3’ UTRs supplied to
*slamdunk*
as relevant.

Therefore, any multimappers with alignments to a single 3’ UTR and non-3’UTR regions (i.e. not annotated in the supplied reference) will be unequivocally
assigned to the single 3’UTR. If there are multiple alignments to this single 3’UTR, one will be chosen at random.

For all other cases, were a read maps to several 3’ UTRs, we are unable to reassign the read uniquely to a given 3’UTR and thus discard it from the analysis.

In short, the procedure is as follows, illustrated by the example below:

1. Create an
   [Interval Tree](https://pypi.python.org/pypi/intervaltree/2.0.4)
   from the supplied 3’ UTR annotation
2. Check the overlaps of all multimapping reads with 3’ UTRs using the Interval Tree
3. Remove any reads with alignments to more than one single 3’ UTR
4. Remove any additional alignments to non-UTR regions

[![images/multimappers.png](images/multimappers.png)](images/multimappers.png)

# Sample file format

Sample description files are a convenient way to provide multiple sample files as well as corresponding sample information to
*slamdunk*
. A sample description
file is a tab or comma separated plain text file with the following columns:

| Column | Datatype | Description |
| --- | --- | --- |
| Filepath | String | Path to raw reads in BAM/fasta(gz)/fastq(gz) format |
| Sample description | String | Description of the sample |
| Sample type | String | Type of sample. Only relevant for timecourses (pulse/chase) otherwise use any value |
| Timepoint | Integer | Timepoint of the sample in minutes. Again only relevant for timecourses otherwise use any value |

# Tcount file format

The
*tcount*
file is the central output file of
*slamdunk*
. It contains all results, conversion rates and other statistics for each UTR which is the
main starting point for any subsequent analysis that will follow e.g. transcript half-life estimates or DE analysis.

*Tcount*
files are essentially tab-separated text files containing one line entry per 3’ UTR supplied by the user. Each entry contains the following
columns:

| Column | Datatype | Description |
| --- | --- | --- |
| chromosome | String | Chromosome on which the 3’ UTR resides |
| start | Integer | Start position of the 3’ UTR |
| end | Integer | End position of the 3’ UTR |
| name | String | Name or ID of the 3’ UTR supplied by the user |
| length | Integer | Length of the 3’ UTR |
| strand | String | Strand of the 3’ UTR |
| conversionRate | Float | Average conversion rate (see [*Conversion rates*](docs.html#conversionrates) ) |
| readsCPM | Float | Normalized number of reads as counts per million |
| Tcontent | Integer | Number of Ts in the 3’ UTR (As for - strand UTRs) |
| coverageOnTs | Integer | Cumulative coverage on all Ts in the 3’ UTR |
| conversionsOnTs | Integer | Cumulative number of T>C conversions in the 3’ UTR |
| readCount | Integer | Number of reads aligning to the 3’ UTR |
| tcReadCount | Integer | Number of reads with T>C conversions aligning to the 3’ UTR |
| multimapCount | Integer | Number of reads considered as multimappers aligning to the 3’ UTR |

Here is an example:

```
chr13   14197734        14199362        ENSMUSG00000039219      1628    +       0.0466045272969 4.00770947448   587     751     35      59      29      0
chr2    53217389        53219220        ENSMUSG00000026960      1831    +       0.0270802560315 28.3936027175   709     6093    165     418     138     2
chr2    53217389        53218446        ENSMUSG00000026960      1057    +       0.0268910814471 23.9783295677   407     5169    139     353     118     0
chr3    95495394        95495567        ENSMUSG00000015522      173     +       0.0290697674419 1.08683646766   53      172     5       16      5       0
chr3    95495394        95497237        ENSMUSG00000015522      1843    +       0.0253636702723 11.6834920273   584     2681    68      172     55      4
chr6    113388777       113389056       ENSMUSG00000079426      279     +       0.0168514412417 16.7780379694   71      2255    38      247     38      3
```

# Usage

*Slamdunk*
is a modular analysis software. Modules are dubbed
*dunks*
and each dunk builds upon the results from the previous dunks.

The idea is to always process all samples with one command line call of a given dunk. Output files typically get the same name as the input files with a certain prefix (e.g. “slamdunk\_mapped”).
The command line interface follows the “samtools/bwa” style. Meaning that all commands are available through the central executable/script
*slamdunk*
(located in the bin directory)
Wildcard characters to supply multiple files are recognized throughout
*slamdunk*
.

Available dunks are:

```
'map', 'filter', 'snp', 'count', 'all'
```

Calling a module with –help shows all possible parameters text:

```
usage: slamdunk all [-h] -r REFERENCEFILE -b BED [-fb FILTERBED] -o OUTPUTDIR [-5 TRIM5]
                 [-a MAXPOLYA] [-n TOPN] [-t THREADS] [-q] [-e] [-m]
                 [-mq MQ] [-mi IDENTITY] [-nm NM] [-mc COV] [-mv VAR]
                 [-mts] [-rl MAXLENGTH] [-mbq MINQUAL] [-i SAMPLEINDEX]
                 [-ss]
                 files [files ...]

positional arguments:
   files                 Single csv/tsv file (recommended) containing all
                         sample files and sample info or a list of all sample
                         BAM/FASTA(gz)/FASTQ(gz) files

optional arguments:
   -h, --help            show this help message and exit
   -r REFERENCEFILE, --reference REFERENCEFILE
                         Reference fasta file
   -b BED, --bed BED     BED file with 3'UTR coordinates
   -fb FILTERBED, --filterbed FILTERBED
                         BED file with 3'UTR coordinates to filter multimappers
   -o OUTPUTDIR, --outputDir OUTPUTDIR
                         Output directory for slamdunk run.
   -5 TRIM5, --trim-5p TRIM5
                         Number of bp removed from 5' end of all reads
                         (default: 12)
   -a MAXPOLYA, --max-polya MAXPOLYA
                         Max number of As at the 3' end of a read (default: 4)
   -n TOPN, --topn TOPN  Max. number of alignments to report per read (default:
                         1)
   -t THREADS, --threads THREADS
                         Thread number (default: 1)
   -q, --quantseq        Run plain Quantseq alignment without SLAM-seq scoring
   -e, --endtoend        Use a end to end alignment algorithm for mapping.
   -m, --multimap        Use reference to resolve multimappers (requires -n >
                         1).
   -mq MQ, --min-mq MQ   Minimum mapping quality (default: 2)
   -mi IDENTITY, --min-identity IDENTITY
                         Minimum alignment identity (default: 0.95)
   -nm NM, --max-nm NM   Maximum NM for alignments (default: -1)
   -mc COV, --min-coverage COV
                         Minimimum coverage to call variant (default: 10)
   -mv VAR, --var-fraction VAR
                         Minimimum variant fraction to call variant (default:
                         0.8)
   -mts, --multiTCStringency
                         Multiple T>C conversion required for T>C read
   -rl MAXLENGTH, --max-read-length MAXLENGTH
                         Max read length in BAM file
   -mbq MINQUAL, --min-base-qual MINQUAL
                   