cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - train
label: montreal-forced-aligner_mfa_train_acoustic
doc: "Train an acoustic model.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
inputs:
  - id: corpus_directory
    type: Directory
    doc: Path to the directory containing the corpus.
    inputBinding:
      position: 1
  - id: dictionary_path
    type: File
    doc: Path to the dictionary file.
    inputBinding:
      position: 2
  - id: output_model_path
    type: string
    doc: Path of the trained acoustic model (zip) to write.
    inputBinding:
      position: 3
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Clean intermediate files before training.
    inputBinding:
      position: 103
      prefix: --clean
  - id: config_path
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    inputBinding:
      position: 103
      prefix: --config_path
  - id: num_jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs to use.
    inputBinding:
      position: 103
      prefix: --num_jobs
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output directory if it exists.
    inputBinding:
      position: 103
      prefix: --overwrite
outputs:
  - id: acoustic_model
    type: File
    doc: The trained acoustic model.
    outputBinding:
      glob: $(inputs.output_model_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
