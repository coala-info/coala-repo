# seqtk CWL Generation Report

## seqtk_seq

### Tool Description
Common transformation of FASTA/FASTQ sequences, including masking, partitioning, and format conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqtk/overview
- **Total Downloads**: 702.3K
- **Last updated**: 2025-07-09
- **GitHub**: https://github.com/lh3/seqtk
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
```


## seqtk_size

### Tool Description
Calculate the total number of bases and sequences in a FASTA/FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::stk_size] failed to open the input file/stream.
```


## seqtk_comp

### Tool Description
Get the nucleotide composition of a FASTA/FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
```


## seqtk_sample

### Tool Description
Subsample sequences from FASTA/FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   seqtk sample [-2] [-s seed=11] <in.fa> <frac>|<number>

Options: -s INT       RNG seed [11]
         -2           2-pass mode: twice as slow but with much reduced memory
```


## seqtk_subseq

### Tool Description
Extract subsequences from FASTA/FASTQ files using a BED file or a list of names

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage:   seqtk subseq [options] <in.fa> <in.bed>|<name.list>
Options:
  -t       TAB delimited output
  -s       strand aware
  -l INT   sequence line length [0]
Note: Use 'samtools faidx' if only a few regions are intended.
```


## seqtk_fqchk

### Tool Description
Fastq quality check and distribution analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk fqchk [-q 20] <in.fq>
Note: use -q0 to get the distribution of all quality values
```


## seqtk_mergepe

### Tool Description
Merge paired-end reads from two separate FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk mergepe <in1.fq> <in2.fq>
```


## seqtk_split

### Tool Description
Split a FASTA/FASTQ file into multiple files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk split [options] <prefix> <in.fa>
Options:
  -n INT    number of files [10]
  -l INT    line length [0]
```


## seqtk_trimfq

### Tool Description
Trim low-quality regions from FASTQ sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   seqtk trimfq [options] <in.fq>

Options: -q FLOAT    error rate threshold (disabled by -b/-e) [0.05]
         -l INT      maximally trim down to INT bp (disabled by -b/-e) [30]
         -b INT      trim INT bp from left (non-zero to disable -q/-l) [0]
         -e INT      trim INT bp from right (non-zero to disable -q/-l) [0]
         -L INT      retain at most INT bp from the 5'-end (non-zero to disable -q/-l) [0]
         -Q          force FASTQ output
```


## seqtk_hety

### Tool Description
Analyze heterozygosity in a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   seqtk hety [options] <in.fa>

Options: -w INT   window size [50000]
         -t INT   # start positions in a window [5]
         -m       treat lowercases as masked
```


## seqtk_gc

### Tool Description
Identify GC-rich or AT-rich regions in a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk gc [options] <in.fa>
Options:
  -w         identify high-AT regions
  -f FLOAT   min GC fraction (or AT fraction for -w) [0.60]
  -l INT     min region length to output [20]
  -x FLOAT   X-dropoff [10.0]
```


## seqtk_mutfa

### Tool Description
Mutate a FASTA file based on a SNP list. The SNP file should contain at least four columns: 'chr', '1-based-pos', 'any', and 'base-changed-to'.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk mutfa <in.fa> <in.snp>

Note: <in.snp> contains at least four columns per line which are:
      'chr  1-based-pos  any  base-changed-to'.
```


## seqtk_mergefa

### Tool Description
Merge two FASTA/Q files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: seqtk mergefa [options] <in1.fa> <in2.fa>

Options: -q INT   quality threshold [0]
         -i       take intersection
         -m       convert to lowercase when one of the input base is N
         -r       pick a random allele from het
         -h       suppress hets in the input
```


## seqtk_famask

### Tool Description
Apply a mask to a FASTA sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk famask <src.fa> <mask.fa>
```


## seqtk_dropse

### Tool Description
Drop single-end reads from interleaved FASTQ

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::stk_dropse] failed to open the input file/stream.
```


## seqtk_rename

### Tool Description
Rename sequences in a FASTA/FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::stk_rename] failed to open the input file/stream.
```


## seqtk_randbase

### Tool Description
Randomize bases in a sequence file (usually part of the seqtk toolkit)

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::stk_randbase] failed to open the input file/stream.
```


## seqtk_cutN

### Tool Description
Cut sequences at long N tracts

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   seqtk cutN [options] <in.fa>

Options: -n INT    min size of N tract [1000]
         -p INT    penalty for a non-N [10]
         -g        print gaps only, no sequence
```


## seqtk_gap

### Tool Description
Find gaps in a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: seqtk gap [-l 50] <in.fa>
```


## seqtk_listhet

### Tool Description
Identify and list heterozygous sites from a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::stk_listhet] failed to open the input file/stream.
```


## seqtk_hpc

### Tool Description
A tool for processing biological sequences (HPC version).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::stk_hpc] failed to open the input file/stream.
```


## seqtk_telo

### Tool Description
The provided text does not contain help information or a description for the tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
- **Homepage**: https://github.com/lh3/seqtk
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
0	0
```


## Metadata
- **Skill**: generated
