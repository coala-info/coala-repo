cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - cis-ase
label: regtools_cis-ase
doc: "Identify cis ase.\n\nTool homepage: https://github.com/griffithlab/regtools/"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., identify)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
stdout: regtools_cis-ase.out
