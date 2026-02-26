cwlVersion: v1.2
class: CommandLineTool
baseCommand: enzbert
label: enzbert
doc: "EnzBert: A BERT-based model for enzyme function prediction.\n\nTool homepage:
  https://gitlab.inria.fr/nbuton/tfpc/-/tree/EnzBert_conda"
inputs:
  - id: chosen_model
    type:
      - 'null'
      - string
    doc: 'Which models to use: EnzBert_SwissProt_2016_08, EnzBert_SwissProt_2018_01,
      EnzBert_SwissProt_2021_04, EnzBert_EC40, EnzBert_ECPred40'
    inputBinding:
      position: 101
      prefix: --chosen_model
  - id: enzyme_a_priori
    type:
      - 'null'
      - boolean
    doc: If we know the sequences are enzyme
    inputBinding:
      position: 101
      prefix: --enzyme_a_priori
  - id: fasta_path
    type: File
    doc: Fasta file with the sequences
    inputBinding:
      position: 101
      prefix: --fasta_path
  - id: max_seq_length
    type:
      - 'null'
      - int
    doc: Limit the sequence lenght and take only the begining of the sequence. 
      This can avoid Out Of Memory error for very long sequences.
    inputBinding:
      position: 101
      prefix: --max_seq_length
  - id: output_attentions_scores
    type:
      - 'null'
      - boolean
    doc: Compute and outputs attentions scores
    inputBinding:
      position: 101
      prefix: --output_attentions_scores
  - id: path_model
    type: Directory
    doc: Path of the directory containing the models
    inputBinding:
      position: 101
      prefix: --path_model
  - id: top_k
    type:
      - 'null'
      - int
    doc: How many prediction per sequence
    inputBinding:
      position: 101
      prefix: --top_k
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If the prediction results are shown in the terminal
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_folder_path
    type:
      - 'null'
      - Directory
    doc: Path of the csv output prediction
    outputBinding:
      glob: $(inputs.output_folder_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enzbert:1.1--pyh7e72e81_0
