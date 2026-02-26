cwlVersion: v1.2
class: CommandLineTool
baseCommand: circtools
label: circtools_command
doc: "a modular, python-based framework for circRNA-related tools that unifies several
  functions in single command line driven software.\n\nTool homepage: https://github.com/dieterich-lab/circtools"
inputs:
  - id: command
    type: string
    doc: Command to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_command.out
