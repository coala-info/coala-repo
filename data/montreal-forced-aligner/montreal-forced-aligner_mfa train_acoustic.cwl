cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - montreal-forced-aligner
  - mfa
  - train_acoustic
label: montreal-forced-aligner_mfa train_acoustic
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
  - id: output_directory
    type: Directory
    doc: Path to the directory to save the trained acoustic model.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
