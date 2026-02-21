---
name: mergevcf
description: mergevcf is a specialized Python utility for merging VCF files by identifying overlapping genomic calls.
homepage: https://github.com/ljdursi/mergevcf
---

# mergevcf

## Overview
mergevcf is a specialized Python utility for merging VCF files by identifying overlapping genomic calls. While it can handle general VCF merging, its primary strength lies in its handling of Structural Variants. It treats SVs as pairs of breakpoints and considers them identical if they fall within a user-specified distance. The tool provides clear provenance by adding a `Callers=` tag to the INFO field of the merged output, allowing researchers to track which specific caller or pipeline identified each variant.

## Command Line Usage

The basic syntax for mergevcf requires specifying labels for the input files followed by the paths to the VCF files themselves.

### Common Patterns

**Merging SVs from multiple callers:**
To merge results from three different pipelines (e.g., Broad, DKFZ, and Sanger) and require that at least two callers agree on a variant for it to be marked as PASS:
```bash
mergevcf -l broad,dkfz,sanger -n -m 2 svs_broad.vcf svs_dkfz.vcf svs_sanger.vcf > merged_svs.vcf
```

### Argument Reference
- `-l <labels>`: A comma-separated list of labels to identify the source of each VCF file. The order of labels must match the order of the input files.
- `-n`: Includes the number of callers that identified the variant in the output.
- `-m <int>`: Minimum support threshold. Variants seen by fewer than this number of callers will not be marked as PASS.
- `-v`: Enable verbose output for debugging the merging process.

## Best Practices and Expert Tips

### Provenance Tracking
Always use the `-l` flag. Without it, identifying which original file contributed a specific variant in the merged output becomes significantly more difficult. The resulting INFO field will contain `Callers=label1,label2` for merged entries.

### Structural Variant Normalization
The tool is specifically optimized for SVs. It normalizes breakpoints, which is critical because different callers often report slightly different coordinates for the same large-scale structural event. If you are merging simple SNPs or Indels, standard tools like `bcftools merge` may be faster, but for SVs, mergevcf's proximity-based logic is preferred.

### Known Limitations and Troubleshooting
- **Archived Status**: This tool is archived. If you encounter "Assertion Errors" on specific chromosomes (like chrX) or issues with modern `pysam` versions, consider using the improved fork `mergeSVvcf`.
- **Missing Genotypes**: Users have reported that the merged output may lack the GT (Genotype) field in certain configurations. Always verify the header and sample columns of your output if your downstream analysis requires genotype information.
- **Chromosome Naming**: Ensure all input VCFs use the same chromosome naming convention (e.g., all "chr1" or all "1") to avoid variants being treated as distinct due to string mismatches.

## Reference documentation
- [Merge VCFs README](./references/github_com_ljdursi_mergevcf.md)
- [Known Issues and Limitations](./references/github_com_ljdursi_mergevcf_issues.md)