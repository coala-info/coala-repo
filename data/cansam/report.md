# cansam CWL Generation Report

## cansam_samcat

### Tool Description
Concatenate SAM/BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
- **Homepage**: https://github.com/jmarshall/cansam
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cansam/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jmarshall/cansam
- **Stars**: N/A
### Original Help Text
```text
Usage: samcat [-bnv] [-f FLAGS] [-o FILE] [-O FORMAT] [FILE]...
Options:
  -b         Write output in BAM format (equivalent to -Obam)
  -f FLAGS   Display only alignment records matching FLAGS
  -n         Suppress '@' headers in the output
  -o FILE    Write to FILE rather than standard output
  -O FORMAT  Write output in the specified FORMAT
  -v         Display file information and statistics
Output formats:
  bam        Compressed binary BAM format
  hex        SAM format, with flags displayed in hexadecimal
  text       SAM format, with flags displayed as readable strings
  ubam       Uncompressed binary BAM format
```


## cansam_samhead

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
- **Homepage**: https://github.com/jmarshall/cansam
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: samhead [FILE]...
```


## cansam_samsort

### Tool Description
Sort SAM/BAM/CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
- **Homepage**: https://github.com/jmarshall/cansam
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: samsort [-bcm] [-f CMP] [-o FILE] [-S SIZE] [-T DIR] [-z NUM] [FILE]...
Options:
  -b         Write output in BAM format
  -c         Check whether input is already sorted
  -f CMP     Compare records according to comparison function CMP [location]
  -m         Merge already-sorted files
  -o FILE    Write output to FILE rather than standard output
  -S SIZE    Use SIZE amount of in-memory working space
  -T DIR     Write temporary files to DIR [$TMPDIR or /tmp]
  -z NUMBER  Compress output at level NUMBER [SAM: no compression; BAM: 6]
Comparison functions:
  location   Order by chromosome then position (and then read name)
  qname      Order by read (query) name then first/second ordering flags
```


## cansam_samgroupbyname

### Tool Description
Group SAM/BAM records by read name.

### Metadata
- **Docker Image**: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
- **Homepage**: https://github.com/jmarshall/cansam
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: samgroupbyname [-bpv] [-o FILE] [FILE]
Options:
  -b       Write output in BAM format
  -o FILE  Write to FILE rather than standard output
  -p       Emit pairs only, discarding any leftover singleton reads
  -v       Display file information and statistics
```


## cansam_samsplit

### Tool Description
Split a SAM/BAM file into multiple files based on read group information.

### Metadata
- **Docker Image**: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
- **Homepage**: https://github.com/jmarshall/cansam
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: samsplit [OPTION]... FILE [TEMPLATE]
Options:
  -b        Write output files in BAM format
  -f FLAGS  Emit only alignment records matching FLAGS
  -o FILE   Write all selected records to FILE, in addition to splitting
  -q NUM    Discard reads with mapping quality less than NUM
  -z NUM    Compress output files at level NUM (default for BAM; none for SAM)
Template and output file expansions:
  %XY       Read group header's XY field
  %#        Index of the read group (within the @RG headers, from 1)
  %*        Input FILE basename, without directory part or extension
  %.        "sam" or "bam", as appropriate for the chosen output format
  %%        A single "%" character
The output TEMPLATE defaults to "%*-%ID.%."
```

