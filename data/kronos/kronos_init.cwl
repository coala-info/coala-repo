cwlVersion: v1.2
class: CommandLineTool
baseCommand: kronos_init
label: kronos_init
doc: "initialize a pipeline from a given config file\n\nTool homepage: https://github.com/jtaghiyar/kronos"
inputs:
  - id: config_file
    type: File
    doc: path to the config_file.yaml
    inputBinding:
      position: 101
      prefix: --config_file
  - id: input_samples
    type:
      - 'null'
      - File
    doc: path to the samples file
    inputBinding:
      position: 101
      prefix: --input_samples
  - id: pipeline_name
    type: string
    doc: a name for the resultant pipeline
    inputBinding:
      position: 101
      prefix: --pipeline_name
  - id: setup_file
    type:
      - 'null'
      - File
    doc: path to the setup file
    inputBinding:
      position: 101
      prefix: --setup_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0
stdout: kronos_init.out
