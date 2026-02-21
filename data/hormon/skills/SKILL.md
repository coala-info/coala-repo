---
name: hormon
description: HORmon is a specialized bioinformatics suite designed to characterize the repetitive architecture of centromeres in human genome assemblies.
homepage: https://github.com/ablab/HORmon
---

# hormon

## Overview
HORmon is a specialized bioinformatics suite designed to characterize the repetitive architecture of centromeres in human genome assemblies. It automates the transition from raw centromeric sequences to structured Higher-Order Repeat (HOR) annotations. The tool operates in two primary stages: first, it identifies individual alpha-satellite monomers based on a consensus template; second, it polishes these monomers and determines how they organize into the larger, repeating patterns that define centromeric structure.

## Usage Workflow

### 1. Monomer Inference
The first step extracts draft monomers from your centromeric sequence using a known alpha-satellite consensus template.

```bash
monomer_inference -seq <centromere_sequence.fa> -mon <alpha_sat_template.fa> -o <output_directory>
```

**Key Outputs:**
- `final/monomers.fa`: The inferred monomers.
- `final/final_decomposition.tsv`: Initial sequence annotation.

### 2. HOR Decomposition
The second step uses the inferred monomers to identify and decompose the sequence into Higher-Order Repeats.

```bash
HORmon --seq <centromere_sequence.fa> \
       --mon <output_directory>/final/monomers.fa \
       --cen-id <id> \
       --monomer-thr 2 \
       --edge-thr 2 \
       --min-traversals 2 \
       -o <hor_output_directory>
```

**Key Outputs:**
- `mn.fa`: Final polished monomers.
- `final_decomposition.tsv`: Final monomer decomposition.
- `HORs.tsv`: Description of identified HORs.
- `HORdecomposition.tsv`: Full HOR decomposition of the sequence.

## Best Practices and Expert Tips
- **Isolate Centromeres**: Always run HORmon on each centromere independently. The tool is not designed to process a whole-genome assembly simultaneously and may produce unreliable results if centromeres are not separated.
- **Input Requirements**: Ensure the input sequence is specifically the centromeric region. Providing an entire chromosome may lead to excessive noise or processing failure.
- **Threshold Tuning**:
    - `--monomer-thr`: Minimum occurrences required for a monomer to be considered valid.
    - `--edge-thr`: Minimum occurrences for monomer pairs.
    - `--min-traversals`: Minimum number of times a pattern must repeat to be classified as an HOR.
- **Environment**: HORmon is natively supported on Linux. If working on macOS or Windows, use a Linux-based container or environment.
- **Conda Installation**: The most reliable way to manage dependencies (like `stringdecomposer` and `clustalo`) is via bioconda: `conda install -c bioconda hormon`.

## Reference documentation
- [HORmon GitHub Repository](./references/github_com_ablab_HORmon.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hormon_overview.md)