---
name: ampliconsuite
description: AmpliconSuite is a comprehensive bioinformatics framework designed to resolve the complex architecture of focal amplifications in cancer.
homepage: https://github.com/AmpliconSuite
---

# ampliconsuite

## Overview
AmpliconSuite is a comprehensive bioinformatics framework designed to resolve the complex architecture of focal amplifications in cancer. At its core, it integrates structural variation (SV) and copy-number (CN) data to reconstruct genomic "cycles" and "paths" that represent the physical structure of amplified regions. The suite is essential for researchers distinguishing between different modes of oncogene amplification, such as ecDNA, BFB cycles, or chromothripsis-driven rearrangements.

## Core Workflow: AmpliconSuite-pipeline
The recommended way to run the analysis is through the `AmpliconSuite-pipeline.py` wrapper (formerly PrepareAA), which automates input preparation, seed detection, and downstream classification.

### 1. Environment Setup
Before execution, ensure the Mosek license and data repository are configured:
- **Mosek License**: Place `mosek.lic` in `$HOME/mosek/`. The tool will not run without this.
- **Data Repo**: Set the `AA_DATA_REPO` environment variable to your annotations directory.
- **Download Data**: Use the pipeline to fetch reference files:
  ```bash
  AmpliconSuite-pipeline.py --download_repo [hg19|GRCh37|GRCh38|mm10]
  ```

### 2. Running the Pipeline (Short-Read)
To process a BAM file from scratch (including CNV calling and classification):
```bash
AmpliconSuite-pipeline.py --bam sample.bam --ref GRCh38 --out sample_output --run_AA --run_classifier
```
- Use `--cnv_bed` if you already have copy number calls to save time.
- Use `--nthreads` to enable multi-threading for the alignment and SV detection steps.

## Long-Read Analysis with CoRAL
For PacBio or Oxford Nanopore data, use CoRAL to reconstruct amplicons.

### 1. Seed Generation
Identify amplified intervals from copy number calls:
```bash
coral seed --cn-seg sample.cns --output-prefix sample_seeds
```

### 2. Reconstruction
Perform the full reconstruction of the breakpoint graph:
```bash
coral reconstruct --lr-bam sample.bam --cnv-seed sample_seeds_CNV_SEEDS.bed --cn-seg sample.cns --output-prefix ./output/sample
```

## Classification and Interpretation
If running tools standalone, use `AmpliconClassifier` to interpret `AmpliconArchitect` (AA) outputs.

### Classification Command
```bash
python amplicon_classifier.py --ref GRCh38 --AA_results /path/to/AA_outputs/
```

### Key Output Files
- `*_amplicon_classification_profiles.tsv`: The primary result file. Look for "Positive" in the `ecDNA+` or `BFB+` columns.
- `*_gene_list.tsv`: Lists oncogenes located on the amplified structures and their estimated copy numbers.
- `*_feature_entropy.tsv`: Provides complexity scores for the amplicons.

## Expert Tips and Best Practices
- **Reference Genomes**: Use `GRCh38_viral` if you suspect oncoviral hybrid focal amplifications (e.g., HPV or HBV integrations).
- **Filtering**: Always use `AmpliconSuite-pipeline` rather than standalone `AmpliconArchitect` for initial runs. The pipeline applies critical filters to seed regions that prevent extreme runtimes and false positives.
- **Memory Management**: AA can be memory-intensive for highly rearranged genomes. Ensure at least 16-32GB of RAM is available for complex samples.
- **Visualization**: Use `CycleViz` to generate circular plots of identified ecDNA structures for publication.

## Reference documentation
- [AmpliconSuite-pipeline](./references/github_com_AmpliconSuite_AmpliconSuite-pipeline.md)
- [AmpliconArchitect](./references/github_com_AmpliconSuite_AmpliconArchitect.md)
- [AmpliconClassifier](./references/github_com_AmpliconSuite_AmpliconClassifier.md)
- [CoRAL (Long-read)](./references/github_com_AmpliconSuite_CoRAL.md)