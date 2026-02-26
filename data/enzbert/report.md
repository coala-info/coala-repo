# enzbert CWL Generation Report

## enzbert

### Tool Description
EnzBert: A BERT-based model for enzyme function prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/enzbert:1.1--pyh7e72e81_0
- **Homepage**: https://gitlab.inria.fr/nbuton/tfpc/-/tree/EnzBert_conda
- **Package**: https://anaconda.org/channels/bioconda/packages/enzbert/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/enzbert/overview
- **Total Downloads**: 44
- **Last updated**: 2025-10-29
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: enzbert [-h] [--chosen_model CHOSEN_MODEL] --fasta_path FASTA_PATH
               [--output_folder_path OUTPUT_FOLDER_PATH]
               [--max_seq_length MAX_SEQ_LENGTH] [--enzyme_a_priori]
               [--output_attentions_scores] [--top_k TOP_K] [--verbose]
               --path_model PATH_MODEL

optional arguments:
  -h, --help            show this help message and exit
  --chosen_model CHOSEN_MODEL
                        Which models to use: EnzBert_SwissProt_2016_08,
                        EnzBert_SwissProt_2018_01, EnzBert_SwissProt_2021_04,
                        EnzBert_EC40, EnzBert_ECPred40
  --fasta_path FASTA_PATH
                        Fasta file with the sequences
  --output_folder_path OUTPUT_FOLDER_PATH
                        Path of the csv output prediction
  --max_seq_length MAX_SEQ_LENGTH
                        Limit the sequence lenght and take only the begining
                        of the sequence. This can avoid Out Of Memory error
                        for very long sequences.
  --enzyme_a_priori     If we know the sequences are enzyme
  --output_attentions_scores
                        Compute and outputs attentions scores
  --top_k TOP_K         How many prediction per sequence
  --verbose             If the prediction results are shown in the terminal
  --path_model PATH_MODEL
                        Path of the directory containing the models
```


## Metadata
- **Skill**: generated
