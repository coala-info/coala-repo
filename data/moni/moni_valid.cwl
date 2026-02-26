cwlVersion: v1.2
class: CommandLineTool
baseCommand: moni
label: moni_valid
doc: "moni: error: argument {build,ms,mems,extend}: invalid choice: 'valid' (choose
  from 'build', 'ms', 'mems', 'extend')\n\nTool homepage: https://github.com/maxrossi91/moni"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (build, ms, mems, extend)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
stdout: moni_valid.out
