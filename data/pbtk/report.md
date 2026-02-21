# pbtk CWL Generation Report

## pbtk

### Tool Description
FAIL to generate CWL: pbtk not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Total Downloads**: 55.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbbioconda
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pbtk not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pbtk not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pbtk_bam2fasta

### Tool Description
Converts multiple BAM and/or DataSet files into into gzipped FASTA file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
bam2fasta - Converts multiple BAM and/or DataSet files into into gzipped FASTA file(s).

Usage:
  bam2fasta [options] <input>

  input                    STR  Input file(s).

Options:
  -o,--output              STR  Prefix of output filenames, '-' implies streaming. Streaming not supported with
                                compression nor with split_barcodes
  -c                       INT  Gzip compression level [1-9] [1]
  -u                            Do not compress. In this case, we will not add .gz, and we ignore any -c setting.
  --split-barcodes              Split output into multiple FASTA files, by barcode pairs.
  -p,--seqid-prefix        STR  Prefix for sequence IDs in headers
  --with-biosample-prefix       Add BioSample to prefix for sequence IDs in headers

  -h,--help                     Show this help and exit.
  --version                     Show application version and exit.
  -j,--num-threads         INT  Number of threads to use, 0 means autodetection. [0]

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_bam2fastq

### Tool Description
Converts multiple BAM and/or DataSet files into into gzipped FASTQ file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
bam2fastq - Converts multiple BAM and/or DataSet files into into gzipped FASTQ file(s).

Usage:
  bam2fastq [options] <input>

  input                    STR  Input file(s).

Options:
  -o,--output              STR  Prefix of output filenames
  -c                       INT  Gzip compression level [1-9] [1]
  -u                            Do not compress. In this case, we will not add .gz, and we ignore any -c setting.
  --split-barcodes              Split output into multiple FASTQ files, by barcode pairs.
  -p,--seqid-prefix        STR  Prefix for sequence IDs in headers
  --with-biosample-prefix       Add BioSample to prefix for sequence IDs in headers

  -h,--help                     Show this help and exit.
  --version                     Show application version and exit.
  -j,--num-threads         INT  Number of threads to use, 0 means autodetection. [0]

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_pbmerge

### Tool Description
pbmerge merges PacBio BAM files. If the input is DataSetXML, any filters will be applied.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
pbmerge - pbmerge merges PacBio BAM files. If the input is DataSetXML, any filters will be applied.

Usage:
  pbmerge [options] <INPUT>

  INPUT             FILE  Input file(s). Maybe one of: DataSetXML, BAM file(s), or FOFN

Input/Output:
  -o                STR   Output BAM filename. Writes to stdout if not provided.
  --no-pbi                Disables creation of PBI index file. PBI always disabled when writing to stdout.

  -h,--help               Show this help and exit.
  --version               Show application version and exit.
  -j,--num-threads  INT   Number of threads to use, 0 means autodetection. [0]

Examples:
    $ pbmerge -o merged.bam data.subreadset.xml
    $ pbmerge -o merged.bam data_1.bam data_2.bam data_3.bam
    $ pbmerge -o merged.bam data_bams.fofn

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_pbindex

### Tool Description
pbindex creates a index file that enables random-access to PacBio-specific data in BAM files. Generated index filename will be the same as input BAM plus .pbi suffix.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
pbindex - pbindex creates a index file that enables random-access to PacBio-specific data in BAM files. Generated index
          filename will be the same as input BAM plus .pbi suffix.

Usage:
  pbindex [options] <IN.bam>

  IN.bam            FILE  Input BAM file

Options:
  -h,--help               Show this help and exit.
  --version               Show application version and exit.
  -j,--num-threads  INT   Number of threads to use, 0 means autodetection. [0]
  --log-level       STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file        FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_extracthifi

### Tool Description
extract HiFi reads (>= Q20) from full CCS reads.bam output

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
extracthifi - extract HiFi reads (>= Q20) from full CCS reads.bam output

Usage:
  extracthifi [options] <input.bam> <output.bam>

  input.bam         STR  Input CCS BAM.
  output.bam        STR  Ouput HiFi BAM.

Options:
  -h,--help              Show this help and exit.
  --version              Show application version and exit.
  -j,--num-threads  INT  Number of threads to use, 0 means autodetection. [0]

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_zmwfilter

### Tool Description
Filter ZMWs from BAM data

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
zmwfilter - Filter ZMWs from BAM data

Usage:
  zmwfilter [options] <input> <output>

  input               FILE   Input BAM, FASTX, or DataSet XML
  output              FILE   Output BAM or FASTX (same as input format)

Filtering:
  --include           STR    Include ZMWs in the output file. This can be either a comma-separated list of IDs or a
                             filename containing one ID per line.
  --exclude           STR    Exclude ZMWs from the output file. This can be either a comma-separated list of IDs or a
                             filename containing one ID per line.
  --downsample        FLOAT  Fraction of random ZMWs to include in the output BAM file. Downsampling is not supported
                             on FASTX files.
  --downsample-count  INT    Number of random ZMWs to include in the output BAM file. Downsampling is not supported on
                             FASTX files.
  --downsample-seed   INT    Seed for the downsampling random-number generator. Set this value for reproducible output.
                             Downsampling is not supported on FASTX files.
  --show-all                 Print all unique ZMW hole numbers to stdout, one per line. No filtering is applied.
  --num-passes        INT    Include only ZMWs that have >= N subreads. [0]
  --names             FILE   Include only these read names in the output file. This should be a file containing one
                             name per line. No other filtering is applied, and FASTX input is not supported.

  -h,--help                  Show this help and exit.
  --version                  Show application version and exit.
  -j,--num-threads    INT    Number of threads to use, 0 means autodetection. [0]
  --log-level         STR    Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file          FILE   Log to a file, instead of stderr.


Note:
  1. Downsampling is not supported on FASTX files.
  2. FASTX record names must match the format of PacBio BAM read names, e.g.
     '>movie_name/zmw_id/ccs' or '@movie_name/zmw_id/ccs'

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_pbindexdump

### Tool Description
pbindexdump prints a human-readable view of PBI data to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
pbindexdump - pbindexdump prints a human-readable view of PBI data to stdout.

Usage:
  pbindexdump [options] [input.bam.pbi]

  input.bam.pbi        FILE  Input PBI file. If not provided, stdin will be used as input.

Output Options:
  --format             STR   Output format. Valid choices: (json, cpp). [json]
  --json-indent-level  INT   JSON indent level. [4]
  --json-raw                 Print fields in a layout that more closely reflects the PBI file format (per-field
                             columns, not per-record objects.
  --zmws-only                Print only the ZMW hole number for each record to stdout, one per line.

  -h,--help                  Show this help and exit.
  --version                  Show application version and exit.
  -j,--num-threads     INT   Number of threads to use, 0 means autodetection. [0]

Supported output formats:
  json: 'pretty-printed' JSON
  cpp:  copy/paste-able C++ code that can be used to construct the
        equivalent BAM::PbiRawData object.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

## pbtk_ccs-kinetics-bystrandify

### Tool Description
ccs-kinetics-bystrandify converts a BAM containing CCS-Kinetics tags to a pseudo-bystrand CCS BAM with pw/ip tags that can be used as a substitute for subreads in applications expecting such kinetic information.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbtk/overview
- **Validation**: PASS
### Original Help Text
```text
ccs-kinetics-bystrandify - ccs-kinetics-bystrandify converts a BAM containing CCS-Kinetics tags to a pseudo-bystrand
                           CCS BAM with pw/ip tags that can be used as a substitute for subreads in applications
                           expecting such kinetic information.

Usage:
  ccs-kinetics-bystrandify [options] <IN.bam|xml> <OUT.bam>

  IN.bam|xml        FILE  CCS BAM or ConsensusReadSet XML
  OUT.bam           FILE  Output CCS BAM or ConsensusReadSet XML

  --min-coverage    INT   Specifies the minimum number of passes per strand (fn/rn) for creating a strand-specific
                          read. [1]

  -h,--help               Show this help and exit.
  --version               Show application version and exit.
  -j,--num-threads  INT   Number of threads to use, 0 means autodetection. [0]
  --log-level       STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [INFO]
  --log-file        FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

