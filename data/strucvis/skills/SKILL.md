---
name: strucvis
description: strucvis is a specialized tool for small RNA (sRNA) research that integrates sequence alignment data with structural predictions.
homepage: https://github.com/MikeAxtell/strucVis
---

# strucvis

## Overview

strucvis is a specialized tool for small RNA (sRNA) research that integrates sequence alignment data with structural predictions. By processing sorted BAM files against a reference genome, it utilizes RNAfold to predict the secondary structure of a specific genomic region and then color-codes the resulting structure based on the depth of sRNA coverage. This provides a visual representation of how sRNAs map onto hairpins or other structural motifs, accompanied by a plain-text alignment view in dot-bracket notation.

## Installation and Environment

The tool is available via Bioconda. It requires `perl5`, `samtools`, `RNAfold` (from the ViennaRNA package), and `ps2pdf` (from Ghostscript) to be available in your system PATH.

```bash
conda install bioconda::strucvis
```

## Command Line Usage

The primary command is `strucVis`. All inputs except for the locus name and optional switches are required.

### Basic Syntax
```bash
strucVis -b <alignments.bam> -g <genome.fa> -c <Chr:start-stop> -s <strand> -p <output_prefix>
```

### Required Arguments
- `-b`: Path to a sorted and indexed BAM file containing sRNA alignments.
- `-g`: Path to the FASTA formatted reference genome. This file must be indexed using `samtools faidx`.
- `-c`: Genomic coordinates of interest in the format `Chr:start-stop` (e.g., `Chr4:11962937-11963045`).
- `-s`: The strand of interest. You must specify either `plus` or `minus`.
- `-p`: The name for the output PDF file. **Do not include the .pdf extension**; the tool appends it automatically.

### Optional Arguments
- `-n`: A descriptive name for the locus (e.g., `MIR159a`). This name appears in the PDF and the text alignment file. Defaults to "Unnamed Locus".
- `-x`: Suppress the printing of detailed file metadata (paths, coordinates) on the generated post-script/PDF file.
- `-v`: Display version information.
- `-h`: Display the help message.

## Expert Tips and Best Practices

- **Index Verification**: Before running `strucVis`, ensure your BAM file has a corresponding `.bai` index and your genome FASTA has a `.fai` index in the same directory. The tool will fail if these are missing.
- **Coordinate Selection**: When visualizing miRNA precursors, include roughly 15-20 nucleotides of flanking sequence around the predicted foldback to ensure `RNAfold` captures the full structural context.
- **Output Interpretation**: 
    - **PDF**: Provides a high-quality vector graphic where nucleotide colors represent read depth.
    - **Text File**: Generates a `.txt` file showing the dot-bracket structure with individual sRNA sequences aligned underneath, including their length (`len`) and abundance (`al`).
- **Apple Silicon (M1/M2/M3) Compatibility**: If installing via Conda on modern Macs, you may need to set the subdir to `osx-64` for the environment to resolve dependencies correctly:
  ```bash
  conda config --env --set subdir osx-64
  conda install strucvis
  ```
- **Ghostscript Dependency**: If the tool runs but fails to produce a PDF, verify that `ps2pdf` is functional in your terminal, as this is the final step in the visualization pipeline.

## Reference documentation
- [strucVis GitHub Repository](./references/github_com_MikeAxtell_strucVis.md)
- [Bioconda strucvis Overview](./references/anaconda_org_channels_bioconda_packages_strucvis_overview.md)