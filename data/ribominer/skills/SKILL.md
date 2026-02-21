---
name: ribominer
description: RiboMiner is a Python-based toolset designed for the comprehensive analysis of the translatome using ribosome profiling data.
homepage: https://github.com/xryanglab/RiboMiner
---

# ribominer

## Overview

RiboMiner is a Python-based toolset designed for the comprehensive analysis of the translatome using ribosome profiling data. It facilitates a multi-step workflow covering Quality Control (QC), Metagene Analysis (MA), Feature Analysis (FA), and Enrichment Analysis (EA). A defining characteristic of RiboMiner is its focus on the longest transcript of protein-coding genes to ensure standardized comparisons across different genomic features. Use this skill to execute the RiboMiner pipeline, from preparing transcriptome-level annotations to detecting specific ribosome stalling events.

## Data Preparation (DP)

Before analysis, you must generate transcript-level sequences and annotations. RiboMiner relies on `RiboCode` for initial processing.

1.  **Generate Transcriptome Annotations**:
    Use `prepare_transcripts` (from the RiboCode package) to create the base annotation directory.
    ```bash
    prepare_transcripts -g <annotation.gtf> -f <genome.fa> -o <output_dir>
    ```

2.  **Identify Longest Transcripts**:
    RiboMiner functions optimally when using the longest transcript per gene.
    ```bash
    OutputTranscriptInfo -c <output_dir>/transcripts_cds.txt -g <annotation.gtf> -f <output_dir>/transcripts_sequence.fa -o longest.transcripts.info.txt -O all.transcripts.info.txt
    ```

3.  **Extract Sequences**:
    Generate amino acid and CDS sequences for the identified longest transcripts.
    ```bash
    GetProteinCodingSequence -i <output_dir>/transcripts_sequence.fa -c longest.transcripts.info.txt -o <prefix> --mode whole --table 1
    ```

## Quality Control (QC)

Quality control ensures the Ribo-seq data exhibits the expected 3-nt periodicity and footprint length distribution.

1.  **Periodicity Checking**:
    Use `metaplots` to determine the P-site offset for different read lengths.
    ```bash
    metaplots -a <RiboCode_annot_dir> -r <sorted_indexed.bam> -o <prefix>
    ```

2.  **Defining Attributes**:
    After identifying lengths with good periodicity and their respective offsets, create a tab-separated `attributes.txt` file. This file is mandatory for downstream metagene and feature analysis.
    
    **Format**: `bamFiles` | `readLengths` | `Offsets` | `bamLegends`
    *Example*:
    ```text
    ./sample1.bam    27,28,29    12,12,12    Control_R1
    ./sample2.bam    27,28,29    12,12,12    Treatment_R1
    ```

3.  **Alternative Periodicity Tool**:
    If statistics are not required, use the native RiboMiner `Periodicity` command:
    ```bash
    Periodicity -i <sample.bam> -a <RiboCode_annot_dir> -o <prefix> -c longest.transcripts.info.txt -L 25 -R 35
    ```

## Best Practices

*   **BAM Requirements**: All input BAM files must be sorted and indexed (`samtools sort` and `samtools index`) before running RiboMiner commands.
*   **GTF Compatibility**: Ensure your GTF annotation file contains `transcript_type` or `transcript_biotype` attributes in the final field, as RiboMiner uses these to filter protein-coding genes.
*   **Genetic Codes**: When running `GetProteinCodingSequence`, the `--table` parameter defaults to 1 (Standard Code). Adjust this if working with mitochondrial data or specific organisms.
*   **UTR Analysis**: If your analysis requires UTR-specific features, use `GetUTRSequences` with the `transcripts_cds.txt` file generated during the Data Preparation phase.

## Reference documentation

- [RiboMiner GitHub Repository](./references/github_com_xryanglab_RiboMiner.md)
- [RiboMiner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ribominer_overview.md)