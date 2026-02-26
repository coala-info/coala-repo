cwlVersion: v1.2
class: CommandLineTool
baseCommand: neurodocker
label: neurodocker_reprozip
doc: "Neurodocker is a command-line interface to generate custom Dockerfiles and Singularity
  recipes.\n\nTool homepage: https://github.com/kaczmarj/neurodocker"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Valid options are: generate, reprozip.'
    inputBinding:
      position: 1
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Set logging verbosity level. Options: debug, info, warning, error, critical.'
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neurodocker:0.5.0--py_0
stdout: neurodocker_reprozip.out
