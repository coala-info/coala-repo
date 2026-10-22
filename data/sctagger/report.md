# sctagger CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sctagger_extract_lr_bc | PASS |  |
| sctagger_extract_sr_bc | PASS |  |
| sctagger_extract_sr_bc_from_lr | PASS |  |
| sctagger_match_trie | PASS |  |

## sctagger_extract_lr_bc

### Tool Description
Extract from long reads the segment where a cellular barcode is most likely to be found (after the short-read adapter)

### Metadata
- **Docker Image**: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/sctagger
- **Package**: https://anaconda.org/channels/bioconda/packages/sctagger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scTagger.py extract_lr_bc [-h] -r READS [READS ...]
                                 [-g RANGES [RANGES ...]] [-z] [-t THREADS]
                                 [-sa SHORT_READ_ADAPTER] [-o OUTFILE]
                                 [-p PLOTFILE] [--num-bp-after NUM_BP_AFTER]

options:
  -h, --help            show this help message and exit
  -r READS [READS ...], --reads READS [READS ...]
                        Space separated paths to reads in FASTQ
  -g RANGES [RANGES ...], --ranges RANGES [RANGES ...]
                        Space separated of the ranges of where SR adapter
                        should be found on the LR's. Intervals should have
                        start with "f" or "r" to indicated which side of the
                        read the interval is suppused to be. E.g. f20:40 r1:30
                        means SR adapter needs to be either on the range
                        20-40bp (20 and 40 both included) and on the forward
                        strand OR the last 30bp from the end of the read and
                        on the reverse strand. If adapters are found on
                        multiple ranges on the read, then all of them are
                        considered invalid. Ranges are 1-indexed and
                        inclusive. Default: Detect from data.
  -z, --gzipped         Indicate input is gzipped. Default: Assume input is
                        gzipped if it ends with ".gz".
  -t THREADS, --threads THREADS
                        Number of threads. Default: 1
  -sa SHORT_READ_ADAPTER, --short-read-adapter SHORT_READ_ADAPTER
                        Short-read adapter. Default: CTACACGACGCTCTTCCGATCT
  -o OUTFILE, --outfile OUTFILE
                        Path to output file. Output file is gzipped. STDOUT is
                        in normal text. Default: stdout
  -p PLOTFILE, --plotfile PLOTFILE
                        Path to plot file. Default: no plotting
  --num-bp-after NUM_BP_AFTER
                        Number of bases after the end of the SR adapter
                        alignment to generate. Default: 20
```

## sctagger_extract_sr_bc

### Tool Description
Extract the top short-read cellular barcodes that cover most of the reads from a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/sctagger
- **Package**: https://anaconda.org/channels/bioconda/packages/sctagger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scTagger.py extract_sr_bc [-h] -i INPUT [-o OUTFILE] [-p PLOTFILE]
                                 [-t THREADS] [--thresh THRESH]
                                 [--step-size STEP_SIZE]
                                 [--max-barcode-cnt MAX_BARCODE_CNT]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input BAM file
  -o OUTFILE, --outfile OUTFILE
                        Path to output file. Default: STDOUT
  -p PLOTFILE, --plotfile PLOTFILE
                        Path to plot file
  -t THREADS, --threads THREADS
                        Number of threads. Default: 1
  --thresh THRESH       Percentage theshold required per step to continue
                        adding read barcodes. Default: 0.005
  --step-size STEP_SIZE
                        Number of barcodes processed at a time and whose sum
                        is used to check against the theshold. Default: 1000
  --max-barcode-cnt MAX_BARCODE_CNT
                        Max number of barcodes to keep. Default: 25000
```

## sctagger_extract_sr_bc_from_lr

### Tool Description
Build a list of cellular barcodes directly from the long-read segments by exact matches to a 10x barcode whitelist

### Metadata
- **Docker Image**: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/sctagger
- **Package**: https://anaconda.org/channels/bioconda/packages/sctagger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scTagger.py extract_sr_bc_from_lr [-h] -i INPUT [-o OUTFILE] -wl
                                         BARCODE_WHITELIST [--thresh THRESH]
                                         [--step-size STEP_SIZE]
                                         [--max-barcode-cnt MAX_BARCODE_CNT]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input TSV file generated from extract_lr_bc step
  -o OUTFILE, --outfile OUTFILE
                        Path to output file. Default: STDOUT
  -wl BARCODE_WHITELIST, --barcode-whitelist BARCODE_WHITELIST
                        Path to TXT barcode whiltelist such as 10x Chromimum
                        v3 3M-february-2018.txt.gz barcode file
  --thresh THRESH       Percentage theshold required per step to continue
                        adding read barcodes. Default: 0.005
  --step-size STEP_SIZE
                        Number of barcodes processed at a time and whose sum
                        is used to check against the theshold. Default: 1000
  --max-barcode-cnt MAX_BARCODE_CNT
                        Max number of barcodes to keep. Default: 25000
```

## sctagger_match_trie

### Tool Description
Match long-read barcode segments with the selected short-read barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/sctagger
- **Package**: https://anaconda.org/channels/bioconda/packages/sctagger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scTagger.py match_trie [-h] -lr LONG_READ_SEGMENTS -sr
                              SHORT_READ_BARCODES [-mr MAX_ERROR] [-m MEM]
                              [-bl BARCODE_LENGTH] [-t THREADS] [-p PLOTFILE]
                              [-o OUTFILE]

options:
  -h, --help            show this help message and exit
  -lr LONG_READ_SEGMENTS, --long-read-segments LONG_READ_SEGMENTS
                        Long-read segments TSV file
  -sr SHORT_READ_BARCODES, --short-read-barcodes SHORT_READ_BARCODES
                        Short-read barcode list TSV file
  -mr MAX_ERROR, --max-error MAX_ERROR
                        Maximum number of errors allowed for barcode matching.
                        Default: 2
  -m MEM, --mem MEM     Maximum number of GB of RAM to be used. Default: 16.0
  -bl BARCODE_LENGTH, --barcode-length BARCODE_LENGTH
                        Length of barcodes. Default: 16
  -t THREADS, --threads THREADS
                        Number of threads to use for searching. Default: 16
  -p PLOTFILE, --plotfile PLOTFILE
                        Path of plot file. Default: no plotting
  -o OUTFILE, --outfile OUTFILE
                        Path to output file. Output file is gzipped. STDOUT is
                        in normal text. Default: stdout
```

