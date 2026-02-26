cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani
label: pyani_additional
doc: "pyani: a Python package for ANI analysis\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
stdout: pyani_additional.out
