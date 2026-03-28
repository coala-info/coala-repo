---
name: amptk
description: AMPtk is a suite of scripts designed to process raw amplicon sequencing data into filtered OTU tables and taxonomic assignments. Use when user asks to demultiplex NGS data, cluster sequences into OTUs or ASVs, filter index-bleed artifacts, or assign taxonomy to fungal and bacterial amplicons.
homepage: https://github.com/nextgenusfs/amptk
---


# amptk

## Overview

AMPtk (Amplicon ToolKit) is a specialized suite of scripts designed to transform raw NGS data from Illumina, Ion Torrent, or 454 platforms into filtered OTU tables and taxonomic assignments. Unlike many pipelines that use fixed-length truncation, AMPtk utilizes expected-error quality trimming, making it particularly effective for variable-length amplicons like the fungal Internal Transcribed Spacer (ITS) region. It integrates multiple clustering algorithms (UPARSE, DADA2, UNOISE) and employs a robust "hybrid" Last Common Ancestor (LCA) approach for taxonomy, combining global alignment with Bayesian classifiers.

## Core Workflow and Commands

### 1. Setup and Databases
Before processing data, install the required reference databases.
```bash
# Install all supported databases (ITS, 16S, LSU, COI)
amptk install -i ITS 16S LSU COI

# Check installed versions and database paths
amptk info
```

### 2. Pre-Processing (Demultiplexing)
Choose the command based on your sequencing platform and file delivery format.

*   **Illumina (Standard folder of PE reads):**
    ```bash
    amptk illumina -i input_folder -o output_prefix -f fITS7 -r ITS4
    ```
*   **Ion Torrent (BAM or FASTQ):**
    ```bash
    amptk ion -i data.bam -o output_prefix -f fITS7 -r ITS4 --barcode_fasta barcodes.fa
    ```
*   **SRA Data (Single FASTQ per sample):**
    ```bash
    amptk SRA -i folder_of_fastqs -f F_primer -r R_primer -o output_prefix
    ```
*   **Expert Tip:** Use `--require_primer off` if you used custom sequencing primers where the primer sequence is not present in the read.

### 3. Clustering and Denoising
AMPtk supports several algorithms. All take the `.demux.fq.gz` file from the pre-processing step.

*   **UPARSE (OTUs):** `amptk cluster -i data.demux.fq.gz -o out`
*   **DADA2 (ASVs/iSeqs):** `amptk dada2 -i data.demux.fq.gz --platform illumina -o out`
*   **UNOISE3:** `amptk unoise3 -i data.demux.fq.gz -o out`

### 4. Filtering (Index-Bleed Correction)
This is a critical step to remove "barcode switching" or "index-bleed" artifacts. It is highly recommended to include a mock community (spike-in) in your run.

```bash
# Filter using a mock community to calculate bleed automatically
amptk filter -i data.otu_table.txt -f data.cluster.otus.fa -b mock_barcode_name -m mock_type

# Manual filter (e.g., 0.5% bleed) if no mock is available
amptk filter -i data.otu_table.txt -f data.cluster.otus.fa -p 0.005
```

### 5. Taxonomy Assignment
Assign taxonomy using the hybrid approach (Global Alignment + SINTAX/UTAX).

```bash
amptk taxonomy -i data.final.txt -f data.filtered.otus.fa -m data.mapping_file.txt -d ITS2 -o final_output
```

## Best Practices
*   **Variable Length Amplicons:** For ITS data, avoid hard truncation. Use the default `-l 300` in pre-processing to maintain informative length variation.
*   **Mock Communities:** Always use a synthetic or biological mock community to empirically measure the index-bleed for your specific sequencing run.
*   **Mapping Files:** Ensure your mapping file is QIIME-like (tab-delimited). AMPtk uses the first 5 columns: `#SampleID`, `BarcodeSequence`, `LinkerPrimerSequence`, `ReversePrimer`, and `phinchID`.
*   **Memory Management:** If using the 32-bit version of USEARCH, you may hit a 4GB RAM limit. As of v1.5.1, AMPtk can use VSEARCH (64-bit) for most steps to bypass this.



## Subcommands

| Command | Description |
|---------|-------------|
| amptk-OTU_cluster_ref.py | Script runs UPARSE OTU clustering. Requires USEARCH by Robert C. Edgar: http://drive5.com/usearch |
| amptk-assign_taxonomy.py | assign taxonomy to OTUs |
| amptk-barcode_rarify.py | Script to sub-sample reads down to the same number for each sample (barcode) |
| amptk-dada2.py | Script takes output from amptk pre-processing and runs DADA2 |
| amptk-dada2.py | Script takes output from amptk pre-processing and runs pacbio DADA2 |
| amptk-drop.py | Script that drops OTUs and then creates OTU table |
| amptk-extract_region.py | Script searches for primers and removes them if found. Useful for trimming a reference dataset for assigning taxonomy after OTU clustering. It is also capable of reformatting UNITE taxonomy fasta headers to be compatible with UTAX and creating USEARCH/UTAX UBD databases for assigning taxonomy. |
| amptk-fastq2sra.py | Script to split FASTQ file from Ion, 454, or Illumina by barcode sequence into separate files for submission to SRA. This script can take the BioSample worksheet from NCBI and create an SRA metadata file for submission. |
| amptk-get_barcode_counts.py | Script loops through demuxed fastq file counting occurances of barcodes, can optionally quality trim and recount. |
| amptk-keep_samples.py | Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with barcode names in list |
| amptk-lulu.py | Script runs OTU table post processing LULU to identify low abundance error OTUs |
| amptk-merge_metadata.py | Takes a meta data csv file and OTU table and makes transposed output files. |
| amptk-process_illumina_folder.py | Script that takes De-mulitplexed Illumina data from a folder and processes it for amptk (merge PE reads, strip primers, trim/pad to set length. |
| amptk-process_illumina_folder.py | Script that takes De-mulitplexed Illumina data from a folder and processes it for amptk (merge PE reads, strip primers, trim/pad to set length. |
| amptk-process_illumina_raw.py | Script finds barcodes, strips forward and reverse primers, relabels, and then trim/pads reads to a set length |
| amptk-process_ion.py | Script finds barcodes, strips forward and reverse primers, relabels, and then trim/pads reads to a set length |
| amptk-process_ion.py | Script finds barcodes, strips forward and reverse primers, relabels, and then trim/pads reads to a set length |
| amptk-process_pacbio.py | Script to process pacbio CCS amplicon data |
| amptk-remove_samples.py | Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with barcode names in list |
| amptk-stats.py | Script takes BIOM as input and runs basic summary stats |
| amptk-unoise2.py | Script runs UNOISE2 algorithm. Requires USEARCH9 by Robert C. Edgar: http://drive5.com/usearch |
| amptk-unoise3.py | Script runs UNOISE3 algorithm. Requires USEARCH9 by Robert C. Edgar: http://drive5.com/usearch |
| amptk_primers | Primers hard-coded into AMPtk |
| csv2heatmap.py | Script that creates heatmap(s) from csv data, column 1 is the row name, csv file has headers. |
| funguild | Script takes OTU table as input and runs FUNGuild to assing functional annotation to an OTU              based on the Guilds database. AMPtk runs method based off of script by Zewei Song (2015-2021). |
| summarize | Summarize amplicon sequencing data |

## Reference documentation
- [AMPtk Overview](./references/amptk_readthedocs_io_en_latest_overview.html.md)
- [AMPtk Commands](./references/amptk_readthedocs_io_en_latest_commands.html.md)
- [AMPtk Pre-Processing](./references/amptk_readthedocs_io_en_latest_pre-processing.html.md)
- [AMPtk Clustering](./references/amptk_readthedocs_io_en_latest_clustering.html.md)
- [AMPtk OTU Table Filtering](./references/amptk_readthedocs_io_en_latest_filtering.html.md)
- [AMPtk Taxonomy](./references/amptk_readthedocs_io_en_latest_taxonomy.html.md)