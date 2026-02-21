---
name: varvamp
description: varVAMP (Variable Virus AMPlicons) is a specialized primer design tool tailored for the extreme genetic diversity found in viral populations.
homepage: https://github.com/jonas-fuchs/varVAMP
---

# varvamp

## Overview
varVAMP (Variable Virus AMPlicons) is a specialized primer design tool tailored for the extreme genetic diversity found in viral populations. While standard tools often fail on highly variable alignments, varVAMP introduces ambiguous (degenerate) characters into primer sequences and minimizes mismatches at the critical 3' end. It is the primary tool for generating ARTIC-style tiled primer schemes for viruses, ensuring that the majority of variants in an alignment are successfully amplified for downstream sequencing on platforms like Oxford Nanopore or Illumina.

## Usage Modes
The tool operates in three distinct "flavors" depending on the experimental goal:

- **TILED**: Uses a graph-based approach to design overlapping amplicons that cover the entire viral genome. This is the standard mode for whole-genome sequencing (WGS).
- **SINGLE**: Identifies the highest-quality non-overlapping amplicons. Best for PCR-based screening or diagnostic applications where full coverage is not required.
- **QPCR**: Designs small amplicons with optimized internal TaqMan probes. It balances melting temperatures (Tm) between primers and probes while checking for secondary structures.

## Command Line Patterns
The basic syntax follows a sub-command structure:
```bash
varvamp [MODE] -i <input_alignment.fasta> [OPTIONS]
```

### Common Options and Flags
- `-i, --input`: Path to the input viral sequence alignment (FASTA format).
- `--name`: Specify a prefix for the output files and primer names.
- `-a`: Used in qPCR mode to define specific constraints (e.g., setting to 0 can trigger specific behaviors in older versions).
- `--n_to_test`: Defines the number of primer candidates to evaluate during the optimization phase.

## Best Practices and Expert Tips
- **Alignment Quality**: The quality of your input alignment is the single most important factor. Ensure sequences are properly aligned; varVAMP will report extensively gapped sequences that might interfere with design.
- **Degeneracy Management**: varVAMP automatically introduces ambiguous characters. If the diversity is too high, the degeneracy might become too great for synthesis. Monitor the logs for the number of variants covered by each primer.
- **ARTIC Compatibility**: varVAMP outputs primer BED files in ARTICv3 format. These are directly compatible with many NGS pipelines (like the ARTIC field bioinformatics pipeline) for primer clipping.
- **Off-Target Checking**: The tool integrates with BLAST to check for off-target binding. Amplicons with potential off-target hits are reported in the `off_target_amplicons` column of the output TSV files.
- **Tiled Overlaps**: In `TILED` mode, the tool enforces overlaps between amplicon inserts to ensure no "blind spots" exist in the final consensus sequence.
- **Output Interpretation**:
    - **TSV files**: Contain detailed metrics for every primer pair, including penalty scores and BLAST hits.
    - **BED files**: Provide the coordinates and pool assignments for the primer scheme.
    - **Consensus files**: Differentiate between majority consensus and "ambi" (ambiguous) consensus sequences.

## Reference documentation
- [varVAMP GitHub Overview](./references/github_com_jonas-fuchs_varVAMP.md)
- [varVAMP Bioconda Package](./references/anaconda_org_channels_bioconda_packages_varvamp_overview.md)
- [Version 1.2.0 Release Notes (Algorithmic Details)](./references/github_com_jonas-fuchs_varVAMP_tags.md)