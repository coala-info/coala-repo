# qimba CWL Generation Report

## qimba_make-mapping

### Tool Description
Generate a sample mapping file from a directory of sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/qimba
- **Package**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Total Downloads**: 407
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/qimba
- **Stars**: N/A
### Original Help Text
```text
Usage: qimba make-mapping [OPTIONS] INPUT_DIR

  Generate a sample mapping file from a directory of sequence files.

  This command scans INPUT_DIR for sequence files and creates a mapping file
  based on the file naming pattern. Sample names are extracted by: 1. Removing
  the extension 2. Stripping any additional pattern (--strip) 3. Splitting on
  forward/reverse tags and taking the prefix

  Each sample must have an R1 file, R2 is optional.

Output Options:
  -o, --output FILE  Output mapping file (default: stdout)
  -a, --absolute     Use absolute paths in output

Other Options:
  -e, --ext TEXT        File extension to look for [default: .fastq.gz]
  -1, --tag-for TEXT    Forward read tag [default: _R1]
  -2, --tag-rev TEXT    Reverse read tag [default: _R2]
  -s, --strip TEXT      Additional string to strip from filenames
  -c, --safe-char TEXT  Safe character for sample names (default _)
  -k, --dont-rename     Do not remove illegal chars from SampleIDs
  --help                Show this message and exit.
```


## qimba_show-samples

### Tool Description
Display sample information from a mapping file.

### Metadata
- **Docker Image**: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/qimba
- **Package**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qimba show-samples [OPTIONS] MAPPING_FILE

  Display sample information from a mapping file.

Options:
  --attr TEXT  Show specific attribute for all samples
  --help       Show this message and exit.
```


## qimba_derep

### Tool Description
Dereplicate FASTA sequences using USEARCH.

  This command identifies and collapses identical sequences, keeping track
  of their abundance in the sequence headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/qimba
- **Package**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qimba derep [OPTIONS]

  Dereplicate FASTA sequences using USEARCH.

  This command identifies and collapses identical sequences, keeping track
  of their abundance in the sequence headers.

  Example usage:   qimba derep -i input.fasta -o unique.fasta --threads 8

Main Arguments:
  -i, --input-fasta FILE  Input FASTA file to dereplicate  [required]
  -o, --output FILE       Output FASTA file with unique sequences  [required]

Runtime Options:
  --threads INTEGER  Number of threads [default from config: 4]
  --verbose          Enable verbose output

Other Options:
  --help  Show this message and exit.
```


## qimba_merge

### Tool Description
Merge paired end into a single file using USEARCH

  This command generates a merged FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/qimba
- **Package**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qimba merge [OPTIONS]

  Merge paired end into a single file using USEARCH

  This command generates a merged FASTQ file

  Example usage:   qimba merge -i input.tsv -o merge.fastq --threads 8

Main Arguments:
  -i, --input-samplesheet FILE  Input samplesheet  [required]
  -o, --output FILE             Output FASTQ file  [required]

Runtime Options:
  --threads INTEGER  Number of threads [default from config: 4]
  --verbose          Enable verbose output

Other Options:
  --tmp-dir FILE  Temporary directory (overrides config value)
  --help          Show this message and exit.
```


## qimba_dada2-split

### Tool Description
Split DADA2 TSV file into FASTA and simplified TSV.

### Metadata
- **Docker Image**: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/qimba
- **Package**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qimba dada2-split [OPTIONS] INPUT_FILE

  Split DADA2 TSV file into FASTA and simplified TSV.

  This command processes a DADA2-format TSV file containing sequences and
  their counts across samples. It generates:

  1. A FASTA file containing unique sequences with ASV IDs 2. A simplified TSV
  file with ASV IDs replacing sequences

  The input TSV must have sequences in the first column and sample counts in
  subsequent columns. Empty counts are treated as zeros.

  Example usage:   qimba dada2-split input.tsv -o output   qimba dada2-split
  input.tsv -o output --verbose

Output Options:
  -o, --output TEXT  Output basename (without extension)  [required]

Other Options:
  -v, --verbose  Print detailed progress information
  --help         Show this message and exit.
```


## qimba_check-tab

### Tool Description
Check TSV files for their dimensions and consistency.

### Metadata
- **Docker Image**: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/qimba
- **Package**: https://anaconda.org/channels/bioconda/packages/qimba/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qimba check-tab [OPTIONS] [FILES]...

  Check TSV files for their dimensions and consistency.

Options:
  --strict / --no-strict  Strictly enforce consistent column counts
  --help                  Show this message and exit.
```


## Metadata
- **Skill**: generated
