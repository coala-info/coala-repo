cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadbit
label: tadbit_to
doc: "A toolkit for analyzing and visualizing TADs.\n\nTool homepage: http://sgt.cnag.cat/3dg/tadbit/"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available choices: map, parse, filter, describe,
      clean, normalize, bin, merge, segment.'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadbit:1.0.1--py310h2a84d7f_1
stdout: tadbit_to.out
