# pipits CWL Generation Report

## pipits_pipits_createreadpairslist

### Tool Description
Creates a read pairs list file for PIPITS from a directory of FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
- **Homepage**: https://github.com/hsgweon/pipits
- **Package**: https://anaconda.org/channels/bioconda/packages/pipits/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pipits/overview
- **Total Downloads**: 49.2K
- **Last updated**: 2025-05-02
- **GitHub**: https://github.com/hsgweon/pipits
- **Stars**: N/A
### Original Help Text
```text
usage: pipits_createreadpairslist [-h] -i <DIR> [-o <FILE>]
                                  [--label-prefix <TXT>]
                                  [--label-suffix <TXT>] [--relabel <TXT>]
                                  [--extra-extensions <EXT> [<EXT> ...]]
                                  [--ignore-missing-pairs] [-v] [--version]

Creates a read pairs list file for PIPITS from a directory of FASTQ files.

options:
  -h, --help            show this help message and exit
  -i, --inputdir <DIR>  [REQUIRED] Directory containing raw paired-end
                        sequence files (FASTQ format, can be .gz or .bz2
                        compressed). Files should be named like
                        'SampleID_...R1...' and 'SampleID_...R2...'.
  -o, --output <FILE>   Name of the output list file [default:
                        readpairslist.txt]
  --label-prefix <TXT>  Add a specified prefix string to the beginning of each
                        SampleID in the output file. Forbidden characters:
                        '_', ' '.
  --label-suffix <TXT>  Add a specified suffix string to the end of each
                        SampleID in the output file. Forbidden characters:
                        '_', ' '.
  --relabel <TXT>       Rename all samples using the given text as a base,
                        automatically appending sequential numbers (e.g.,
                        'prefix001', 'prefix002'). Forbidden characters: '_',
                        ' '.
  --extra-extensions <EXT> [<EXT> ...]
                        Additional file extensions to recognize as FASTQ
                        (e.g., .fq .FQ.GZ). Case-insensitive. Include the dot
                        if desired.
  --ignore-missing-pairs
                        Ignore prefixes with missing pairs (singletons or >2
                        files) and create the list file using only complete
                        pairs.
  -v, --verbose         Verbose mode (log debug messages).
  --version             show program's version number and exit
```


## pipits_pipits_prep

### Tool Description
Reindex, join (VSEARCH), quality filter, convert and merge Illumina FASTQ data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
- **Homepage**: https://github.com/hsgweon/pipits
- **Package**: https://anaconda.org/channels/bioconda/packages/pipits/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pipits_prep [-h] -i <DIR> [-o <DIR>] -l <FILE> [--FASTX-q <INT>]
                   [--FASTX-p <INT>] [--keep-Ns] [-b <INT>] [-r] [-v]
                   [-t <INT>] [--version]

pipits_prep: Reindex, join (VSEARCH), quality filter, convert and merge
Illumina FASTQ data.

options:
  -h, --help           show this help message and exit
  -i <DIR>             [REQUIRED] Directory containing raw sequence files
                       (FASTQ format, can be .gz or .bz2 compressed).
  -o <DIR>             Directory to output results [default:
                       pipits_prep_output]
  -l <FILE>            [REQUIRED] Tab-separated file with three columns:
                       SampleID, ForwardReadFilename, ReverseReadFilename.
                       Only files listed here will be processed.
  --FASTX-q <INT>      FASTX quality filter: Minimum quality score to keep
                       [default: 30]
  --FASTX-p <INT>      FASTX quality filter: Minimum percent of bases that
                       must have '--FASTX-q' quality [default: 80]
  --keep-Ns            Keep sequences containing 'N' nucleotides during FASTQ
                       to FASTA conversion [default: False, sequences with N
                       are removed by FASTX tools]
  -b <INT>             Base PHRED quality score encoding of input FASTQ files
                       (e.g., 33 or 64) [default: 33]
  -r, --retain         Retain intermediate files in the 'tmp' subdirectory.
  -v, --verbose        Verbose mode (log debug messages to console and file).
  -t, --threads <INT>  Number of threads for VSEARCH joining [default: 1]
  --version            show program's version number and exit
```


## pipits_pipits_funits

### Tool Description
PIPITS_FUNITS v4.0: Extract ITS1 or ITS2 regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
- **Homepage**: https://github.com/hsgweon/pipits
- **Package**: https://anaconda.org/channels/bioconda/packages/pipits/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pipits_funits [-h] -i <FILE> -o <DIR> -x {ITS1,ITS2} [-t <INT>]
                     [--itsx-threads <INT>] [-r] [-v] [--version]

PIPITS_FUNITS v4.0: Extract ITS1 or ITS2 regions.

options:
  -h, --help            show this help message and exit
  -i <FILE>             [REQUIRED] Input FASTA file (e.g., from pipits_prep).
  -o <DIR>              [REQUIRED] Directory to output results.
  -x {ITS1,ITS2}        [REQUIRED] Subregion (ITS1 or ITS2).
  -t <INT>              Number of parallel ITSx *processes* to run [default:
                        1].
  --itsx-threads <INT>  Number of threads *per* ITSx process [default: 1].
                        Total threads used = -t * --itsx-threads.
  -r                    Retain intermediate files.
  -v                    Verbose mode (more detailed logging).
  --version             show program's version number and exit
```


## pipits_pipits_process

### Tool Description
Sequences to OTU Table

### Metadata
- **Docker Image**: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
- **Homepage**: https://github.com/hsgweon/pipits
- **Package**: https://anaconda.org/channels/bioconda/packages/pipits/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PIPITS_PROCESS: Sequences to OTU Table [-h] -i <FILE> [-o <DIR>]
                                              [-d <FLOAT>] [-c <FLOAT>]
                                              [--sintaxconfidence <FLOAT>]
                                              [-l <TXT>] [--includeuniqueseqs]
                                              [-r] [-v] [-t <INT>] [--Xms XMS]
                                              [--Xmx XMX]
                                              [--taxassignmentmethod {all,rdp,sin}]
                                              [--unite {19.02.2025,04.04.2024,25.07.2023,27.10.2022,10.05.2021,04.02.2020,02.02.2019,01.12.2017,28.06.2017}]
                                              [--ignore-db-download]

options:
  -h, --help            show this help message and exit
  -i <FILE>             [REQUIRED] ITS sequences in FASTA. Typically output
                        from pipits_funits
  -o <DIR>              [REQUIRED] Directory to output results.
  -d <FLOAT>            VSEARCH - Identity threshold [default: 0.97]
  -c <FLOAT>            RDP assignment confidence threshold - RDP Classifier
                        confidence threshold for output [default: 0.85]
  --sintaxconfidence <FLOAT>
                        VSEARCH SINTAX assignment confidence threshold
                        [default: 0.85]
  -l <TXT>              Sample list file. One sample ID per line. If not
                        provided, it will be generated automatically from
                        FASTA headers (part before first '_').
  --includeuniqueseqs   PIPITS by default removes unique sequences before
                        clustering. If you want singletons, choose this
                        option.
  -r                    Retain intermediate files (Beware intermediate files
                        use excessive disk space!)
  -v                    Verbose mode (more detailed logging).
  -t <INT>              Number of Threads [default: 1]
  --Xms XMS             The minimum size, in bytes, of the memory allocation
                        pool for JVM
  --Xmx XMX             The maximum size, in bytes, of the memory allocation
                        pool for JVM
  --taxassignmentmethod {all,rdp,sin}
                        Choice of taxonomic assignment. By default, PIPITS
                        will run SINTAX (VSEARCH). Selecting 'all' runs both
                        RDP and SINTAX. Databases downloaded automatically
                        unless --ignore-db-download is specified.
  --unite {19.02.2025,04.04.2024,25.07.2023,27.10.2022,10.05.2021,04.02.2020,02.02.2019,01.12.2017,28.06.2017}
                        UNITE db version to be used - PIPITS will download db
                        automaticlly unless --ignore-db-download is specified.
                        Leaving this option out will default to the most
                        recent version of UNITE available to PIPITS.
  --ignore-db-download  Ignore automatic download of database files. Assumes
                        databases are already present in 'pipits_db/'.
```

