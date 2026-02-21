---
name: bbmap
description: Fast and accurate splice-aware read aligner.
homepage: https://sourceforge.net/projects/bbmap
---

# bbmap

## Overview
BBTools is a high-performance suite of Java-based bioinformatics tools designed for processing high-throughput sequencing data. It is widely used for its speed, memory efficiency, and versatility in handling large genomic datasets. This skill enables the execution of critical preprocessing and analysis steps, such as mapping reads to a reference genome, removing adapter sequences and contaminants, merging overlapping paired-end reads, and normalizing coverage to facilitate assembly.

## Core Tool Usage and Patterns

### General Syntax and Configuration
Most BBTools follow a standard parameter syntax: `tool.sh in=<input> out=<output> [options]`.

- **Memory Management**: BBTools automatically detects available memory, but you can override it using the `-Xmx` flag (e.g., `bbmap.sh -Xmx20g in=reads.fq`).
- **Threading**: Use `t=<integer>` to cap the number of worker threads on shared systems.
- **Paired Reads**: Handle paired files using `in1=` and `in2=` or the `#` wildcard (e.g., `in=reads_#.fq`).
- **Piping**: Use `in=stdin.fq` and `out=stdout.fq` for streaming. Specify extensions so the tool knows the format (e.g., `in=stdin.fastq.gz`).

### BBMap: Short Read Aligner
Use for DNA/RNA-seq alignment. It is splice-aware and handles long indels well.
- **Basic Alignment**: `bbmap.sh in=reads.fq ref=reference.fa out=mapped.sam`
- **Indexing**: BBMap indexes the reference on the fly. To save the index to a specific location, use `path=/path/to/index/`.
- **RNA-seq**: For organisms with long introns (like humans), set `maxindel=200k`.

### BBDuk: Decontamination and Trimming
"Duk" stands for Decontamination Using Kmers. Use this for quality/adapter trimming and filtering.
- **Adapter Trimming**: `bbduk.sh in=reads.fq out=clean.fq ref=adapters.fa ktrim=r k=23 mink=11 hdist=1`
- **Contaminant Filtering**: `bbduk.sh in=reads.fq out=unmatched.fq ref=phix.fa k=31 hdist=1`
- **Quality Trimming**: `bbduk.sh in=reads.fq out=trimmed.fq qtrim=rl trimq=10`

### BBMerge: Paired-Read Merging
Merges overlapping paired-end reads into single reads.
- **Standard Merge**: `bbmerge.sh in1=r1.fq in2=r2.fq out=merged.fq outu=unmerged.fq`
- **Strictness**: Adjust merging stringency with flags like `strict`, `vstrict`, or `loose`.
- **Insert Size**: Use `ihist=histogram.txt` to generate an insert size distribution.

### BBNorm: Coverage Normalization
Reduces coverage in high-depth areas to a target level, useful for speeding up assemblies.
- **Normalization**: `bbnorm.sh in=reads.fq out=norm.fq target=100 min=5`
- **Error Correction**: Use `ecc=t` to perform k-mer based error correction during normalization.

### Reformat: Data Manipulation
A lightweight tool for format conversion and subsampling.
- **Format Conversion**: `reformat.sh in=reads.fastq out=reads.fasta`
- **Subsampling**: `reformat.sh in=reads.fq out=sampled.fq sampledfraction=0.1`
- **Interleaving**: `reformat.sh in1=r1.fq in2=r2.fq out=interleaved.fq`

### Clumpify: Compression and Deduplication
Groups overlapping reads to improve compression or find duplicates.
- **Compression**: `clumpify.sh in=reads.fq.gz out=clumped.fq.gz reorder`
- **Deduplication**: `clumpify.sh in=reads.fq.gz out=deduped.fq.gz dedupe`

## Expert Tips and Best Practices
1. **Order of Operations**: For best results, follow the JGI recommended preprocessing order: 
   1. Adapter trimming (`BBDuk`)
   2. Contaminant filtering (`BBDuk`)
   3. Human/Host removal (`BBMap`)
   4. Normalization (`BBNorm`)
   5. Error correction (`Tadpole` or `BBNorm`)
   6. Merging (`BBMerge`)
2. **Pigz/Unpigz**: If installed, BBTools will use `pigz` for multi-threaded gzip compression/decompression, significantly increasing speed.
3. **Validation**: Use `reformat.sh in=reads.fq vpair` to verify that paired-end files are correctly synchronized.
4. **K-mer Length**: For most filtering tasks, `k=31` is the standard for high specificity. For adapter trimming, shorter k-mers (e.g., `k=23` with `mink=11`) are preferred.

## Reference documentation
- [BBTools User Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide.md)
- [General Usage Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_usage-guide.md)
- [BBMap Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbmap-guide.md)
- [BBDuk Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbduk-guide.md)
- [BBMerge Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbmerge-guide.md)
- [BBNorm Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbnorm-guide.md)
- [Reformat Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_reformat-guide.md)
- [Data Preprocessing Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_data-preprocessing.md)