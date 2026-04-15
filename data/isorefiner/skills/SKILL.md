---
name: isorefiner
description: IsoRefiner improves the accuracy of transcript isoform identification by reconciling and filtering outputs from multiple long-read sequencing tools. Use when user asks to refine transcript models, merge results from different isoform identification tools, or filter structural errors from long-read GTF datasets.
homepage: https://github.com/rkajitani/IsoRefiner
metadata:
  docker_image: "quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1"
---

# isorefiner

## Overview

IsoRefiner is a specialized bioinformatics suite designed to improve the accuracy of transcript isoform identification. By leveraging long-read sequencing data, it reconciles outputs from multiple transcript-identification tools (such as Bambu, StringTie, and IsoQuant) and de novo assemblers (like RNA-Bloom). The tool applies specific filtering logic to remove structural errors and merges high-confidence results into a final, refined GTF dataset. It is optimized for Oxford Nanopore cDNA reads but is compatible with other long-read technologies.

## Installation and Setup

IsoRefiner is best managed via Conda or Docker to handle its extensive dependencies (Minimap2, Samtools, Bedtools, etc.).

**Bioconda (Recommended):**
```bash
conda create -y -c conda-forge -c bioconda -n isorefiner_env python=3.12.8 isorefiner
conda activate isorefiner_env
```

**Docker:**
```bash
docker pull rkajitani/isorefiner
# Run interactively
docker run -it -v $(pwd):/work -w /work rkajitani/isorefiner /bin/bash
```

## Core Workflows

### Automated End-to-End Refinement
The `trans_struct_wf` command is the most efficient way to run the full pipeline, including trimming, mapping, multi-tool execution, filtering, and merging.

```bash
isorefiner trans_struct_wf \
  -r reads.fastq.gz \
  -g genome.fasta \
  -a reference.gtf \
  -o refined_output.gtf \
  -t 32
```

### Manual Step-by-Step Execution
For greater control over specific tool parameters, execute the subcommands individually.

1.  **Preprocessing:**
    *   **Trim:** `isorefiner trim -r reads.fastq -t 8` (Uses Porechop_ABI)
    *   **Map:** `isorefiner map -r trimmed.fastq -g genome.fasta -t 16` (Uses Minimap2)

2.  **Tool-Specific Identification:**
    Run mapping-based tools using the generated BAM:
    *   `isorefiner run_bambu -b mapped.bam -g genome.fasta -a reference.gtf`
    *   `isorefiner run_stringtie -b mapped.bam -g genome.fasta -a reference.gtf`
    *   `isorefiner run_isoquant -b mapped.bam -g genome.fasta -a reference.gtf`

3.  **Filtering and Refining:**
    Filter the output of each tool to remove low-quality structures:
    ```bash
    isorefiner filter -i tool_output.gtf -r trimmed.fastq -g genome.fasta -o filtered_tool.gtf
    ```
    Merge all filtered results into the final dataset:
    ```bash
    isorefiner refine -i filtered_*.gtf -r trimmed.fastq -g genome.fasta -a reference.gtf
    ```

## Expert Tips and Best Practices

*   **Input Handling:** If you have multiple read files, provide them as a space-delimited string within quotes: `-r "sample1.fq sample2.fq"`.
*   **Resource Management:** Use the `-t` (threads) option across all subcommands to maximize performance, especially during the `map` and `run_rnabloom` steps.
*   **Intermediate Files:** By default, IsoRefiner creates directories named `isorefiner_{command}_work`. Use the `-d` flag to specify a custom working directory if running multiple iterations to avoid overwriting logs and intermediate BAMs.
*   **Tool Selection:** While the workflow runs multiple tools, you can prioritize specific ones (e.g., `bambu` for quantification-heavy tasks or `rnabloom` for novel isoform discovery) by running them manually and passing only their filtered GTFs to the `refine` step.



## Subcommands

| Command | Description |
|---------|-------------|
| isorefiner filter | Filter transcript structures based on read alignments. |
| isorefiner run_bambu | Run Bambu for isoform refinement |
| isorefiner run_espresso | Run ESPRESSO for transcript assembly and quantification. |
| isorefiner run_isoquant | Run isoquant |
| isorefiner run_rnabloom | Run RNA-Bloom for transcript assembly and quantification. |
| isorefiner run_stringtie | Run StringTie to assemble transcripts |
| isorefiner trans_struct_wf | This tool refines transcript structures based on reads and reference annotation. |
| isorefiner_map | Map reads to a reference genome using minimap2 and sort the output. |
| isorefiner_refine | Refine transcript isoform structures based on reads and reference annotation. |
| isorefiner_trim | Trim reads using Porechop_ABI |

## Reference documentation
- [IsoRefiner GitHub README](./references/github_com_rkajitani_IsoRefiner_blob_main_README.md)
- [Step-by-Step Test Script](./references/github_com_rkajitani_IsoRefiner_blob_main_test_isorefiner_step_by_step.sh.md)
- [Conda Dependencies](./references/github_com_rkajitani_IsoRefiner_blob_main_conda.yml.md)