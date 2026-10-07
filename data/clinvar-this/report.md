# clinvar-this CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| clinvar-this_data_acmg_class_by_freq | PASS |  |
| clinvar-this_data_extract_vars | PASS |  |
| clinvar-this_data_gene_phenotype_links | PASS |  |
| clinvar-this_data_gene_variant_report | PASS |  |
| clinvar-this_data_xml_to_jsonl | PASS |  |

## clinvar-this_data_acmg_class_by_freq

### Tool Description
Create links between gene and phenotype.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-this
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-this/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: clinvar-this data acmg-class-by-freq [OPTIONS] INPUT_FILE OUTPUT_FILE

  Create links between gene and phenotype.

Options:
  --thresholds TEXT  Whether to filter to rows with HPO terms (default: true)
  --help             Show this message and exit.
```

## clinvar-this_data_extract_vars

### Tool Description
Write out variants from RCV records.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-this
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-this/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: clinvar-this data extract-vars [OPTIONS] PATH_INPUT PATH_OUTPUT_DIR

  Write out variants from RCV records.

Options:
  --gzip-output / --no-gzip-output
                                  Whether to gzip output (default: true)
  --help                          Show this message and exit.
```

## clinvar-this_data_gene_phenotype_links

### Tool Description
Create links between gene and phenotype.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-this
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-this/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: clinvar-this data gene-phenotype-links [OPTIONS] INPUT_FILE OUTPUT_FILE

  Create links between gene and phenotype.

Options:
  --needs-hpo-terms / --no-needs-hpo-terms
                                  Whether to filter to rows with HPO terms
                                  (default: true)
  --help                          Show this message and exit.
```

## clinvar-this_data_gene_variant_report

### Tool Description
Create a gene variant summary report.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-this
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-this/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: clinvar-this data gene-variant-report [OPTIONS] INPUT_FILE OUTPUT_FILE

  Create a gene variant summary report.

Options:
  --help  Show this message and exit.
```

## clinvar-this_data_xml_to_jsonl

### Tool Description
Convert XML to JSONL

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-this
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-this/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: clinvar-this data xml-to-jsonl [OPTIONS] INPUT_FILE OUTPUT_FILE

  Convert XML to JSONL

Options:
  --fasta-ref-hg19 TEXT           Normalize hg19 coordinates with FASTA
  --fasta-ref-hg38 TEXT           Normalize hg38 coordinates with FASTA
  --max-records INTEGER           Maximum number of records to convert
  --show-progress / --no-show-progress
                                  Whether to show progress bar.
  --help                          Show this message and exit.
```
