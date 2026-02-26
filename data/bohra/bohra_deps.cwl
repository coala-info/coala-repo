cwlVersion: v1.2
class: CommandLineTool
baseCommand: bohra_deps
label: bohra_deps
doc: "Manage bohra dependencies.\n\nTool homepage: https://github.com/kristyhoran/bohra"
inputs:
  - id: command
    type: string
    doc: The command to run (check, install, update)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
stdout: bohra_deps.out
