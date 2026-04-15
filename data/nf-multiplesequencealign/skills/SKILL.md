---
name: multiplesequencealign
description: This pipeline deploys and benchmarks Multiple Sequence Alignment (MSA) tools using FASTA sequences or protein structures as input, supporting various aligners, guide tree builders, and evaluation metrics like Sum of Pairs or iRMSD. Use when you need to compare performance across different MSA algorithms, generate consensus alignments, or visualize structural alignments with Foldmason.
homepage: https://github.com/nf-core/multiplesequencealign
---

# multiplesequencealign

## Overview
nf-core/multiplesequencealign is designed to automate the deployment and benchmarking of popular Multiple Sequence Alignment (MSA) tools. It addresses the challenge of selecting and evaluating the most effective alignment strategy for specific biological datasets by providing a unified framework for running multiple tools in parallel.

The pipeline processes sequence data in FASTA format or structural data in PDB format, producing aligned sequences along with comprehensive evaluation metrics. Users receive standardized alignment files, statistical summaries of input sequences, and comparative reports to identify the highest-quality alignments for downstream analysis.

## Data preparation
Input can be provided via direct command-line flags for single datasets or via a samplesheet for multiple datasets. A toolsheet is used to define the specific combinations of guide tree builders and aligners to be tested.

**Samplesheet columns (`--input`):**
- `id`: Unique identifier for the dataset (required).
- `fasta`: Path to the input FASTA file (required if `optional_data` is absent).
- `reference`: Path to a reference alignment for evaluation.
- `optional_data`: Path to a directory or `.tar.gz` containing protein structures (PDB).
- `template`: Path to a template file for specific aligners.

Example `samplesheet.csv`:
```csv
id,fasta,optional_data
sample1,data/seq1.fa,data/structures/
sample2,data/seq2.fa,data/struct2.tar.gz
```

**Toolsheet columns (`--tools`):**
- `aligner`: The MSA tool to use (e.g., FAMSA, MAFFT, TCOFFEE, FOLDMASON).
- `tree`: Optional guide tree tool (e.g., FAMSA, CLUSTALO).
- `args_tree`: Optional arguments for the tree builder.
- `args_aligner`: Optional arguments for the aligner.

## How to run
For a simple run with one tool and one FASTA file, use the `easy_deploy` profile. For complex benchmarking, provide both a samplesheet and a toolsheet.

**Single tool run:**
```bash
nextflow run nf-core/multiplesequencealign \
   -profile easy_deploy,docker \
   --seqs input.fasta \
   --aligner FAMSA \
   --outdir results
```

**Benchmarking run:**
```bash
nextflow run nf-core/multiplesequencealign \
   -profile docker \
   --input samplesheet.csv \
   --tools toolsheet.csv \
   --outdir results
```

Key parameters include `--pdbs_dir` for structural data, `--tree` for specific guide trees, and `--use_gpu` for GPU-accelerated aligners like LEARNMSA. Use `-resume` to restart a run from the last successful step and `-r` to specify a pipeline version.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary deliverables include the generated alignments (often in `.aln.gz` or `.fasta.gz` format) and evaluation scores such as Sum of Pairs (SoP) and Total Column (TC) scores.

For a high-level summary, users should first examine the `multiqc/multiqc_report.html` file, which aggregates alignment statistics and benchmarking results. The pipeline also generates a Shiny app for interactive data exploration and optional Foldmason HTML files for structural MSA visualization. Detailed output documentation is available at `https://nf-co.re/multiplesequencealign/output`.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/FAQs.md`](references/docs/usage/FAQs.md)
- [`references/docs/usage/adding_a_tool.md`](references/docs/usage/adding_a_tool.md)
- [`references/docs/usage/chaining_with_proteinfold.md`](references/docs/usage/chaining_with_proteinfold.md)