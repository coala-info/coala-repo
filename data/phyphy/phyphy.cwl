cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyphy
label: phyphy
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to container execution and disk space issues.\n\
  \nTool homepage: https://github.com/sjspielman/phyphy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyphy:0.4.3--py_0
stdout: phyphy.out
