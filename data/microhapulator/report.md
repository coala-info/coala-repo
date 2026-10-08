# microhapulator CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| microhapulator_mhpl8r_contain | PASS |  |
| microhapulator_mhpl8r_contrib | PASS |  |
| microhapulator_mhpl8r_convert | PASS |  |
| microhapulator_mhpl8r_diff | PASS |  |
| microhapulator_mhpl8r_dist | PASS |  |
| microhapulator_mhpl8r_filter | PASS |  |
| microhapulator_mhpl8r_hetbalance | PASS |  |
| microhapulator_mhpl8r_locbalance | PASS |  |
| microhapulator_mhpl8r_mappingqc | PASS |  |
| microhapulator_mhpl8r_mix | PASS |  |
| microhapulator_mhpl8r_pipe | Not completed | pipeline, skipped (runs a whole Snakemake workflow). |
| microhapulator_mhpl8r_prob | PASS |  |
| microhapulator_mhpl8r_repetitive | PASS |  |
| microhapulator_mhpl8r_seq | PASS |  |
| microhapulator_mhpl8r_sim | PASS |  |
| microhapulator_mhpl8r_type | PASS |  |
| microhapulator_mhpl8r_unite | PASS |  |

## microhapulator_mhpl8r_pipe

### Tool Description
Perform a complete end-to-end microhap analysis pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r pipe [-h] [-w D] [-n] [-t T] [-s ST] [-d DT] [-a AT] [-l LT]
                   [-D DA] [-G GA] [-c CSV] [--single] [--copy-input]
                   [--hspace HS]
                   markerrefr markerdefn seqpath samples [samples ...]

Perform a complete end-to-end microhap analysis pipeline

positional arguments:
  markerrefr            path to a FASTA file containing marker reference
                        sequences
  markerdefn            path to a TSV file containing marker definitions
  seqpath               path to a directory containing FASTQ files
  samples               list of sample names or path to .txt file containing
                        sample names

optional arguments:
  -h, --help            show this help message and exit
  -w D, --workdir D     pipeline working directory; default is current
                        directory
  -n, --dryrun          do not execute the workflow, but display what would
                        have been done
  -t T, --threads T     process each batch using T threads; by default, one
                        thread per available core is used
  -s ST, --static ST    global fixed read count threshold; ST=5 by default
  -d DT, --dynamic DT   global percentage of total read count threshold; e.g.
                        use --dynamic=0.02 to apply a 2% analytical threshold;
                        DT=0.02 by default
  -a AT, --ambiguous-thresh AT
                        filter out reads with more than AT percent of
                        ambiguous characters ('N'); AT=0.2 by default
  -l LT, --length-thresh LT
                        filter out reads that are less than LT bp long; LT=50
                        by default
  -D DA, --discard-alert DA
                        issue an alert in the final report for each marker
                        whose read discard rate (proportion of reads that
                        could not be typed) exceeds DA; by default DA=0.25
  -G GA, --gap-alert GA
                        issue an alert in the final report for each marker
                        whose gap rate (proportion of reads containing one or
                        more gap alleles) exceeds DA; by default DA=0.05
  -c CSV, --config CSV  CSV file specifying marker-specific thresholds to
                        override global thresholds; three required columns:
                        'Marker' for the marker name; 'Static' and 'Dynamic'
                        for marker-specific thresholds
  --single              accept single-end reads only; by default, only paired-
                        end reads are accepted
  --copy-input          copy input files to working directory; by default,
                        input files are symlinked
  --hspace HS           horizontal spacing between samples in the read
                        distribution length ridge plots; negative value for
                        this parameter enables overlapping plots; HS=-0.7 by
                        default
```


## microhapulator_mhpl8r_seq

### Tool Description
Simulate paired-end Illumina MiSeq sequencing of the given profile(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r seq [-h] [-o OUT [OUT ...]] [-n N] [-p P [P ...]]
                  [-s INT [INT ...]]
                  tsv refrseqs profiles [profiles ...]

Simulate paired-end Illumina MiSeq sequencing of the given profile(s)

positional arguments:
  tsv                   microhaplotype marker definitions in tabular (TSV)
                        format
  refrseqs              microhaplotype reference sequences in FASTA format
  profiles              one or more simple or complex profiles (JSON files)

optional arguments:
  -h, --help            show this help message and exit
  -o OUT [OUT ...], --out OUT [OUT ...]
                        write simulated paired-end MiSeq reads in FASTQ format
                        to the specified file(s); if one filename is provided,
                        reads are interleaved and written to the file; if two
                        filenames are provided, reads are written to paired
                        files; by default, reads are interleaved and written
                        to the terminal (standard output)
  -n N, --num-reads N   number of reads to simulate; default is 500000
  -p P [P ...], --proportions P [P ...]
                        simulated mixture samples with multiple contributors
                        at the specified proportions; by default even
                        proportions are used
  -s INT [INT ...], --seeds INT [INT ...]
                        seeds for random number generator, 1 per profile
```


## microhapulator_mhpl8r_filter

### Tool Description
Apply static and/or dynamic thresholds to distinguish true and false haplotypes. Thresholds are applied to the haplotype read counts of a raw typing result. Static integer thresholds are commonly used as detection thresholds, below which any haplotype count is considered noise. Dynamic thresholds are commonly used as analytical thresholds and represent a percentage of the total read count at the marker, after any haplotypes failing a static threshold are discarded.

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r filter [-h] [-o FILE] [-s ST] [-d DT] [-c CSV] result

Apply static and/or dynamic thresholds to distinguish true and false
haplotypes. Thresholds are applied to the haplotype read counts of a raw
typing result. Static integer thresholds are commonly used as detection
thresholds, below which any haplotype count is considered noise. Dynamic
thresholds are commonly used as analytical thresholds and represent a
percentage of the total read count at the marker, after any haplotypes failing
a static threshold are discarded.

positional arguments:
  result                MicroHapulator typing result in JSON format

optional arguments:
  -h, --help            show this help message and exit
  -o FILE, --out FILE   write output to FILE; by default, output is written to
                        the terminal (standard output)
  -s ST, --static ST    global fixed read count threshold
  -d DT, --dynamic DT   global percentage of total read count threshold; e.g.
                        use --dynamic=0.02 to apply a 2% analytical threshold
  -c CSV, --config CSV  CSV file specifying marker-specific thresholds to
                        override global thresholds; three required columns:
                        'Marker' for the marker name; 'Static' and 'Dynamic'
                        for marker-specific thresholds
```


## microhapulator_mhpl8r_contain

### Tool Description
Perform a simple containment test

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r contain [-h] [-o FILE] profile1 profile2

Perform a simple containment test

positional arguments:
  profile1             simulated or inferred genotype profile in JSON format
  profile2             simulated or inferred genotype profile in JSON format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to "FILE"; by default, output is written
                       to the terminal (standard output)
```


## microhapulator_mhpl8r_contrib

### Tool Description
Estimate the minimum number of DNA contributors to a suspected mixture

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r contrib [-h] [-o FILE] result

Estimate the minimum number of DNA contributors to a suspected mixture

positional arguments:
  result               typing result in JSON format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to FILE; by default, output is written to
                       the terminal (standard output)
```


## microhapulator_mhpl8r_convert

### Tool Description
Convert a typing result to a format compatible with probabilistic genotyping software applications

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r convert [-h] [-o FILE] [--no-counts] [-f] result sample

Convert a typing result to a format compatible with probabilistic genotyping
software applications

positional arguments:
  result               filtered MicroHapulator typing result in JSON format
  sample               sample name

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to 'FILE'; by default, output is written
                       to the terminal (standard output)
  --no-counts          do not include haplotype counts if you are interpreting
                       your data with a semi-continuous probgen model such as
                       LRMix Studio; by default, haplotype counts are included
                       for interpretation with fully continuous probgen model
                       such as EuroForMix
  -f, --fix-homo       duplicate a homozygous haplotype so that it is reported
                       twice
```


## microhapulator_mhpl8r_diff

### Tool Description
Compare two profiles and determine the markers at which their genotypes differ

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r diff [-h] [-o FILE] profile1 profile2

Compare two profiles and determine the markers at which their genotypes differ

positional arguments:
  profile1             typing result or simulated profile in JSON format
  profile2             typing result or simulated profile in JSON format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to "FILE"; by default, output is written
                       to the terminal (standard output)
```


## microhapulator_mhpl8r_dist

### Tool Description
Compute a simple Hamming distance between two profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r dist [-h] [-o FILE] profile1 profile2

Compute a simple Hamming distance between two profiles

positional arguments:
  profile1             typing result or simulated profile in JSON format
  profile2             typing result or simulated profile in JSON format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to "FILE"; by default, output is written
                       to the terminal (standard output)
```


## microhapulator_mhpl8r_hetbalance

### Tool Description
Compute and plot heterozygote balance

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r hetbalance [-h] [-c FILE] [--figure FILE] [--figsize W H]
                         [--dpi DPI] [-t T] [--labels] [--absolute]
                         input

Compute and plot heterozygote balance

positional arguments:
  input                a typing result including haplotype counts in JSON
                       format

optional arguments:
  -h, --help           show this help message and exit
  -c FILE, --csv FILE  write read counts to FILE in CSV format
  --figure FILE        plot heterzygote balance bar graph to FILE using
                       Matplotlib; image format is inferred from extension of
                       provided file name
  --figsize W H        dimensions (width × height in inches) of the image file
                       to be generated; figure dimensions determined
                       automatically by default
  --dpi DPI            resolution (in dots per inch) of the image file to be
                       generated; DPI=200 by default
  -t T, --title T      add a title (such as a sample name) to the histogram
                       plot
  --labels             include labels showing marker names and read counts
  --absolute           plot absolute rather than relative read counts
```


## microhapulator_mhpl8r_locbalance

### Tool Description
Plot interlocus balance in the terminal and/or a high-resolution graphic. Also normalize read counts and perform a chi-square goodness-of-fit test assuming uniform read coverage across markers. The reported chi-square statistic measures the extent of imbalance, and can be compared among samples sequenced using the same panel: the minimum value of 0 represents perfectly uniform coverage, while the maximum value of D occurs when all reads map to a single marker (D represents the degrees of freedom, or the number of markers minus 1).

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r locbalance [-h] [-c FILE] [-D] [-q] [--figure FILE]
                         [--figsize W H] [--dpi DPI] [-t T] [--color C]
                         input

Plot interlocus balance in the terminal and/or a high-resolution graphic. Also
normalize read counts and perform a chi-square goodness-of-fit test assuming
uniform read coverage across markers. The reported chi-square statistic
measures the extent of imbalance, and can be compared among samples sequenced
using the same panel: the minimum value of 0 represents perfectly uniform
coverage, while the maximum value of D occurs when all reads map to a single
marker (D represents the degrees of freedom, or the number of markers minus
1).

positional arguments:
  input                a typing result including haplotype counts in JSON
                       format

optional arguments:
  -h, --help           show this help message and exit
  -c FILE, --csv FILE  write read counts to FILE in CSV format
  -D, --no-discarded   do not included mapping but discarded reads in read
                       counts; by default, reads that are mapped to the marker
                       but discarded because they do not span all variants at
                       the marker are included
  -q, --quiet          do not print interlocus balance histogram to standard
                       output in ASCII
  --figure FILE        plot interlocus balance histogram to FILE using
                       Matplotlib; image format is inferred from extension of
                       provided file name
  --figsize W H        dimensions (width × height in inches) of the image file
                       to be generated; 6 4 by default
  --dpi DPI            resolution (in dots per inch) of the image file to be
                       generated; DPI=200 by default
  -t T, --title T      add a title (such as a sample name) to the histogram
                       plot
  --color C            override histogram plot color; green by default
```


## microhapulator_mhpl8r_mappingqc

### Tool Description
Calculate number of on target, off target, repetitive, and contaminant reads and create a donut plot

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r mappingqc [-h] [--csv CSV] [--figure FIGURE] [--title TITLE]
                        marker refr rep

Calculate number of on target, off target, repetitive, and contaminant reads
and create a donut plot

positional arguments:
  marker           path of csv file containing number of reads mapped to
                   marker sequences
  refr             path of csv file containing number of reads mapped to full
                   reference genome
  rep              path of csv file containing number of repetitive reads per
                   marker

optional arguments:
  -h, --help       show this help message and exit
  --csv CSV        write read counts to FILE in CSV format
  --figure FIGURE  create donut plot to FILE showing porportions of on target,
                   off target, repetitive, and contaminant reads
  --title TITLE    add a title (such as a sample name) to the donut plot
```


## microhapulator_mhpl8r_mix

### Tool Description
Combine simulated profiles into a mock DNA mixture

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r mix [-h] [-o FILE] profiles [profiles ...]

Combine simulated profiles into a mock DNA mixture

positional arguments:
  profiles             simulated genotype profiles in JSON format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to "FILE"; by default, output is written
                       to the terminal (standard output)
```


## microhapulator_mhpl8r_prob

### Tool Description
Compute a profile random match probability (RMP) or an RMP-based likelihood ratio (LR) test

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r prob [-h] [-e ε] [-o FILE] freq profile1 [profile2]

Compute a profile random match probability (RMP) or an RMP-based likelihood
ratio (LR) test

positional arguments:
  freq                 population haplotype frequencies in tabular (TSV)
                       format
  profile1             typing result or simulated genotype in JSON format
  profile2             typing result or simulated genotype in JSON format;
                       optional

optional arguments:
  -h, --help           show this help message and exit
  -e ε, --erate ε      rate of genotyping error; by default ε=0.01
  -o FILE, --out FILE  write output to FILE; by default, output is written to
                       the terminal (standard output)
```


## microhapulator_mhpl8r_repetitive

### Tool Description
Calculate number of reads that map to a marker sequence but map preferentially to another locus when aligned to the whole genome

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r repetitive [-h] [-o FILE] [-b B] markerbam refbam tsv

Calculate number of reads that map to a marker sequence but map preferentially
to another locus when aligned to the whole genome

positional arguments:
  markerbam            alignment file of reads aligned to marker sequences
  refbam               alignment file in BAM format of reads aligned to hg38
  tsv                  marker definitions tsv including chromosome and full
                       reference genome offset columns

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to FILE; by default, output is written to
                       the terminal (standard output)
  -b B, --base-qual B  minimum base quality (PHRED score) to be considered
                       reliable for haplotype calling; by default B=10,
                       corresponding to Q10, i.e., 90% probability that the
                       base call is correct
```


## microhapulator_mhpl8r_sim

### Tool Description
Simulate a diploid genotype from the specified microhaplotype frequencies

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r sim [-h] [-s INT] [-o FILE] [--haplo-seq FILE]
                  [--sequences FILE] [--markers FILE]
                  freq

Simulate a diploid genotype from the specified microhaplotype frequencies

positional arguments:
  freq                 population microhaplotype frequencies in tabular (tab
                       separated) format

optional arguments:
  -h, --help           show this help message and exit
  -s INT, --seed INT   seed for random number generator
  -o FILE, --out FILE  write simulated profile data in JSON format to FILE
  --haplo-seq FILE     write simulated haplotype sequences in FASTA format to
                       FILE
  --sequences FILE     microhaplotype sequences in FASTA format; required if
                       `--haplo-seq` enabled, ignored if not
  --markers FILE       microhaplotype marker definitions in tabular (tab
                       separated) format; required if `--haplo-seq` enabled,
                       ignored if not
```


## microhapulator_mhpl8r_type

### Tool Description
Perform haplotype calling

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r type [-h] [-o FILE] [-b B] [-m M] tsv bam

Perform haplotype calling

positional arguments:
  tsv                  path of a TSV file containing marker metadata,
                       specifically the offset of each SNP for every marker in
                       the panel
  bam                  path of a BAM file containing NGS reads aligned to
                       marker reference sequences and sorted

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to FILE; by default, output is written to
                       the terminal (standard output)
  -b B, --base-qual B  minimum base quality (PHRED score) to be considered
                       reliable for haplotype calling; by default B=10,
                       corresponding to Q10, i.e., 90% probability that the
                       base call is correct
  -m M, --max-depth M  maximum permitted read depth; by default M=1000000
```


## microhapulator_mhpl8r_unite

### Tool Description
Simulate the creation of a new profile from a mother and father

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r unite [-h] [-o FILE] [-s INT] mom dad

Simulate the creation of a new profile from a mother and father

positional arguments:
  mom                  simulated or inferred genotype in JSON format
  dad                  simulated or inferred genotype in JSON format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output to "FILE"; by default, output is written
                       to the terminal (standard output)
  -s INT, --seed INT   seed for random number generator
```

## Metadata
- **Skill**: generated
