---
name: surpyvor
description: Surpyvor is a Python utility that wraps the SURVIVOR toolset to manage, merge, and evaluate structural variant callsets. Use when user asks to merge VCF files, identify intersections or unions of variants, calculate performance metrics like precision and recall, or generate Venn and UpSet plots for variant overlaps.
homepage: https://github.com/wdecoster/surpyvor
metadata:
  docker_image: "quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0"
---

# surpyvor

## Overview
`surpyvor` is a Python-based utility designed to streamline the management of structural variant (SV) data. By wrapping the `SURVIVOR` toolset, it provides a more accessible interface for complex operations such as merging VCF files, identifying intersections (high confidence) or unions (high sensitivity) of variants, and performing rigorous performance evaluations. It includes built-in support for generating publication-quality plots to visualize callset overlaps.

## Common CLI Patterns

### Merging and Intersecting Callsets
- **Merge multiple VCFs**: Combine SV calls from different tools or samples.
  `surpyvor merge --variants callset1.vcf callset2.vcf -o merged.vcf`
- **High Confidence (Intersection)**: Extract variants present in all provided VCFs.
  `surpyvor highconf --variants caller1.vcf caller2.vcf caller3.vcf -o intersection.vcf`
- **High Sensitivity (Union)**: Create a union of all variants across callsets.
  `surpyvor highsens --variants caller1.vcf caller2.vcf -o union.vcf`

### Performance Evaluation (PRF)
Calculate precision, recall, and F-measure by comparing a query VCF against a truth set.
`surpyvor prf --variants truth.vcf query.vcf --matrix --bar`
- Use `--ignore_chroms` to exclude non-canonical contigs (default: `chrEBV`).

### Visualization
- **Venn Diagram**: Compare 2 or 3 VCF files.
  `surpyvor venn --variants a.vcf b.vcf c.vcf --plotout overlap_venn.png`
- **UpSet Plot**: Visualize intersections for more than 3 VCF files.
  `surpyvor upset --variants v1.vcf v2.vcf v3.vcf v4.vcf --plotout upset_plot.png`

## Tool-Specific Best Practices
- **Distance Parameter**: The default distance for considering SVs concordant is 500bp (`-d 500`). For high-accuracy long-read callers, consider reducing this to 100-200bp to minimize false matches.
- **Minimum Length**: By default, `surpyvor` filters out variants shorter than 50bp (`-l 50`). Adjust this if your analysis includes smaller indels.
- **Environment Setup**: Ensure `SURVIVOR`, `bcftools`, `bgzip`, and `tabix` are available in your system's `$PATH`, as `surpyvor` relies on these binaries for core processing.
- **Output Handling**: Most commands default to `stdout`. Always specify `-o` or `--output` for VCF results to avoid terminal flooding.
- **SNV Mode**: For merging small variants using `bcftools` logic through the wrapper, use the `--snv` flag if supported by your version.



## Subcommands

| Command | Description |
|---------|-------------|
| surpyvor highconf | Merge variants from multiple VCF files, considering high confidence variants. |
| surpyvor highsens | Merge variants from multiple VCF files. |
| surpyvor lengthplot | Plot variant lengths from a VCF file. |
| surpyvor minlen | Filter SVs by minimum length |
| surpyvor prf | Calculate performance metrics for structural variant calls. |
| surpyvor purge2d | Filter alignments from a BAM file. |
| surpyvor svlentruncate | Truncates SVLEN in VCF files. |
| surpyvor upset | Generate upset plots for structural variants |
| surpyvor varcount | VCF to plot from |
| surpyvor venn | Generate Venn diagrams of structural variants from multiple VCF files. |
| surpyvor_carrierplot | Plot carrier plots from VCF files. |
| surpyvor_fixref | Fixes reference sequences in a VCF file. |
| surpyvor_fixvcf | Fix problems related to using jasmine |
| surpyvor_haplomerge | Merge VCF files from multiple callers. |
| surpyvor_merge | Merge VCF files from multiple callers. |

## Reference documentation
- [surpyvor README](./references/github_com_wdecoster_surpyvor_blob_master_README.md)
- [surpyvor Setup and Dependencies](./references/github_com_wdecoster_surpyvor_blob_master_setup.py.md)