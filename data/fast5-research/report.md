# fast5-research CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fast5-research_extract_reads | Failed | image problem: the program crashes at import with SyntaxError at 'yield from' (Python 2.7 image, Python 3 code) |
| fast5-research_filter_from_bam | Failed | image problem: the program crashes at import with SyntaxError at 'yield from' (Python 2.7 image, Python 3 code) |
| fast5-research_filter_reads | Failed | image problem: the program crashes at import with SyntaxError at 'yield from' (Python 2.7 image, Python 3 code) |
| fast5-research_index_reads | Failed | image problem: the program crashes at import with SyntaxError at 'yield from' (Python 2.7 image, Python 3 code) |
| fast5-research_read_summary | Failed | image problem: the program crashes at import with SyntaxError at 'yield from' (Python 2.7 image, Python 3 code) |

## fast5-research_filter_from_bam

### Tool Description
Create filter file from BAM and sequencing summary

### Metadata
- **Docker Image**: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
- **Homepage**: https://github.com/nanoporetech/fast5_research
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5-research/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_from_bam [--seperator SEP] [--id-col READID_COL] [--fname-col FNAME_COL] [-r REGION] [--workers WORKERS] [-p] BAM SUMMARY [SUMMARY ...]

Create filter file from BAM and sequencing summary

positional arguments:
  BAM                   Path to BAM file
  SUMMARY               Sequencing summary files

options:
  --seperator SEP       Seperator in sequencing summary files
  --id-col READID_COL   Column name for read_id in sequencing summary files
  --fname-col FNAME_COL Column name for fast5 filename in sequencing summary files
  -r, --region REGION   Print reads only from this region
  --workers WORKERS     Number of worker processes.
  -p, --primary-only    Ignore secondary and supplementary alignments

(Help text rebuilt from the argparse definitions in fast5_research/extract.py, because the program crashes at import in the image with: SyntaxError: invalid syntax at 'yield from zip(a, b, c)'.)
```

## fast5-research_extract_reads

### Tool Description
Bulk .fast5 to read .fast5 conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
- **Homepage**: https://github.com/nanoporetech/fast5_research
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5-research/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_reads [--multi | --single] [--flat] [--by_id] [--prefix PREFIX] [--channel_range CHANNEL_RANGE CHANNEL_RANGE] [--summary SUMMARY] [--workers WORKERS] [--limit LIMIT] input output

Bulk .fast5 to read .fast5 conversion.

positional arguments:
  input                 Bulk .fast5 file for input.
  output                Output folder.

options:
  --multi               Output multi-read files.
  --single              Output single-read files.
  --flat                Create all .fast5 files in one directory
  --by_id               Name single-read .fast5 files by read_id.
  --prefix PREFIX       Read file prefix.
  --channel_range CHANNEL_RANGE CHANNEL_RANGE
                        Channel range (inclusive).
  --summary SUMMARY     Strand summary file containing at least columns channel, start_time and duration).
  --workers WORKERS     Number of worker processes.
  --limit LIMIT         Limit reads per channel.

(Help text rebuilt from the argparse definitions in fast5_research/extract.py, because the program crashes at import in the image with: SyntaxError: invalid syntax at 'yield from zip(a, b, c)'.)
```

## fast5-research_filter_reads

### Tool Description
Extract reads from multi-read .fast5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
- **Homepage**: https://github.com/nanoporetech/fast5_research
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5-research/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_reads [--tsv_field TSV_FIELD] [--prefix PREFIX] [--recursive] [--workers WORKERS] [--multi | --single] input output filter

Extract reads from multi-read .fast5 files.

positional arguments:
  input                 Path to input multi-read .fast5 files (or list of files).
  output                Output folder.
  filter                A .tsv file with column read_id defining required reads. If a filename column is present, this will be used as the location of the read.

options:
  --tsv_field TSV_FIELD Field name from filter file to obtain read IDs.
  --prefix PREFIX       Read file prefix.
  --recursive           Search recursively under input for source files.
  --workers WORKERS     Number of worker processes.
  --multi               Output multi-read files.
  --single              Output single-read files.

(Help text rebuilt from the argparse definitions in fast5_research/extract.py, because the program crashes at import in the image with: SyntaxError: invalid syntax at 'yield from zip(a, b, c)'.)
```

## fast5-research_index_reads

### Tool Description
Build index of reads within .fast5s. Output to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
- **Homepage**: https://github.com/nanoporetech/fast5_research
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5-research/overview
- **Validation**: PASS

### Original Help Text
```text
usage: index_reads [--recursive] [--workers WORKERS] input

Build index of reads within .fast5s. Output to stdout.

positional arguments:
  input              .fast5 directory

options:
  --recursive        Search recursively under input for source files.
  --workers WORKERS  Number of worker processes.

(Help text rebuilt from the argparse definitions in fast5_research/extract.py, because the program crashes at import in the image with: SyntaxError: invalid syntax at 'yield from zip(a, b, c)'.)
```

## fast5-research_read_summary

### Tool Description
Summarize reads stored in a Bulk .fast5

### Metadata
- **Docker Image**: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
- **Homepage**: https://github.com/nanoporetech/fast5_research
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5-research/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_summary [--channel_range CHANNEL_RANGE CHANNEL_RANGE] input output

Summarize reads stored in a Bulk .fast5

positional arguments:
  input                 Bulk .fast5 file for input.
  output                Output text file.

options:
  --channel_range CHANNEL_RANGE CHANNEL_RANGE
                        Channel range (inclusive).

(Help text rebuilt from the argparse definitions in fast5_research/extract.py, because the program crashes at import in the image with: SyntaxError: invalid syntax at 'yield from zip(a, b, c)'.)
```

## Metadata
- **Docker Image**: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
- **Homepage**: https://github.com/nanoporetech/fast5_research
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5-research/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/filter_from_bam", line 7, in <module>
    from fast5_research.extract import filter_file_from_bam
  File "/usr/local/lib/python2.7/site-packages/fast5_research/extract.py", line 26
    yield from zip(a, b, c)
             ^
SyntaxError: invalid syntax
```

