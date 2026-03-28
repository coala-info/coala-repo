# longreadsum CWL Generation Report

## longreadsum_fa

### Tool Description
Summarize long read data from FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/WGLab/LongReadSum
- **Stars**: N/A
### Original Help Text
```text
2026-02-25 15:53:39,884 [INFO] Log file is log_output.log
2026-02-25 15:53:39,885 [ERROR] No input file(s) are provided. 

usage: longreadsum fa [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                      [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                      [-R READCOUNT [READCOUNT ...]]
                      [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                      [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX] [-s SEED]
                      [-d DETAIL]

For example:
python longreadsum fa -i input.fasta -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## longreadsum_fq

### Tool Description
For example:
python longreadsum fq -i input.fastq -o /output_directory/

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-25 15:54:00,185 [INFO] Log file is log_output.log
2026-02-25 15:54:00,185 [ERROR] No input file(s) are provided. 

usage: longreadsum fq [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                      [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                      [-R READCOUNT [READCOUNT ...]]
                      [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                      [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX] [-s SEED]
                      [-d DETAIL] [-u UDQUAL]

For example:
python longreadsum fq -i input.fastq -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling
  -u UDQUAL, --udqual UDQUAL
                        User defined quality offset for bases in fq. Default: -1.

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## longreadsum_f5

### Tool Description
Summarize long read sequencing data from fast5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-25 15:54:43,312 [INFO] Log file is log_output.log
2026-02-25 15:54:43,312 [ERROR] No input file(s) are provided. 

usage: longreadsum f5 [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                      [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                      [-R READCOUNT [READCOUNT ...]]
                      [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                      [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX] [-s SEED]
                      [-d DETAIL]

For example:
python longreadsum f5 -i input.fast5 -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## longreadsum_f5s

### Tool Description
Parses fast5 files for long read summary statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-25 15:55:41,174 [INFO] Log file is log_output.log
2026-02-25 15:55:41,174 [ERROR] No input file(s) are provided. 

usage: longreadsum f5s [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                       [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                       [-R READCOUNT [READCOUNT ...]]
                       [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                       [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX] [-s SEED]
                       [-d DETAIL] [-r READ_IDS]

For example:
python longreadsum f5s -R 5 10 -i input.fast5 -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling
  -r READ_IDS, --read_ids READ_IDS
                        A comma-separated list of read IDs to extract from the file.

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## longreadsum_seqtxt

### Tool Description
Processes sequencing summary files.

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-25 15:56:02,642 [INFO] Log file is log_output.log
2026-02-25 15:56:02,642 [ERROR] No input file(s) are provided. 

usage: longreadsum seqtxt [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                          [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                          [-R READCOUNT [READCOUNT ...]]
                          [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                          [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX]
                          [-s SEED] [-d DETAIL] [-S SEQ] [-m {1,2,3}]

For example:
python longreadsum seqtxt -i sequencing_summary.txt -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling
  -S SEQ, --seq SEQ     sequencing_summary.txt only? Default: 1(yes).
  -m {1,2,3}, --sum_type {1,2,3}
                        Different fields in sequencing_summary.txt. Default: 1.

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## longreadsum_bam

### Tool Description
Summarize BAM files for long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-25 15:56:36,780 [INFO] Log file is log_output.log
2026-02-25 15:56:36,781 [ERROR] No input file(s) are provided. 

usage: longreadsum bam [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                       [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                       [-R READCOUNT [READCOUNT ...]]
                       [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                       [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX] [-s SEED]
                       [-d DETAIL]

For example:
python longreadsum bam -i input.bam -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## longreadsum_rrms

### Tool Description
Extracts read information based on a CSV file and BAM input.

### Metadata
- **Docker Image**: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
- **Homepage**: https://github.com/WGLab/LongReadSum
- **Package**: https://anaconda.org/channels/bioconda/packages/longreadsum/overview
- **Validation**: PASS

### Original Help Text
```text
usage: longreadsum rrms [-h] [-i INPUT] [-I INPUTS] [-P INPUTPATTERN]
                        [--fontsize FONTSIZE] [--markersize MARKERSIZE]
                        [-R READCOUNT [READCOUNT ...]]
                        [-p DOWNSAMPLE_PERCENTAGE] [-g LOG] [-G LOG_LEVEL]
                        [-o OUTPUTFOLDER] [-t THREADS] [-Q OUTPREFIX]
                        [-s SEED] [-d DETAIL] -c CSV

For example:
python longreadsum rrms -i input.bam -c input.csv -o /output_directory/

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single input filepath
  -I INPUTS, --inputs INPUTS
                        Multiple comma-separated input filepaths
  -P INPUTPATTERN, --inputPattern INPUTPATTERN
                        Use pattern matching (*) to specify multiple input files. Enclose the pattern in double quotes.
  -p DOWNSAMPLE_PERCENTAGE, --downsample_percentage DOWNSAMPLE_PERCENTAGE
                        The percentage of downsampling for quick run. Default: 1.0 without downsampling
  -c CSV, --csv CSV     CSV file containing read IDs to extract from the BAM file.
                        The CSV file should contain a read id column with the header 'read_id' as well as a column containing the accepted/rejected status of the read with the header 'decision'.
                        Accepted reads should have a value of 'stop_receiving' in the 'decision' column, while rejected reads should have a value of 'unblock'.

Common parameters for %(prog)s:
  --fontsize FONTSIZE   Font size for plots. Default: 14
  --markersize MARKERSIZE
                        Marker size for plots. Default: 10
  -R READCOUNT [READCOUNT ...], --readCount READCOUNT [READCOUNT ...]
                        Set the number of reads to randomly sample from the file. Default: 8.
  -g LOG, --log LOG     Log file
  -G LOG_LEVEL, --log_level LOG_LEVEL
                        Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default: 2.
  -o OUTPUTFOLDER, --outputfolder OUTPUTFOLDER
                        The output folder.
  -t THREADS, --threads THREADS
                        The number of threads used. Default: 1.
  -Q OUTPREFIX, --outprefix OUTPREFIX
                        The prefix of output. Default: `QC_`.
  -s SEED, --seed SEED  The number for random seed. Default: 1.
  -d DETAIL, --detail DETAIL
                        Will output detail in files? Default: 0(no).
```


## Metadata
- **Skill**: generated
