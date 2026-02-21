---
name: ciri-full
description: CIRI-full is a specialized bioinformatics suite designed to reconstruct the complete internal structure of circular RNAs.
homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html
---

# ciri-full

## Overview
CIRI-full is a specialized bioinformatics suite designed to reconstruct the complete internal structure of circular RNAs. While standard tools often only identify the back-spliced junction, CIRI-full utilizes "Reverse Overlap" (RO) features from paired-end reads to resolve the full-length sequence and quantify different isoforms within a single circRNA locus. Use this skill to navigate the multi-step workflow involving BWA, CIRI2, and CIRI-AS, or to execute the automated CIRI-full pipeline.

## Core Workflows

### 1. Automated Pipeline
The simplest way to run the full analysis. It automatically handles the integration of CIRI2, CIRI-AS, and CIRI-full modules.

**Prerequisites:** `bwa` must be in your `$PATH`.

```bash
java -jar CIRI-full.jar Pipeline \
  -1 reads_1.fq.gz \
  -2 reads_2.fq.gz \
  -r reference.fa \
  -a annotation.gtf \
  -d ./output_dir \
  -o sample_prefix \
  -t 8
```

### 2. Step-by-Step Manual Execution
Use this approach if you need to fine-tune specific modules or have already run CIRI2/CIRI-AS.

#### Step A: RO1 (Identify Reverse Overlap)
Identifies 5'-RO features and merges paired-end reads into long single-end reads.
```bash
java -jar CIRI-full.jar RO1 -1 r1.fq -2 r2.fq -o sample_ro1
```
*Tip: Adjust `-minM` (default 13) if you have very short reads or specific overlap requirements.*

#### Step B: BWA Alignment of RO Reads
You must align the merged reads from RO1 before proceeding to RO2.
```bash
bwa mem -T 19 -t 8 reference.fa sample_ro1_ro1.fq > sample_ro1.sam
```

#### Step C: RO2 (Filter Authentic RO Reads)
Screens for authentic circular features based on the alignment.
```bash
java -jar CIRI-full.jar RO2 \
  -r reference.fa \
  -s sample_ro1.sam \
  -l <read_length> \
  -o sample_ro2
```

#### Step D: Merge (Final Reconstruction)
Combines RO2 results with CIRI-AS output to generate the final `.anno` file.
```bash
java -jar CIRI-full.jar Merge \
  -c prefix.ciri \
  -as prefix_jav.list \
  -ro sample_ro2_info.list \
  -r reference.fa \
  -a annotation.gtf \
  -o final_results
```

### 3. Visualization and Quantification (CIRI-vis)
Generates PDF visualizations of isoforms and FASTA sequences of reconstructed circRNAs.

```bash
java -jar CIRI-vis.jar \
  -i final_results_merge_circRNA_detail.anno \
  -l library_length.txt \
  -r reference.fa \
  -d ./vis_output \
  -min 10
```

## Expert Tips & Best Practices
- **Read Length Consistency**: CIRI-full requires paired-end reads to be of equal length for the RO1 module to function correctly.
- **BWA Parameters**: When aligning for CIRI-full, always use `bwa mem -T 19`. This specific score threshold is critical for capturing the split-reads necessary for circRNA detection.
- **Memory Management**: For large datasets, ensure the Java Heap Size is sufficient (e.g., `java -Xmx16G -jar ...`).
- **Output Interpretation**: The `prefix_merge_circRNA_detail.anno` is the primary output. It clusters reads by BSJ position and provides the estimated coverage for each reconstructed isoform.

## Reference documentation
- [CIRI-full Cookbook Documentation](./references/ciri-cookbook_readthedocs_io_en_latest_CIRI-full.html.md)
- [CIRI-full Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ciri-full_overview.md)