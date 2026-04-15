---
name: createtaxdb
description: This pipeline automates the parallel construction of custom metagenomic classifier databases for multiple tools like Kraken2, DIAMOND, and Centrifuge using a CSV samplesheet of reference genomes and NCBI-style taxonomy files. Use when you need to generate consistent, multi-tool reference databases from the same input genome set for taxonomic profiling workflows or as a companion to nf-core/taxprofiler.
homepage: 
---

# createtaxdb

## Overview
nf-core/createtaxdb solves the challenge of manually building reference databases for various metagenomic classifiers by automating the process from a single set of input genomes. It supports a wide array of nucleotide and protein-based profilers, ensuring that different tools use the exact same reference versions and taxonomic metadata.

The pipeline takes FASTA files and NCBI-style taxonomy identifiers to produce indexed database files ready for downstream classification. It is particularly useful for researchers who need to compare results across different profiling tools or who are using the nf-core/taxprofiler pipeline and require custom reference sets.

## Data preparation
The primary input is a comma-separated samplesheet specified with `--input`. This file must contain columns for a unique identifier, a taxonomic ID, and paths to DNA and/or amino acid FASTA files.

Minimal samplesheet example:
```csv
id,taxid,fasta_dna,fasta_aa
Human_MT,9606,chrMT.fna,
SARS-CoV-2,694009,genomic.fna.gz,genomic.faa.gz
B_fragilis,817,GCF_016889925.1.fna,GCF_016889925.1.faa
```

In addition to the samplesheet, the pipeline requires NCBI-style taxonomy files:
*   `--nodesdmp`: Path to `nodes.dmp`.
*   `--namesdmp`: Path to `names.dmp`.
*   `--accession2taxid`: NCBI-style four-column accession to taxonomy ID map.
*   `--nucl2taxid` / `--prot2taxid`: Two-column mapping files for specific tools like Centrifuge or Kraken2.
*   `--malt_mapdb`: Required only if building MALT databases.

## How to run
Run the pipeline by specifying the input samplesheet, the desired database name, and the specific tools you wish to build databases for using `--build_<tool>` flags.

```bash
nextflow run nf-core/createtaxdb \
   -profile docker \
   -r 1.0.0 \
   --input samplesheet.csv \
   --outdir ./results \
   --dbname custom_db \
   --nodesdmp ./taxonomy/nodes.dmp \
   --namesdmp ./taxonomy/names.dmp \
   --accession2taxid ./taxonomy/nucl_gb.accession2taxid \
   --build_kraken2 \
   --build_diamond \
   --build_centrifuge
```

Key parameters include:
*   `-profile`: Deployment profile (e.g., `docker`, `singularity`, `conda`).
*   `--dbname`: Prefix for the resulting database files.
*   `--<tool>_build_options`: Pass custom strings to the underlying build tools (e.g., `--kraken2_build_options '--kmer-len 45'`).
*   `--generate_downstream_samplesheets`: Creates input files for pipelines like nf-core/taxprofiler.
*   `-resume`: Restarts the pipeline from the last cached step if interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`. The structure includes:
*   Tool-specific folders (e.g., `kraken2/`, `diamond/`, `centrifuge/`) containing the final indexed database files.
*   `cat/`: If `--save_concatenated_fastas` is used, contains the merged reference sequences.
*   `multiqc/`: Quality control reports for the build process.
*   `pipeline_info/`: Execution logs and resource usage reports.

For detailed information on specific tool outputs, refer to the official [output documentation](https://nf-co.re/createtaxdb/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/dev.md`](references/docs/usage/dev.md)
- [`references/docs/usage/faq.md`](references/docs/usage/faq.md)
- [`references/docs/usage/tutorials.md`](references/docs/usage/tutorials.md)