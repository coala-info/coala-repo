---
name: find_circ
description: find_circ identifies circular RNA junctions by analyzing back-spliced alignments of unmapped read anchors. Use when user asks to identify circular RNA, extract anchors from unmapped reads, or detect back-splice junctions from RNA-seq data.
homepage: https://github.com/marvin-jens/find_circ
---


# find_circ

## Overview
The find_circ pipeline identifies circular RNA by analyzing reads that fail to map contiguously to a reference genome. It works by extracting "anchors" from the ends of unmapped reads, re-mapping them, and identifying cases where the anchors map in a "back-spliced" orientation (the downstream anchor maps upstream of the upstream anchor). This skill covers the standard command-line workflow involving Bowtie2, samtools, and the find_circ Python scripts.

## Prerequisites
- Python 2.7 with `numpy` and `pysam`
- Bowtie2 and samtools installed in the PATH
- A reference genome (FASTA) and its corresponding Bowtie2 index

## Standard Workflow

### 1. Initial Mapping and Unmapped Read Extraction
Map your RNA-seq reads against the genome. Use sensitive settings to ensure that only truly non-contiguous reads remain unmapped.

```bash
# Map reads and sort output
bowtie2 -p 16 --very-sensitive --score-min=C,-15,0 --mm -x <bt2_index> -q -U <reads.fastq.gz> | \
samtools view -hbuS - | samtools sort -o mapped_sorted.bam

# Extract unmapped reads (flag 4)
samtools view -hf 4 mapped_sorted.bam | samtools view -Sb - > unmapped.bam
```

### 2. Generate Anchors
Use `unmapped2anchors.py` to extract the head and tail sequences (anchors) from the unmapped reads. These anchors are typically 20bp long.

```bash
./unmapped2anchors.py unmapped.bam | gzip > anchors.fastq.gz
```

### 3. Map Anchors and Detect Junctions
Map the anchors back to the genome and pipe the output directly into `find_circ.py`.

```bash
bowtie2 -p 16 --score-min=C,-15,0 --reorder --mm -q -U anchors.fastq.gz -x <bt2_index> | \
./find_circ.py \
  --genome=<genome.fa> \
  --prefix=<sample_prefix>_ \
  --name=<sample_name> \
  --stats=stats.txt \
  --reads=spliced_reads.fa \
  > splice_sites.bed
```

## Expert Tips and Best Practices

### Filtering for Circular RNAs
The output `splice_sites.bed` contains both linear and circular junctions. To isolate circular RNAs, use grep:
```bash
grep "CIRCULAR" splice_sites.bed > circ_candidates.bed
```

### Handling Uniqueness
By default (v1.2+), `find_circ.py` does not report junctions that lack at least one read where both anchors align uniquely. 
- Use `--halfuniq` if you want to report junctions with only one uniquely aligned anchor.
- Use `--report_nobridge` to include junctions flagged as `NO_UNIQ_BRIDGES`.

### Performance and Memory
- Use the `--mm` flag in Bowtie2 for memory-mapped I/O when working with large indices on machines with limited RAM.
- Ensure the `--genome` FASTA file is indexed (find_circ will attempt to create a `.fai` or internal index on first access).

### Merging Results
If you have multiple samples or need to consolidate results, use `merge_bed.py`. Note that in newer versions, you may need the `-c` flag to maintain compatibility with older input formats.

## Reference documentation
- [find_circ GitHub Repository](./references/github_com_marvin-jens_find_circ.md)
- [Bioconda find_circ Overview](./references/anaconda_org_channels_bioconda_packages_find_circ_overview.md)