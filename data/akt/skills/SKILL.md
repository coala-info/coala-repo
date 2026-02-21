name: akt
description: Ancestry and Kinship Tools (AKT) for statistical genetics. Use when analyzing VCF/BCF files to perform Principal Component Analysis (PCA), calculate kinship coefficients, discover pedigrees, identify unrelated individuals, or perform Mendelian phasing.

# AKT (Ancestry and Kinship Tools)

AKT provides high-performance statistical genetics routines using the htslib API. It is designed to work seamlessly with VCF/BCF files and integrates well into bioinformatics pipelines alongside `bcftools`.

## Core Commands

### Principal Component Analysis (PCA)
Used for population structure analysis and ancestry inference.

- **Standard PCA**:
  `akt pca -R <sites.vcf.gz> <input.bcf> > pca.txt`
- **Project onto 1000 Genomes**:
  `akt pca -W <1000G_reference.vcf.gz> <input.bcf> > 1000G_projections.txt`

### Kinship and Relatedness
Used to identify family relationships or verify sample identity.

- **Calculate Kinship Coefficients**:
  `akt kin -R <sites.vcf.gz> -M 1 <input.bcf> > kinship.txt`
  *Note: `-M 1` uses the robust KING-robust estimator.*
- **Identify Duplicates**:
  `awk '$6 > 0.4' kinship.txt` (Filters for samples with kinship > 0.4, indicating duplicates or MZ twins).

### Pedigree Reconstruction
Used to build family trees from kinship data.

- **Discover Pedigrees**:
  `akt relatives <kinship.txt> -p <output_prefix>`
- **Generate Unrelated Set**:
  `akt unrelated <kinship.txt> > unrelated.ids`
  *Useful for selecting a subset of samples for association studies to avoid inflation.*

### Phasing
- **Mendelian Phasing**:
  `akt pedphase <input.bcf> > phased.vcf`
  *Performs transmission phasing for duos and trios.*

## Expert Tips & Best Practices

### Reference Sites (-R)
Always use a high-quality set of reference sites (e.g., WGS variants from GRCh37/38) with the `-R` flag. This ensures AKT focuses on informative, common SNPs and significantly speeds up processing by skipping rare or noisy variants.

### Performance
- AKT is multi-threaded. Use the `-n` option in `akt kin` and `akt ibd` to specify the number of threads.
- If running on macOS or systems where OpenMP is unavailable, ensure the binary was compiled with `make no_omp` (though this limits execution to a single thread).

### Input Handling
- AKT reads both VCF and BCF. For large-scale analyses, prefer BCF for faster I/O.
- Ensure input files are indexed (`tabix` for VCF, `bcftools index` for BCF) for efficient random access when using reference sites.

### Downstream Analysis
AKT output is typically tab-delimited text.
- Use `scripts/pca.R` (found in the AKT repository) to quickly visualize PCA results.
- Use `scripts/1000G_pca.R` for plotting projections against the 1000 Genomes reference.