cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus-install
label: famus_famus-install
doc: "Download and install FAMUS pre-trained models\n\nTool homepage: https://github.com/burstein-lab/famus"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config
  - id: download_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory to download tar files to (default: current directory)'
    inputBinding:
      position: 101
      prefix: --download-dir
  - id: keep_tars
    type:
      - 'null'
      - boolean
    doc: Keep downloaded tar files after extraction
    inputBinding:
      position: 101
      prefix: --keep-tars
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save logs.
    default: /root/.famus/logs
    inputBinding:
      position: 101
      prefix: --log-dir
  - id: models
    type: string
    doc: 'Models to install (format: model_type, e.g., kegg_comprehensive,orthodb_light)'
    inputBinding:
      position: 101
      prefix: --models
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the installed models to
    inputBinding:
      position: 101
      prefix: --models-dir
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
stdout: famus_famus-install.out
