---
name: genmod
description: genmod is a bioinformatics suite that automates the annotation and analysis of genetic inheritance patterns in VCF files. Use when user asks to identify Mendelian inheritance models, annotate variants with CADD scores or population frequencies, and filter or sort genetic variants based on functional scores.
homepage: http://github.com/moonso/genmod
---

# genmod

## Overview

genmod is a specialized bioinformatics suite designed to automate the annotation and analysis of genetic inheritance patterns in VCF files. It is particularly powerful for family-based genomics, allowing researchers to identify variants that follow specific Mendelian models (such as Autosomal Recessive, Dominant, or X-linked) across pedigrees of arbitrary size. Beyond inheritance modeling, it provides utilities for functional annotation, variant scoring, and high-performance filtering.

## Core Workflows

### 1. Standard Annotation Pipeline
The most common workflow involves annotating gene regions followed by inheritance model analysis.

```bash
# Annotate regions and then identify genetic models
cat input.vcf | \
  genmod annotate - --annotate_regions | \
  genmod models - --family_file family.ped > annotated_output.vcf
```

### 2. Annotating External Data
Enhance VCFs with frequency and pathogenicity data:
- **CADD Scores**: `genmod annotate <vcf> --cadd_file <path_to_cadd.tsv.gz>`
- **Population Frequencies**: Use `--thousand_g <vcf>` or `--exac <vcf>` to add allele frequency data.
- **Custom Regions**: Use `-a <dir>` to point to a custom annotation directory built via `genmod build`.

### 3. Genetic Model Analysis (`genmod models`)
This command requires a pedigree file (`.ped` or `.family`).
- **Strict Mode**: Use `-s/--strict` to only annotate models where there is "proof" (all individuals must have non-missing genotype calls).
- **Phased Data**: Use `--phased` if your VCF is phased. This significantly improves the accuracy of Autosomal Compound Heterozygote (`AR_comp`) detection by ensuring variants are on different alleles.
- **Reduced Penetrance**: Provide a TSV of gene IDs using `-r <file.tsv>` to allow healthy carriers in Autosomal Dominant models.

### 4. Filtering and Sorting
Once annotated, use these tools to prioritize variants:
- **Filter by Score**: `genmod filter <vcf> -a CADD -t 15 --greater --discard` (keeps variants with CADD > 15 and removes those missing the score).
- **Sort by Rank**: `genmod sort <vcf> --rank_score` (useful after running `genmod score`).

## Expert Tips

- **Compound Heterozygotes**: By default, `genmod` looks for compound heterozygotes only in exonic or canonical splice sites to reduce noise. To check the entire gene body, use the `--whole_gene` flag (if available in your version) or ensure your region annotations include intronic areas.
- **Performance**: Use the `-p/--processes` flag to enable multithreading. However, if you need to maintain VCF record order during streaming, set `-p 1`.
- **Keyword Matching**: If your VCF already has gene annotations under a different INFO key (e.g., "Gene"), use `-k Gene` in the `models` command so `genmod` knows which variants belong to the same functional unit.
- **X-Linked Logic**: `genmod` accounts for X-inactivation; it allows healthy females to be carriers in X-Linked Dominant models, whereas healthy males cannot carry the variant.



## Subcommands

| Command | Description |
|---------|-------------|
| genmod annotate | Annotate vcf variants. |
| genmod compound | Score compound variants in a vcf file based on their rank score. |
| genmod filter | Filter vcf variants. |
| genmod models | Annotate genetic models for vcf variants. |
| genmod score | Score variants in a vcf file using a Weighted Sum Model. |
| genmod_sort | Sort a VCF file based on rank score. |

## Reference documentation
- [Genmod Overview](./references/clinical-genomics_github_io_genmod.md)
- [Annotating Patterns of Inheritance](./references/clinical-genomics_github_io_genmod_commands_annotate-models.md)
- [Genetic Models and Conditions](./references/clinical-genomics_github_io_genmod_genetic-models.md)
- [Annotate Variants CLI](./references/clinical-genomics_github_io_genmod_commands_annotate-variants.md)
- [Filtering Variants](./references/clinical-genomics_github_io_genmod_commands_filter-variants.md)