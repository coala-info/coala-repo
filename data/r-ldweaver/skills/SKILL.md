---
name: r-ldweaver
description: This tool performs genomewide epistasis and co-selection analysis in bacteria by identifying linkage disequilibrium outliers from sequence alignments. Use when user asks to identify epistatic interactions, detect linkage disequilibrium outliers, annotate genomic links, or visualize bacterial co-selection networks.
homepage: https://cran.r-project.org/web/packages/ldweaver/index.html
---

# r-ldweaver

name: r-ldweaver
description: Expert guidance for using the ldweaver R package to perform genomewide epistasis and co-selection analysis in bacteria. Use this skill when you need to identify linkage disequilibrium (LD) outliers from sequence alignments, annotate genomic links, or visualize bacterial epistasis.

## Overview

ldweaver is an R package designed for Genomewide Epistasis Analysis in bacteria. It identifies pairs of variants (links) with unusually high linkage disequilibrium (LD) relative to their genomic distance, which often indicates co-selection or epistatic interactions. It supports sequence alignments (FASTA) and reference annotations (GenBank/GFF3) to produce ranked outlier links, visualizations, and exports for dynamic explorers like GWESExplorer.

## Installation

Install the package from GitHub using devtools:

```R
install.packages("devtools")
devtools::install_github("Sudaraka88/LDWeaver")
```

Note: For very large datasets (>2^31 elements), ensure the `spam` and `spam64` packages are installed.

## Core Workflow

The primary entry point is the `LDWeaver()` function, which handles the end-to-end pipeline.

### One-Liner Analysis
```R
library(LDWeaver)

LDWeaver::LDWeaver(
  dset = "my_project",
  aln_path = "path/to/alignment.aln.gz",
  gbk_path = "path/to/reference.gbk",
  save_additional_outputs = TRUE,
  num_clusts_CDS = 3
)
```

### Step-by-Step Custom Pipeline
For more control, use the modular functions:

1. **Parse Data**:
   ```R
   snp.dat <- LDWeaver::parse_fasta_alignment(aln_path = "align.aln.gz")
   gbk <- LDWeaver::parse_genbank_file(gbk_path = "ref.gbk", g = snp.dat$g)
   ```

2. **Estimate Variation & Weights**:
   ```R
   cds_var <- LDWeaver::estimate_variation_in_CDS(gbk = gbk, snp.dat = snp.dat)
   hdw <- LDWeaver::estimate_Hamming_distance_weights(snp.dat = snp.dat)
   ```

3. **Compute LD & Fit Models**:
   ```R
   sr_links <- LDWeaver::perform_MI_computation(
     snp.dat = snp.dat, 
     hdw = hdw, 
     cds_var = cds_var,
     lr_save_path = "lr_links.tsv",
     sr_save_path = "sr_links.tsv"
   )
   ```

4. **Annotation & Visualization**:
   ```R
   # Generate GWES plots
   LDWeaver::make_gwes_plots(sr_links = sr_links, plt_folder = "output_dir")

   # SnpEff Annotations
   tophits <- LDWeaver::perform_snpEff_annotations(
     dset_name = "my_project",
     links_df = sr_links,
     snp.dat = snp.dat,
     gbk = gbk
   )
   ```

## Key Functions and Parameters

- `LDWeaver()`: Main wrapper. Key arguments:
    - `aln_has_all_bases`: Set to `FALSE` if using a SNP-only alignment (requires `pos` vector).
    - `mega_dset`: Set to `TRUE` for massive datasets (requires `spam64`).
    - `snp_filt_method`: "relaxed" or "strict" filtering.
- `create_tanglegram()`: Generates HTML tanglegrams to visualize links between genomic regions.
- `create_network_for_gene()`: Extracts links for a specific gene (e.g., "pbp") to create network visualizations.
- `write_output_for_gwes_explorer()`: Exports data for the GWESExplorer web tool.
- `cleanup()`: Organizes the cluttered output directory into structured subfolders.

## Tips for Success

- **Alignment Size**: For robust results, use alignments with >500 sequences.
- **Short-range vs Long-range**: By default, `sr_dist` is 20,000 bp. Links within this distance are "short-range" and modeled against background LD; links beyond this are "long-range".
- **Reference Mismatch**: If your alignment is only a partial genome, set `validate_ref_ann_lengths = FALSE` to bypass sequence length validation.
- **Performance**: Use `save_additional_outputs = TRUE` to cache intermediate `.rds` files (SNPs, weights, diversity) and avoid re-computing during iterative runs.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)