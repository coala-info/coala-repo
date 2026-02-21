---
name: optimir
description: OptimiR is a specialized alignment workflow designed for small RNA-seq data that integrates individual genetic information.
homepage: https://github.com/FlorianThibord/OptimiR
---

# optimir

## Overview
OptimiR is a specialized alignment workflow designed for small RNA-seq data that integrates individual genetic information. By incorporating VCF files, it generates personalized reference libraries containing "polymiRs"—alternative miRNA sequences that reflect the user's specific genetic variants. This approach improves alignment accuracy for variant-carrying reads and enables the quantification of Allele Specific Expression (ASE) and the characterization of post-transcriptional modifications (isomiRs).

## Core CLI Usage

### Primary Processing Workflow
The main entry point for alignment and quantification is the `process` command.

```bash
optimir process --fq /path/to/sample.fq.gz --dir_output /path/to/output/ --vcf /path/to/genotypes.vcf
```

### Key Arguments
- `--fq`: Path to the input fastq file (supports .gz).
- `--dir_output`: Directory where results and temporary files will be stored.
- `--vcf`: (Optional but recommended) VCF file containing variants to be integrated into the miRNA reference.
- `--rmTempFiles`: Use this flag to delete the `OptimiR_tmp` directory after a successful run to save disk space.
- `--trimAgain`: Forces re-trimming of adapters even if temporary files from a previous run exist.

## Best Practices and Expert Tips

### VCF and Genotype Integration
- **Sample Matching**: The sample name inside the VCF file must exactly match the basename of the fastq file (e.g., `sample1.fq.gz` requires sample name `sample1` in the VCF).
- **Coordinate System**: Ensure your VCF uses GRCh38 coordinates to remain compatible with default miRBase 21 GFF3 files.
- **Multi-allelic Variants**: OptimiR requires multi-allelic variants to be decomposed into separate lines.
- **Genotype Format**: Use standard formats like `0/0`, `0/1`, `1/0`, or `1/1`. Complex genotypes like `0/2` are not supported.

### Analyzing Results
OptimiR produces three main output directories:
1. **OptimiR_lib**: Contains the generated fasta sequences for miRs and polymiRs, along with alignment indexes.
2. **OptimiR_Results**: Contains the final abundance tables.
   - `polymiRs_table`: Detailed counts for reference vs. alternative alleles.
   - `consistency_table`: Indicates if alignments match the provided genotypes (useful for filtering noise).
   - `isomiRs_dist`: Distribution of modifications (Trimming, Templated Tailing, Non-Templated Tailing).
3. **3_PostProcess**: Located within the output directory, this contains the final BAM alignment files.

### Visualization
Use the provided R scripts located in `optimir/libs/R_plot/` to generate publication-ready figures:
- **ASE Analysis**: Run `plot_ASE.R` on the `polymiRs_table.annot` file to visualize reference vs. alternative allele counts in heterozygotes.
- **isomiR Distribution**: Run `plot_isoDist.R` on the `isomiRs_dist.annot` file to see the landscape of miRNA modifications.

### Performance Optimization
- **Caching**: OptimiR uses a pickle directory in `OptimiR_lib` to store library objects. If you run multiple samples against the same VCF/Reference, OptimiR will skip the library generation step, significantly reducing computation time.
- **Resuming**: If a run is interrupted, keeping the `OptimiR_tmp` folder allows the tool to skip the trimming and collapsing steps upon restart.

## Reference documentation
- [OptimiR GitHub Repository](./references/github_com_Florian_Thibord_OptimiR.md)
- [OptimiR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_optimir_overview.md)