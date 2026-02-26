---
name: rpsbproc
description: This tool post-processes RPS-BLAST search results to provide non-redundant domain annotations. Use when user asks to analyze RPS-BLAST output, obtain non-redundant domain hits, or annotate query sequences with domain superfamily and functional site information.
homepage: https://ftp.ncbi.nih.gov/pub/mmdb/cdd/rpsbproc/README
---


# rpsbproc

rpsbproc/SKILL.md
```yaml
name: rpsbproc
description: |
  Post-processes the results of local RPS-BLAST searches to provide a non-redundant view of search results and additional annotation on query sequences, such as domain superfamilies and functional sites. Use when Claude needs to:
  1. Analyze raw RPS-BLAST or rpstblastn output.
  2. Obtain a non-redundant set of conserved domain hits.
  3. Annotate query sequences with domain superfamily and functional site information.
  4. Replicate the functionality of the NCBI Batch CD-Search web service locally.
```
## Overview
The `rpsbproc` utility is designed to enhance the output of local RPS-BLAST and rpstblastn searches. It takes the raw alignment data and enriches it with information about domain superfamilies and functional sites. The tool then reorganizes these hits to present a non-redundant set of results, effectively transforming raw alignments into detailed domain/site annotations on your query sequences at various redundancy levels. This provides similar output to the NCBI Batch CD-Search web service but for local analyses.

## Usage Instructions

The `rpsbproc` command-line utility requires the output from a local RPS-BLAST or rpstblastn search as input. It then processes this input to generate annotated, non-redundant results.

### Core Command Structure

The basic command structure is as follows:

```bash
rpsbproc -i <input_rpsblast_output_file> -o <output_file> [options]
```

### Key Options and Parameters

*   `-i <input_rpsblast_output_file>`: Specifies the input file containing the results from `rpsblast` or `rpstblastn`. This is a mandatory argument.
*   `-o <output_file>`: Specifies the output file where the processed, annotated results will be saved. This is also a mandatory argument.
*   `--dbdir <directory>`: Specifies the directory containing the domain annotation data files (e.g., `cddid.tbl`, `cddannot.dat`). These are crucial for `rpsbproc` to add superfamily and functional site information. If not provided, `rpsbproc` may look in the current directory or a default location.
*   `--seqdbdir <directory>`: Specifies the directory containing the RPS-BLAST databases (e.g., `Cdd_LE`, `Cog_LE`). This is necessary for `rpsbproc` to correctly interpret the domain information.
*   `--evalue <threshold>`: Sets the E-value threshold for reporting hits. Defaults to 10.
*   `--sort <criteria>`: Specifies the sorting criteria for the output hits. Common criteria include `score`, `evalue`, or `domain`.
*   `--redundancy <level>`: Controls the level of redundancy in the output. Options might include `none`, `low`, `medium`, `high`.

### Expert Tips and Best Practices

1.  **Data Directory Setup**: Ensure that the `--dbdir` and `--seqdbdir` arguments point to correctly downloaded and unpacked annotation data and RPS-BLAST databases, respectively. Refer to the `getcdddata.sh` and `getblbins.sh` scripts in the `utils` directory for guidance on downloading these.
2.  **Input File Format**: `rpsbproc` expects the standard output format from `rpsblast` or `rpstblastn`. If you are using custom output formats, ensure they are compatible or consider re-running RPS-BLAST with a standard format.
3.  **Non-Redundant Output**: The primary utility of `rpsbproc` is its ability to provide non-redundant results. Experiment with the `--redundancy` and `--sort` options to find the most informative view for your analysis.
4.  **Tab-Delimited Output**: The output is typically tab-delimited, making it easy to parse programmatically with scripting languages (like Python or R) or to open directly in spreadsheet software.
5.  **E-value Threshold**: Adjust the `--evalue` threshold based on the stringency required for your analysis. A lower E-value will result in fewer, more significant hits.
6.  **Combining with RPS-BLAST**: For a complete workflow, first run `rpsblast` or `rpstblastn` to generate the initial alignment file, then pipe or feed this output into `rpsbproc` for annotation and reduction.

## Reference documentation
- [Post-RPSBLAST Processing Utility v0.1 README file](./references/ftp_ncbi_nih_gov_pub_mmdb_cdd_rpsbproc_README.md)