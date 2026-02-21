---
name: isonclust
description: isONclust is a tool designed for the de novo clustering of long transcript reads.
homepage: https://github.com/ksahlin/isONclust
---

# isonclust

## Overview
isONclust is a tool designed for the de novo clustering of long transcript reads. It utilizes a greedy, quality-value-based algorithm to group reads by their gene family of origin, effectively handling the variable error rates inherent in Oxford Nanopore Technologies (ONT) and Pacific Biosciences (PacBio) data. The tool outputs a mapping of reads to cluster IDs, which can then be used to generate cluster-specific FASTQ files for further analysis.

## Usage Patterns

### Oxford Nanopore (ONT) Reads
For ONT data, use the `--ont` flag, which sets the k-mer size (`--k 13`) and window size (`--w 20`) optimized for this technology.

```bash
isONclust --ont --fastq reads.fastq --outfolder ./output_dir --t 8
```

### PacBio Iso-Seq Reads
isONclust requires full-length non-chimeric (flnc) reads. Ensure quality values are present (e.g., by using the `--polish` flag during CCS generation).

**Using FASTQ input:**
```bash
isONclust --isoseq --fastq flnc.fastq --outfolder ./output_dir --t 8
```

**Using BAM input (Legacy isoseq3 support):**
If you have both CCS and FLNC BAM files:
```bash
isONclust --isoseq --ccs ccs.bam --flnc flnc.bam --outfolder ./output_dir
```

### Generating Cluster FASTQ Files
The primary output is `final_clusters.tsv`. To extract the actual sequences into separate FASTQ files for each cluster:

```bash
isONclust write_fastq --clusters ./output_dir/final_clusters.tsv --fastq reads.fastq --outfolder ./fastq_output --N 1
```
*Note: `--N 1` specifies the minimum cluster size to output.*

## Best Practices and Expert Tips
- **Scale Considerations**: For datasets exceeding 10 million reads, the developer recommends using **isONclust3**, which offers improved speed and accuracy over the original version.
- **Hardware Allocation**: Use the `--t` parameter to specify the number of CPU cores. Clustering is computationally intensive; providing more cores significantly reduces runtime.
- **Input Quality**: For PacBio, always ensure your reads have quality scores. If starting from a BAM file without them, use `bamtools convert -format fastq` to ensure the quality strings are preserved in the resulting FASTQ.
- **Output Interpretation**: The `final_clusters.tsv` file is ordered by cluster size (largest first). The first column is the Cluster ID, and the second is the Read Accession.
- **Manual Tuning**: If the default `--ont` or `--isoseq` presets do not yield satisfactory results, you can manually adjust `--k` (k-mer size) and `--w` (window size).

## Reference documentation
- [isONclust GitHub Repository](./references/github_com_ksahlin_isONclust.md)
- [isONclust Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_isonclust_overview.md)