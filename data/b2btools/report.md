# b2btools CWL Generation Report

## b2btools

### Tool Description
Bio2Byte Tool - Command Line Interface

### Metadata
- **Docker Image**: quay.io/biocontainers/b2btools:3.0.7--py311h39195ad_3
- **Homepage**: https://bio2byte.be/
- **Package**: https://anaconda.org/channels/bioconda/packages/b2btools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/b2btools/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-10-09
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
<module 'b2bTools.__main__' from '/usr/local/lib/python3.11/site-packages/b2bTools/__main__.py'>
usage: b2bTools [-h] [-v] -i INPUT_FILE -o OUTPUT_JSON_FILE
                [-t OUTPUT_TABULAR_FILE] [-m METADATA_FILE]
                [-dj DISTRIBUTION_JSON_FILE] [-dt DISTRIBUTION_TABULAR_FILE]
                [-s {comma,tab}] [--short_ids] [--mode {single_seq,msa}]
                [--dynamine] [--disomine] [--efoldmine] [--agmata] [--psper]
                [-id SEQUENCE_ID]

Bio2Byte Tool - Command Line Interface

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT_FILE, --input_file INPUT_FILE
                        File to process
  -o OUTPUT_JSON_FILE, --output_json_file OUTPUT_JSON_FILE
                        Path to JSON output file
  -t OUTPUT_TABULAR_FILE, --output_tabular_file OUTPUT_TABULAR_FILE
                        Path to tabular output file
  -m METADATA_FILE, --metadata_file METADATA_FILE
                        Path to tabular metadata file
  -dj DISTRIBUTION_JSON_FILE, --distribution_json_file DISTRIBUTION_JSON_FILE
                        Path to distribution output JSON file
  -dt DISTRIBUTION_TABULAR_FILE, --distribution_tabular_file DISTRIBUTION_TABULAR_FILE
                        Path to distribution output JSON file
  -s {comma,tab}, --sep {comma,tab}
                        Tabular separator
  --short_ids           Trim sequence ids (up to 20 chars per seq)
  --mode {single_seq,msa}
                        Execution mode: Single Sequence or MSA Analysis
  --dynamine            Run DynaMine predictor
  --disomine            Run DisoMine predictor
  --efoldmine           Run EFoldMine predictor
  --agmata              Run AgMata predictor
  --psper               Run PSPer predictor
  -id SEQUENCE_ID, --sequence_id SEQUENCE_ID
                        Sequence to extract results instead of getting all the
                        results
```

