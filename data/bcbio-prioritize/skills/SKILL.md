---
name: bcbio-prioritize
description: bcbio-prioritize ranks and filters biological variants by cross-referencing callsets with known disease-relevant genes and pathways. Use when user asks to prioritize variant calls, identify missing sequencing coverage in critical regions, or create binned BED files from biological evidence sources like ClinVar and CIViC.
homepage: https://github.com/chapmanb/bcbio.prioritize
metadata:
  docker_image: "quay.io/biocontainers/bcbio-prioritize:0.0.8--2"
---

# bcbio-prioritize

## Overview

bcbio-prioritize is a specialized tool for biological variant prioritization. It allows researchers to focus on the most interesting signals within high-quality variant callsets by leveraging pre-existing knowledge of disease-relevant genes and pathways. The tool flattens comparisons to transcript-level bins, making it easier to evaluate the impact of both small variants and large structural variants (SVs). Beyond prioritization, it can identify "missing" regions where sequencing coverage is insufficient to make calls in critical genes.

## Command Line Usage

### 1. Creating Prioritization Regions
The `create` command generates a binned BED file of regions with biological evidence (e.g., from ClinVar, CIViC, or custom lists).

```bash
bcbio-prioritize create -o known.bed.gz -b transcript.bed -k evidence1.vcf -k evidence2.bed
```
- `-b`: A BED file of transcript regions used as bins.
- `-k`: Input files containing biological evidence (can be VCF or BED).
- `-o`: The resulting compressed prioritization BED file.

### 2. Prioritizing Variant Calls
Use the `known` command to cross-reference your sample calls against the prioritization regions created in the previous step.

```bash
bcbio-prioritize known -i sample_calls.vcf.gz -k known.bed.gz -o prioritized_output.vcf.gz
```
- Works with both VCF and BED inputs.
- For VCF outputs, the tool adds a `KNOWN` INFO field containing details on the biological hits.
- For large structural variants, the tool specifically annotates hits around the start and end coordinates (breakends) to better identify events like gene fusions.

### 3. Identifying Missing Coverage
To find regions of interest that lack sufficient sequencing depth:

```bash
bcbio-prioritize missing known.db coverage.db > missing_regions.bed
```

### 4. Updating Biological Evidence (CIViC)
You can generate prioritization files directly from the CIViC database for specific genome builds:

```bash
# Using Leiningen/Source
lein run create-civic --build GRCh37
lein run create-civic --build GRCh38
```

## Expert Tips and Best Practices

- **Large VCF Handling**: For very large VCF files, ensure `bcftools` is available in your PATH. bcbio-prioritize uses it to pre-select variants and improve processing speed.
- **Structural Variant Logic**: When dealing with breakends (BNDs), the tool is designed to carry along both sides of the breakend if at least one falls within a prioritized region, ensuring you don't lose the context of a translocation.
- **Input Normalization**: If using arbitrary BED files as input for prioritization, the tool handles BED6 by truncating to BED4. Ensure your gene names are in the 4th column for optimal results.
- **Memory Management**: If you encounter `OutOfMemoryError` on massive datasets, use the `known` command which avoids loading the entire intersection into memory, unlike earlier versions.

## Reference documentation
- [bcbio.prioritize README](./references/github_com_chapmanb_bcbio.prioritize.md)
- [Release Tags and Version History](./references/github_com_chapmanb_bcbio.prioritize_tags.md)