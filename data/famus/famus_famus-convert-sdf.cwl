cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus-convert-sdf
label: famus_famus-convert-sdf
doc: "Convert sdf_train.json files of installed models to pickle format.\n\nTool homepage:
  https://github.com/burstein-lab/famus"
inputs:
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of sequences to process at once for classification or threshold 
      calculation.
    default: 20000
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: config
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config
  - id: device
    type:
      - 'null'
      - string
    doc: Device to use (cpu or cuda).
    default: cuda
    inputBinding:
      position: 101
      prefix: --device
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save logs.
    default: /root/.famus/logs
    inputBinding:
      position: 101
      prefix: --log-dir
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save or load models.
    default: /root/.famus/models
    inputBinding:
      position: 101
      prefix: --models-dir
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use.
    default: 4
    inputBinding:
      position: 101
      prefix: --n-processes
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Disable logging.
    default: false
    inputBinding:
      position: 101
      prefix: --no-log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus_famus-convert-sdf.out
