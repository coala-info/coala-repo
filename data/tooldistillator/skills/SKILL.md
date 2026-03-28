---
name: tooldistillator
description: ToolDistillator converts raw outputs from various bioinformatics tools into standardized JSON objects for structured data analysis. Use when user asks to convert tool reports to JSON, batch process multiple reports, aggregate findings from different tools into a single summary, or parse tabular files into structured formats.
homepage: https://gitlab.com/ifb-elixirfr/abromics
---


# tooldistillator

## Overview
ToolDistillator is a specialized utility designed to bridge the gap between diverse bioinformatics tool outputs and structured data analysis. It transforms raw text, TSV, or XML reports from over 40 different bioinformatics tools into standardized JSON objects. This skill is particularly useful for data scientists and bioinformaticians who need to programmatically handle results from multiple disparate tools or aggregate findings from large-scale genomic analyses into a single, parsable summary.

## Core Workflows

### Single Tool Extraction
To convert a specific tool's output to JSON, use the tool-specific subcommand.
- **Basic Pattern**: `tooldistillator <tool_name> <input_file> -o <output.json>`
- **Example (Abricate)**: `tooldistillator abricate report.tsv -o results.json`
- **Example (FastQC)**: `tooldistillator fastqc report.txt -o fastqc_results.json`

### Batch Processing (Same Tool)
You can process multiple reports from the same tool into a single JSON file by providing a list or wildcard.
- **Pattern**: `tooldistillator <tool_name> path/to/reports/*.tsv -o combined_results.json`
- **Note**: This is only supported for tools using a single input type (e.g., Abricate). Tools requiring multiple file types (like Shovill) must be processed individually.

### Aggregating Different Tools (Summarize)
To merge JSON reports generated from different tools into one master file:
- **Pattern**: `tooldistillator summarize <json_report1> <json_report2> ... -o final_summary.json`
- **Force Overwrite**: Use `-f` or `--force` if the output file already exists.

## Tool-Specific Best Practices

### Metadata and Versioning
Many subcommands allow you to embed metadata directly into the JSON output. This is highly recommended for reproducibility.
- Use `--analysis_software_version` to record the version of the tool that generated the original report.
- Use `--reference_database_version` for tools relying on DBs (e.g., Abricate, AMRFinderPlus).

### Handling Tabular Data
If a tool is not explicitly supported but produces a standard headered TSV, use the `tabular_file` subcommand:
- `tooldistillator tabular_file report.tsv -o output.json`

### Common Tool Inputs
| Tool | Primary Input File |
| :--- | :--- |
| **AMRFinderPlus** | `report.tsv` |
| **Bakta** | `output.json` |
| **Checkm2** | `quality_report.tsv` |
| **GTDB-tk** | `taxonomy_summary.tsv` |
| **Kraken2** | `report.tsv` |
| **Quast** | `report.tsv` |



## Subcommands

| Command | Description |
|---------|-------------|
| tooldistillator summarize | Aggregate several reports |
| tooldistillator.py abricate | Extract information from output(s) of abricate (OUTPUT.tsv) |
| tooldistillator.py amrfinderplus | Extract information from output(s) of amrfinderplus (report.tsv) |
| tooldistillator.py argnorm | Extract information from output(s) of argnorm (output.tsv) |
| tooldistillator.py bakta | Extract information from output(s) of bakta (OUTPUT.json) |
| tooldistillator.py bandage | Extract information from output(s) of bandage (OUTPUT.txt) |
| tooldistillator.py bracken | Extract information from output(s) of bracken (report.tsv) |
| tooldistillator.py bwa | Extract information from output(s) of bwa (input.bam) |
| tooldistillator.py checkm2 | Extract information from output(s) of checkm2 (quality_report.tsv) |
| tooldistillator.py concoct | Extract information from output(s) of concoct (merge_cluster.tsv) |
| tooldistillator.py coreprofiler | Extract information from output(s) of coreprofiler (results.tsv) |
| tooldistillator.py coverm | Extract information from output(s) of coverm (coverage_report.tsv) |
| tooldistillator.py dastool | Extract information from output(s) of dastool (summary.tsv) |
| tooldistillator.py deeparg | Extract information from output(s) of deeparg (report.txt) |
| tooldistillator.py drep | Extract information from output(s) of drep (quality_and_cluster_summary.csv) |
| tooldistillator.py eggnogmapper | Extract information from output(s) of eggnogmapper (annotations_report.tsv) |
| tooldistillator.py fastp | Extract information from output(s) of fastp (report.json) |
| tooldistillator.py fastqc | Extract information from output(s) of fastqc (report.txt) |
| tooldistillator.py filtlong | Extract information from output(s) of filtlong (input.fastq) |
| tooldistillator.py flye | Extract information from output(s) of flye (contig.fasta) |
| tooldistillator.py groot | Extract information from output(s) of groot (report.tsv) |
| tooldistillator.py gtdbtk | Extract information from output(s) of gtdbtk (tax_summary.tsv) |
| tooldistillator.py integronfinder2 | Extract information from output(s) of integronfinder2 (OUTPUT.integrons, OUTPUT.summary) |
| tooldistillator.py isescan | Extract information from output(s) of isescan (OUTPUT.tsv) |
| tooldistillator.py kraken2 | Extract information from output(s) of kraken2 (report.tsv) |
| tooldistillator.py maxbin2 | Extract information from output(s) of maxbin2 (bin_summary.tsv) |
| tooldistillator.py megahit | Extract information from output(s) of megahit (contig.fasta) |
| tooldistillator.py metabat2 | Extract information from output(s) of metabat2 (depth.txt) |
| tooldistillator.py mmseqs2linclust | Extract information from output(s) of mmseqs2linclust (contig.fasta) |
| tooldistillator.py mmseqs2taxonomy | Extract information from output(s) of mmseqs2taxonomy (tax_report.tsv) |
| tooldistillator.py multiqc | Extract information from output(s) of multiqc (output.html) |
| tooldistillator.py plasmidfinder | Extract information from output(s) of plasmidfinder (plasmidfinder.tsv) |
| tooldistillator.py polypolish | Extract information from output(s) of polypolish (contig.fasta) |
| tooldistillator.py prodigal | Extract information from output(s) of prodigal (gene_coordinates.tsv) |
| tooldistillator.py quast | Extract information from output(s) of quast (report.tsv) |
| tooldistillator.py recentrifuge | Extract information from output(s) of recentrifuge (data.tsv) |
| tooldistillator.py refseqmasher | Extract information from output(s) of refseqmasher (OUTPUT.tsv) |
| tooldistillator.py shovill | Extract information from output(s) of shovill (contig.fasta) |
| tooldistillator.py staramr | Extract information from output(s) of staramr (resfinder.tsv) |
| tooldistillator.py sylph | Extract information from output(s) of sylph (report.tsv) |
| tooldistillator.py sylphtax | Extract information from output(s) of sylphtax (merge_report.tsv) |
| tooldistillator.py tabular_file | Extract information from output(s) of tabular_file (report.tsv) |
| tooldistillator.py tooltest | Extract information from output(s) of tooltest (unitest) |

## Reference documentation
- [ToolDistillator README](./references/gitlab_com_ifb-elixirfr_abromics_tooldistillator_-_raw_main_README.md)