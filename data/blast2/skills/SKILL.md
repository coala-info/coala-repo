---
name: blast2
description: Blast2Bam converts BLASTn XML output into SAM format by cross-referencing original sequence files and a reference genome. Use when user asks to convert BLAST results to SAM or BAM format, process paired-end BLAST alignments, or integrate BLAST outputs into standard mapping workflows.
homepage: https://github.com/guyduche/Blast2Bam
---


# blast2

## Overview
Blast2Bam is a specialized utility designed to bridge the gap between BLAST sequence alignments and standard mapping formats. It transforms the XML output (format 5) from a BLASTn search into a SAM file by cross-referencing the original sequence files (FastQ or Fasta) and the target reference genome. This allows researchers to leverage BLAST's alignment sensitivity while maintaining compatibility with modern BAM-based toolsets like SAMtools and Picard.

## CLI Usage Patterns

### Basic Conversion
To convert a single-end BLAST result to SAM:
```bash
blast2bam blast_results.xml reference.fasta reads.fastq > output.sam
```

### Paired-End Data
For paired-end data, provide both FastQ files. The tool will automatically pair the BLAST results in the SAM output:
```bash
blast2bam blast_results.xml reference.fasta reads_1.fastq reads_2.fastq > output.sam
```

### Interleaved Input
If your input FastQ/Fasta is interleaved (forward and reverse sequences in one file), use the `-p` flag:
```bash
blast2bam -p blast_results.xml reference.fasta interleaved_reads.fastq > output.sam
```

## Common Options and Best Practices

### Metadata and Headers
*   **Read Groups**: Always include a read group header line using `-R` for compatibility with downstream tools like GATK or Picard.
    ```bash
    blast2bam -R '@RG\tID:foo\tSM:sample1' blast.xml ref.fasta reads.fastq > output.sam
    ```

### Alignment Filtering and Formatting
*   **Minimum Length**: Use `-W [INT]` to filter out short, potentially spurious alignments.
*   **CIGAR Strings**: Use the `-c` flag to output a "short" version of the CIGAR string (using 'M' instead of '=' and 'X'). This is often necessary for older tools that do not support the extended CIGAR format.
*   **Position Adjustment**: Use `-z` to ensure the alignment position is correctly adjusted to the reference coordinate system.

### Integration Workflow
Blast2Bam is typically the final step in a three-part pipe:
1.  **Convert**: FastQ to Fasta (if necessary).
2.  **Align**: Run `blastn` with `-outfmt 5` (XML).
3.  **Format**: Run `blast2bam` to generate the SAM file.

Example pipe:
```bash
blastn -db reference_db -query reads.fasta -outfmt 5 | blast2bam - reference.fasta reads.fastq > output.sam
```

## Docker Usage
If the binary is not installed locally, use the official Docker container. Ensure you mount the current working directory to `/data`:
```bash
docker run --rm -v ${PWD}:/data guyduche/blast2bam [options] blast.xml ref.fasta reads.fastq > output.sam
```

## Reference documentation
- [Blast2Bam Main Documentation](./references/github_com_guyduche_Blast2Bam.md)