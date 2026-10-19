# rambo-k CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rambo-k | PASS | real reads of two species separate by score (SARS-CoV-2 mean -1.9, B. fragilis mean +0.1) |

## rambo-k

### Tool Description
usage: RAMBOK.py [-h] -r REFFILE1 -R REFFILE2 [-n NAME1] [-N NAME2] -1

### Metadata
- **Docker Image**: quay.io/biocontainers/rambo-k:1.21--py36_0
- **Homepage**: https://gitlab.com/SimonHTausch/RAMBO-K
- **Package**: https://anaconda.org/channels/bioconda/packages/rambo-k/overview
- **Validation**: PASS

### Original Help Text
```text
usage: RAMBOK.py [-h] -r REFFILE1 -R REFFILE2 [-n NAME1] [-N NAME2] -1
                 UNASSIGNED1 [-2 UNASSIGNED2] [-k KMERSIZES] [-o OUTPATH]
                 [-a AMOUNT] [-t THREADS] [-x CHUNKSIZE] [-g GAPSIZE]
                 [-c CUTOFF_LOWER] [-C CUTOFF_HIGHER] [-d] [-f FILETYPE]

optional arguments:
  -h, --help            show this help message and exit
  -r REFFILE1, --reffile1 REFFILE1
                        Reference file of species 1 in fasta-format. Should
                        pair with name1
  -R REFFILE2, --reffile2 REFFILE2
                        Reference file of species 2 in fasta-format. Should
                        pair with name2
  -n NAME1, --name1 NAME1
                        Name of species 1
  -N NAME2, --name2 NAME2
                        Name of species 2
  -1 UNASSIGNED1, --unassigned1 UNASSIGNED1
                        Fasta- or fastq-file containing mixed reads.
  -2 UNASSIGNED2, --unassigned2 UNASSIGNED2
                        Fasta- or fastq-file containing mixed reads, only
                        required in paired end mode.
  -k KMERSIZES, --kmersizes KMERSIZES
                        Order of Markov-Chain/kmer length. Enter as range
                        (e.g. 4:8) or list (e.g. 4,6,8) or integer (e.g. 8).
                        Default = 8
  -o OUTPATH, --outpath OUTPATH
                        Folder to write results to. Default = $name1_$name2/
                        in your working directory
  -a AMOUNT, --amount AMOUNT
                        Number of reads to be simulated, default = 50000
  -t THREADS, --threads THREADS
                        Number of Threads to use
  -x CHUNKSIZE, --chunksize CHUNKSIZE
                        Size of chunks created at a time for simulation,
                        default = 100000. Only change if you know what you are
                        doing!
  -g GAPSIZE, --gapsize GAPSIZE
                        Estimated size of gapsize in case of paired end reads,
                        default = 1
  -c CUTOFF_LOWER, --cutoff_lower CUTOFF_LOWER
                        Lower cutoff: Output only reads with a score lower
                        than or equal to this value, use m1 for -1
  -C CUTOFF_HIGHER, --cutoff_higher CUTOFF_HIGHER
                        Higher cutoff: Output only reads with a score higher
                        than or equal to this value, use m1 for -1
  -d, --delete_temp     \Delete temporary files. Calculations will start from
                        beginning next time.
  -f FILETYPE, --filetype FILETYPE
                        Type of your input reads. fasta or fastq, default =
                        fastq
```

## Metadata
- **Skill**: not generated
