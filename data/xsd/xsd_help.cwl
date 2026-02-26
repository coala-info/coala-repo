cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsd
label: xsd_help
doc: "xsd is a command-line tool for generating code from XML Schema Definitions (XSD).\n\
  \nTool homepage: https://github.com/tefra/xsdata"
inputs:
  - id: cmd
    type: string
    doc: 'The command to execute. Available commands: help, version, cxx-tree, cxx-parser.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsd:4.0.0_dep--h0a036d8_4
stdout: xsd_help.out
