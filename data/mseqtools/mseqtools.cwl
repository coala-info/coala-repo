cwlVersion: v1.2
class: CommandLineTool
baseCommand: mseqtools
label: mseqtools
doc: "Sequence manipulation toolkit\n\nTool homepage: https://github.com/arumugamlab/mseqtools"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: subset'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mseqtools:0.9.1--h7132678_1
stdout: mseqtools.out
