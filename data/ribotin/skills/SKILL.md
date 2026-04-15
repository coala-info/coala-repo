---
name: ribotin
description: ribotin resolves the complex, repetitive structure of ribosomal DNA to produce high-quality consensus sequences from long-read sequencing data. Use when user asks to assemble rDNA morphs, resolve rDNA tangles from Verkko or hifiasm assemblies, or generate accurate rDNA representations using HiFi and ONT reads.
homepage: https://github.com/maickrau/ribotin
metadata:
  docker_image: "quay.io/biocontainers/ribotin:1.5--h077b44d_0"
---

# ribotin

## Overview
ribotin is a specialized tool designed to resolve the complex, repetitive structure of ribosomal DNA (rDNA). It works by identifying rDNA-specific reads through k-mer matching against a reference or by leveraging the topology of assembly graphs. The tool produces high-quality consensus sequences and can resolve highly abundant rDNA morphs when provided with ultralong Oxford Nanopore (ONT) reads. It is particularly effective for generating accurate rDNA representations that are often collapsed or misassembled in standard whole-genome assembly pipelines.

## CLI Usage Patterns

### Reference-Based Assembly
Use `ribotin-ref` when you have raw reads but no existing assembly.

```bash
# Basic human rDNA assembly with HiFi and ONT reads
ribotin-ref -x human -i hifi_reads.fa --nano ont_reads.fa -o output_dir

# Non-human assembly (requires an example morph and size estimate)
ribotin-ref --approx-morphsize 45000 -r reference_morphs.fa -i hifi_reads.fa -o output_dir
```

### Assembly-Integrated Workflows
Use these modes to extract rDNA tangles directly from graph-based assemblies.

**Verkko Integration:**
```bash
# Automatic detection from a Verkko output directory
ribotin-verkko -x human -i /path/to/verkko_assembly/ -o output_prefix
```

**hifiasm Integration:**
```bash
# Automatic detection using hifiasm assembly prefix and original reads
ribotin-hifiasm -x human -a /path/to/hifiasm_prefix -i hifi_reads.fa --nano ont_reads.fa -o output_prefix
```

### Manual Tangle Selection
If automatic detection fails to isolate the rDNA tangle, provide specific nodes from the assembly GFA.

```bash
# Manual node selection (nodes in tangle.txt should be space or line separated)
ribotin-verkko -x human -i /path/to/verkko/ -o output_prefix -c tangle1_nodes.txt -c tangle2_nodes.txt
```

## Expert Tips and Best Practices

*   **Species with Short Morphs**: For species with rDNA morphs <10kb, you can achieve extremely high accuracy by using HiFi reads for both the `-i` and `--nano` inputs. Adjust clustering parameters to resolve fine-scale differences:
    `--morph-cluster-maxedit 10 --morph-recluster-minedit 1`
*   **Consistent Orientation**: When comparing multiple samples, use `--orient-by-reference single_morph.fa` to ensure all resulting consensuses use the same forward/reverse orientation and starting offset.
*   **Non-Human References**: If a complete reference is unavailable for a non-human species, you can generate a partial reference by performing a quick HiFi-only assembly (e.g., using MBG) and extracting sequences from the identified rDNA tangle.
*   **Output Interpretation**: The primary assembled morphs are found in `morphs.fa`. This file includes the sequences and their corresponding ONT coverage levels, which helps distinguish between major and minor rDNA variants.



## Subcommands

| Command | Description |
|---------|-------------|
| ribotin-hifiasm | A tool for assembling genomes using hifiasm, with support for various read types and advanced phasing options. |
| ribotin-ref | Ribotin reference-based analysis |
| ribotin-verkko | ribotin-verkko version bioconda 1.5 |

## Reference documentation
- [ribotin GitHub README](./references/github_com_maickrau_ribotin_blob_master_README.md)
- [ribotin Makefile and Dependencies](./references/github_com_maickrau_ribotin_blob_master_makefile.md)