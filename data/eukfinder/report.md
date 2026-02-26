# eukfinder CWL Generation Report

## eukfinder_short_seqs

### Tool Description
optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  Description

### Metadata
- **Docker Image**: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
- **Homepage**: https://github.com/RogerLab/Eukfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/eukfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eukfinder/overview
- **Total Downloads**: 905
- **Last updated**: 2025-04-26
- **GitHub**: https://github.com/RogerLab/Eukfinder
- **Stars**: N/A
### Original Help Text
```text
usage: eukfinder short_seqs [-h] --r1 R1 --r2 R2 --un UN -o OUT_NAME
                            [-n NUMBER_OF_THREADS] [-z NUMBER_OF_CHUNKS]
                            [-t TAXONOMY_UPDATE] [-p PLAST_DATABASE]
                            [-m PLAST_ID_MAP] [--cdb CDB] [-e E_VALUE]
                            [--pid PID] [--cov COV] [--max_m MAX_M] [-k KMERS]
                            [--mhlen MHLEN] [--pclass PCLASS]
                            [--uclass UCLASS]

optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  Description

  --r1 R1, --reads-r1 R1
                        left reads
  --r2 R2, --reads-r2 R2
                        right reads
  --un UN, --un-pair-reads UN
                        orphan reads
  -o OUT_NAME, --out_name OUT_NAME
                        output file basename
  -n NUMBER_OF_THREADS, --number-of-threads NUMBER_OF_THREADS
                        Number of threads
  -z NUMBER_OF_CHUNKS, --number-of-chunks NUMBER_OF_CHUNKS
                        Number of chunks to split a file
  -t TAXONOMY_UPDATE, --taxonomy-update TAXONOMY_UPDATE
                        Set to True the first time the program is used.
                        Otherwise set to False
  -p PLAST_DATABASE, --plast-database PLAST_DATABASE
                        path to plast database
  -m PLAST_ID_MAP, --plast-id-map PLAST_ID_MAP
                        path to taxonomy map for plast database
  --cdb CDB, --centrifuge-database CDB
                        path to centrifuge database
  -e E_VALUE, --e-value E_VALUE
                        threshold for plast searches
  --pid PID, --percent_id PID
                        percentage identity for plast searches
  --cov COV, --coverage COV
                        percentage coverage for plast searches
  --max_m MAX_M, --max_memory MAX_M
                        Maximum memory allocated to carry out an assembly
  -k KMERS, --kmers KMERS
                        kmers to use during assembly. These must be odd and
                        less than 128. default is 21,33,55
  --mhlen MHLEN, --min-hit-length MHLEN
                        Minimum hit length by Centrifuge searches
  --pclass PCLASS, --p-reads-class PCLASS
                        Classification for pair end reads
  --uclass UCLASS, --u-reads-class UCLASS
                        Classification for un-pair end reads
```


## eukfinder_read_prep

### Tool Description
Description

### Metadata
- **Docker Image**: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
- **Homepage**: https://github.com/RogerLab/Eukfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/eukfinder/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eukfinder read_prep [-h] --r1 R1 --r2 R2 -n THREADS -i ILLUMINA_CLIP
                           --hcrop HCROP -l LEADING_TRIM -t TRAIL_TRIM --wsize
                           WSIZE --qscore QSCORE --mlen MLEN --mhlen MHLEN
                           --hg HG -o OUT_NAME [--cdb CDB] [--qenc QENC]

optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  Description

  --r1 R1, --reads-r1 R1
                        left reads
  --r2 R2, --reads-r2 R2
                        right reads
  -n THREADS, --threads THREADS
                        number of threads
  -i ILLUMINA_CLIP, --illumina-clip ILLUMINA_CLIP
                        adaptor file
  --hcrop HCROP, --head-crop HCROP
                        head trim
  -l LEADING_TRIM, --leading-trim LEADING_TRIM
                        leading trim
  -t TRAIL_TRIM, --trail-trim TRAIL_TRIM
                        trail trim
  --wsize WSIZE, --window-size WSIZE
                        sliding window size
  --qscore QSCORE, --quality-score QSCORE
                        quality score for trimming
  --mlen MLEN, --min-length MLEN
                        minimum length of read after trimming to be kept by
                        trimmomatic
  --mhlen MHLEN, --min-hit-length MHLEN
                        minimum hit length
  --hg HG, --host-genome HG
                        host genome to get map out
  -o OUT_NAME, --out_name OUT_NAME
                        output file basename
  --cdb CDB, --centrifuge-database CDB
                        path to centrifuge database
  --qenc QENC, --quality-encoding QENC
                        quality encoding for trimmomatic
```


## eukfinder_long_seqs

### Tool Description
Finds long sequences in a given file and searches them against a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
- **Homepage**: https://github.com/RogerLab/Eukfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/eukfinder/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eukfinder long_seqs [-h] -l LONG_SEQS -o OUT_NAME --mhlen MHLEN
                           [--cdb CDB] [-n NUMBER_OF_THREADS]
                           [-z NUMBER_OF_CHUNKS] [-t TAXONOMY_UPDATE]
                           [-p PLAST_DATABASE] [-m PLAST_ID_MAP] [-e E_VALUE]
                           [--pid PID] [--cov COV]

optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  Description

  -l LONG_SEQS, --long-seqs LONG_SEQS
                        long sequences file
  -o OUT_NAME, --out_name OUT_NAME
                        output file basename
  --mhlen MHLEN, --min-hit-length MHLEN
                        minimum hit length
  --cdb CDB, --centrifuge-database CDB
                        path to centrifuge database
  -n NUMBER_OF_THREADS, --number-of-threads NUMBER_OF_THREADS
                        Number of threads
  -z NUMBER_OF_CHUNKS, --number-of-chunks NUMBER_OF_CHUNKS
                        Number of chunks to split a file
  -t TAXONOMY_UPDATE, --taxonomy-update TAXONOMY_UPDATE
                        Set to True the first time the program is used.
                        Otherwise set to False
  -p PLAST_DATABASE, --plast-database PLAST_DATABASE
                        path to plast database
  -m PLAST_ID_MAP, --plast-id-map PLAST_ID_MAP
                        path to taxonomy map for plast database
  -e E_VALUE, --e-value E_VALUE
                        threshold for plast searches
  --pid PID, --percent_id PID
                        percentage identity for plast searches
  --cov COV, --coverage COV
                        percentage coverage for plast searches
```


## eukfinder_read_prep_env

### Tool Description
Prepare environment for eukfinder

### Metadata
- **Docker Image**: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
- **Homepage**: https://github.com/RogerLab/Eukfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/eukfinder/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eukfinder read_prep_env [-h] --r1 R1 --r2 R2 -n THREADS -i
                               ILLUMINA_CLIP --hcrop HCROP -l LEADING_TRIM -t
                               TRAIL_TRIM --wsize WSIZE --qscore QSCORE --mlen
                               MLEN --mhlen MHLEN -o OUT_NAME --cdb CDB
                               [--qenc QENC]

optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  Description

  --r1 R1, --reads-r1 R1
                        left reads
  --r2 R2, --reads-r2 R2
                        right reads
  -n THREADS, --threads THREADS
                        number of threads
  -i ILLUMINA_CLIP, --illumina-clip ILLUMINA_CLIP
                        adaptor file
  --hcrop HCROP, --head-crop HCROP
                        head trim
  -l LEADING_TRIM, --leading-trim LEADING_TRIM
                        leading trim
  -t TRAIL_TRIM, --trail-trim TRAIL_TRIM
                        trail trim
  --wsize WSIZE, --window-size WSIZE
                        sliding window size
  --qscore QSCORE, --quality-score QSCORE
                        quality score for trimming
  --mlen MLEN, --min-length MLEN
                        minimum length of read after trimming to be kept by
                        trimmomatic
  --mhlen MHLEN, --min-hit-length MHLEN
                        minimum hit length
  -o OUT_NAME, --out_name OUT_NAME
                        output file basename
  --cdb CDB, --centrifuge-database CDB
                        path to centrifuge database
  --qenc QENC, --quality-encoding QENC
                        quality encoding for trimmomatic
```


## eukfinder_download_db

### Tool Description
Download EukFinder databases

### Metadata
- **Docker Image**: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
- **Homepage**: https://github.com/RogerLab/Eukfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/eukfinder/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eukfinder download_db [-h] [-n NAME] [-p PATH]

optional arguments:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  directory name for storing the databases
  -p PATH, --path PATH  filesystem path for storing the databases
```


## Metadata
- **Skill**: generated
