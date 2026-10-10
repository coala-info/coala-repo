cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - muat
  - train
  - from-scratch
label: muat_train_from-scratch
doc: "Train a MuAt model from scratch.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: mutation_type
    type: string
    doc: "Mutation type; choose from {snv, snv+mnv, snv+mnv+indel, snv+mnv+indel+svmei, snv+mnv+indel+svmei+neg}."
    inputBinding:
      prefix: --mutation-type
  - id: use_motif
    type: boolean
    doc: "Use motif input."
    inputBinding:
      prefix: --use-motif
  - id: use_position
    type: ['null', boolean]
    doc: "Use genomic position input."
    inputBinding:
      prefix: --use-position
  - id: use_ges
    type: ['null', boolean]
    doc: "Use genic, exonic, and strand annotation."
    inputBinding:
      prefix: --use-ges
  - id: train_split_filepath
    type: File
    doc: "Training split data (columns prep_path, class_name, class_index); example file in example_files/train_split_example.tsv."
    inputBinding:
      prefix: --train-split-filepath
  - id: val_split_filepath
    type: File
    doc: "Internal validation split data; example file in example_files/val_split_example.tsv."
    inputBinding:
      prefix: --val-split-filepath
  - id: preprocessed_files
    type:
      type: array
      items: File
    doc: "Preprocessed .muat.tsv files named in the split files (staged in the working directory so relative names resolve)"
  - id: save_dir
    type: string
    doc: "Directory to save the model."
    inputBinding:
      prefix: --save-dir
  - id: epoch
    type: ['null', int]
    doc: "Number of epochs (default: 5)."
    inputBinding:
      prefix: --epoch
  - id: learning_rate
    type: ['null', float]
    doc: "Learning rate (default: 6e-4)."
    inputBinding:
      prefix: --learning-rate
  - id: batch_size
    type: ['null', int]
    doc: "Batch size (default: 2)."
    inputBinding:
      prefix: --batch-size
  - id: n_layer
    type: ['null', int]
    doc: "Number of attention layers (default: 1)."
    inputBinding:
      prefix: --n-layer
  - id: n_head
    type: ['null', int]
    doc: "Number of attention heads (default: 8)."
    inputBinding:
      prefix: --n-head
  - id: n_emb
    type: ['null', int]
    doc: "Embedding dimension (default: 128)."
    inputBinding:
      prefix: --n-emb
  - id: mutation_sampling_size
    type: ['null', int]
    doc: "Maximum number of mutations to fetch for the model (default: 5000)."
    inputBinding:
      prefix: --mutation-sampling-size
  - id: sampling_replacement
    type: ['null', boolean]
    doc: "Use sampling with replacement. Default is False"
    inputBinding:
      prefix: --sampling-replacement
  - id: motif_dictionary_filepath
    type: ['null', File]
    doc: "Path to the motif dictionary (.tsv)."
    inputBinding:
      prefix: --motif-dictionary-filepath
  - id: position_dictionary_filepath
    type: ['null', File]
    doc: "Path to the genomic position dictionary (.tsv)."
    inputBinding:
      prefix: --position-dictionary-filepath
  - id: ges_dictionary_filepath
    type: ['null', File]
    doc: "Path to the genic exonic strand dictionary (.tsv)."
    inputBinding:
      prefix: --ges-dictionary-filepath
outputs:
  - id: save_dir_out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.save_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.preprocessed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
