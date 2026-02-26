---
name: ctat-mutations
description: The CTAT-Mutations pipeline extracts high-confidence variants from transcriptomic data by integrating RNA-Seq variant calling with specialized filtering and annotation. Use when user asks to identify somatic-like mutations from RNA-Seq data, analyze long-read transcriptomics for variants, or apply machine learning-based boosting to filter RNA-editing artifacts.
homepage: https://github.com/NCIP/ctat-mutations
---


# ctat-mutations

## Overview
The CTAT-Mutations pipeline is a specialized bioinformatics workflow designed to extract high-confidence variants from transcriptomic data. It integrates GATK Best Practices for RNA-Seq variant calling with downstream annotation and filtering steps. This skill helps you configure the pipeline to prioritize somatic-like mutations, filter out common germline variants and RNA-editing artifacts, and generate interactive visualizations for variant inspection.

## Core Command Line Usage

### Standard Short-Read Analysis
For standard paired-end RNA-Seq data, use the following pattern:

```bash
python /path/to/ctat_mutations \
  --left reads_1.fastq.gz \
  --right reads_2.fastq.gz \
  --sample_id <SAMPLE_NAME> \
  --genome_lib_dir <PATH_TO_CTAT_GENOME_LIB> \
  --outputdir <OUTPUT_DIR> \
  --cpu <THREADS>
```

### Long-Read (PacBio IsoSeq) Analysis
As of v4.0.0, the pipeline supports long reads. Note that boosting is disabled for long reads.

1. **Prepare the genome library** (one-time setup for long reads):
   ```bash
   python mutation_lib_prep/ctat-mutation-lib-integration.py --genome_lib_dir /path/to/ctat_genome_lib
   ```
2. **Run the pipeline**:
   ```bash
   ctat_mutations --left long_reads.fastq.gz --is_long_reads --genome_lib_dir /path/to/ctat_genome_lib
   ```

## Advanced Filtering and Boosting
By default, the pipeline uses "hard filters." You can enable machine learning-based boosting to reduce false positives.

- **Boosting Methods**: `gradient_boosting`, `stochastic_gradient_boosting`, `adaptive_boosting`, or `random_forest`.
- **Usage**: Add `--boosting_method <method>` to your command.
- **Tip**: You can run with default filters first, then re-run with boosting. The pipeline will reuse existing intermediate files to save time.

## Containerized Execution
Using Docker or Singularity is recommended to avoid dependency conflicts.

### Docker
```bash
docker run --rm -v `pwd`:`pwd` -v /tmp:/tmp \
  -v ${CTAT_GENOME_LIB}:/ctat_genome_lib_dir:ro \
  trinityctat/ctat_mutations \
  /usr/local/src/ctat-mutations/ctat_mutations \
  --left `pwd`/reads_1.fastq.gz \
  --right `pwd`/reads_2.fastq.gz \
  --sample_id test \
  --output `pwd`/output_dir \
  --genome_lib_dir /ctat_genome_lib_dir
```

### Singularity
```bash
singularity exec -e -B `pwd`:`pwd` -B /tmp:/tmp \
  -B ${CTAT_GENOME_LIB}:/ctat_genome_lib_dir:ro \
  ctat_mutations.simg \
  /usr/local/src/ctat-mutations/ctat_mutations \
  --left `pwd`/reads_1.fastq.gz \
  --right `pwd`/reads_2.fastq.gz \
  --sample_id test \
  --output `pwd`/output_dir \
  --genome_lib_dir /ctat_genome_lib_dir
```

## Key Outputs
- **`variants.HC_init.wAnnot.vcf.gz`**: The full set of annotated HaplotypeCaller variants.
- **`cancer.vcf` / `cancer.tab`**: Prioritized set of cancer-relevant variants.
- **`igvjs_viewer.html`**: An interactive HTML report for visual inspection of variants and read support.

## Best Practices
- **Genome Library**: Ensure you use the specific CTAT Genome Library (Hg19 or Hg38) required by the pipeline.
- **Resource Allocation**: Variant calling is computationally intensive; always specify `--cpu` to match your environment's capabilities.
- **Maintenance Note**: The tool is no longer actively developed; for critical production pipelines, verify results against current GATK versions if necessary.

## Reference documentation
- [CTAT-Mutations Wiki Home](./references/github_com_TrinityCTAT_ctat-mutations_wiki_Home_1ca4fa2b38f82ab86da2d4ccb80ab3b77250e627.md)
- [Docker and Singularity Instructions](./references/github_com_TrinityCTAT_ctat-mutations_wiki_ctat_mutations_docker_singularity.md)