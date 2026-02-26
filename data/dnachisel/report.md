# dnachisel CWL Generation Report

## dnachisel

### Tool Description
DNA Chisel Command Line Interface

### Metadata
- **Docker Image**: quay.io/biocontainers/dnachisel:3.2.16--pyh7e72e81_0
- **Homepage**: https://github.com/Edinburgh-Genome-Foundry/DnaChisel
- **Package**: https://anaconda.org/channels/bioconda/packages/dnachisel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnachisel/overview
- **Total Downloads**: 45.2K
- **Last updated**: 2025-05-10
- **GitHub**: https://github.com/Edinburgh-Genome-Foundry/DnaChisel
- **Stars**: N/A
### Original Help Text
```text
DNA Chisel Command Line Interface

Usage:
  dnachisel <source> <target> [--circular] [--mute] [--with_sequence_edits]

Where ``source`` is a fasta or Genbank file, and target can be one of:
- A folder name or a zip name (extension .zip). In this case a complete report
  along with the sequence will be generated.
- A Genbank file. In this case, only the optimized sequence file is created.
  The with_sequence_edits option specifies that edits are also annotated in the
  Genbank file. Note that the filename must end with '.gb'.

Note: this CLI will be developed on a per-request basis, so don't hesitate to
ask for more handles and options on Github
(https://github.com/Edinburgh-Genome-Foundry/DnaChisel/issues)

Example to output the result to a genbank:

>>> dnachisel annotated_record.gb optimized_record.gb

Example to output the result to a folder:

>>> dnachisel annotated_record.gb optimization_report/

Example to output the result to a zip archive:

>>> dnachisel annotated_record.gb optimization_report.zip
```

