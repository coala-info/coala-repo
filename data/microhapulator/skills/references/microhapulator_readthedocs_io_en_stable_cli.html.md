### Navigation

* [index](genindex.html "General Index")
* [next](conduct.html "Contributor Code of Conduct") |
* [previous](api.html "Python API Reference") |
* [mhpl8r](index.html) »
* Command Line Interface

# Command Line Interface[¶](#command-line-interface "Permalink to this heading")

This page shows the MicroHapulator command line interface: how inputs and settings are specified for each subcommand.

**NOTE**: The MicroHapulator CLI is under [Semantic Versioning](https://semver.org/).
In brief, this means that every stable version of the MicroHapulator software is assigned a version number, and that any changes to the software's behavior or interface require the software version number to be updated in prescribed and predictable ways.

---

## End-to-end analysis workflow[¶](#end-to-end-analysis-workflow "Permalink to this heading")

### `mhpl8r pipe`[¶](#mhpl8r-pipe "Permalink to this heading")

Perform a complete end-to-end microhap analysis pipeline

```
usage: mhpl8r pipe [-h] [-w D] [-n] [-t T] [-s ST] [-d DT] [-a AT] [-l LT]
                   [-D DA] [-G GA] [-c CSV] [--single] [--copy-input]
                   [--hspace HS]
                   markerrefr markerdefn seqpath samples [samples ...]
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`markerrefr`
:   path to a FASTA file containing marker reference sequences

`markerdefn`
:   path to a TSV file containing marker definitions

`seqpath`
:   path to a directory containing FASTQ files

`samples`
:   list of sample names or path to .txt file containing sample names

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-w, --workdir`
:   pipeline working directory; default is current directory

`-n, --dryrun`
:   do not execute the workflow, but display what would have been done

`-t, --threads`
:   process each batch using T threads; by default, one thread per available core is used

`-s, --static`
:   global fixed read count threshold; ST=5 by default

`-d, --dynamic`
:   global percentage of total read count threshold; e.g. use --dynamic=0.02 to apply a 2% analytical threshold; DT=0.02 by default

`-a, --ambiguous-thresh`
:   filter out reads with more than AT percent of ambiguous characters ('N'); AT=0.2 by default

`-l, --length-thresh`
:   filter out reads that are less than LT bp long; LT=50 by default

`-D, --discard-alert`
:   issue an alert in the final report for each marker whose read discard rate (proportion of reads that could not be typed) exceeds DA; by default DA=0.25

`-G, --gap-alert`
:   issue an alert in the final report for each marker whose gap rate (proportion of reads containing one or more gap alleles) exceeds DA; by default DA=0.05

`-c, --config`
:   CSV file specifying marker-specific thresholds to override global thresholds; three required columns: 'Marker' for the marker name; 'Static' and 'Dynamic' for marker-specific thresholds

`--single`
:   accept single-end reads only; by default, only paired-end reads are accepted

`--copy-input`
:   copy input files to working directory; by default, input files are symlinked

`--hspace`
:   horizontal spacing between samples in the read distribution length ridge plots; negative value for this parameter enables overlapping plots; HS=-0.7 by default

## Haplotype calling[¶](#haplotype-calling "Permalink to this heading")

### `mhpl8r type`[¶](#mhpl8r-type "Permalink to this heading")

Perform haplotype calling

```
usage: mhpl8r type [-h] [-o FILE] [-b B] [-m M] tsv bam
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`tsv`
:   path of a TSV file containing marker metadata, specifically the offset of each SNP for every marker in the panel

`bam`
:   path of a BAM file containing NGS reads aligned to marker reference sequences and sorted

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to FILE; by default, output is written to the terminal (standard output)

`-b, --base-qual`
:   minimum base quality (PHRED score) to be considered reliable for haplotype calling; by default B=10, corresponding to Q10, i.e., 90% probability that the base call is correct

`-m, --max-depth`
:   maximum permitted read depth; by default M=1000000

### `mhpl8r filter`[¶](#mhpl8r-filter "Permalink to this heading")

Apply static and/or dynamic thresholds to distinguish true and false haplotypes. Thresholds are applied to the haplotype read counts of a raw typing result. Static integer thresholds are commonly used as detection thresholds, below which any haplotype count is considered noise. Dynamic thresholds are commonly used as analytical thresholds and represent a percentage of the total read count at the marker, after any haplotypes failing a static threshold are discarded.

```
usage: mhpl8r filter [-h] [-o FILE] [-s ST] [-d DT] [-c CSV] result
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`result`
:   MicroHapulator typing result in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to FILE; by default, output is written to the terminal (standard output)

`-s, --static`
:   global fixed read count threshold

`-d, --dynamic`
:   global percentage of total read count threshold; e.g. use --dynamic=0.02 to apply a 2% analytical threshold

`-c, --config`
:   CSV file specifying marker-specific thresholds to override global thresholds; three required columns: 'Marker' for the marker name; 'Static' and 'Dynamic' for marker-specific thresholds

## Analysis, QA/QC, and interpretation[¶](#analysis-qa-qc-and-interpretation "Permalink to this heading")

### `mhpl8r locbalance`[¶](#mhpl8r-locbalance "Permalink to this heading")

Plot interlocus balance in the terminal and/or a high-resolution graphic. Also normalize read counts and perform a chi-square goodness-of-fit test assuming uniform read coverage across markers. The reported chi-square statistic measures the extent of imbalance, and can be compared among samples sequenced using the same panel: the minimum value of 0 represents perfectly uniform coverage, while the maximum value of D occurs when all reads map to a single marker (D represents the degrees of freedom, or the number of markers minus 1).

```
usage: mhpl8r locbalance [-h] [-c FILE] [-D] [-q] [--figure FILE]
                         [--figsize W H] [--dpi DPI] [-t T] [--color C]
                         input
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`input`
:   a typing result including haplotype counts in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-c, --csv`
:   write read counts to FILE in CSV format

`-D, --no-discarded`
:   do not included mapping but discarded reads in read counts; by default, reads that are mapped to the marker but discarded because they do not span all variants at the marker are included

`-q, --quiet`
:   do not print interlocus balance histogram to standard output in ASCII

`--figure`
:   plot interlocus balance histogram to FILE using Matplotlib; image format is inferred from extension of provided file name

`--figsize`
:   dimensions (width × height in inches) of the image file to be generated; 6 4 by default

`--dpi`
:   resolution (in dots per inch) of the image file to be generated; DPI=200 by default

`-t, --title`
:   add a title (such as a sample name) to the histogram plot

`--color`
:   override histogram plot color; green by default

### `mhpl8r hetbalance`[¶](#mhpl8r-hetbalance "Permalink to this heading")

Compute and plot heterozygote balance

```
usage: mhpl8r hetbalance [-h] [-c FILE] [--figure FILE] [--figsize W H]
                         [--dpi DPI] [-t T] [--labels] [--absolute]
                         input
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`input`
:   a typing result including haplotype counts in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-c, --csv`
:   write read counts to FILE in CSV format

`--figure`
:   plot heterzygote balance bar graph to FILE using Matplotlib; image format is inferred from extension of provided file name

`--figsize`
:   dimensions (width × height in inches) of the image file to be generated; figure dimensions determined automatically by default

`--dpi`
:   resolution (in dots per inch) of the image file to be generated; DPI=200 by default

`-t, --title`
:   add a title (such as a sample name) to the histogram plot

`--labels`
:   include labels showing marker names and read counts

`--absolute`
:   plot absolute rather than relative read counts

### `mhpl8r repetitive`[¶](#mhpl8r-repetitive "Permalink to this heading")

Calculate number of reads that map to a marker sequence but map preferentially to another locus when aligned to the whole genome

```
usage: mhpl8r repetitive [-h] [-o FILE] [-b B] markerbam refbam tsv
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`markerbam`
:   alignment file of reads aligned to marker sequences

`refbam`
:   alignment file in BAM format of reads aligned to hg38

`tsv`
:   marker definitions tsv including chromosome and full reference genome offset columns

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to FILE; by default, output is written to the terminal (standard output)

`-b, --base-qual`
:   minimum base quality (PHRED score) to be considered reliable for haplotype calling; by default B=10, corresponding to Q10, i.e., 90% probability that the base call is correct

### `mhpl8r mappingqc`[¶](#mhpl8r-mappingqc "Permalink to this heading")

Calculate number of on target, off target, repetitive, and contaminant reads and create a donut plot

```
usage: mhpl8r mappingqc [-h] [--csv CSV] [--figure FIGURE] [--title TITLE]
                        marker refr rep
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`marker`
:   path of csv file containing number of reads mapped to marker sequences

`refr`
:   path of csv file containing number of reads mapped to full reference genome

`rep`
:   path of csv file containing number of repetitive reads per marker

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`--csv`
:   write read counts to FILE in CSV format

`--figure`
:   create donut plot to FILE showing porportions of on target, off target, repetitive, and contaminant reads

`--title`
:   add a title (such as a sample name) to the donut plot

### `mhpl8r contrib`[¶](#mhpl8r-contrib "Permalink to this heading")

Estimate the minimum number of DNA contributors to a suspected mixture

```
usage: mhpl8r contrib [-h] [-o FILE] result
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`result`
:   typing result in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to FILE; by default, output is written to the terminal (standard output)

### `mhpl8r prob`[¶](#mhpl8r-prob "Permalink to this heading")

Compute a profile random match probability (RMP) or an RMP-based likelihood ratio (LR) test

```
usage: mhpl8r prob [-h] [-e ε] [-o FILE] freq profile1 [profile2]
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`freq`
:   population haplotype frequencies in tabular (TSV) format

`profile1`
:   typing result or simulated genotype in JSON format

`profile2`
:   typing result or simulated genotype in JSON format; optional

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-e, --erate`
:   rate of genotyping error; by default ε=0.01

`-o, --out`
:   write output to FILE; by default, output is written to the terminal (standard output)

### `mhpl8r diff`[¶](#mhpl8r-diff "Permalink to this heading")

Compare two profiles and determine the markers at which their genotypes differ

```
usage: mhpl8r diff [-h] [-o FILE] profile1 profile2
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`profile1`
:   typing result or simulated profile in JSON format

`profile2`
:   typing result or simulated profile in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to "FILE"; by default, output is written to the terminal (standard output)

### `mhpl8r dist`[¶](#mhpl8r-dist "Permalink to this heading")

Compute a simple Hamming distance between two profiles

```
usage: mhpl8r dist [-h] [-o FILE] profile1 profile2
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`profile1`
:   typing result or simulated profile in JSON format

`profile2`
:   typing result or simulated profile in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to "FILE"; by default, output is written to the terminal (standard output)

### `mhpl8r contain`[¶](#mhpl8r-contain "Permalink to this heading")

Perform a simple containment test

```
usage: mhpl8r contain [-h] [-o FILE] profile1 profile2
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`profile1`
:   simulated or inferred genotype profile in JSON format

`profile2`
:   simulated or inferred genotype profile in JSON format

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to "FILE"; by default, output is written to the terminal (standard output)

### `mhpl8r convert`[¶](#mhpl8r-convert "Permalink to this heading")

Convert a typing result to a format compatible with probabilistic genotyping software applications

```
usage: mhpl8r convert [-h] [-o FILE] [--no-counts] [-f] result sample
```

#### Positional Arguments[¶](#positional-arguments "Permalink to this heading")

`result`
:   filtered MicroHapulator typing result in JSON format

`sample`
:   sample name

#### Named Arguments[¶](#named-arguments "Permalink to this heading")

`-o, --out`
:   write output to 'FILE'; by default, output is written to the terminal (standard output)

`--no-counts`
:   do not include haplotype counts if you are interpreting your data with a semi-continuous probgen model such as LRMix Studio; by default, haplotype counts are included for interpretation with fully continuous probgen model such as EuroForMix

`-f, --fix-homo`
:   duplicate a homozygous haplotype so that it is reported twice

### `mhpl8r getrefr`[¶](#mhpl8r-getrefr "Permalink to this heading")

Download and index a GRCh38 assembly file suitable as a whole-genome mapping reference

```
usage: mhpl8r getrefr [-h]
```

## Simulation[¶](#simulation "Permalink to this heading")

### `mhpl8r sim`[¶](#mhpl8r-sim "Permalink to this heading")

Simulate a diploid genotype from the specified microhaplotype frequencies

```
usage: mhpl8r sim [-h] [-s INT] [-o