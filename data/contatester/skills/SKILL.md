---
name: contatester
description: contatester assesses the purity of human genomic samples by identifying and estimating cross-contamination within VCF files. Use when user asks to assess sample purity, identify cross-contamination between individuals, or estimate contamination levels in NGS data.
homepage: https://github.com/CNRGH/contatester
metadata:
  docker_image: "quay.io/biocontainers/contatester:1.0.0--py311r44he3b539c_4"
---

# contatester

## Overview
contatester is a specialized bioinformatics utility used to assess the purity of human genomic samples. By analyzing the distribution of alleles within a VCF file, it identifies potential cross-contamination between individuals and estimates the degree of that contamination. This tool is a critical quality control step in Next-Generation Sequencing (NGS) pipelines to ensure that downstream variant calls are not compromised by sample mixing.

## Command Line Usage

### Basic Syntax
The tool requires either a single VCF file or a list of files.

```bash
# Analyze a single VCF file (Whole Genome by default)
contatester -f input.vcf.gz -o ./output_dir

# Analyze a list of VCF files (one path per line)
contatester -l vcf_list.txt -o ./output_dir
```

### Core Arguments
- `-f, --file`: Path to a VCF file (version 4.2).
- `-l, --list`: Path to a text file containing a list of VCFs (one per lane).
- `-e, --experiment`: Specify `WG` (Whole Genome) or `EX` (Exome). Default is `WG`.
- `-r, --report`: Generates a PDF report visualizing the contamination estimation.
- `-s, --threshold`: Set the threshold for "contaminated" status. Default is `4`.
- `-c, --check`: Enables a specific check for each provided VCF.

### Common Workflow Patterns

**Exome Analysis with Reporting**
When working with Exome data, always specify the experiment type to ensure the allelic balance calculations use appropriate genomic context.
```bash
contatester -f sample_exome.vcf.gz -e EX -r -o ./reports
```

**High-Efficiency Batch Processing**
For large cohorts, use the list input and adjust threading. Note that if `-c` is enabled, the default thread count increases from 1 to 4.
```bash
contatester -l cohort_vcfs.txt -t 8 -c -o ./batch_results
```

## Best Practices and Expert Tips

1. **VCF Requirements**: Ensure your VCF files are version 4.2. The tool relies on specific fields to calculate allelic balance; if your VCF is missing depth (DP) or allelic depth (AD) information, the results may be inaccurate or the tool may fail.
2. **Threshold Tuning**: The default threshold (`-s 4`) is a general starting point. If you are working with highly sensitive clinical samples or low-input DNA, you may need to lower this threshold to catch subtle contamination.
3. **Environment Dependencies**: contatester requires `bcftools` (>= 1.9), `R` (3.3.1+), and `pegasus` (>= 4.8.2) to be available in your environment. If running via Conda, these should be handled automatically.
4. **PDF Reports**: Always use the `-r` flag during initial quality control. The visual representation of allelic balance is often more intuitive for identifying "noisy" samples than the raw numerical output.
5. **Docker Usage**: If you encounter dependency conflicts (especially with R libraries), use the official Docker image:
   ```bash
   docker run --rm -v $(pwd):/data cnrgh/contatester:1.0.0 -f /data/input.vcf.gz -o /data/results
   ```

## Reference documentation
- [contatester GitHub Repository](./references/github_com_CNRGH_contatester.md)
- [Bioconda contatester Overview](./references/anaconda_org_channels_bioconda_packages_contatester_overview.md)