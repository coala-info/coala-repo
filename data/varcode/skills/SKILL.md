---
name: varcode
description: varcode analyzes genomic variants to predict their biological effects on proteins. Use when user asks to load genomic variants, group or filter variants, predict protein effects, or determine how variants alter amino acid sequences.
homepage: https://github.com/openvax/varcode
---


# varcode

## Overview
varcode is a Pythonic interface for genomic variant analysis that simplifies the process of mapping raw mutations to their biological effects. It acts as a bridge between genomic coordinates and protein-level changes, allowing researchers to programmatically determine how specific variants alter amino acid sequences. The library is particularly useful for high-throughput screening of mutation datasets where understanding the functional "effect" (e.g., whether a mutation causes a protein to truncate) is critical for downstream analysis.

## Installation and Setup
Before using varcode, you must install the library and the necessary reference genome data via `pyensembl`.

```python
# Installation
# pip install varcode
# or
# conda install bioconda::varcode

# Required: Download Ensembl reference data (e.g., releases 75 and 76)
# pyensembl install --release 75 76
```

## Core Workflow Patterns

### Loading and Inspecting Variants
The primary entry point is loading variant files (like MAF) into a `VariantCollection`.

```python
import varcode

# Load variants from a Mutation Annotation Format (MAF) file
variants = varcode.load_maf("data.maf")

# Basic inspection
print(f"Loaded {len(variants)} variants")
first_variant = variants[0]
print(first_variant.contig, first_variant.start, first_variant.ref, first_variant.alt)
```

### Grouping and Filtering
Use built-in methods to organize variants by biological context.

```python
# Group variants by gene name to analyze specific pathways
gene_groups = variants.groupby_gene_name()

# Extract variants for a specific gene of interest (e.g., TP53)
tp53_variants = gene_groups.get("TP53", [])
```

### Predicting Protein Effects
The `.effects()` method is the core functional tool, returning an `EffectCollection`.

```python
# Predict effects for all variants in a collection
effects = tp53_variants.effects()

# Filter for specific high-impact effects
stop_losses = [e for e in effects if "StopLoss" in str(type(e))]

# Access protein-level details
for effect in effects:
    if hasattr(effect, 'aa_mutation_start_offset'):
        print(f"Gene: {effect.gene_name} | Effect: {effect.short_description}")
        print(f"Mutant Sequence: {effect.mutant_protein_sequence[:10]}...")
```

## Expert Tips and Best Practices
- **Coordinate System Awareness**: varcode uses a **1-based, base-counted** genomic coordinate system to maintain consistency with Ensembl. Always verify your input data source (e.g., 0-based BED files) before loading to avoid off-by-one errors.
- **Memory Management**: When working with very large VCF or MAF files, use the `groupby` methods early to reduce the working set of variants in memory.
- **Effect Priority**: Not all transcripts for a gene will show the same effect for a single variant. `varcode` provides effects for all overlapping transcripts; you may need to filter for the "top" or "canonical" transcript effect depending on your research goals.
- **Reference Consistency**: Ensure the `genome` parameter in your variant objects matches the Ensembl release installed via `pyensembl`. Mismatched versions (e.g., GRCh37 vs GRCh38) will lead to incorrect effect predictions or lookup failures.

## Reference documentation
- [Library for manipulating genomic variants and predicting their effects](./references/github_com_openvax_varcode.md)
- [varcode - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_varcode_overview.md)