---
name: stringtie
description: StringTie assembles RNA-Seq alignments into full-length transcripts and quantifies their expression levels using a network flow algorithm. Use when user asks to assemble transcripts, quantify gene expression, merge multiple sample assemblies, or process long-read and hybrid RNA-Seq datasets.
homepage: https://ccb.jhu.edu/software/stringtie
---


# stringtie

## Overview
StringTie is a highly efficient bioinformatic tool designed to assemble RNA-Seq alignments into full-length transcripts and quantify their expression levels. It utilizes a network flow algorithm to resolve complex splice graphs, making it particularly effective at identifying alternative splicing events and novel isoforms. This skill provides the procedural knowledge required to execute standard assembly, reference-guided quantification, and multi-sample merging workflows.

## Core Workflows

### 1. Standard Transcript Assembly
Use this for de novo or reference-guided assembly of a single sample.
- **Input**: Coordinate-sorted BAM/CRAM file.
- **Command**: `stringtie <input.bam> -o <output.gtf> [options]`

**Key Options:**
- `-G <ref.gtf>`: Use a reference annotation to guide assembly (highly recommended).
- `-p <int>`: Enable multi-threading (default is 1).
- `-l <label>`: Set a custom prefix for output transcript IDs (default: `STRG`).

### 2. Expression Estimation Mode (`-e`)
Use this when you only want to quantify the expression of known transcripts from a reference GTF, without assembling new ones.
- **Requirement**: Must be used with `-G`.
- **Command**: `stringtie -e -G <ref.gtf> <input.bam> -o <output.gtf>`

### 3. Long-Read and Mixed-Read Assembly
StringTie supports specialized algorithms for long-read data (PacBio/ONT) or hybrid datasets.
- **Long-reads only**: `stringtie -L <long_reads.bam> -o <output.gtf>`
- **Mixed-reads**: `stringtie --mix <short_reads.bam> <long_reads.bam> -o <output.gtf>`
  - *Note*: In `--mix` mode, short reads must be the first positional BAM and long reads the second.

### 4. Multi-Sample Merge Workflow
To perform differential expression, you must first create a unified transcriptome across all samples.
1. **Assemble** each sample individually.
2. **Merge**: `stringtie --merge -G <ref.gtf> -o <merged.gtf> <assembly_list.txt>`
   - `<assembly_list.txt>` is a file containing the paths to all individual GTF files.
3. **Re-quantify**: Run StringTie with `-e -G <merged.gtf>` on each original BAM file to get consistent counts.

## Expert Tips and Best Practices

### Library Prep Awareness
Always specify the library type if your RNA-Seq data is stranded to improve assembly accuracy:
- `--rf`: For `fr-firststrand` (e.g., dUTP, TruSeq stranded).
- `--fr`: For `fr-secondstrand`.

### Handling High-Coverage Contaminants
If mitochondrial or ribosomal RNA coverage is extremely high and causing performance bottlenecks, use the `-x` flag to ignore those contigs:
- `stringtie -x "chrM,chrMT" <input.bam> -o <output.gtf>`

### Downstream Integration
- **Ballgown**: Use the `-B` or `-b <path>` flag during the final quantification step to generate `.ctab` files.
- **DESeq2/edgeR**: Use the `prepDE.py` script (provided in the StringTie package) on the GTF outputs to generate count matrices.
- **Validation**: Use `gffread` to extract transcript sequences or `gffcompare` to evaluate assembly accuracy against a reference.

### Performance Tuning
- **Memory**: StringTie is memory-efficient, but very complex loci (e.g., in long-read data) can occasionally spike.
- **Trimming**: By default, StringTie trims transcript ends based on coverage drops. Use `-t` to disable this if you believe your alignments already represent full-length boundaries accurately.

## Reference documentation
- [StringTie Manual](./references/ccb_jhu_edu_software_stringtie_index.shtml_1.md)
- [GFF/GTF Format Handling](./references/ccb_jhu_edu_software_stringtie_gff.shtml.md)
- [Release History and Version Features](./references/ccb_jhu_edu_software_stringtie_history.shtml.md)