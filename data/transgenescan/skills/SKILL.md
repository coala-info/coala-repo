---
name: transgenescan
description: TransGeneScan predicts coding sequences and genes in metatranscriptomic data, including on both sense and anti-sense strands. Use when user asks to predict coding sequences, find genes in metatranscriptomic data, convert gene predictions to GFF format, separate sense and antisense gene predictions, or assemble transcripts and predict genes from raw reads.
homepage: https://github.com/COL-IU/TransGeneScan
---


# transgenescan

## Overview
TransGeneScan is a specialized gene-finding tool optimized for metatranscriptomic data. It extends the logic of FragGeneScan by incorporating strand-specific hidden states, allowing it to accurately predict coding sequences (CDS) on both sense and anti-sense strands. This is particularly valuable for assembled transcripts where strand orientation is not always guaranteed. The tool can identify single genes or multiple genes within an operon and provides outputs in standard bioinformatics formats including FASTA (nucleic and amino acid) and GFF.

## Command Line Usage

### Primary Execution
The main interface for the tool is a Perl wrapper that handles the HMM execution and initial processing.

```bash
run_TransGeneScan.pl -in=[input_fasta] -out=[output_prefix] -thread=[number]
```

- `-in`: Path to the input FASTA file containing assembled transcripts.
- `-out`: Base name for output files (the tool will append extensions).
- `-thread`: Number of threads to use (default is 1).

### Output File Extensions
TransGeneScan generates several files based on the `[output_prefix]`:
- `.out`: The primary coordinate file (start, end, strand, frame, score).
- `.ffn`: Nucleotide sequences of predicted genes.
- `.faa`: Amino acid sequences of predicted genes.
- `.rem`: Headers of input sequences where no genes were predicted.

## Post-Processing and Format Conversion

### Converting to GFF
To integrate results into genomic pipelines, convert the native output to GFF3 format using the provided Python utility:

```bash
python FGS_gff.py [output_prefix].out [output_prefix].gff
```

### Separating Sense and Antisense Predictions
If your analysis requires distinguishing between genes found on the sense vs. antisense strands, use the `processFragOut.py` script:

```bash
python processFragOut.py [input_fasta] [output_prefix].out [output_prefix]
```
This generates:
- `[output_prefix].sn`: Predictions on sense transcripts.
- `[output_prefix].as`: Predictions on antisense transcripts.

## Assembly Pipeline
If starting from raw reads rather than assembled transcripts, TransGeneScan includes a pipeline script to assemble transcripts based on read mappings to a reference genome:

```bash
./scripts/pipeline.sh [reference.fasta] [reads_prefix] [TGS_HOME_DIR] [n] [k] [t]
```
*Note: `n`, `k`, and `t` are parameters passed directly to BWA.*

## Best Practices and Tips
- **Input Quality**: Ensure your input FASTA headers do not contain complex characters that might break the Perl/Python parsing logic.
- **Thread Scaling**: For large metatranscriptomic assemblies, always utilize the `-thread` parameter to significantly reduce execution time.
- **Interpreting Scores**: The fifth column in the `.out` file is a log-likelihood score. Higher scores indicate higher confidence in the gene prediction.
- **Handling .rem Files**: Always check the `.rem` file. A high number of sequences in this file may indicate highly fragmented assemblies or non-coding RNA sequences that the HMM cannot model.
- **Environment**: Ensure `perl`, `python`, and a C compiler (like `gcc`) are in your PATH. If using the assembly pipeline, `bwa` and `samtools` must also be available.

## Reference documentation
- [TransGeneScan GitHub README](./references/github_com_COL-IU_TransGeneScan.md)
- [Bioconda TransGeneScan Overview](./references/anaconda_org_channels_bioconda_packages_transgenescan_overview.md)