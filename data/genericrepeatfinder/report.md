# genericrepeatfinder CWL Generation Report

## genericrepeatfinder_grf-main

### Tool Description
This program performs genome-wide terminal inverted repeat (TIR), terminal direct repeat (TDR), and MITE candidate detection for input genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/genericrepeatfinder:1.0.2--h9948957_1
- **Homepage**: https://github.com/bioinfolabmu/GenericRepeatFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/genericrepeatfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genericrepeatfinder/overview
- **Total Downloads**: 18.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinfolabmu/GenericRepeatFinder
- **Stars**: N/A
### Original Help Text
```text
This program performs genome-wide terminal inverted repeat (TIR), terminal direct repeat (TDR), and MITE candidate detection for input genome sequences.
Usage: grf-main [options]
[mandatory parameters]
-i <string>  Input genome sequence file in FASTA format.
-c <int>  Choice of analysis: 0: TIR detection; 1: MITE candidate detection; 2: TDR detection.
-o <string>  Output directory.
--min_tr <int>  Minimum length of the terminal repeats; must >= 5.
[optional parameters]
-t <int>  Number of threads used in this program; default = 1.
-f <int> Format for outputs; 0: FASTA format; 1: only IDs; default = 0.
--max_mismatch <int>  Maximum number of mismatches allowed in the terminal repeats; set -1 to be unlimited; default = -1.
--max_indel <int>  Maximum number of indels allowed in the terminal repeats; set -1 to be unlimited; default = -1.
-p <int>  Maximum percentage of unpaired nucleotides in the terminal repeats; set -1 to be unlimited; default = 10.
-r <float>  Maximum length ratio of spacer/total sequence; set -1 to be unlimited; default = -1.
-s <int>  Length of the seed region; default = 10; must >= 5 and <= '--min_tr'.
--seed_mismatch <int>  Maximum mismatch number in the seed region; default = 1.
--min_space <int>  Minimum distance between two seed regions; for TIRs/TDRs, default = 0; for MITEs, default = 30.
--max_space <int>  Maximum distance between two seed regions; for TIRs/TDRs, default = 980; for MITEs, default = 780.

If indel is enabled, in the extension of seed regions, the following scoring matrix for alignment is used.
--match <int>  Award score (positive number) for 1 match; default = 1.
--mismatch <int>  Penalty score (positive number) for 1 mismatch; default = 1.
--indel <int>  Penalty score (positive number) for 1 indel; default = 2.
--block <int>  Block size during alignment; default = 100.
--block_ratio <float>  For the best alignment in the current block, if the length of aligned sequences <= block_ratio * block_size, the alignment procedure will stop and the end position of the best alignment will be returned. Otherwise, a new block will be created and the alignment will continue from the current end position; default = 0.8.

For MITE detection,
--min_tsd <int>  Minimum length of TSDs; default = 2.
--max_tsd <int>  Maximum length of TSDs; default = 10.

To restrict terminal repeat (TR) and spacer length of detected TIRs, TDRs, and MITE candidates, set the following options:
Note: minimum TR length has been set in the mandatory parameter '--min_tr'.
--max_tr <int>  Maximum TR length.
--min_spacer_len <int>  Minimum spacer length.
--max_spacer_len <int>  Maximum spacer length.
```

