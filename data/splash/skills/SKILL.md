---
name: splash
description: SPLASH (Statistical Protocol for Lineage-Agnostic Sequence Heterogeneity) is a reference-free framework that identifies sample-specific sequence variations by analyzing the statistical composition of k-mer pairs (anchors and targets).
homepage: https://github.com/refresh-bio/splash
---

# splash

## Overview
SPLASH (Statistical Protocol for Lineage-Agnostic Sequence Heterogeneity) is a reference-free framework that identifies sample-specific sequence variations by analyzing the statistical composition of k-mer pairs (anchors and targets). By bypassing the alignment step, it avoids the computational bottlenecks and biases of traditional reference-based pipelines, enabling the discovery of novel biological events in non-model organisms or highly divergent sequences.

## Core Workflow

### 1. Prepare Input
Create a tab-separated or space-separated `input.txt` file where each line defines a sample:
```bash
# Format: {sample_name} {path_to_fastq}
Sample_A /data/reads/sample_a.fastq.gz
Sample_B /data/reads/sample_b.fastq.gz
```
For **10x/Visium** data, the path should point to a text file containing comma-separated FASTQ paths (R1, R2).

### 2. Execute Analysis
Run the main pipeline with default parameters:
```bash
splash input.txt
```

### 3. Interpret Results
The primary output is `result.after_correction.scores.tsv`. Key columns include:
- `pval_opt`: The statistical significance of the variation.
- `effect_size_bin`: A measure (0 to 1) of how strongly the variation divides the samples.
- `target_entropy`: Diversity of the sequences following the anchor.

## Common CLI Patterns

### Single-Cell and Spatial Analysis
To enable barcoded data processing, specify the technology:
```bash
splash --technology 10x input.txt
splash --technology visium input.txt
```

### Supervised Metadata Testing
To find anchors that vary significantly between specific metadata groups (e.g., "Control" vs "Treated"):
```bash
splash --supervised_test_samplesheet metadata.tsv input.txt
```
*Note: The metadata file must have `sample_name` and `group` as the first two columns.*

### Local Assembly with Compactors
Use the `compactors` tool to assemble diverse regions starting from specific anchors:
```bash
compactors fastq.list anchors.tsv output.tsv --max_length 2000 --num_threads 8
```

### Reference Annotation with Lookup Tables
To check if discovered k-mers match known transcriptomes:
1. **Build Index**:
   ```bash
   build_lookup_table.py --kmer_len 27 --outname my_index.slt reference_list.txt
   ```
2. **Query Index**:
   ```bash
   lookup_table query --input_fmt fasta query_sequences.fa my_index.slt results.txt
   ```

## Expert Tips & Performance Tuning

- **Memory Management**: If you have high RAM availability, use `--kmc_use_RAM_only_mode True` to speed up k-mer counting.
- **Disk I/O**: For datasets with many small samples, increase `--n_threads_stage_1`. For large samples, focus on `--n_threads_stage_2`.
- **Filtering Noise**: 
  - Use `--poly_ACGT_len` (default 8) to filter low-complexity sequences.
  - Increase `--anchor_count_threshold` (default 50) if the output contains too many low-confidence anchors.
- **Gap Analysis**: If looking for variations separated by a distance (e.g., long-range splicing), set `--gap_len` to a specific integer instead of the default 0.
- **Post-processing**: You can run BLAST automatically on significant anchors by passing a JSON configuration:
  ```bash
  splash --postprocessing_item postprocessing/blast.json input.txt
  ```

## Reference documentation
- [SPLASH Wiki Home](./references/github_com_refresh-bio_splash_wiki.md)
- [Configuration Parameters](./references/github_com_refresh-bio_splash_wiki_Configuration.md)
- [Input and Output Guide](./references/github_com_refresh-bio_splash_wiki_Input-and-output.md)
- [Compactors Assembly](./references/github_com_refresh-bio_splash_wiki_Compactors.md)
- [Lookup Table Annotation](./references/github_com_refresh-bio_splash_wiki_Lookup_table.md)
- [GLM Supervised Mode](./references/github_com_refresh-bio_splash_wiki_GLM_supervised.md)