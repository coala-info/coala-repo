---
name: artemis
description: Artemis is an interactive visualization and analysis environment for genomic data, sequence features, and high-throughput sequencing alignments. Use when user asks to visualize genomes, compare DNA sequences for synteny, view BAM or CRAM alignment files, or generate circular and linear DNA maps.
homepage: http://sanger-pathogens.github.io/Artemis/
metadata:
  docker_image: "quay.io/biocontainers/artemis:18.2.0--hdfd78af_0"
---

# artemis

## Overview
Artemis is a specialized environment for the interactive analysis of genomic data. It allows for the integration of various data types—including sequence features, six-frame translations, and high-throughput sequencing (HTS) data—within a single visual context. This skill provides the necessary command-line patterns to launch the specific components of the Artemis suite (Artemis, ACT, BamView, and DNAPlotter) and manage their resource requirements.

## Core Tool Usage

### 1. Artemis (Genome Browser)
Use `art` to visualize single genomes and their annotations (EMBL, GenBank, GFF, FASTA).

*   **Basic Launch:**
    ```bash
    art
    ```
*   **Open with specific file:**
    ```bash
    art sequence_file.embl
    ```
*   **MacOS Command Line:**
    ```bash
    Artemis.app/Contents/art
    ```

### 2. ACT (Artemis Comparison Tool)
Use `act` to display pairwise comparisons between two or more DNA sequences to identify synteny or insertions/deletions.

*   **Basic Launch:**
    ```bash
    act
    ```
*   **Compare two sequences with a BLAST/crunch file:**
    ```bash
    act sequence1.embl comparison_file.crunch sequence2.embl
    ```

### 3. BamView (NGS Visualization)
Use `bamview` to visualize read-alignment data (BAM/CRAM) against a reference.

*   **Basic Launch:**
    ```bash
    bamview
    ```
*   **Load specific BAM/CRAM:**
    ```bash
    bamview -a alignment.bam
    ```
*   **Load CRAM with reference:**
    ```bash
    bamview -a alignment.cram -r reference.fasta
    ```
*   **Remote files:**
    ```bash
    bamview -a 'ftp://ftp.site/data.bam'
    ```

### 4. DNAPlotter (Map Generation)
Use `dnaplotter` to create publication-quality circular or linear DNA maps.

*   **Launch with template:**
    ```bash
    dnaplotter -t template_file.xml
    ```

## Expert Tips and Configuration

### Memory Management
Artemis tools are Java-based and may require manual memory allocation for large datasets (e.g., large BAM files or multiple genome comparisons).

*   **Environment Variable Method (Recommended):**
    Set `ARTEMIS_JVM_FLAGS` to define the maximum heap size (`-mx`) and initial heap size (`-ms`).
    ```bash
    export ARTEMIS_JVM_FLAGS="-mx4g -ms500m"
    ```
*   **Script Modification:**
    If running via the provided shell scripts, locate the `FLAGS` line and update the `-mx` value (e.g., change `-mx2g` to `-mx4g`).

### Data Preparation for BamView
To ensure BamView functions correctly, alignment files must be sorted and indexed:
1.  **Sort:** `samtools sort input.bam -o sorted.bam`
2.  **Index:** `samtools index sorted.bam` (creates `sorted.bam.bai`)
3.  **Naming:** Ensure the `.bai` or `.crai` index file is in the same directory as the alignment file and shares the same base name.

### Docker Execution (Headless/Remote)
When running via Docker, an X server must be active on the host.
```bash
docker run -d -e DISPLAY="<host_ip>:0" \
  -v /path/to/data:/artemis \
  --rm artemis <program_name>
```
*Replace `<program_name>` with `art`, `act`, `bamview`, or `dnaplotter`.*



## Subcommands

| Command | Description |
|---------|-------------|
| act | Genome Comparison Tool |
| art | Artemis: Genome Browser and Annotation Tool |
| artemis_bamview | Starting BamView with arguments |
| dnaplotter | DNA Image Generation Tool |

## Reference documentation
- [Artemis Overview](./references/sanger-pathogens_github_io_Artemis_Artemis.md)
- [ACT Comparison Tool](./references/sanger-pathogens_github_io_Artemis_ACT.md)
- [BamView Alignment Viewer](./references/sanger-pathogens_github_io_Artemis_BamView.md)
- [DNAPlotter Map Generator](./references/sanger-pathogens_github_io_Artemis_DNAPlotter.md)