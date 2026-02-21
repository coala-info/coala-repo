cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-upload
label: galaxy-upload
doc: "A tool for uploading data to a Galaxy instance. Note: The provided help text
  contains only system error messages and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/galaxyproject/galaxy-upload"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-upload:1.0.1--pyhdfd78af_0
stdout: galaxy-upload.out
