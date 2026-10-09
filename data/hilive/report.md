# hilive CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hilive | PASS | synthetic data: BCL files written from 55 real SARS-CoV-2 Illumina reads; 51 reads aligned, positions match the BWA alignment (reads below 3 threads hang the tool) |
| hilive_hilive-build | PASS |  |

## hilive

### Tool Description
Realtime Alignment of Illumina Reads

### Metadata
- **Docker Image**: biocontainers/hilive:v1.1-2-deb_cv1
- **Homepage**: https://github.com/wtv-filipa/AppHiLives
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hilive/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/wtv-filipa/AppHiLives
- **Stars**: N/A
### Original Help Text
```text
------
HiLive v1.1 - Realtime Alignment of Illumina Reads
------

Copyright (c) 2015-2017, Martin S. Lindner and the HiLive contributors. See CONTRIBUTORS for more info.
All rights reserved

HiLive is open-source software. Check with --license for details.

Usage: 
  hilive BC_DIR INDEX CYCLES OUTDIR [options]

Required:
  BC_DIR                Illumina BaseCalls directory of the sequencing run to analyze
  INDEX                 Path to k-mer index file (*.kix)
  CYCLES                Total number of sequencing cycles
  OUTDIR                Output directory

General:
  -h [ --help ]                 Print this help message and exit
  --license                     Print licensing information and exit
  -s [ --settings ] arg         Load settings from file. If command line 
                                arguments are given additionally, they are 
                                prefered.
  --runinfo arg                 Path to runInfo.xml for parsing read and index 
                                lengths [Default (if activated): 
                                BC_DIR/../../RunInfo.xml]
  --continue arg                Continue an interrupted HiLive run from a 
                                specified cycle. We strongly recommend to load 
                                the settings from the previous run using the -s
                                option.

IO settings:
  --temp arg                    Temporary directory for the alignment files 
                                [Default: ./temp]
  -B [ --bam ]                  Create BAM files instead of SAM files [Default:
                                false]
  -O [ --output-cycles ] arg    Cycles for alignment output. The respective 
                                temporary files are kept. [Default: last cycle]
  --extended-cigar              Activate extended CIGAR format (= and X instead
                                of only M) in output files [Default: false]
  -k [ --keep-files ] arg       Keep intermediate alignment files for these 
                                cycles. The last cycle is always kept. 
                                [Default: None]
  -K [ --keep-all-files ]       Keep all intermediate alignment files [Default:
                                false]
  --min-as-ratio arg            Minimum alignment score (relative to the 
                                current read length) for alignments to be 
                                reported (0-1) [Default: 0 - Report all 
                                alignments]
  --force-resort                If set, the align files are always sorted 
                                before output. Existing sorted align files are 
                                overwritten [Default: false]
  -l [ --lanes ] arg            Select lane [Default: all lanes]
  -t [ --tiles ] arg            Select tile numbers [Default: all tiles]
  -r [ --reads ] arg            Enumerate read lengths and type. Example: -r 
                                101R 8B 8B 101R equals paired-end sequencing 
                                with 2x101bp reads and 2x8bp barcodes. 
                                Overwrites information of runInfo.xml. 
                                [Default: single end reads without barcodes]

Alignment settings:
  -e [ --min-errors ] arg       Number of errors tolerated in read alignment 
                                [Default: 2]
  -m [ --mode ] arg             Alignment mode. [ALL|A]: Report all alignments;
                                [BESTN#|N#]: Report alignments of the best # 
                                scores; [ALLBEST|H]: Report all alignments with
                                the best score (similar to N1); [UNIQUE|U]: 
                                Report only unique alignments; [ANYBEST|B]: 
                                Report one best alignment (default)
  --disable-ohw-filter          Disable the One-Hit Wonder filter [Default: 
                                false]
  --start-ohw arg               First cycle to apply One-Hit Wonder filter 
                                [Default: 20]
  -w [ --window ] arg           Set the window size to search for alignment 
                                extension, i.e. maximum total 
                                insertion/deletion size [Default: 5]
  --min-quality arg             Minimum allowed basecall quality [Default: 1]
  -b [ --barcodes ] arg         Enumerate barcodes (must have same length) for 
                                demultiplexing, e.g. -b AGGATC -b CCCTTT 
                                [Default: no demultiplexing]
  -E [ --barcode-errors ] arg   Enumerate the number of tolerated errors (only 
                                SNPs) for each barcode fragment, e.g. -E 2 2 
                                [Default: 1 per fragment]
  --keep-all-barcodes           Align and output all barcodes [Default: false]

Technical settings:
  --block-size arg              Block size for the alignment input/output 
                                stream in Bytes. Append 'K' or 'M' to specify 
                                in Kilobytes or Megabytes, respectively (e.g. 
                                '--block-size 64M' for 64 Megabytes)
  -c [ --compression ] arg      Compress alignment files. 0: no compression 1: 
                                Deflate (smaller) 2: LZ4 (faster; default)
  -n [ --num-threads ] arg      Number of threads to spawn [Default: all 
                                available]
  -N [ --num-out-threads ] arg  Maximum number of threads to use for output if 
                                threads are not idle [Default: half of -n]
```


## hilive_hilive-build

### Tool Description
Build the k-mer index (*.kix) of reference genomes for HiLive.

### Metadata
- **Docker Image**: biocontainers/hilive:v1.1-2-deb_cv1
- **Homepage**: https://gitlab.com/SimonHTausch/HiLive
- **Package**: https://anaconda.org/channels/bioconda/packages/hilive/overview
- **Validation**: PASS

### Original Help Text
```text

------
HiLive Index Builder v1.1 - Build Index for Realtime Alignment of Illumina Reads
------

Copyright (c) 2015-2017, Martin S. Lindner and the HiLive contributors. See CONTRIBUTORS for more info.
All rights reserved

HiLive is open-source software. Check with --license for details.

Usage: 
  hilive-build INPUT KMER_WEIGHT [options]

Required:
  INPUT                 Reference genomes in (multi-) FASTA format.
  KMER_WEIGHT           Number of non-gap positions in a k-mer (For ungapped k-mers this is the k-mer size).

General:
  -h [ --help ]               Print this help message and exit
  --license                   Print licensing information and exit

Options:
  -o [ --outfile ] arg        Set output file name [Default: INPUT.kix]
  -t [ --trim ] arg (=0)      Ignore k-mers with more than t occurrences. 
                              [Default: no limit]
  -p [ --gap-positions ] arg  Gap positions in the k-mer pattern (example: -p 3
                              6 7 for 1101100111 with k=7). [Default: ungapped]
  --do-not-convert-spaces     Do not convert all spaces in reference ids to 
                              underscores [Default: converting is on]
  --trim-after-space          Trim all reference ids after first space 
                              [Default: false]
```

## Metadata
- **Skill**: not generated
