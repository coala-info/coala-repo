cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus-classify
label: famus_famus-classify
doc: "Classify protein sequences using installed models.\n\nTool homepage: https://github.com/burstein-lab/famus"
inputs:
  - id: input_fasta_file_path
    type: File
    doc: Path to input fasta file
    inputBinding:
      position: 1
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of sequences to process at once for classification or threshold 
      calculation.
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: config
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 102
      prefix: --config
  - id: device
    type:
      - 'null'
      - string
    doc: Device to use (cpu or cuda).
    inputBinding:
      position: 102
      prefix: --device
  - id: load_sdf_from_pickle
    type:
      - 'null'
      - boolean
    doc: Load sdf_train from pickle instead of json for slightly faster 
      classification preprocessing.
    inputBinding:
      position: 102
      prefix: --load-sdf-from-pickle
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save logs.
    inputBinding:
      position: 102
      prefix: --log-dir
  - id: model_type
    type:
      - 'null'
      - string
    doc: Type of model(s) to use (comprehensive or light).
    inputBinding:
      position: 102
      prefix: --model-type
  - id: models
    type:
      - 'null'
      - string
    doc: Models to use for classification separated by commas
    inputBinding:
      position: 102
      prefix: --models
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save or load models.
    inputBinding:
      position: 102
      prefix: --models-dir
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use.
    inputBinding:
      position: 102
      prefix: --n-processes
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Disable logging.
    inputBinding:
      position: 102
      prefix: --no-log
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
