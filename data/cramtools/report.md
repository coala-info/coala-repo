# cramtools CWL Generation Report

## cramtools_bam

### Tool Description
A tool to process CRAM files, including conversion to BAM, decryption, and tag calculation.

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cramtools/overview
- **Total Downloads**: 28.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/enasequence/cramtools
- **Stars**: N/A
### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
 A region to access specified as <sequence name>[:<start inclusive>[-[<stop inclusive>]]
  Options:    --calculate-md-tag          Calculate MD tag. (default: false)
    --calculate-nm-tag          Calculate NM tag. (default: false)
    --count-only, -c            Count number of records. (default: false)
    --decrypt                   Decrypt the file. (default: false)
    --default-quality-score     Use this quality score (decimal representation of ASCII symbol) as a default value when the original quality score was lost due to compression. Minimum is 33. (default: 63)
    --filter-flags, -F          Filtering flags.  (default: 0)
    --ignore-md5-mismatch       Issue a warning on sequence MD5 mismatch and continue. This does not garantee the data will be read succesfully.  (default: false)
    --inject-sq-uri             Inject or change the @SQ:UR header fields to point to ENA reference service.  (default: false)
    --input-cram-file, -I       The path or FTP URL to the CRAM file to uncompress. Omit if standard input (pipe).
    --output-bam-file, -O       The path to the output BAM file.
    --password, -p              Password to decrypt the file.
    --print-sam-header          Print SAM header when writing SAM format. (default: false)
    --reference-fasta-file, -R  Path to the reference fasta file, it must be uncompressed and indexed (use 'samtools faidx' for example). 
    --required-flags, -f        Required flags.  (default: 0)
    --skip-md5-check            Skip MD5 checks when reading the header. (default: false)
    --sync-bam-output           Write BAM output in the same thread. (default: false)
    -b, --output-bam-format     Output in BAM format. (default: false)
    -H                          Print SAM header and quit. (default: false)
    -h, --help                  Print help and quit (default: false)
    -l, --log-level             Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## cramtools_cram

### Tool Description
CRAM compression tool for converting BAM/SAM to CRAM

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
 
  Options:    --capture-all-tags              Capture all tags. (default: false)
    --capture-tags                  Capture the tags listed, for example 'OQ:XA:XB' (default: )
    --encrypt                       Encrypt the CRAM file. (default: false)
    --ignore-md5-mismatch           Fail on MD5 mismatch if true, or correct (overwrite) the checksums and continue if false. (default: false)
    --ignore-tags                   Ignore the tags listed, for example 'OQ:XA:XB' (default: )
    --inject-sq-uri                 Inject or change the @SQ:UR header fields to point to ENA reference service.  (default: false)
    --input-bam-file, -I            Path to a BAM file to be converted to CRAM. Omit if standard input (pipe).
    --input-is-sam                  Input is in SAM format. (default: false)
    --lossless-quality-score, -Q    Preserve all quality scores. Overwrites '--lossless-quality-score'. (default: false)
    --lossy-quality-score-spec, -L  A string specifying what quality scores should be preserved. (default: )
    --max-records                   Stop after compressing this many records.  (default: 9223372036854775807)
    --output-cram-file, -O          The path for the output CRAM file. Omit if standard output (pipe).
    --preserve-read-names, -n       Preserve all read names. (default: false)
    --reference-fasta-file, -R      The reference fasta file, uncompressed and indexed (.fai file, use 'samtools faidx'). 
    -h, --help                      Print help and quit (default: false)
    -l, --log-level                 Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## cramtools_index

### Tool Description
Index a BAM or CRAM file using cramtools.

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
  Options:    --help, -h        Print help and exit. (default: false)
    --index-file, -O  Write index to this file.
    --index-format    Choose between BAM index (bai) and CRAM index (crai).  (default: CRAI)
    --input-file, -I  Path to a BAM or CRAM file to be indexed. Omit if standard input (pipe).
    -l, --log-level   Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## cramtools_merge

### Tool Description
The paths to the CRAM or BAM files to uncompress.

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
 The paths to the CRAM or BAM files to uncompress. 
  Options:    --output-file               Path to the output BAM file. Omit for stdout.
    --reference-fasta-file, -R  Path to the reference fasta file, it must be uncompressed and indexed (use 'samtools faidx' for example).
    --region, -r                Alignment slice specification, for example: chr1:65000-100000.
    --sam-format                Output in SAM rather than BAM format. (default: false)
    --sam-header                Print SAM file header when output format is text SAM. (default: false)
    -h, --help                  Print help and quit (default: false)
    -l, --log-level             Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
    -v, --validation-level      Change validation stringency level: STRICT, LENIENT, SILENT. (default: STRICT)
```


## cramtools_fastq

### Tool Description
Uncompress CRAM files into FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
  Options:    --default-quality-score     Use this quality score (decimal representation of ASCII symbol) as a default value when the original quality score was lost due to compression. Minimum is 33. (default: 63)
    --enumerate                 Append read names with read index (/1 for first in pair, /2 for second in pair). (default: false)
    --fastq-base-name, -F       '_number.fastq[.gz] will be appended to this string to obtain output fastq file name. If this parameter is omitted then all reads are printed with no garanteed order.
    --gzip, -z                  Compress fastq files with gzip. (default: false)
    --ignore-md5-mismatch       Issue a warning on sequence MD5 mismatch and continue. This does not garantee the data will be read succesfully.  (default: false)
    --input-cram-file, -I       The path to the CRAM file to uncompress. Omit if standard input (pipe).
    --max-records               Stop after reading this many records. (default: -1)
    --read-name-prefix          Replace read names with this prefix and a sequential integer.
    --reference-fasta-file, -R  Path to the reference fasta file, it must be uncompressed and indexed (use 'samtools faidx' for example). 
    --reverse                   Re-reverse reads mapped to negative strand. (default: false)
    --skip-md5-check            Skip MD5 checks when reading the header. (default: false)
    -h, --help                  Print help and quit (default: false)
    -l, --log-level             Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## cramtools_fixheader

### Tool Description
Fix headers in CRAM files, including MD5 calculation and URI injection for reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: fixheader [options]
  Options:    --confirm-md5               Calculate MD5 for sequences mentioned in the header. Requires --reference-fasta-file option. (default: false)
    --inject-uri                Inject URI for all reference sequences in the header. (default: false)
    --input-cram-file, -I       The path to the CRAM file.
    --reference-fasta-file, -R  Path to the reference fasta file, it must be uncompressed and indexed (use 'samtools faidx' for example). 
    --uri-pattern               String formatting pattern for sequence URI to be injected. (default: http://www.ebi.ac.uk/ena/cram/md5/%s)
    -h, --help                   (default: false)
    -l, --log-level             Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## cramtools_getref

### Tool Description
A list of MD5 checksums for which the sequences should be downloaded.

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
 A list of MD5 checksums for which the sequences should be downloaded.
  Options:    --destination-file, -F  Destination file.
    --fasta-line-length     Wrap fasta lines accroding to this value. (default: 80)
    --gzip, -z              Compress fasta with gzip. (default: false)
    --ignore-not-found      Don't fail on not found sequences, just issue a warning. (default: false)
    --input-file, -I        The path to the CRAM or BAM file to extract sequence MD5 checksums.
    -h, --help              Print help and quit (default: false)
    -l, --log-level         Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## cramtools_qstat

### Tool Description
Quality statistics for CRAM or BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/cramtools:3.0.b127--0
- **Homepage**: https://github.com/enasequence/cramtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Version 3.0-b127

Usage: <main class> [options]
  Options:    --default-quality-score  Use this value as a default or missing quality score. Lowest is 0, which corresponds to '!' in fastq. (default: 30)
    --input-file, -I         The path to the CRAM or BAM file.
    -h, --help               Print help and quit (default: false)
    -l, --log-level          Change log level: DEBUG, INFO, WARNING, ERROR. (default: ERROR)
```


## Metadata
- **Skill**: generated
