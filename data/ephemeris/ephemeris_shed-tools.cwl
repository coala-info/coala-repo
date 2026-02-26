cwlVersion: v1.2
class: CommandLineTool
baseCommand: shed-tools
label: ephemeris_shed-tools
doc: "A command-line tool for managing tools in Galaxy from the Tool Shed.\n\nTool
  homepage: https://github.com/galaxyproject/ephemeris"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute: install, update, or test.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_shed-tools.out
