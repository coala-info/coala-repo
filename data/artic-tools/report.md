# artic-tools CWL Generation Report

## artic-tools_align_trim

### Tool Description
Trim alignments from an amplicon scheme

### Metadata
- **Docker Image**: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
- **Homepage**: https://github.com/will-rowe/artic-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/artic-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/artic-tools/overview
- **Total Downloads**: 52.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/will-rowe/artic-tools
- **Stars**: N/A
### Original Help Text
```text
Trim alignments from an amplicon scheme
Usage: /usr/local/bin/artic-tools align_trim [OPTIONS] scheme

Positionals:
  scheme TEXT:FILE REQUIRED   The ARTIC primer scheme

Options:
  -h,--help                   Print this help message and exit
  -b,--inputFile TEXT         The input BAM file (will try STDIN if not provided)
  --minMAPQ UINT              A minimum MAPQ threshold for processing alignments (default = 15)
  --normalise UINT            Subsample to N coverage per strand (default = 100, deactivate with 0)
  --report TEXT               Output an align_trim report to file
  --start                     Trim to start of primers instead of ends
  --remove-incorrect-pairs    Remove amplicons with incorrect primer pairs
  --no-read-groups            Do not divide reads into groups in SAM output
  --verbose                   Output debugging information to STDERR
```


## artic-tools_get_scheme

### Tool Description
Download an ARTIC primer scheme and reference sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
- **Homepage**: https://github.com/will-rowe/artic-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/artic-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Download an ARTIC primer scheme and reference sequence
Usage: /usr/local/bin/artic-tools get_scheme [OPTIONS] scheme

Positionals:
  scheme TEXT REQUIRED        The name of the scheme to download (ebola|nipah|scov2)

Options:
  -h,--help                   Print this help message and exit
  --schemeVersion UINT=0      The ARTIC primer scheme version (default = latest)
  -o,--outDir TEXT            The directory to write the scheme and reference sequence to
```


## artic-tools_validate_scheme

### Tool Description
Validate an amplicon scheme for compliance with ARTIC standards

### Metadata
- **Docker Image**: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
- **Homepage**: https://github.com/will-rowe/artic-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/artic-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Validate an amplicon scheme for compliance with ARTIC standards
Usage: /usr/local/bin/artic-tools validate_scheme [OPTIONS] scheme

Positionals:
  scheme TEXT:FILE REQUIRED   The primer scheme to validate

Options:
  -h,--help                   Print this help message and exit
  -o,--outputPrimerSeqs TEXT  If provided, will write primer sequences as multiFASTA (requires --refSeq to be provided)
  -r,--refSeq TEXT            The reference sequence for the primer scheme (FASTA format)
  --outputInserts TEXT        If provided, will write primer scheme inserts as BED (exluding primer sequences)
```


## artic-tools_check_vcf

### Tool Description
Check a VCF file based on primer scheme info and user-defined cut offs

### Metadata
- **Docker Image**: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
- **Homepage**: https://github.com/will-rowe/artic-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/artic-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Check a VCF file based on primer scheme info and user-defined cut offs
Usage: /usr/local/bin/artic-tools check_vcf [OPTIONS] vcf scheme

Positionals:
  vcf TEXT:FILE REQUIRED      The input VCF file to filter
  scheme TEXT:FILE REQUIRED   The primer scheme to use

Options:
  -h,--help                   Print this help message and exit
  -o,--summaryOut TEXT REQUIRED
                              Summary of variant checks will be written here (TSV format)
  --vcfOut TEXT               If provided, will write variants that pass checks to this file
  -q,--minQual FLOAT          Minimum quality score to keep a variant (default = 10)
```


## Metadata
- **Skill**: generated
