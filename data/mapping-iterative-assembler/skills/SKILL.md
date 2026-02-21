---
name: mapping-iterative-assembler
description: "The Mapping Iterative Assembler (MIA) is a specialized tool for \"reference-assisted assembly.\" Unlike standard mappers, MIA operates iteratively: it aligns sequencing reads to a reference, calls a consensus sequence, and then uses that consensus as the reference for the next round of alignment."
homepage: https://github.com/mpieva/mapping-iterative-assembler
---

# mapping-iterative-assembler

## Overview
The Mapping Iterative Assembler (MIA) is a specialized tool for "reference-assisted assembly." Unlike standard mappers, MIA operates iteratively: it aligns sequencing reads to a reference, calls a consensus sequence, and then uses that consensus as the reference for the next round of alignment. This process repeats until the sequence converges. It is highly optimized for ancient DNA (aDNA) research because it can incorporate substitution matrices that account for common post-mortem chemical damages (like deamination), leading to more accurate mitochondrial reconstructions.

## CLI Usage and Best Practices

### Core Workflow
The tool typically involves an iterative loop. While the specific binary names are often `mia` and `ma`, the workflow follows this logic:
1.  **Initial Alignment**: Align shotgun or targeted reads to a starting reference (e.g., a related species or a standard mitochondrial reference).
2.  **Consensus Calling**: Generate a new consensus from the alignment.
3.  **Iteration**: Use the new consensus as the reference for the next mapping step.
4.  **Convergence**: Stop when the consensus sequence no longer changes between iterations.

### Key Functional Features
- **Ancient DNA Substitution Matrices**: Use the matrix support to improve alignment accuracy for damaged DNA. This is critical for aDNA to prevent the "reference bias" where damaged reads fail to map to a pristine reference.
- **Mitochondrial Assembly**: Best suited for small, high-coverage targets like the mitogenome. It is not intended for large-scale nuclear genome assembly.
- **Contamination Checking**: Use the companion `contamination-checker` program post-assembly. It compares the called consensus against a panel of known human mitochondria to identify reads that may be modern contaminants rather than endogenous ancient DNA.

### Common CLI Patterns & Tips
- **Substitution Matrices**: Ensure you are utilizing the `-M` flag (which is often the default in later versions) to enable the use of substitution matrices.
- **Circular References**: When assembling mitochondria, be aware of the "edge effect" at the start/end of the linear fasta reference. Some versions or related scripts (like `easy-consensus`) may help manage the circular nature of the genome.
- **The `--foot` Option**: Use this option for more precise control over the alignment parameters during the mapping phase.
- **The `-c` Option**: This flag is used during the consensus calling phase; ensure it is correctly configured to handle the depth and quality of your specific aDNA library.

### Troubleshooting
- **Compilation**: If building from source, the tool requires a standard GNU build environment (Gcc, Make, Autotools). Note that certain Haskell-based components (like `mia_consensus.hc`) may require specific older versions of the Glasgow Haskell Compiler (GHC) to compile correctly.
- **Input Formats**: While primarily designed for older formats, ensure your Fastq data is properly pre-processed (adapters trimmed) before starting the iterative loop.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_mpieva_mapping-iterative-assembler.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_mapping-iterative-assembler_overview.md)