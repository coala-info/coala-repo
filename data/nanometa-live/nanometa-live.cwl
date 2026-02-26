cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanometa-live
label: nanometa-live
doc: "Starting the Nanometa Live pipeline.\n\nTool homepage: https://github.com/FOI-Bioinformatics/nanometa_live"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the configuration file.
    default: config.yaml
    inputBinding:
      position: 101
      prefix: --config
  - id: path
    type: Directory
    doc: The path to the project directory.
    inputBinding:
      position: 101
      prefix: --path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanometa-live:0.4.3--pyhdfd78af_0
stdout: nanometa-live.out
