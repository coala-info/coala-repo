---
name: ucsc-lavtoaxt
description: The `lavToAxt` utility is part of the UCSC Genome Browser "Kent" toolset.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-lavtoaxt

## Overview
The `lavToAxt` utility is part of the UCSC Genome Browser "Kent" toolset. Its primary function is to convert the output of BLASTZ (LAV format) into AXT format. Unlike LAV files, AXT files include the actual nucleotide sequences for the alignment blocks. Because the source LAV file only contains coordinates, `lavToAxt` requires access to the underlying sequence data (usually in `.2bit` or `.nib` format) for both the target and query genomes to "reconstruct" the alignment with sequences.

## Usage Instructions

### Basic Command Pattern
The tool requires the input alignment, the sequence sources, and the output filename:
```bash
lavToAxt input.lav target_sequence query_sequence output.axt
```

### Sequence Data Sources
The `target_sequence` and `query_sequence` arguments can be:
- A path to a `.2bit` file (recommended for efficiency).
- A directory containing `.nib` files.
- A path to a specific `.nib` file.

### Common CLI Options
- `-fa`: Output the sequences in FASTA format within the AXT file.
- `-psl`: Input is in PSL format instead of LAV (though `pslToAxt` is often preferred for this).
- `-tDir`: Specify that the target sequence argument is a directory of nib files.
- `-qDir`: Specify that the query sequence argument is a directory of nib files.

### Expert Tips
1. **Coordinate Systems**: Ensure your sequence files match the assembly version used to generate the LAV file. Mismatched versions will result in incorrect sequences being pulled into the AXT output.
2. **Memory Efficiency**: Use `.2bit` files instead of directories of `.nib` files. The tool handles `.2bit` random access very efficiently, which is critical when processing large whole-genome alignments.
3. **Missing Sequences**: If the tool encounters coordinates in the LAV file that exceed the length of the provided sequence files, it will error out. This often happens if "chr" prefixes are inconsistent between the alignment file and the sequence metadata.
4. **Permissions**: If running a freshly downloaded binary from the UCSC server, remember to set execution permissions: `chmod +x lavToAxt`.

## Reference documentation
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-lavtoaxt Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-lavtoaxt_overview.md)