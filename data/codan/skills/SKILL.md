---
name: codan
description: CodAn identifies protein-coding regions and untranslated regions within eukaryotic transcript sequences. Use when user asks to annotate coding sequences, determine CDS boundaries in de novo transcriptomes, or predict the coding potential of full or partial transcripts.
homepage: https://github.com/pedronachtigall/CodAn
---

# codan

## Overview

CodAn (Coding sequence Annotator) is a computational tool designed to identify the structural regions of eukaryotic transcripts. By leveraging specialized predictive models, it distinguishes between the protein-coding regions and the non-coding 5' and 3' UTRs. This skill should be used when you have transcript sequences (in FASTA format) and need to determine their coding potential and exact CDS boundaries. It is particularly effective for annotating de novo assembled transcriptomes where genomic reference data might be limited.

## Model Selection

Choosing the correct model is critical for prediction accuracy. Models are categorized by taxonomic group and transcript completeness.

### Taxonomic Groups
- **VERT**: Vertebrates
- **INV**: Invertebrates
- **PLANTS**: Plants
- **FUNGI**: Fungi

### Transcript Types
- **full**: Use for transcripts believed to be complete (containing start and stop codons).
- **partial**: Use for fragmented transcripts or ESTs where the sequence may be truncated.

**Note**: Models must be decompressed (unzipped) before they can be passed to the `-m` parameter.

## Command Line Usage

The primary executable is `codan.py`.

### Basic Syntax
```bash
codan.py -t <transcripts.fa> -m <path/to/model_folder> -o <output_directory>
```

### Common Parameters
- `-t, --transcripts`: Path to the input FASTA file.
- `-m, --model`: Path to the directory containing the specific decompressed model.
- `-s, --strand`: Specify the strand to predict (plus, minus, or both). Default is `both`.
- `-c, --cpu`: Number of threads for parallel processing. Default is `1`.
- `-o, --output`: Directory where results will be saved.

### Execution Patterns

**Processing Vertebrate Full-Length Transcripts:**
```bash
codan.py -t human_transcripts.fa -m ./models/VERT_full -c 4 -o annotation_results
```

**Processing Plant Partial Transcripts (Plus Strand Only):**
```bash
codan.py -t arabidopsis_fragments.fa -m ./models/PLANTS_partial -s plus -c 8 -o plant_out
```

## Docker Integration

When using the official Docker container, the models are pre-installed in a specific location.

**Running via Docker:**
```bash
docker run -v $PWD:/project --rm -it pedronachtigall/codan:latest \
codan.py -t transcripts.fa -m /app/CodAn/models/VERT_full -o output_folder
```
*Note: The `-v $PWD:/project` flag mounts your current directory to the container's working directory.*

## Expert Tips

- **Sequence Formatting**: If your FASTA file has extremely long single-line sequences, use the provided `BreakLines.py` script to format them to 100 nucleotides per line for better compatibility:
  ```bash
  python3 BreakLines.py input.fa formatted_output.fa
  ```
- **Permissions**: If running from a git clone or manual installation, ensure the binaries have execution permissions: `chmod +x path/to/CodAn/bin/*`.
- **Dependencies**: Ensure `blastn` (NCBI-BLAST+) is in your system PATH, as CodAn relies on it for internal sequence analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| codan.py | CodAn: Coding Regions Annotator for transcripts using deep learning and BLAST. |
| tops-viterbi_decoding | ToPS Viterbi decoding tool |

## Reference documentation
- [CodAn README](./references/github_com_pedronachtigall_CodAn_blob_master_README.md)
- [CodAn Dockerfile](./references/github_com_pedronachtigall_CodAn_blob_master_Dockerfile.md)
- [BreakLines Script](./references/github_com_pedronachtigall_CodAn_blob_master_scripts_BreakLines.py.md)