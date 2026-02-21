---
name: genmod
description: `genmod` is a specialized bioinformatics suite for the functional annotation and inheritance modeling of genomic variants.
homepage: http://github.com/moonso/genmod
---

# genmod

## Overview

`genmod` is a specialized bioinformatics suite for the functional annotation and inheritance modeling of genomic variants. It allows researchers to move beyond simple variant calling by identifying how specific mutations segregate within families and scoring them based on their predicted impact. It is highly efficient, utilizing multithreading to process whole-exome or whole-genome data rapidly.

## Common CLI Patterns

### Basic Annotation and Modeling
The most common workflow involves annotating gene regions and then identifying inheritance models using a pedigree (.ped) file.

```bash
# Annotate regions and inheritance models in a single pipeline
cat study_group.vcf | \
  genmod annotate - --annotate-regions | \
  genmod models - --family_file family_trio.ped > annotated_variants.vcf
```

### Building Custom Annotations
If working with non-human organisms or specific gene sets, use the build tool to create a compatible annotation database.

```bash
genmod build_annotation <annotation_source_file> -t <type> -o <output_directory>
```

### Sorting and Scoring
After annotation, variants can be sorted by genomic position or rank score, and then filtered.

```bash
# Sort variants by rank score
genmod sort annotated_variants.vcf --sort_key rank_score > sorted_variants.vcf

# Score variants based on existing annotations
genmod score sorted_variants.vcf > scored_variants.vcf
```

## Tool-Specific Best Practices

- **Standard Input/Output**: Use the `-` character to represent stdin or stdout when chaining commands. This avoids creating massive intermediate VCF files on disk.
- **Pedigree Files**: Ensure your `.ped` (or `.family`) file follows standard Linkage format. `genmod models` relies on this to correctly identify inheritance patterns like `AR_hom` (Autosomal Recessive Homozygous) or `AR_comp` (Compound Heterozygote).
- **Annotation Keys**: By default, `genmod` uses the `Annotation` key in the VCF INFO field for gene names. If you use custom annotations, you can specify the keyword using the `--keyword` flag.
- **Performance**: `genmod` is multithreaded by default. For large datasets (WGS), ensure the environment has sufficient CPU cores to take advantage of the parallel processing of chromosome chunks.
- **Compound Heterozygotes**: To identify compound heterozygotes, `genmod models` must be used. It will add a `Compounds` entry to the INFO field listing the variant pairs.

## Reference documentation
- [genmod GitHub Overview](./references/github_com_Clinical-Genomics_genmod.md)
- [genmod Wiki: Annotate](./references/github_com_Clinical-Genomics_genmod_wiki_Annotate.md)
- [genmod Wiki: Build Annotation](./references/github_com_Clinical-Genomics_genmod_wiki_Build-Annotation.md)