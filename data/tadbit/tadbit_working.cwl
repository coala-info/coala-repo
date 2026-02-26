cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadbit
label: tadbit_working
doc: "TADbit: a toolkit for the analysis of 3D genome organization.\n\nTool homepage:
  http://sgt.cnag.cat/3dg/tadbit/"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (map, parse, filter, describe, clean, normalize, bin,
      merge, segment)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadbit:1.0.1--py310h2a84d7f_1
stdout: tadbit_working.out
