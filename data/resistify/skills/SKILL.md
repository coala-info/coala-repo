---
name: resistify
description: Resistify is a lightweight, high-throughput tool designed to identify and classify plant resistance genes from protein FASTA files.
homepage: https://github.com/swiftseal/resistify
---

# resistify

## Overview
Resistify is a lightweight, high-throughput tool designed to identify and classify plant resistance genes from protein FASTA files. It primarily targets two classes of proteins: Nucleotide-binding Leucine-rich Repeat (NLR) proteins and Pattern Recognition Receptors (PRRs). By combining domain searches with re-implementations of specialized tools like NLRexpress and TMbed, it provides detailed annotations of motifs, domains, and classification types (e.g., CNL, TNL, RLP, RLK).

## Usage Patterns

### NLR Identification
To predict NLRs within a set of protein sequences, use the `nlr` command. By default, this identifies sequences containing NB-ARC domains.

```bash
resistify nlr <input.fa> -o <output_directory>
```

**Key Options:**
- `--retain`: Use this to identify highly fragmented NLRs. It reports NLR-associated motifs for all sequences, even those without a full NB-ARC domain. Note: This increases processing time.
- `--coconat`: Enhances coiled-coil (CC) domain annotation sensitivity. It can identify cryptic CCs that lack the standard EDVID motif.

### PRR Identification
To predict Pattern Recognition Receptors (RLPs and RLKs), use the `prr` command.

```bash
resistify prr <input.fa> -o <output_directory>
```

**Important Considerations:**
- **Hardware**: The PRR pipeline is GPU-accelerated. Running on CPU only will be significantly slower.
- **Logic**: It uses TMbed to identify single-pass transmembrane domains and NLRexpress for LRR domains.

### Visualization
If you have already run a prediction and want to generate plots of the results:

```bash
resistify draw
```

### Model Management
For environments without active internet access during runtime (e.g., HPC clusters), pre-download the required models for CoCoNat or PRR pipelines:

```bash
download_models
```

## Interpreting Results
The tool generates several TSV files in the output directory:
- `results.tsv`: The primary summary. Look at the **Classification** column for the final call (e.g., CNL, TNL, RLK).
- `motifs.tsv`: Detailed breakdown of NLRexpress motifs (P-loop, Walker-B, etc.) with positions and probabilities.
- `domains.tsv`: List of all identified domains per sequence.
- `nlr.fasta` / `prr.fasta`: FASTA files containing only the identified resistance gene sequences.

## Expert Tips
- **MADA Motifs**: Check the `MADA` and `MADAL` columns in `results.tsv` for NLRs. These indicate the presence of specific N-terminal signatures associated with cell death triggering.
- **Environment Variables**: If you need to change where models are stored, set the `$HF_HOME` and `$TORCH_HOME` environment variables before running the tool.
- **Input Format**: Ensure input files are protein sequences. Resistify is not designed for direct nucleotide input.

## Reference documentation
- [SwiftSeal/resistify GitHub Repository](./references/github_com_SwiftSeal_resistify.md)