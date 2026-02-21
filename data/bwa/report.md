# bwa CWL Generation Report

## bwa_index

### Tool Description
Index database sequences in the FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Total Downloads**: 2.0M
- **Last updated**: 2025-05-13
- **GitHub**: https://github.com/lh3/bwa
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   bwa index [options] <in.fasta>

Options: -a STR    BWT construction algorithm: bwtsw, is or rb2 [auto]
         -p STR    prefix of the index [same as fasta name]
         -b INT    block size for the bwtsw algorithm (effective with -a bwtsw) [10000000]
         -6        index files named as <in.fasta>.64.* instead of <in.fasta>.* 

Warning: `-a bwtsw' does not work for short genomes, while `-a is' and
         `-a div' do not work for long genomes.
```


## bwa_mem

### Tool Description
Burrows-Wheeler Alignment Tool, MEM algorithm for aligning low-divergence sequences against a large reference genome

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bwa mem [options] <idxbase> <in1.fq> [in2.fq]

Algorithm options:

       -t INT        number of threads [1]
       -k INT        minimum seed length [19]
       -w INT        band width for banded alignment [100]
       -d INT        off-diagonal X-dropoff [100]
       -r FLOAT      look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
       -y INT        seed occurrence for the 3rd round seeding [20]
       -c INT        skip seeds with more than INT occurrences [500]
       -D FLOAT      drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]
       -W INT        discard a chain if seeded bases shorter than INT [0]
       -m INT        perform at most INT rounds of mate rescues for each read [50]
       -S            skip mate rescue
       -P            skip pairing; mate rescue performed unless -S also in use

Scoring options:

       -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
       -B INT        penalty for a mismatch [4]
       -O INT[,INT]  gap open penalties for deletions and insertions [6,6]
       -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]
       -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5]
       -U INT        penalty for an unpaired read pair [17]

       -x STR        read type. Setting -x changes multiple parameters unless overridden [null]
                     pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref)
                     ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref)
                     intractg: -B9 -O16 -L5  (intra-species contigs to ref)

Input/output options:

       -p            smart pairing (ignoring in2.fq)
       -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
       -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]
       -o FILE       sam file to output results to [stdout]
       -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)
       -5            for split alignment, take the alignment with the smallest query (not genomic) coordinate as primary
       -q            don't modify mapQ of supplementary alignments
       -K INT        process INT input bases in each batch regardless of nThreads (for reproducibility) []

       -v INT        verbosity level: 1=error, 2=warning, 3=message, 4+=debugging [3]
       -T INT        minimum score to output [30]
       -h INT[,INT]  if there are <INT hits with score >80.00% of the max score, output all in XA [5,200]
                     A second value may be given for alternate sequences.
       -z FLOAT      The fraction of the max score to use with -h [0.800000].
                     specify the mean, standard deviation (10% of the mean if absent), max
       -a            output all alignments for SE or unpaired PE
       -C            append FASTA/FASTQ comment to SAM output
       -V            output the reference FASTA header in the XR tag
       -Y            use soft clipping for supplementary alignments
       -M            mark shorter split hits as secondary

       -I FLOAT[,FLOAT[,INT[,INT]]]
                     specify the mean, standard deviation (10% of the mean if absent), max
                     (4 sigma from the mean if absent) and min of the insert size distribution.
                     FR orientation only. [inferred]
       -u            output XB instead of XA; XB is XA with the alignment score and mapping quality added.

Note: Please read the man page for detailed description of the command line and options.
```


## bwa_fastmap

### Tool Description
Identify Super Maximal Exact Matches (SMEMs) in a sequence against a reference index.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   bwa fastmap [options] <idxbase> <in.fq>

Options: -l INT    min SMEM length to output [17]
         -w INT    max interval size to find coordiantes [20]
         -i INT    min SMEM interval size [1]
         -L INT    max MEM length [2147483647]
         -I INT    stop if MEM is longer than -l with a size less than INT [0]
```


## bwa_pemerge

### Tool Description
Merge paired-end reads from BWA

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   bwa pemerge [-mu] <read1.fq> [read2.fq]

Options: -m       output merged reads only
         -u       output unmerged reads only
         -t INT   number of threads [1]
         -T INT   minimum end overlap [10]
         -Q INT   max sum of errors [70]
```


## bwa_aln

### Tool Description
Find the SA coordinates of the input reads

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   bwa aln [options] <prefix> <in.fq>

Options: -n NUM    max #diff (int) or missing prob under 0.02 err rate (float) [0.04]
         -o INT    maximum number or fraction of gap opens [1]
         -e INT    maximum number of gap extensions, -1 for disabling long gaps [-1]
         -i INT    do not put an indel within INT bp towards the ends [5]
         -d INT    maximum occurrences for extending a long deletion [10]
         -l INT    seed length [32]
         -k INT    maximum differences in the seed [2]
         -m INT    maximum entries in the queue [2000000]
         -t INT    number of threads [1]
         -M INT    mismatch penalty [3]
         -O INT    gap open penalty [11]
         -E INT    gap extension penalty [4]
         -R INT    stop searching when there are >INT equally best hits [30]
         -q INT    quality threshold for read trimming down to 35bp [0]
         -f FILE   file to write output to instead of stdout
         -B INT    length of barcode
         -L        log-scaled gap penalty for long deletions
         -N        non-iterative mode: search for all n-difference hits (slooow)
         -I        the input is in the Illumina 1.3+ FASTQ-like format
         -b        the input read file is in the BAM format
         -0        use single-end reads only (effective with -b)
         -1        use the 1st read in a pair (effective with -b)
         -2        use the 2nd read in a pair (effective with -b)
         -Y        filter Casava-filtered sequences
```


## bwa_samse

### Tool Description
Generate alignments in the SAM format given single-end reads

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwa samse [-n max_occ] [-f out.sam] [-r RG_line] <prefix> <in.sai> <in.fq>
```


## bwa_sampe

### Tool Description
Generate alignments in the SAM format given paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   bwa sampe [options] <prefix> <in1.sai> <in2.sai> <in1.fq> <in2.fq>

Options: -a INT   maximum insert size [500]
         -o INT   maximum occurrences for one end [100000]
         -n INT   maximum hits to output for paired reads [3]
         -N INT   maximum hits to output for discordant pairs [10]
         -c FLOAT prior of chimeric rate (lower bound) [1.0e-05]
         -f FILE  sam file to output results to [stdout]
         -r STR   read group header line such as `@RG\tID:foo\tSM:bar' [null]
         -P       preload index into memory (for base-space reads only)
         -s       disable Smith-Waterman for the unmapped mate
         -A       disable insert size estimate (force -s)

Notes: 1. For SOLiD reads, <in1.fq> corresponds R3 reads and <in2.fq> to F3.
       2. For reads shorter than 30bp, applying a smaller -o is recommended to
          to get a sensible speed at the cost of pairing accuracy.
```


## bwa_bwasw

### Tool Description
BWA-SW alignment algorithm for long reads, supporting Smith-Waterman alignment and chimeric read detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:   bwa bwasw [options] <target.prefix> <query.fa> [query2.fa]

Options: -a INT   score for a match [1]
         -b INT   mismatch penalty [3]
         -q INT   gap open penalty [5]
         -r INT   gap extension penalty [2]
         -w INT   band width [50]
         -m FLOAT mask level [0.50]

         -t INT   number of threads [1]
         -f FILE  file to output results to instead of stdout
         -H       in SAM output, use hard clipping instead of soft clipping
         -C       copy FASTA/Q comment to SAM output
         -M       mark multi-part alignments as secondary
         -S       skip Smith-Waterman read pairing
         -I INT   ignore pairs with insert >=INT for inferring the size distr [20000]

         -T INT   score threshold divided by a [30]
         -c FLOAT coefficient of length-threshold adjustment [5.5]
         -z INT   Z-best [1]
         -s INT   maximum seeding interval size [3]
         -N INT   # seeds to trigger rev aln; 2*INT is also the chaining threshold [5]
         -G INT   maximum gap size during chaining [10000]

Note: For long Illumina, 454 and Sanger reads, assembly contigs, fosmids and
      BACs, the default setting usually works well. For the current PacBio
      reads (end of 2010), '-b5 -q2 -r1 -z10' is recommended. One may also
      increase '-z' for better sensitivity.
```


## bwa_shm

### Tool Description
Manage BWA indices in shared memory

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bwa shm [-d|-l] [-f tmpFile] [idxbase]

Options: -d       destroy all indices in shared memory
         -l       list names of indices in shared memory
         -f FILE  temporary file to reduce peak memory
```


## bwa_fa2pac

### Tool Description
Convert FASTA format to PAC format for BWA indexing

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwa fa2pac [-f] <in.fasta> [<out.prefix>]
```


## bwa_pac2bwt

### Tool Description
Generate BWT from a PAC file

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwa pac2bwt [-d] <in.pac> <out.bwt>
```


## bwa_pac2bwtgen

### Tool Description
Generate a BWT from a PAC file

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwtgen <in.pac> <out.bwt>
```


## bwa_bwtupdate

### Tool Description
Update the BWT (Burrows-Wheeler Transform) file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwa bwtupdate <the.bwt>
```


## bwa_bwt2sa

### Tool Description
Generate suffix array from BWT

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwa bwt2sa [-i 32] <in.bwt> <out.sa>
```


## Metadata
- **Skill**: generated
