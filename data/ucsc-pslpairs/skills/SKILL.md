---
name: ucsc-pslpairs
description: This tool identifies and joins paired-end read alignment records within PSL files. Use when user asks to process paired-end BLAT results, join alignment records, or filter for concordant read pairs.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-pslpairs

## Overview
The `ucsc-pslpairs` tool is a specialized utility from the UCSC Genome Browser "kent" suite designed to process PSL alignment files. It identifies and joins alignment records representing paired-end reads. This is essential in bioinformatics pipelines to validate library insert sizes, filter for concordant pairs, or identify discordant alignments that may indicate genomic rearrangements.

## Usage Instructions

### Basic Command Pattern
The tool typically requires an input PSL file and an output destination. Because it is a UCSC utility, running the command without arguments usually displays the full help text.

```bash
pslPairs [options] input.psl output.psl
```

### Common Workflow Patterns
1. **Joining BLAT Results**: After aligning paired-end reads using BLAT, use `pslPairs` to consolidate the individual read alignments into paired records.
2. **Filtering by Proximity**: Use the tool to ensure that paired reads align within a reasonable distance of each other on the same chromosome.
3. **Orientation Validation**: The tool checks that reads are in the expected orientation (e.g., forward-reverse) based on the sequencing library type.

### Expert Tips
- **Input Sorting**: While some UCSC tools require sorted input, `pslPairs` often performs better or requires input to be grouped by query name so that pairs are processed together.
- **Score Thresholds**: When joining pairs, the tool may allow you to set minimum score requirements to ensure only high-quality alignments are considered for pairing.
- **Handling Multiple Hits**: If a read has multiple alignments, `pslPairs` helps resolve which pair combination is the most likely "true" genomic origin based on distance and alignment scores.

## Reference documentation
- [ucsc-pslpairs Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_ucsc-pslpairs_overview.md)
- [UCSC Kent Tool Binaries (Linux x86_64)](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Genome Browser Source (Kent)](./references/github_com_ucscGenomeBrowser_kent.md)