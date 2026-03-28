# kegalign-full CWL Generation Report

## kegalign-full_faToTwoBit

### Tool Description
Convert DNA from fasta to 2bit format

### Metadata
- **Docker Image**: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
- **Homepage**: https://github.com/galaxyproject/KegAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/kegalign-full/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kegalign-full/overview
- **Total Downloads**: 905
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/galaxyproject/KegAlign
- **Stars**: N/A
### Original Help Text
```text
faToTwoBit - Convert DNA from fasta to 2bit format
usage:
   faToTwoBit in.fa [in2.fa in3.fa ...] out.2bit
options:
   -long            use 64-bit offsets for index.   Allow for twoBit to contain more than 4Gb of sequence. 
                    NOT COMPATIBLE WITH OLDER CODE.
   -noMask          Ignore lower-case masking in fa file.
   -stripVersion    Strip off version number after '.' for GenBank accessions.
   -ignoreDups      Convert first sequence only if there are duplicate sequence
                    names.  Use 'twoBitDup' to find duplicate sequences.
   -namePrefix=XX.  add XX. to start of sequence name in 2bit.
```


## kegalign-full_runner.py

### Tool Description
Runner script for kegalign-full

### Metadata
- **Docker Image**: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
- **Homepage**: https://github.com/galaxyproject/KegAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/kegalign-full/overview
- **Validation**: PASS

### Original Help Text
```text
usage: runner.py [-h] [--output-type [{commands,output,tarball}]]
                 --output-file OUTPUT_FILE [--diagonal-partition] [--nogapped]
                 [--markend] [--num-gpu NUM_GPU] [--num-cpu NUM_CPU] [--debug]
                 --tool_directory TOOL_DIRECTORY

options:
  -h, --help            show this help message and exit
  --output-type [{commands,output,tarball}]
                        output type (default: commands)
  --output-file OUTPUT_FILE
                        output pathname
  --diagonal-partition  run diagonal partition optimization
  --nogapped            don't perform gapped extension stage
  --markend             write a marker line just before completion
  --num-gpu NUM_GPU     number of GPUs to use (default: -1 [use all GPUs])
  --num-cpu NUM_CPU     number of CPUs to use (default: -1 [use all CPUs])
  --debug               print debug messages
  --tool_directory TOOL_DIRECTORY
                        tool directory
```


## kegalign-full_kegalign

### Tool Description
You must specify a target file and a query file

### Metadata
- **Docker Image**: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
- **Homepage**: https://github.com/galaxyproject/KegAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/kegalign-full/overview
- **Validation**: PASS

### Original Help Text
```text
You must specify a target file and a query file

Usage: run_kegalign target query [options]
Version: v0.1.2.8

Sequence Options:
  --strand arg (=both)  strand to search - plus/minus/both

Scoring Options:
  --scoring arg         Scoring file in LASTZ format
  --ambiguous arg       ambiguous nucleotides - n/iupac

Seeding Options:
  --seed arg (=12of19)  seed pattern-12of19(1110100110010101111)/14of22(1110101
                        100110010101111)/an arbitrary pattern of 1s, 0s, and Ts
                         
  --step arg (=1)       Offset between the starting positions of successive 
                        target words considered for generating seed table
  --notransition        don't allow one transition in a seed hit

Ungapped Extension Options:
  --xdrop arg (=910)      x-drop value for gap-free extension
  --hspthresh arg (=3000) segment score threshold for high scoring pairs
  --noentropy             don't adjust low score segment pair scores using 
                          entropy factor after filtering stage

Gapped Extension Options:
  --nogapped            don't perform gapped extension stage
  --ydrop arg (=9430)   y-drop value for gapped extension
  --gappedthresh arg    score threshold for gapped alignments
  --notrivial           Don't output a trivial self-alignment block if the 
                        target and query sequences are identical

Output Options:
  --format arg (=maf-)  format of output file (same formats as provided by 
                        LASTZ) - lav, lav+text, axt, axt+, maf, maf+, maf-, 
                        sam, softsam, sam-, softsam-, cigar, BLASTN, 
                        differences, rdotplot, text
  --output arg          output filename
  --target_prefix arg   prefix the target sequence names with argument string
  --query_prefix arg    prefix the query sequence names with argument string
  --markend             write a marker line just before completion

System Options:
  --wga_chunk_size arg (=250000)        chunk sizes for GPU calls for Xdrop - 
                                        change only if you are a developer
  --lastz_interval_size arg (=10000000) LASTZ interval for ydrop - change only 
                                        if you are a developer
  --seq_block_size arg (=500000000)     LASTZ interval for ydrop - change only 
                                        if you are a developer
  --num_gpu arg (=-1)                   Specify number of GPUs to use - -1 if 
                                        all the GPUs should be used
  --num_threads arg (=-1)               Specify number of CPU threads to use - 
                                        -1 if all the CPU threads should be 
                                        used
  --debug                               print debug messages
  --version                             print version
  --help                                Print help messages
```


## kegalign-full_diagonal_partition.py

### Tool Description
Partitions a large alignment file into smaller chunks based on diagonal blocks.

### Metadata
- **Docker Image**: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
- **Homepage**: https://github.com/galaxyproject/KegAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/kegalign-full/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/diagonal_partition.py", line 42, in <module>
    chunk_size = int(sys.argv[1])
                 ^^^^^^^^^^^^^^^^
ValueError: invalid literal for int() with base 10: '--help'
```


## Metadata
- **Skill**: generated
