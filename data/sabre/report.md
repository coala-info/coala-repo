# sabre CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sabre_pe | PASS | synthetic data: real sarscov2 reads with planted barcodes (one with a mismatch); counts and trimmed reads match |
| sabre_se | PASS | synthetic data: real sarscov2 reads with planted barcodes (one with a mismatch); counts and trimmed reads match |

## sabre_pe

### Tool Description
Paired-end barcode de-multiplexing of FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sabre:1.000--h577a1d6_6
- **Homepage**: https://github.com/najoshi/sabre/
- **Package**: https://anaconda.org/channels/bioconda/packages/sabre/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sabre pe -f <paired-end fastq file 1> -r <paired-end fastq file 2> -b <barcode file> -u <unknown barcode output file 1> -w <unknown barcode output file 2>

Options:
-f, --pe-file1, Input paired-end fastq file 1 (required, must have same number of records as pe2)
-r, --pe-file2, Input paired-end fastq file 2 (required, must have same number of records as pe1)
-b, --barcode-file, File with barcode and two output file names per line (required)
-u, --unknown-output1, Output paired-end file 1 that contains records with no barcodes found. (required)
-w, --unknown-output2, Output paired-end file 2 that contains records with no barcodes found. (required)
-c, --both-barcodes, Optional flag that indicates that both fastq files have barcodes.
-m <n>, --max-mismatch <n>, Optional argument that is the maximum number of mismatches allowed in a barcode. Default 0.
--quiet, don't print barcode matching info
--help, display this help and exit
--version, output version information and exit
```

## sabre_se

### Tool Description
Single-end barcode de-multiplexing of FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sabre:1.000--h577a1d6_6
- **Homepage**: https://github.com/najoshi/sabre/
- **Package**: https://anaconda.org/channels/bioconda/packages/sabre/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sabre se -f <fastq sequence file> -b <barcode file> -u <unknown barcode output file>

Options:
-f, --fastq-file, Input fastq file (required)
-b, --barcode-file, File with barcode and output file name per line (required)
-u, --unknown-output, Output file that contains records with no barcodes found. (required)
-m <n>, --max-mismatch <n>, Optional argument that is the maximum number of mismatches allowed in a barcode. Default 0.
--quiet, don't output matching info
--help, display this help and exit
--version, output version information and exit
```

## Metadata
- **Skill**: generated
