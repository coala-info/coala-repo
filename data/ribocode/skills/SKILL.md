---
name: ribocode
description: RiboCode identifies actively translated regions and non-canonical open reading frames by analyzing the 3-nucleotide periodicity of ribosome-protected fragments. Use when user asks to detect translated ORFs, perform P-site calibration, or identify non-canonical translation products like uORFs from Ribo-seq data.
homepage: https://github.com/xryanglab/RiboCode
---


# ribocode

## Overview
RiboCode is a computational framework designed to detect actively translated regions by analyzing the 3-nucleotide periodicity of ribosome-protected fragments (RPFs). This skill enables the identification of translation across the genome, covering both annotated coding sequences and non-canonical ORFs such as upstream ORFs (uORFs) and internal ORFs. It is used after initial read processing (trimming and rRNA removal) and alignment to the transcriptome.

## Workflow and CLI Usage

### 1. Annotation Preparation
Before running the analysis, you must prepare the transcript annotation files from a genome FASTA and a GTF file.
```bash
prepare_transcripts -g <annotation.gtf> -f <genome.fa> -o <output_dir>
```
*   **Note**: The GTF file must include a three-level hierarchy (gene, transcript, and exon). If these are missing, use the `GTFupdate` command provided by the package.

### 2. P-site Calibration and Metaplots
This step identifies the P-site offsets for different RPF read lengths and generates periodicity plots.
```bash
metaplots -a <prepared_annot_dir> -r <transcriptome_aligned.bam>
```
*   **Output**: This generates a PDF for visual inspection of periodicity and a `config.txt` file.
*   **Multiple Samples**: If you have multiple BAM files, list them in a text file (one per line) and use the `-i` argument.

### 3. ORF Detection
The final step uses the calibrated P-site information to predict translated ORFs.
```bash
RiboCode -a <prepared_annot_dir> -c <config.txt> -l no -g -o <result_prefix>
```
*   **Arguments**:
    *   `-l no`: Specifies that the library is not strand-specific (adjust if necessary).
    *   `-g`: Outputs the results in GTF format.
    *   `-b`: Outputs the results in BED format.

## Best Practices and Expert Tips

### Alignment Requirements
RiboCode requires reads to be aligned to the **transcriptome**, not just the genome. When using STAR, ensure you use the following flags:
*   `--quantMode TranscriptomeSAM`: To generate the required transcriptome-aligned BAM.
*   `--outFilterMultimapNmax 1`: RiboCode typically performs best with uniquely mapped reads.
*   `--alignEndsType EndToEnd`: Recommended for Ribo-seq data to ensure accurate P-site mapping.

### Result Interpretation
RiboCode produces two primary text outputs:
1.  **`<name>.txt`**: Contains all predicted ORFs for every transcript isoform.
2.  **`<name>_collapsed.txt`**: Merges ORFs sharing the same stop codon across different isoforms, retaining the most upstream in-frame ATG. This is generally the preferred file for downstream biological analysis.

### ORF Classification
The tool categorizes ORFs based on their position relative to annotated CDS:
*   **annotated**: Matches the annotated CDS stop codon.
*   **uORF / dORF**: Upstream or downstream of the annotated CDS, non-overlapping.
*   **Overlap_uORF / Overlap_dORF**: Overlapping the start or stop of the annotated CDS.
*   **Internal**: Inside the annotated CDS but in a different reading frame.
*   **novel**: Found on non-coding transcripts or genes.

## Reference documentation
- [RiboCode GitHub Repository](./references/github_com_xryanglab_RiboCode.md)
- [RiboCode Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ribocode_overview.md)