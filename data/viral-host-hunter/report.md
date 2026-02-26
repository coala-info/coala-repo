# viral-host-hunter CWL Generation Report

## viral-host-hunter_vhh-predict

### Tool Description
Run the Viral-Host-Hunter prediction pipeline for viral host identification based on protein and DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-host-hunter:0.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/YuehuaOu/Viral-Host-Hunter
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-host-hunter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viral-host-hunter/overview
- **Total Downloads**: 128
- **Last updated**: 2026-01-06
- **GitHub**: https://github.com/YuehuaOu/Viral-Host-Hunter
- **Stars**: N/A
### Original Help Text
```text
usage: vhh-predict [-h] --protein PROTEIN --dna DNA --seq_type {tail,lysin}
                   [--phage_type {gut,environment}]
                   [--level {all,family,genus,species}]
                   [--model_dir MODEL_DIR] [--embedding_dir EMBEDDING_DIR]
                   [--output_dir OUTPUT_DIR]
                   [--output_format {csv,tsv,xlsx,both}]
                   [--prott5_dir PROTT5_DIR] [--lineage]

Run the Viral-Host-Hunter prediction pipeline for viral host identification
based on protein and DNA sequences.

options:
  -h, --help            show this help message and exit
  --protein PROTEIN     Path to the protein FASTA file to be predicted.
  --dna DNA             Path to the corresponding DNA FASTA file.
  --seq_type {tail,lysin}
                        Protein type used for prediction: "tail" or "lysin".
  --phage_type {gut,environment}
                        Phage source type: "gut" for intestinal phages or
                        "environment" for environmental phages. (default: gut)
  --level {all,family,genus,species}
                        Taxonomic prediction level: "all", "family", "genus",
                        or "species". (default: all)
  --model_dir MODEL_DIR
                        Directory containing the trained Viral-Host-Hunter
                        models.
  --embedding_dir EMBEDDING_DIR
                        Directory to save/load precomputed embeddings
                        (prot_embedding.h5, dna_embedding.h5). If embeddings
                        already exist, they will be reused to speed up
                        prediction. (default: ./embeddings)
  --output_dir OUTPUT_DIR
                        Directory to save prediction results. (default:
                        ./output)
  --output_format {csv,tsv,xlsx,both}
                        Output format for prediction results.
  --prott5_dir PROTT5_DIR
                        Path to a local ProtT5 model directory for offline
                        embedding generation. Use this option if the system
                        cannot download the model from the internet. (default:
                        None)
  --lineage             If set, append lineage columns in the output.
```

