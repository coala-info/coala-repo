---
name: tbl2asn
description: The tbl2asn utility converts sequence data and annotation tables into formatted submission packages for GenBank. Use when user asks to prepare Sequin files for NCBI submission, validate sequence annotations, or process bulk genomic data into submission-ready formats.
homepage: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2
---


# tbl2asn

## Overview
The `tbl2asn` utility is a command-line tool designed by NCBI to streamline the transition from raw sequence data and annotation tables to a formatted submission package. It validates the consistency between sequences and their annotations, ensuring that the resulting Sequin files (.sqn) meet GenBank's structural requirements. It is particularly useful for bulk processing of multiple sequences or complex eukaryotic genomes where manual entry is impractical.

## Command Line Usage
The basic syntax requires a directory containing your input files (FASTA and Feature Tables).

```bash
tbl2asn -i [input_file] -t [template_file] -p [directory_path]
```

### Common Arguments
- `-i <filename>`: Input nucleotide FASTA file (must end in .fsa).
- `-t <filename>`: Submission template file (generated via NCBI's Submission Template Tool).
- `-p <path>`: Path to a directory containing input files (alternative to `-i`).
- `-a <type>`: Specifies the file type (e.g., `s` for set, `g` for genomic).
- `-V <flags>`: Verification checks. Use `-V b` to generate a validation report (.val).
- `-M <flags>`: Flag for genomic/mitochondrial/chloroplast metadata (e.g., `-M n` for normal).
- `-j <text>`: Source qualifiers (e.g., `"[organism=Drosophila melanogaster] [strain=standard]"`).

### Standard Workflow
1. **Prepare Files**: Place your `.fsa` (sequence) and `.tbl` (feature table) files in the same directory. They must share the same base filename (e.g., `genome.fsa` and `genome.tbl`).
2. **Run tbl2asn**: Execute the tool pointing to that directory.
   ```bash
   tbl2asn -p . -t template.sbt -V b
   ```
3. **Review Outputs**:
   - `.sqn`: The final submission file.
   - `.val`: Validation errors/warnings.
   - `.dr`: Summary report of the submission.

## Expert Tips
- **Filename Matching**: `tbl2asn` matches features to sequences based on the filename prefix. Ensure your `.fsa`, `.tbl`, and optional `.src` (source) files are named identically before the extension.
- **Validation First**: Always check the `.val` file. "Errors" must be fixed before submission, while "Warnings" should be reviewed for accuracy.
- **Template Updates**: If you are submitting multiple batches, ensure your `.sbt` template file is up to date with current contact and citation information to avoid rejection.
- **Protein Translation**: The tool automatically generates protein translations from CDS features in the `.tbl` file. If translations fail, check for frame shifts or incorrect stop codon placement in your feature table coordinates.

## Reference documentation
- [tbl2asn Overview](./references/anaconda_org_channels_bioconda_packages_tbl2asn_overview.md)