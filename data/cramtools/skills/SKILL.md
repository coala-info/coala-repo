---
name: cramtools
description: CRAMTools is a Java suite designed for the efficient compression, conversion, and manipulation of genomic sequence read data using the CRAM format. Use when user asks to convert BAM to CRAM, transcode CRAM to BAM, index CRAM files, merge sequence data, or apply lossy quality score compression.
homepage: https://github.com/enasequence/cramtools
---

# cramtools

## Overview
CRAMTools is a specialized Java suite designed for the efficient compression and manipulation of sequence read data using the CRAM format. It is particularly useful for researchers working with large-scale genomic datasets who need to reduce storage footprints while maintaining data integrity. The tool leverages reference-based compression, allowing it to achieve significantly higher compression ratios than the standard BAM format by only storing differences against a known reference sequence.

## Core Workflows

### BAM and CRAM Conversion
The primary use case for cramtools is transcoding between formats.

**Convert BAM to CRAM:**
Requires a reference fasta and its `.fai` index.
```bash
java -jar cramtools-3.0.jar cram \
  --input-bam-file <input.bam> \
  --reference-fasta-file <ref.fa> \
  --output-cram-file <output.cram>
```

**Convert CRAM to BAM:**
```bash
java -jar cramtools-3.0.jar bam \
  --input-cram-file <input.cram> \
  --reference-fasta-file <ref.fa> \
  --output-bam-file <output.bam>
```

### Indexing and Utilities
*   **Index:** Generate `.crai` or `.bai` indexes for CRAM files.
    `java -jar cramtools-3.0.jar index --input-file <file.cram>`
*   **Merge:** Combine multiple SAM/BAM/CRAM files.
    `java -jar cramtools-3.0.jar merge --input-file <f1.cram> --input-file <f2.cram> --output-file <merged.cram>`
*   **Fix Header:** Update reference sequence MD5 checksums in the CRAM header.
    `java -jar cramtools-3.0.jar fixheader --input-cram-file <file.cram> --reference-fasta-file <ref.fa>`

## Lossy Compression Models
CRAMTools allows for "lossy" quality score storage to further reduce file size. This is controlled via the `--lossy-model` flag using specific selectors:

*   **Selectors:** `*` (all), `R` (matches reference), `N` (mismatches), `U` (unmapped), `D` (flanking deletions), `Mn` (MapQ > n).
*   **Treatment:** `40` (full precision), `8` (Illumina 8-binning).

**Common Patterns:**
*   `*8`: Bin all quality scores into 8 bins.
*   `N40-D8`: Preserve mismatches at full precision, bin scores flanking deletions.
*   `m5`: Preserve quality scores only for reads with Mapping Quality < 5.

## Reference Management
CRAMTools can automatically discover reference sequences in three ways:
1.  **Local File:** Provided via `-R` or `--reference-fasta-file`.
2.  **ENA Registry:** Automatically downloads sequences from the European Nucleotide Archive using MD5 checksums in the SAM header.
3.  **Local Cache:** Uses `REF_CACHE` or `REF_PATH` environment variables (compatible with samtools/htslib).

To pre-download all references required by a CRAM file:
```bash
java -jar cramtools-3.0.jar getref --input-cram-file <file.cram>
```

## Expert Tips
*   **Java Version:** Ensure Java 1.7 or higher is installed.
*   **Sorting:** Input BAM files must be sorted by reference coordinates before conversion to CRAM.
*   **Memory:** For large files, increase the JVM heap size (e.g., `java -Xmx4G -jar cramtools-3.0.jar ...`).
*   **Legacy Note:** While CRAMTools 3.0 supports CRAM v3, the project is in maintenance mode. For new pipelines, consider `samtools` for CRAM operations as it is the current industry standard.



## Subcommands

| Command | Description |
|---------|-------------|
| cramtools bam | A tool to process CRAM files, including conversion to BAM, decryption, and tag calculation. |
| cramtools cram | CRAM compression tool for converting BAM/SAM to CRAM |
| cramtools fastq | Uncompress CRAM files into FASTQ format. |
| cramtools fixheader | Fix headers in CRAM files, including MD5 calculation and URI injection for reference sequences. |
| cramtools getref | A list of MD5 checksums for which the sequences should be downloaded. |
| cramtools index | Index a BAM or CRAM file using cramtools. |
| cramtools merge | The paths to the CRAM or BAM files to uncompress. |
| cramtools qstat | Quality statistics for CRAM or BAM files |

## Reference documentation
- [CRAMTools GitHub Repository](./references/github_com_enasequence_cramtools.md)
- [ENA Programmatic Access Guide](./references/ena-docs_readthedocs_io_en_latest_retrieval_programmatic-access.html.md)