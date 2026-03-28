# bamkit CWL Generation Report

## bamkit_bamcleanheader.py

### Tool Description
remove illegal and malformed fields from a BAM file's header

### Metadata
- **Docker Image**: quay.io/biocontainers/bamkit:16.07.26--py_0
- **Homepage**: https://github.com/hall-lab/bamkit
- **Package**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hall-lab/bamkit
- **Stars**: N/A
### Original Help Text
```text
usage: bamcleanheader.py [-h] [-S] [input [input ...]]

bamcleanheader.py
author: Author (email@site.com)
version: $Revision: 0.0.1 $
description: remove illegal and malformed fields from a BAM file's header

positional arguments:
  input         SAM/BAM file to inject header lines into. If '-' or absent then defaults to stdin.

optional arguments:
  -h, --help    show this help message and exit
  -S, --is_sam  input is SAM
```


## bamkit_bamheadrg.py

### Tool Description
Inject readgroup info

### Metadata
- **Docker Image**: quay.io/biocontainers/bamkit:16.07.26--py_0
- **Homepage**: https://github.com/hall-lab/bamkit
- **Package**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamheadrg.py [-h] [-r READGROUP] -d DONOR [-S] [recipient]

bamheadrg.py
author: Author (email@site.com)
version: $Revision: 0.0.1 $
description: Inject readgroup info

positional arguments:
  recipient             SAM file to inject header lines into. If '-' or absent then defaults to stdin.

optional arguments:
  -h, --help            show this help message and exit
  -r READGROUP, --readgroup READGROUP
                        Read group(s) to extract (comma separated)
  -d DONOR, --donor DONOR
                        Donor BAM/SAM file to extract read group info
  -S, --donor_is_sam    Donor file is SAM
```


## bamkit_bamfilterrg.py

### Tool Description
Filter BAM files by read group.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamkit:16.07.26--py_0
- **Homepage**: https://github.com/hall-lab/bamkit
- **Package**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/bamfilterrg.py", line 127, in <module>
    sys.exit(main())
  File "/usr/local/bin/bamfilterrg.py", line 123, in main
    bamfilterrg(args.input, args.readgroup, args.n, args.S, args.b, args.u)
  File "/usr/local/bin/bamfilterrg.py", line 24, in bamfilterrg
    in_bam = pysam.Samfile('-', 'rb')
  File "pysam/libcalignmentfile.pyx", line 741, in pysam.libcalignmentfile.AlignmentFile.__cinit__
  File "pysam/libcalignmentfile.pyx", line 990, in pysam.libcalignmentfile.AlignmentFile._open
ValueError: file has no sequences defined (mode='rb') - is it SAM/BAM format? Consider opening with check_sq=False
```


## bamkit_bamgroupreads.py

### Tool Description
Group BAM file by read IDs without sorting

### Metadata
- **Docker Image**: quay.io/biocontainers/bamkit:16.07.26--py_0
- **Homepage**: https://github.com/hall-lab/bamkit
- **Package**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamgroupreads.py [-h] [-i BAM] [-r STR] [-d] [-f] [-S] [-b] [-u] [-M]

bamgroupreads.py
author: Colby Chiang (cc2qe@virginia.edu)
version: $Revision: 0.0.1 $
description: Group BAM file by read IDs without sorting

optional arguments:
  -h, --help            show this help message and exit
  -i BAM, --input BAM   Input BAM file
  -r STR, --readgroup STR
                        Read group(s) to extract (comma separated)
  -d, --reset_dups      Reset duplicate flags
  -f, --fix_flags       Fix mate flags for secondary reads
  -S                    Input is SAM format
  -b                    Output BAM format
  -u                    Output uncompressed BAM format (implies -b)
  -M                    split reads are flagged as secondary, not supplementary. For compatibility with legacy BWA-MEM "-M" flag
```


## bamkit_bamtofastq.py

### Tool Description
Convert a coordinate sorted BAM file to FASTQ (ignores unpaired reads)

### Metadata
- **Docker Image**: quay.io/biocontainers/bamkit:16.07.26--py_0
- **Homepage**: https://github.com/hall-lab/bamkit
- **Package**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamtofastq.py [-h] [-r STR] [-n] [-S] [-H FILE] [BAM [BAM ...]]

bamtofastq.py
author: Ira Hall (ihall@genome.wustl.edu) and Colby Chiang (cc2qe@virginia.edu)
version: $Revision: 0.0.1 $
description: Convert a coordinate sorted BAM file to FASTQ
             (ignores unpaired reads)

positional arguments:
  BAM                   Input BAM file(s). If absent then defaults to stdin.

optional arguments:
  -h, --help            show this help message and exit
  -r STR, --readgroup STR
                        Read group(s) to extract (comma separated)
  -n, --rename          Rename reads
  -S, --is_sam          Input is SAM format
  -H FILE, --header FILE
                        Write BAM header to file
```


## bamkit_bamlibs.py

### Tool Description
output comma delimited string of read group IDs for each library

### Metadata
- **Docker Image**: quay.io/biocontainers/bamkit:16.07.26--py_0
- **Homepage**: https://github.com/hall-lab/bamkit
- **Package**: https://anaconda.org/channels/bioconda/packages/bamkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamlibs.py [-h] [-S] [input]

bamlibs.py
author: Author (email@site.com)
version: $Revision: 0.0.1 $
description: output comma delimited string of read group IDs for each library

positional arguments:
  input         SAM/BAM file to inject header lines into. If '-' or absent then defaults to stdin.

optional arguments:
  -h, --help    show this help message and exit
  -S, --is_sam  input is SAM
```


## Metadata
- **Skill**: generated
