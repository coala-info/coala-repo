---
name: constellations
description: This tool provides standardized SARS-CoV-2 mutation definitions and classification rules for the scorpio engine. Use when user asks to define mutation nomenclature, set lineage classification rules, or manage hierarchical relationships between viral variants.
homepage: https://github.com/cov-lineages/constellations
metadata:
  docker_image: "quay.io/biocontainers/constellations:0.1.12--pyh7cba7a3_0"
---

# constellations

## Overview
The constellations skill provides the procedural knowledge required to work with the standardized SARS-CoV-2 mutation definition sets maintained by the cov-lineages group. It focuses on the specific nomenclature for mutation strings and the logic rules used to classify genomic sequences. Use this skill to ensure that new variant definitions are compatible with the scorpio classification engine and to understand the hierarchical relationship between parent and child lineages in the constellation schema.

## Installation and Environment
The constellations package is primarily distributed via Bioconda. It functions as a data dependency for other bioinformatic tools.

```bash
# Install the constellations package
conda install bioconda::constellations
```

## Mutation Nomenclature
All mutations within a constellation must follow the specific string format: `gene:[ref]coordinates[alt]`.

- **gene**: The gene code (e.g., `S`, `N`, `ORF1ab`) or `nuc` for genomic nucleotide sequences.
- **ref**: The reference amino acid or nucleotide (optional).
- **coordinates**: The position within the feature.
- **alt**: The mutant amino acid or nucleotide (optional).

**Examples:**
- `S:N501Y` (Spike protein, Asparagine to Tyrosine at position 501)
- `nuc:C241T` (Nucleotide change at position 241)
- `N:S235F` (Nucleoprotein change)

## Defining Constellation Rules
Rules determine how the `scorpio` tool classifies a sequence based on the presence or absence of mutations.

### Threshold Rules
Use these to set minimum or maximum counts for specific types of calls:
- `min_alt`: Minimum number of mutant alleles required.
- `max_ref`: Maximum number of reference alleles allowed.
- `max_ambig`: Maximum number of ambiguous calls allowed.

### Mutation-Specific Rules
You can define requirements for specific sites:
- `"N:S235F": "alt"` (Requires the mutant state at this site)
- `"S:614": "ref"` (Requires the reference state at this site)
- `"S:144": "not ref"` (Requires any state other than reference)

## Lineage Hierarchy and Overrides
To manage the relationship between evolving variants, use the following logic:

- **lineage_name & parent_lineage**: Use these together to handle parent/child relationships. A child constellation is only called if the parent is also called.
- **incompatible_lineage_calls**: Use this to force a scorpio call to override a pangolin call. This is critical when a child lineage must meet a very specific definition that might otherwise be misclassified as the broader parent lineage.
- **mrca_lineage**: Specify the Pango lineage of the Most Recent Common Ancestor of the constellation.

## Best Practices for Definitions
- **Unique Labels**: Every constellation must have a unique `label` string.
- **Representative Genomes**: While optional, including a `representative_genome` helps in future-proofing the definition.
- **Haplotype Classification**: Use `ancestral_sites` to partition sites that predate the variant from those that define it. This prevents "scorpio haplotype" from miscounting defining mutations.
- **Intermediate Sites**: If a mutation appears in more than 25% but less than 98% of defining sequences, list it under `intermediate_sites` for manual curation.

## Reference documentation
- [bioconda / constellations](./references/anaconda_org_channels_bioconda_packages_constellations_overview.md)
- [cov-lineages / constellations README](./references/github_com_cov-lineages_constellations.md)