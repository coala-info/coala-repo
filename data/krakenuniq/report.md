# krakenuniq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| krakenuniq | PASS |  |
| krakenuniq_extract_reads | PASS |  |
| krakenuniq_filter | PASS |  |
| krakenuniq_mpa_report | PASS |  |
| krakenuniq_report | PASS |  |
| krakenuniq_translate | PASS |  |

## krakenuniq

### Tool Description
KrakenUniq is a metagenomics classifier that assigns taxonomic labels to short DNA reads and uses unique k-mer counts to reduce false positives.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
- **Homepage**: https://github.com/fbreitwieser/krakenuniq
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Total Downloads**: 58.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fbreitwieser/krakenuniq
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4' locally
1.0.4--pl5321h668145b_4: Pulling from biocontainers/krakenuniq
0cacab098358: Already exists
bd9ddc54bea9: Already exists
0e31f2f99699: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob3044764561: no space left on device

Run 'docker run --help' for more information
```

## krakenuniq_report

### Tool Description
Make a report with aggregate counts per clade from raw KrakenUniq output.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
- **Homepage**: https://github.com/fbreitwieser/krakenuniq
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenuniq-report --db KRAKEN_DB_NAME [OPTIONS] <kraken output file(s)>

OPTIONS:
  --show-zeros    Show full taxonomy table.
  --taxon-counts  Input files are in the format '<taxon ID><tab><count>' instead of Kraken output.
  --taxon-list    Input files is list of taxon IDs instead of Kraken output.
  -h              This message.
  
This script should only be used when post-processing raw KrakenUniq output, and k-mer counts and coverages are not needed. For most use-cases, krakenuniq --report-file is better than krakenuniq-report.
```

## krakenuniq_mpa_report

### Tool Description
Make a MetaPhlAn-style report from KrakenUniq output.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
- **Homepage**: https://github.com/fbreitwieser/krakenuniq
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenuniq-mpa-report [--db KRAKEN_DB_NAME] [options] <kraken output file(s)>

Options:
  --db NAME             Name of Kraken database
                        (default: none)
  --show-zeros          Display taxa even if they lack a read in any sample
  --header-line         Display a header line indicating sample IDs
                        (sample IDs are the filenames)
  --intermediate-ranks  Display taxa not at the standard ranks with x__ prefix
```

## krakenuniq_filter

### Tool Description
Filter KrakenUniq classifications by the proportion of k-mers at or below a node.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
- **Homepage**: https://github.com/fbreitwieser/krakenuniq
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenuniq-filter [--db KRAKEN_DB_NAME] [--threshold NUM] <kraken output file(s)>

Threshold must be between 0 and 1.
```

## krakenuniq_translate

### Tool Description
Print the sequence ID and full taxonomy of each classified read.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
- **Homepage**: https://github.com/fbreitwieser/krakenuniq
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Validation**: PASS

### Original Help Text
```text
krakenuniq-translate: Must specify DB with either --db or $KRAKEN_DEFAULT_DB
```

## krakenuniq_extract_reads

### Tool Description
Extract reads that KrakenUniq matched to a taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
- **Homepage**: https://github.com/fbreitwieser/krakenuniq
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenuniq/overview
- **Validation**: PASS

### Original Help Text
```text
krakenuniq-extract-reads: Extract all reads from FASTQ file that are matched to a specied taxon by KrakenUniq

Usage: krakenuniq-extract-reads [OPTIONS] <taxon> <kraken> <fasta/fastq>

<taxon>         taxonomy ID, possibly multiple separated by ','
<kraken>        kraken result file
<fasta/fastq>   fasta/fastq file, possibly gzipped

Options:
  -a  input is FASTA file (default: FASTQ)
  -f  output in FASTA format
  -i  invert: print all reads not matching taxon
  -t TAXDB Include children of taxonomy IDs, using TAXDB to find them
  -v  verbose
  -p  paired-end reads: use a '%' in fasta/q file name as placeholder for 1 and 2

Example:
    krakenuniq-extract-reads -p 9606 result.kraken input_%.fq 
    outputs all reads of input_1.fq and input_2.fq that have the taxonomy ID 9606 to STDOUT.
```
