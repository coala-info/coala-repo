---
name: peddy
description: Peddy validates the integrity of human genomic datasets by comparing reported familial relationships and sex against actual genotypes. Use when user asks to check for sample swaps, verify pedigree information, predict ancestry, or perform sex-check quality control on VCF files.
homepage: https://github.com/brentp/peddy
metadata:
  docker_image: "quay.io/biocontainers/peddy:0.4.8--pyh5e36f6f_0"
---

# peddy

## Overview

Peddy is a high-performance tool for validating the integrity of human genomic datasets. It compares familial relationships and sex as reported in a PED/FAM file against the actual genotypes found in a VCF. By sampling approximately 25,000 sites (plus chrX) and using 1000 Genomes project data as a background, it provides rapid estimates of relatedness, heterozygosity, sex, and ancestry. It is particularly useful for identifying sample anomalies before proceeding with downstream genetic analysis.

## Usage Instructions

### Basic Command Pattern
The most common way to run peddy is as a module. You must provide a VCF file and a corresponding PED file.

```bash
python -m peddy -p 4 --plot --prefix my_study data/input.vcf.gz data/input.ped
```

### Key Arguments
- `-p, --procs`: Number of CPUs to use. For most datasets, 4 processors provide the best balance of speed.
- `--plot`: Generates interactive HTML reports and static QC plots.
- `--prefix`: The string used to name all output files.
- `--sites`: Specifies the genome build. Defaults to `hg19`. Use `hg38` for newer builds.

### Handling Different Genome Builds
Peddy defaults to GRCh37/hg19. If your data is aligned to hg38, you must specify it explicitly:

```bash
python -m peddy --sites hg38 -p 4 --plot --prefix study_hg38 input.vcf.gz input.ped
```

### Interpreting Outputs
Peddy generates several files that help identify problems:
1. **Interactive HTML (`<prefix>.html`)**: A browser-based dashboard to explore relatedness, sex, and ancestry plots.
2. **Extended PED file (`<prefix>.peddy.ped`)**: A version of your input PED file appended with QC metrics like heterozygosity and sex-check results. **Check this file first** for a quick overview of likely problems.
3. **CSV Files**: Detailed data for heterozygosity, sex, ancestry, and relatedness checks.

## Best Practices and Tips

- **Sample Swaps**: Use the `relatedness` plot in the HTML report to find samples that are more or less related than their pedigree suggests.
- **Sex Checks**: Peddy uses heterozygosity on chrX to infer sex. Discrepancies often indicate sample swaps or chromosomal abnormalities.
- **Ancestry Prediction**: Peddy projects your samples onto the principal components of the 1000 Genomes samples to predict ancestry. This is useful for identifying outliers in supposedly homogeneous cohorts.
- **Performance**: For small cohorts (dozens of samples), 4 cores are sufficient. For larger cohorts (hundreds or thousands), increase the core count to reduce computation time.
- **Alternative**: For extremely large-scale datasets where peddy might be slow, consider using `somalier`, which is a faster, more scalable replacement by the same author.

## Reference documentation
- [Peddy GitHub Repository](./references/github_com_brentp_peddy.md)
- [Bioconda Peddy Package Overview](./references/anaconda_org_channels_bioconda_packages_peddy_overview.md)