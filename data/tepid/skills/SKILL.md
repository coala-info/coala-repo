---
name: tepid
description: TEPID (Transposable Element Polymorphism IDentification) is a bioinformatic pipeline designed to find variation in transposable element content between a sample and a reference genome. Use when user asks to run tepid or use its main features.
homepage: https://github.com/ListerLab/TEPID
metadata:
  docker_image: "quay.io/biocontainers/tepid:0.10--py_0"
---

# tepid

## Overview
TEPID (Transposable Element Polymorphism IDentification) is a bioinformatic pipeline designed to find variation in transposable element content between a sample and a reference genome. It utilizes a combination of split-read and discordant-read mapping (via bowtie2 and yaha) to pinpoint TE boundaries. The tool is most effective with sequencing coverage greater than 20x and read lengths of at least 100 bp. It supports both individual sample analysis and population-scale refinement to improve variant calling across related samples.

## Installation and Environment
TEPID is primarily available via Bioconda or source. Note that it traditionally requires a Python 2.7 environment.

```bash
# Installation via Conda
conda install -c bioconda tepid
```

**Required Dependencies:**
- bowtie2 (>= v2.1.0)
- yaha (>= v0.1.82)
- samtools (> v1.3)
- samblaster (>= v0.1.19, for paired-end data)
- bedtools (>= v2.25.0)

## Step 1: Read Mapping
The mapping step generates the specific BAM files required for discovery, including a standard BAM and a split-read BAM.

### Paired-End Mapping
Use `tepid-map` for paired-end data.
```bash
tepid-map -x /path/to/bowtie2_index \
          -y /path/to/yaha_index \
          -p 8 \
          -s 300 \
          -n sample_name \
          -1 reads_1.fastq \
          -2 reads_2.fastq \
          -z
```
- `-s`: Average insert size (critical for discordant read identification).
- `-z`: Use if input fastq files are gzipped.
- `-r`: Optional recursive search for fastq files in subdirectories.

### Single-End Mapping
Use `tepid-map-se` for single-end data.
```bash
tepid-map-se -x /path/to/bowtie2_index \
             -y /path/to/yaha_index \
             -p 8 \
             -n sample_name \
             -q reads.fastq
```

## Step 2: TE Variant Discovery
Once mapping is complete, use `tepid-discover` to identify variants.

```bash
tepid-discover -n sample_name \
               -c sample_name.bam \
               -s sample_name.split.bam \
               -t TE_annotation.bed \
               -p 8 \
               --strict
```

**Key Arguments:**
- `-t`: TE annotation in BED format (Chrom, Start, Stop, Strand, Name, Family, Superfamily).
- `--strict`: Recommended for reporting only high-confidence variants.
- `-d` / `-i`: Limit search to deletions only or insertions only.
- `--mask`: Provide a list of chromosomes to ignore (e.g., organellar genomes).
- `--se`: Must be included if the mapping was performed in single-end mode.

## Step 3: Refinement and Genotyping (Optional)
For population studies or related samples, use `tepid-refine` to reduce false negatives by checking for evidence of variants identified in other samples.

1. **Merge variants:** Use `merge_insertions.py` and `merge_deletions.py` (found in the `Scripts/` directory) to create a non-redundant list of variants across the population.
2. **Run Refine:**
```bash
tepid-refine -t TE_annotation.bed \
             -n sample_name \
             -c sample_name.bam \
             -s sample_name.split.bam \
             -a all_samples_list.txt \
             -i merged_insertions.bed \
             -d merged_deletions.bed
```
- `-a`: A text file containing one sample name per line.

## Best Practices and Tips
- **Annotation Quality:** The quality of TE calls is heavily dependent on the reference TE annotation. Ensure your BED file is tab-separated and follows the specific 7-column format required by TEPID.
- **Coverage:** If coverage is below 20x, the sensitivity for detecting heterozygous or low-frequency insertions decreases significantly.
- **Memory Management:** Mapping with `yaha` can be memory-intensive depending on the genome size; ensure the execution environment has sufficient RAM for the index size.
- **Output Files:**
  - `[name]_insertions.bed`: Coordinates of non-reference TE insertions.
  - `[name]_deletions.bed`: Reference TEs found to be absent in the sample.
  - Evidence files: TEPID also outputs files containing the names of reads that supported each call, useful for manual curation in IGV.

## Reference documentation
- [TEPID GitHub Repository](./references/github_com_ListerLab_TEPID.md)
- [Bioconda TEPID Overview](./references/anaconda_org_channels_bioconda_packages_tepid_overview.md)