---
name: melon
description: Melon is a bioinformatic tool designed for high-resolution taxonomic profiling of long-read metagenomic datasets.
homepage: https://github.com/xinehc/melon
---

# melon

## Overview
Melon is a bioinformatic tool designed for high-resolution taxonomic profiling of long-read metagenomic datasets. Unlike traditional k-mer based approaches, Melon utilizes marker genes to provide more accurate quantification of genome copies and relative abundances. It is particularly effective for analyzing complex microbial communities where species-level resolution and mean genome size estimation are required.

## Installation and Setup
Install Melon via Bioconda:
```bash
conda create -n melon -c conda-forge -c bioconda melon
conda activate melon
```

### Database Preparation
Melon requires either the NCBI or GTDB database. After downloading, the files must be indexed using `diamond` and `minimap2`.

1. **Download (NCBI Example):**
   ```bash
   wget https://zenodo.org/records/15231351/files/database.tar.gz
   tar -zxvf database.tar.gz
   ```

2. **Indexing:**
   ```bash
   # Index protein database for Diamond
   diamond makedb --in database/prot.fa --db database/prot

   # Index nucleotide files for Minimap2
   ls database/nucl.*.fa | xargs -I {} minimap2 -x map-ont -d database/{}.mmi {}
   ```

## Usage Patterns

### Basic Taxonomic Profiling
Run Melon on quality-controlled long reads:
```bash
melon input_reads.fa.gz -d /path/to/database_dir -o /path/to/output_dir
```

### Pre-filtering Non-Prokaryotic Reads
To improve accuracy in samples with high host (human) or viral contamination, use the Kraken2 pre-filtering module:
```bash
melon input_reads.fa.gz -d database -o . -k /path/to/kraken2_db
```

### Quality Control Recommendations
For optimal results, input reads should be pre-processed to remove low-quality data. Recommended thresholds:
- **Minimum Quality Score:** 10
- **Minimum Read Length:** 1,000 bp
- **Tools:** Use `nanoq` or `Porechop` before running Melon.

## Interpreting Outputs
- **.tsv file:** Contains species-level data including estimated genome copies, relative abundance, and ANI values (gap-compressed and uncompressed).
- **.json file:** Provides the specific taxonomic lineage and classification remark for every processed read.

## Expert Tips
- **Memory Management:** If indexing fails due to memory constraints, manually set the CPU count to 1 or lower the thread count.
- **Database Compatibility:** Ensure your database version matches the Melon version; databases released after 2025-04-16 require Melon v0.3.0 or higher.
- **Genome Size Estimation:** Use the pre-filtering module (`-k`) if you need an accurate estimation of the mean genome size of the prokaryotic fraction in a host-associated sample.

## Reference documentation
- [Melon GitHub Repository](./references/github_com_xinehc_melon.md)
- [Bioconda Melon Overview](./references/anaconda_org_channels_bioconda_packages_melon_overview.md)