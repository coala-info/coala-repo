---
name: cats-rb
description: CATS-rb benchmarks transcriptome assemblies by mapping transcripts to a reference genome to assess biological completeness. Use when user asks to index a reference genome, map transcriptome assemblies, compare relative completeness between multiple assemblies, or evaluate assembly quality against a reference annotation.
homepage: https://github.com/bodulic/CATS-rb
---


# cats-rb

## Overview
CATS-rb (Comprehensive Assessment of Transcript Sequences - reference-based) is a specialized tool for benchmarking transcriptome assemblies. Unlike general assembly metrics (like N50), CATS-rb focuses on biological completeness by mapping transcripts to a reference genome and collapsing overlapping coordinates into non-redundant "element sets" (exons and transcripts). It provides normalized scores (0 to 1) and detailed visualizations to help researchers determine which assembly best represents the underlying biology of the target species.

## Core Workflow
The CATS-rb pipeline consists of three primary stages that must be executed in sequence.

### 1. Indexing the Reference
Prepare the reference genome for mapping.
```bash
CATS_rb_index -g reference_genome.fasta -o index_directory
```

### 2. Mapping Transcripts
Map your transcriptome assembly (FASTA) to the indexed reference. This step must be performed for each assembly you wish to evaluate.
```bash
CATS_rb_map -i index_directory -t assembly.fasta -o mapping_output_dir
```

### 3. Comparison and Scoring
Generate completeness scores and visualizations. This can be done in two modes:

**Relative Completeness (Comparing 2+ assemblies):**
Use this when you want to see which assembly is more complete relative to the others.
```bash
CATS_rb_compare -m "assembly1_dir,assembly2_dir" -n "Name1,Name2" -o comparison_results
```

**Annotation-based Completeness (1+ assemblies vs. GTF):**
Use this for an absolute measure of completeness against a known "gold standard" annotation.
```bash
CATS_rb_compare -m "assembly1_dir" -n "Name1" -a reference_annotation.gtf -o comparison_results
```

## Best Practices and Tips
- **Input Formats**: Ensure your reference genome is in FASTA format and your annotations are in GTF or GFF3 format.
- **Naming Consistency**: When running `CATS_rb_compare`, the order of names in the `-n` flag must strictly match the order of mapping directories in the `-m` flag.
- **Closely Related Species**: While designed for the same species, CATS-rb can be used with a closely related species' genome if a high-quality reference for the target species is unavailable.
- **Interpreting Scores**:
    - **Exon Score**: Reflects the recovery of individual coding/non-coding segments.
    - **Transcript Score**: Reflects the recovery of full-length isoforms.
    - Scores closer to 1.0 indicate higher similarity to the reference or higher relative completeness.
- **Visualizations**: The tool produces an HTML report. Look for the UpSet plots and Venn diagrams to identify specific transcriptomic elements that are unique to one assembly or missing across all versions.

## Troubleshooting
- **Dependency Errors**: CATS-rb relies heavily on R and the `spaln` aligner. If running from source, ensure `spaln` is in your `$PATH`.
- **Memory Issues**: Mapping large transcriptomes to large genomes can be memory-intensive. If running via Docker/Singularity, ensure the container has access to sufficient RAM.

## Reference documentation
- [GitHub - bodulic/CATS-rb](./references/github_com_bodulic_CATS-rb.md)
- [anaconda.org - cats-rb overview](./references/anaconda_org_channels_bioconda_packages_cats-rb_overview.md)