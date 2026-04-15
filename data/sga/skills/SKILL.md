---
name: sga
description: SGA is a modular assembly pipeline that uses a memory-efficient string graph model and FM-index to assemble genomic sequences. Use when user asks to preprocess reads, build BWT indices, perform error correction, compute overlaps, or assemble contigs from DNA sequence data.
homepage: https://github.com/jts/sga
metadata:
  docker_image: "biocontainers/sga:v0.10.15-4-deb_cv1"
---

# sga

## Overview
SGA (String Graph Assembler) is a modular assembly pipeline based on the FM-index derived from the compressed Burrows-Wheeler Transform (BWT). Unlike traditional de Bruijn graph assemblers, SGA utilizes an overlap-based string graph model. This design allows for extreme memory efficiency, enabling the assembly of mammalian-sized genomes on low-end computing clusters by using a compressed representation of DNA sequence reads.

## Core Assembly Workflow
The SGA pipeline is modular; each step typically generates a new set of files or indices.

### 1. Preprocessing and Indexing
Before assembly, reads must be preprocessed and indexed to build the FM-index.
```bash
# Preprocess reads (quality filtering and adapter trimming)
sga preprocess --pe-mode 1 reads_1.fastq reads_2.fastq > reads.preprocess.fastq

# Build the BWT index
sga index -a ropebwt -t 8 reads.preprocess.fastq
```

### 2. Quality Control (Preqc)
It is highly recommended to run the `preqc` module to understand genome characteristics (e.g., heterozygosity, repeat content, and sequencing quality) before proceeding.
```bash
sga preqc -t 8 reads.preprocess.fastq > reads.preqc
# Generate the PDF report (requires python and matplotlib)
sga-preqc-report.py reads.preqc
```

### 3. Error Correction
SGA uses the BWT to perform k-mer based error correction.
```bash
# Correct sequencing errors
sga correct -k 41 -t 8 -o reads.ec.fastq reads.preprocess.fastq

# Re-index the corrected reads
sga index -a ropebwt -t 8 reads.ec.fastq
```

### 4. Filtering and Overlap Computation
Remove redundant reads and compute the overlaps required for the string graph.
```bash
# Filter low-frequency k-mers and duplicate reads
sga filter -x 2 -t 8 reads.ec.fastq

# Compute overlaps (min overlap length -m is a critical parameter)
sga overlap -m 55 -t 8 reads.ec.fastq
```

### 5. Assembly
Construct the string graph and perform graph-based simplifications to produce contigs.
```bash
# Assemble contigs
sga assemble -m 55 -o assembly.contigs reads.ec.fastq
```

## ASQG Graph Format
SGA uses the ASQG (Assembly Graph) format for representing the string graph.
- **HT**: Header record (metadata like version and minimum overlap).
- **VT**: Vertex record (read ID and sequence).
- **ED**: Edge record (overlap details: start/end coordinates, lengths, orientation, and differences).

## Expert Tips and Best Practices
- **Memory Management**: Use the `-a ropebwt` algorithm during indexing for the most memory-efficient index construction.
- **Overlap Length (`-m`)**: The choice of `-m` in `sga overlap` and `sga assemble` significantly impacts contiguity. Larger values reduce false overlaps in repeat regions but may break the graph in low-coverage areas.
- **Parallelization**: Most SGA commands support the `-t` flag for multi-threading.
- **Large Datasets**: For very large datasets, use the `sga index` distributed construction methods to build indices in chunks.



## Subcommands

| Command | Description |
|---------|-------------|
| scaffold | Construct scaffolds from CONTIGSFILE using distance estimates. |
| scaffold2fasta | Write out a fasta file for the scaffolds indicated in SCAFFOLDFILE |
| sga assemble | Create contigs from the assembly graph ASQGFILE. |
| sga bwt2fa | Transform the bwt BWTFILE back into a set of sequences |
| sga cluster | Extract clusters of reads belonging to the same connected components. |
| sga correct | Correct sequencing errors in all the reads in READSFILE |
| sga filter | Remove reads from a data set. The currently available filters are removing exact-match duplicates and removing reads with low-frequency k-mers. Automatically rebuilds the FM-index without the discarded reads. |
| sga filterBAM | Discard mate-pair alignments from a BAM file that are potentially erroneous |
| sga fm-merge | Merge unambiguously sequences from the READSFILE using the FM-index. This program requires filter to be run before it and rmdup to be run after. |
| sga gapfill | Fill in scaffold gaps using walks through a de Bruijn graph |
| sga graph-concordance | Count read support for variants in a vcf file |
| sga graph-diff | Find and report strings only present in the graph of VARIANT when compared to BASE |
| sga index | Index the reads in READSFILE using a suffixarray/bwt |
| sga kmer-count | Generate a table of the k-mers in src.{bwt,fa,fq}, and optionally count the number of time they appears in testX.bwt. Output on stdout the canonical kmers and their counts on forward and reverse strand if input is .bwt If src is a sequence file output forward and reverse counts for each kmer in the file |
| sga overlap | Compute pairwise overlap between all the sequences in READS |
| sga oview | Draw overlaps in ASQGFILE |
| sga preqc | Perform pre-assembly quality checks |
| sga rewrite-evidence-bam | Discard mate-pair alignments from a BAM file that are potentially erroneous |
| sga rmdup | Remove duplicate reads from the data set. |
| sga stats | Print statistics about the read set. Currently this only prints a histogram of the k-mer counts |
| sga subgraph | Extract the subgraph around the sequence with ID from an asqg file. |
| sga_gen-ssa | Build a sampled suffix array for the reads in READSFILE using the BWT |
| sga_haplotype-filter | Remove haplotypes and their associated variants from a data set. |
| sga_merge | Merge the sequence files READS1, READS2 into a single file/index |
| sga_preprocess | Prepare READS1, READS2, ... data files for assembly |
| somatic-variant-filters | Filters somatic variants based on tumor and normal BAM files and a reference genome. |

## Reference documentation
- [SGA GitHub Repository](./references/github_com_jts_sga.md)
- [SGA Wiki Home](./references/github_com_jts_sga_wiki.md)
- [ASQG Format Specification](./references/github_com_jts_sga_wiki_ASQG-Format.md)
- [Preqc Module Guide](./references/github_com_jts_sga_wiki_Preqc.md)
- [SGA Subprograms Overview](./references/github_com_jts_sga_wiki_sga-subprograms.md)