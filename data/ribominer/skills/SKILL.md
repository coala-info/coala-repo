---
name: ribominer
description: RiboMiner is a bioinformatics suite designed to analyze ribosome footprinting data to identify ribosome stalling sites and correlate them with sequence-based properties. Use when user asks to extract translatome features, calculate codon occupancy, analyze biochemical properties of stalling sites, or generate metagene profiles from Ribo-seq experiments.
homepage: https://github.com/xryanglab/RiboMiner
---

# ribominer

## Overview

RiboMiner is a specialized bioinformatics suite designed to extract biological insights from ribosome footprinting (Ribo-seq) experiments. It transforms raw mapping data into high-level translatome features, allowing researchers to identify ribosome stalling sites and correlate them with sequence-based properties like codon usage, charge, and hydrophobicity. It relies on the longest protein-coding transcripts for its calculations to ensure consistency across genomic analyses.

## Data Preparation (DP)

Before analysis, you must generate transcriptome-level annotations and extract sequences.

1.  **Generate RiboCode Annotations**:
    ```bash
    prepare_transcripts -g <annotation.gtf> -f <genome.fa> -o RiboCode_annot
    ```
2.  **Identify Longest Transcripts**:
    ```bash
    OutputTranscriptInfo -c RiboCode_annot/transcripts_cds.txt -g <annotation.gtf> -f RiboCode_annot/transcripts_sequence.fa -o longest.transcripts.info.txt -O all.transcripts.info.txt
    ```
3.  **Extract Sequences**:
    ```bash
    GetProteinCodingSequence -i RiboCode_annot/transcripts_sequence.fa -c longest.transcripts.info.txt -o <prefix> --mode whole --table 1
    ```

## Quality Control (QC)

Assess the 3-nt periodicity and read length distribution of your BAM files.

*   **Periodicity Check**: Use `metaplots` (from the RiboCode dependency) to determine the P-site offset for specific read lengths.
*   **Attributes File**: Create a tab-separated `attributes.txt` to define your samples:
    ```text
    bamFiles    readLengths    Offsets    bamLegends
    ./sample1.bam    27,28,29    12,12,13    Control
    ```
*   **Length Distribution**:
    ```bash
    PlotLengthDist -i attributes.txt -o length_dist_output
    ```

## Metagene Analysis (MA)

Identify stalling events by calculating read densities across transcripts.

*   **Calculate Density**:
    ```bash
    # Generates a .h5 file containing density information
    GetDensitySum -i attributes.txt -o density_output
    ```
*   **Metagene Plotting**:
    ```bash
    PlotMetagene -i density_output.h5 -o metagene_plot --norm yes
    ```

## Feature Analysis (FA)

Correlate stalling with biochemical and sequence properties.

*   **Codon/AA Usage**: Calculate the occupancy of specific codons or amino acids.
    ```bash
    # Example for A-site occupancy
    PlotOccupancy -i density_output.h5 -s <sequence.fa> -o occupancy_results
    ```
*   **Biochemical Properties**: Analyze hydrophobicity or charge distribution around stalling sites.
    ```bash
    # Calculate hydrophobicity index
    PlotHydrophobicity -i density_output.h5 -a <amino_acid_sequence.fa> -o hydro_results
    ```

## Expert Tips

*   **BAM Requirements**: All input BAM files must be sorted and indexed (`samtools index`).
*   **GTF Formatting**: Ensure your GTF file contains `transcript_type` or `transcript_biotype` attributes in the 9th column.
*   **P-site Offsets**: The accuracy of all downstream analyses (MA, FA, EA) depends entirely on the correct Offsets defined in your `attributes.txt`. Always verify these via `metaplots` first.
*   **Memory Management**: For large genomes or many samples, `GetDensitySum` can be resource-intensive; ensure sufficient RAM is available for HDF5 file creation.



## Subcommands

| Command | Description |
|---------|-------------|
| metaplots | This script create aggregate plots of distances from the 5'end of reads to start or stop codons, which help determine the length range of the PRF reads that are most likely originated from the translating ribosomes and identify the P-site locations for each reads lengths. |
| prepare_transcripts | This script is designed for preparing transcripts annotation files. |
| python GetProteinCodingSequence | Extracts protein-coding sequences based on specified coordinates. |
| python GetUTRSequences | Get UTR sequences from transcript and coordinate files. |
| python OutputTranscriptInfo | Output transcript information. |
| python Periodicity | Calculates periodicity of Ribo-seq reads. |

## Reference documentation

- [RiboMiner Implementation Guide](./references/github_com_xryanglab_RiboMiner_blob_master_Implementation.md)
- [RiboMiner README](./references/github_com_xryanglab_RiboMiner_blob_master_README.md)