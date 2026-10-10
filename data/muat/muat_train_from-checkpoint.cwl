cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - muat
  - train
  - from-checkpoint
label: muat_train_from-checkpoint
doc: "Train a MuAt model starting from a checkpoint.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: ckpt_filepath
    type: File
    doc: "Path to load the checkpoint (.pthx)."
    inputBinding:
      prefix: --ckpt-filepath
  - id: mutation_type
    type: string
    doc: "Mutation type; choose from {snv, snv+mnv, snv+mnv+indel, snv+mnv+indel+svmei, snv+mnv+indel+svmei+neg}."
    inputBinding:
      prefix: --mutation-type
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
    type: int
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
