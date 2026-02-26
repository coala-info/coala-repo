---
name: finaletoolkit
description: FinaleToolkit is a bioinformatics suite designed to analyze cell-free DNA fragmentation patterns and calculate fragmentomic metrics. Use when user asks to calculate fragment length distributions, analyze end motifs, compute windowed protection scores, or generate cleavage profiles from sequencing alignments.
homepage: https://github.com/epifluidlab/FinaleToolkit
---


# finaletoolkit

## Overview
FinaleToolkit is a high-performance bioinformatics suite designed for "fragmentomics"—the study of the fragmentation patterns of cell-free DNA. It provides a standardized interface to calculate complex biological metrics that are often used in liquid biopsy research to infer nucleosome positioning and tissue-of-origin. Use this skill to process sequencing alignments and generate quantitative features for downstream epigenetic or clinical analysis.

## Core Functionality
The toolkit supports several specialized cfDNA features:
- **Fragment Length:** Distribution and statistics of DNA fragment sizes.
- **End Motifs:** Frequency of specific k-mers at the ends of fragments.
- **Breakpoint Motifs:** Analysis of sequences surrounding the cleavage site.
- **Windowed Protection Score (WPS):** Measures the density of fragments protecting a specific genomic window, used to map nucleosome footprints.
- **Motif Diversity Score (MDS):** Quantifies the variation in fragment end sequences.
- **DELFI (DNA Evaluation of Fragments for early Interception):** Large-scale fragmentation patterns across genomic bins.
- **Cleavage Profile:** High-resolution mapping of where DNA is cut.

## Input Requirements
- **BAM/CRAM:** Must be paired-end and require an associated index file (`.bai` or `.crai`).
- **Fragment Files:** Must be block-gzipped BED3+2 format (`.frag.gz`) with columns: `chrom`, `start`, `stop`, `mapq`, `strand`. These require a tabix index (`.tbi`).

## Common CLI Patterns

### Installation
```bash
conda install -c bioconda -c conda-forge finaletoolkit
# OR
pip install finaletoolkit
```

### Fragment Length Analysis
To calculate fragment length distributions and summary statistics:
```bash
finaletoolkit frag-length-bins --input sample.bam --output lengths.txt --summary-stats --short-fraction
```
*Tip: Use `--short-fraction` to calculate the ratio of short fragments (typically <150bp) to total fragments, a common biomarker in cfDNA.*

### Calculating Windowed Protection Scores (WPS)
WPS is computationally intensive. Ensure your input is indexed:
```bash
finaletoolkit wps --input sample.bam --intervals regions.bed --output sample.wps.txt
```

### End Motif Analysis
To extract the frequency of 4-mer end motifs:
```bash
finaletoolkit end-motifs --input sample.frag.gz --output motifs.txt --kmer 4
```

### Cleavage Profile
To generate a profile of cleavage sites relative to genomic features:
```bash
finaletoolkit cleavage-profile --input sample.bam --intervals sites.bed --output profile.txt
```

## Best Practices and Expert Tips
- **Parallelization:** Many commands support parallel processing across chromosomes. If processing large WGS datasets, ensure you have sufficient memory when using multi-threading.
- **Fragment Files vs. BAM:** For repetitive analyses, converting BAM files to the `.frag.gz` format (using tools like `samtools` or specialized scripts) can significantly speed up subsequent FinaleToolkit runs as the files are smaller and optimized for fragment-based queries.
- **Quality Filtering:** Use the `--mapq` flag (where available) to filter out low-quality alignments (e.g., MAPQ < 30) which can skew fragmentation metrics, especially in repetitive regions.
- **Short Read Customization:** When using the Python API or specific CLI commands like `frag-length-intervals`, you can customize the definition of "short" reads using the `--short-reads` option (default is often 150bp) to match specific experimental protocols.

## Reference documentation
- [FinaleToolkit GitHub Repository](./references/github_com_epifluidlab_FinaleToolkit.md)
- [FinaleToolkit Wiki and Tutorials](./references/github_com_epifluidlab_FinaleToolkit_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_finaletoolkit_overview.md)