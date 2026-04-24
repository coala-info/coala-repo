cwlVersion: v1.2
class: CommandLineTool
baseCommand: mockinbird_preprocess
label: mockinbird_preprocess
doc: "start preprocessing pipeline using a config script\n\nTool homepage: https://github.com/soedinglab/mockinbird"
inputs:
  - id: parclip_fastq
    type: File
    doc: path to PAR-CLIP fastq reads
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output directory - will be created if it does not exist
    inputBinding:
      position: 2
  - id: prefix
    type: string
    doc: filename prefix for newly created files
    inputBinding:
      position: 3
  - id: config_file
    type: File
    doc: path to preprocessing config file
    inputBinding:
      position: 4
  - id: log_level
    type:
      - 'null'
      - string
    doc: verbosity level of the logger
    inputBinding:
      position: 105
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mockinbird:1.0.0a1--py38he5da3d1_7
stdout: mockinbird_preprocess.out
