# bwa-meme CWL Generation Report

## bwa-meme_index

### Tool Description
Build an index for a FASTA file using various BWT construction algorithms, including MEME.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
- **Homepage**: https://github.com/kaist-ina/BWA-MEME
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa-meme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwa-meme/overview
- **Total Downloads**: 16.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kaist-ina/BWA-MEME
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Looking to launch executable "/usr/local/bin/bwa-meme_mode3.avx512bw", simd = _mode3.avx512bw
Launching executable "/usr/local/bin/bwa-meme_mode3.avx512bw"

Usage:   bwa-meme index [options] <in.fasta>

Options: -a STR    BWT construction algorithm: bwtsw, is, rb2, mem2, ert or meme 
         -p STR    prefix of the index [same as fasta name]
         -t INT    number of threads for MEME index building [1]
         -6        index files named as <in.fasta>.64.* instead of <in.fasta>.* 

Warning: `-a bwtsw' does not work for short genomes, while `-a is' and
         `-a div' do not work not for long genomes.

         `-a meme' to build bwa-meme index (SA, ISA).

Total time taken: 0.0015
```


## bwa-meme_mem

### Tool Description
BWA-MEME (bwa-mem2) alignment tool using learned or ERT indexes for seeding.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
- **Homepage**: https://github.com/kaist-ina/BWA-MEME
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa-meme/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Looking to launch executable "/usr/local/bin/bwa-meme_mode3.avx512bw", simd = _mode3.avx512bw
Launching executable "/usr/local/bin/bwa-meme_mode3.avx512bw"
-----------------------------
Executing in AVX512 mode!!
-----------------------------
* SA compression enabled with xfactor: 8
Usage: bwa-meme (bwa-mem2) mem [options] <idxbase> <in1.fq> [in2.fq]
	Use -7 option to deploy bwa-meme
Options:
  Algorithm options:
    -o STR        Output SAM file name
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
    -o            output file name missing
    -P            skip pairing; mate rescue performed unless -S also in use
Scoring options:
   -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
   -B INT        penalty for a mismatch [4]
   -O INT[,INT]  gap open penalties for deletions and insertions [6,6]
   -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]
   -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5]
   -U INT        penalty for an unpaired read pair [17]
Input/output options:
   -p            smart pairing (ignoring in2.fq)
   -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
   -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]
   -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)
   -5            for split alignment, take the alignment with the smallest coordinate as primary
   -q            don't modify mapQ of supplementary alignments
   -K INT        process INT input bases in each batch regardless of nThreads (for reproducibility) []
   -v INT        verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]
   -T INT        minimum score to output [30]
   -h INT[,INT]  if there are <INT hits with score >80% of the max score, output all in XA [5,200]
   -a            output all alignments for SE or unpaired PE
   -C            append FASTA/FASTQ comment to SAM output
   -V            output the reference FASTA header in the XR tag
   -Y            use soft clipping for supplementary alignments
   -M            mark shorter split hits as secondary
   -I FLOAT[,FLOAT[,INT[,INT]]]
                 specify the mean, standard deviation (10% of the mean if absent), max
                 (4 sigma from the mean if absent) and min of the insert size distribution.
                 FR orientation only. [inferred]
   -Z            Use ERT index for seeding
   -7            Use Learned index for seeding (use BWA-MEME)
Note: Please read the man page for detailed description of the command line and options.

Important parameter settings: 
	BATCH_SIZE: 512
	MAX_SEQ_LEN_REF: 256
	MAX_SEQ_LEN_QER: 128
	MAX_SEQ_LEN8: 128
	SEEDS_PER_READ: 500
	SIMD_WIDTH8 X: 64
	SIMD_WIDTH16 X: 32
	AVG_SEEDS_PER_READ: 64
```


## Metadata
- **Skill**: generated

## bwa-meme_build_rmis_dna.sh

### Tool Description
Learned-index training script for BWA-MEME. For human reference, training requires around 15 minutes and 64GB memory.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
- **Homepage**: https://github.com/kaist-ina/BWA-MEME
- **Package**: https://anaconda.org/channels/bioconda/packages/bwa-meme/overview
- **Validation**: PASS
### Original Help Text
```text
[Info] build_rmis_dna script for BWA-MEME 1.0.5v
Usage: build_rmis_dna.sh <reference file>
    ex 1) ./build_rmis_dna.sh ./human.fasta        # default setting
    ex 2) ./build_rmis_dna.sh ./human.fasta 26     # set number of models to use for second layer 2^26
About: Learned-index training script for BWA-MEME. For human reference, training requires around 15 minutes and 64GB memory. You can set number of models to use for Learned-index (as in ex 2).
```

