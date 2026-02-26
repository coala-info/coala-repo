cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mockinbird
  - postprocess
label: mockinbird_postprocess
doc: "start postprocessing pipeline using a config script\n\nTool homepage: https://github.com/soedinglab/mockinbird"
inputs:
  - id: preprocess_dir
    type: Directory
    doc: folder to files created by the preprocessing
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output directory - will be created if it does not exist
    inputBinding:
      position: 2
  - id: config_file
    type: File
    doc: path to the postprocessing config file
    inputBinding:
      position: 3
  - id: log_level
    type:
      - 'null'
      - string
    doc: verbosity level of the logger
    default: info
    inputBinding:
      position: 104
      prefix: --log_level
  - id: prefix
    type:
      - 'null'
      - string
    doc: preprocessing filename prefix - only required if there are multiple 
      table files in the specified preprocess directory
    default: None
    inputBinding:
      position: 104
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mockinbird:1.0.0a1--py38he5da3d1_7
stdout: mockinbird_postprocess.out
