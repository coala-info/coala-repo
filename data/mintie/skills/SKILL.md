---
name: mintie
description: MINTIE is a bioinformatics pipeline that identifies rare transcriptional events and novel isoforms through de novo assembly and differential expression. Use when user asks to detect rare transcripts, identify novel isoforms, find complex variants like insertions or novel exons, or analyze intergenic rearrangements.
homepage: https://github.com/Oshlack/MINTIE
---


# mintie

## Overview

MINTIE (Method for Identifying Novel Transcripts and Isoforms using Equivalence classes) is a specialized bioinformatic pipeline designed to detect rare transcriptional events that are often missed by standard transcriptomics tools. By utilizing de novo assembly and differential expression of equivalence classes, it highlights variants present in a "case" sample but absent or rare in "control" samples. It can identify complex variants where boundaries contain insertions or novel exons, as well as intergenic rearrangements.

## Installation and Reference Setup

The most reliable way to manage MINTIE is via a dedicated Conda environment.

```bash
# Create and activate environment
mamba create -c conda-forge -c bioconda -n mintie mintie
conda activate mintie

# Automatic reference setup for hg38
mintie -r
```

**Expert Tip**: The automatic reference generation can be brittle. For production environments, download the pre-computed human references from Zenodo (approx. 19GB) and manually configure the `references.groovy` file to point to the extracted `ref/` directory.

## Common CLI Patterns

### Basic Execution
MINTIE typically runs via a wrapper script or by calling the pipeline logic through `bpipe`.

```bash
# View help and directory locations
mintie -h

# Run the standard pipeline (requires a configured params.txt)
mintie [options] <case_fastq_R1> <case_fastq_R2> <control_fastq_files...>
```

### Running Without Controls
If no control samples are available, MINTIE can still be executed, though it will result in a higher number of candidates.
- Use the `-n` or `--no-controls` flag if supported by your version's wrapper.
- Alternatively, run the pipeline without the Differential Expression (DE) step to identify all assembled novel contigs.

## Configuration and Optimization

### Parameter Tuning (`params.txt`)
- **K-mer Sizes (`Ks`)**: Use a range of sizes (e.g., `Ks=25,31,45,51`). Shorter k-mers aid assembly but increase false positives; longer k-mers are more specific but may fail to assemble lowly expressed variants.
- **Contig Length (`min_contig_len`)**: Set this to approximately 1.5x your single-read length to filter out assembly noise.
- **Read Trimming (`min_read_length`)**: Ensure this is greater than your smallest k-mer value.

### Filtering Results
If MINTIE returns too many candidates, prioritize variants using these strategies:
1.  **Gene Lists**: Supply a specific list of genes of interest in `params.txt` to restrict the search space.
2.  **VAF Filtering**: Use the estimated Variant Allele Frequency (VAF) field in the output TSV to filter out low-frequency noise (e.g., VAF > 0.1).
3.  **Read Counts**: Filter for `case_reads > 10` and `control_reads < 5` to ensure the variant is well-supported and truly rare.

## Working with Non-Human Organisms
While designed for human data (hg38), MINTIE can work with other organisms:
- Provide custom genome and transcriptome FASTA/GTF files in `references.groovy`.
- **Critical**: You must disable the hg38-specific splice motif checking by setting `splice_motif_mismatch=4` in your parameters to avoid errors.

## Troubleshooting Assembly
If a known variant is missing from the results:
1.  Check `novel_contigs_info.tsv` to see if it was assembled but filtered out.
2.  Inspect `aligned_contigs_against_genome.bam` in a genome browser (like IGV) to verify if the de novo assembly successfully reconstructed the variant region.
3.  If not assembled, try decreasing the minimum k-mer size or increasing the sensitivity of the assembler.



## Subcommands

| Command | Description |
|---------|-------------|
| bpipe | bpipe is a build and deployment tool for complex software projects. |
| bpipe | Manage and execute pipelines |
| bpipe | bpipe is a build and deployment tool for bioinformatics pipelines. |
| bpipe | bpipe is a build and automation tool for bioinformatics pipelines. |
| bpipe | bpipe is a build and automation tool for bioinformatics pipelines. |
| bpipe | Manage and execute Bpipe pipelines. |
| bpipe | Manage and execute pipelines |
| bpipe | Manage and execute pipelines |
| bpipe | bpipe is a build and automation tool for bioinformatics pipelines. |
| bpipe | Manage and execute Bpipe pipelines. |
| bpipe | Manage and execute Bpipe pipelines. |
| bpipe | Manage and execute pipelines |
| bpipe | bpipe is a build and automation tool for bioinformatics pipelines. |
| bpipe | bpipe [run\|test\|debug\|touch\|execute] [options] <pipeline> <in1> <in2>...              retry [job id] [test]              remake <file1> <file2>...              resume              stop [preallocated]              history              log [-n <lines>] [job id]              jobs              checks [options]              override              status              cleanup              query <file>              preallocate              archive [--delete] <zip file path>              autoarchive              preserve              register <pipeline> <in1> <in2>...              diagram <pipeline> <in1> <in2>...              diagrameditor <pipeline> <in1> <in2>... |
| bpipe | Manage and execute pipelines |
| bpipe | bpipe is a build and deployment tool for bioinformatics pipelines. |
| bpipe | bpipe [run\|test\|debug\|touch\|execute] [options] <pipeline> <in1> <in2>...              retry [job id] [test]              remake <file1> <file2>...              resume              stop [preallocated]              history              log [-n <lines>] [job id]              jobs              checks [options]              override              status              cleanup              query <file>              preallocate              archive [--delete] <zip file path>              autoarchive              preserve              register <pipeline> <in1> <in2>...              diagram <pipeline> <in1> <in2>...              diagrameditor <pipeline> <in1> <in2>... |
| bpipe | Manage and execute pipelines |
| bpipe | bpipe is a build and deployment tool for bioinformatics pipelines. |
| bpipe | Manage and execute bpipe pipelines. |
| bpipe | Manage and execute pipelines |
| cleanup | Cleanup internal files |
| diagrameditor | Diagram editor for a bpipe pipeline |
| remake | Remake files |

## Reference documentation
- [MINTIE Wiki Home](./references/github_com_Oshlack_MINTIE_wiki.md)
- [Installation Guide](./references/github_com_Oshlack_MINTIE_wiki_Install.md)
- [Running MINTIE](./references/github_com_Oshlack_MINTIE_wiki_Run.md)
- [FAQ and Troubleshooting](./references/github_com_Oshlack_MINTIE_wiki_FAQ.md)
- [VCF and Output Formats](./references/github_com_Oshlack_MINTIE_wiki_VCF-output.md)