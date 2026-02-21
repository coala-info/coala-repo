---
name: mitohifi
description: MitoHiFi is a specialized bioinformatics pipeline designed for mitochondrial genome reconstruction.
homepage: https://github.com/marcelauliano/MitoHiFi
---

# mitohifi

## Overview

MitoHiFi is a specialized bioinformatics pipeline designed for mitochondrial genome reconstruction. It automates the transition from raw long-reads or fragmented contigs to a finalized, circularized, and annotated mitogenome. It is particularly useful for biodiversity genomics projects where high-quality mitochondrial assemblies are required for diverse species. The tool handles the circular nature of the molecule by removing redundancy and uses a closely related reference to guide the assembly and annotation process.

## Core Workflows

### 1. Finding a Reference Genome
Before running the main pipeline, you need a closely related mitochondrial reference in both FASTA and GenBank formats. Use the included helper script to automate this:

```bash
python findMitoReference.py -s "Species Name" -o ./reference_dir
```

### 2. Assembling from Raw HiFi Reads
Use this mode when you have raw PacBio HiFi reads. MitoHiFi will extract mitochondrial reads and perform a de novo assembly using hifiasm.

```bash
python mitohifi.py -r hifi_reads.fasta -f ref_mito.fasta -g ref_mito.gbk -t 16 -a animal
```

### 3. Identifying Mitogenomes from Assembled Contigs
Use this mode if you have already performed a whole-genome assembly and want to pull out and finalize the mitochondrial contigs.

```bash
python mitohifi.py -c assembly_contigs.fasta -f ref_mito.fasta -g ref_mito.gbk -t 16 -a animal
```

## Command Line Options and Best Practices

### Required Arguments
- `-r` or `-c`: Input reads OR input contigs (mutually exclusive).
- `-f`: Reference mitogenome in FASTA format.
- `-g`: Reference mitogenome in GenBank format.
- `-t`: Number of threads.

### Key Parameters for Optimization
- **Kingdom Selection (`-a`)**: Specify `animal` (default), `plant`, or `fungi`. This affects the underlying annotation logic.
- **Annotation Engine (`--mitos`)**: By default, MitoHiFi uses MitoFinder. Use `--mitos` to switch to MITOS2 for annotation.
- **Blast Sensitivity (`-p`)**: Adjust the percentage of query coverage (default is often sufficient, but can be lowered for very distant references).
- **Read Length Filtering (`--max-read-len`)**: Useful if you have very long reads that might be NUMTs; defaults to 1.0x the reference length.
- **Circularization Check (`--circular-size`)**: Adjust the size of the overlap used to determine if a contig is circular.

## Expert Tips

- **Heteroplasmy**: MitoHiFi assembles and annotates all detected mitochondrial variants. It selects a "final" representative based on circularization and gene completeness, but check the intermediate outputs if you suspect significant heteroplasmy.
- **NUMT Filtering**: The pipeline identifies Nuclear Mitochondrial DNA (NUMTs) by comparing contig properties and blast results against the reference. Genuine mitogenomes typically show higher coverage and better circularization potential.
- **Output Interpretation**:
    - `final_mitogenome.fasta`: The primary result.
    - `final_mitogenome.gbk`: The annotated genome.
    - `coverage_plot.png`: Essential for verifying that the assembly has consistent read support across the entire circle.

## Reference documentation
- [MitoHiFi Main Documentation](./references/github_com_marcelauliano_MitoHiFi.md)