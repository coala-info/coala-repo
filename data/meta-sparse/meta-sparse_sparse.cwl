cwlVersion: v1.2
class: CommandLineTool
baseCommand: SPARSE.py
label: meta-sparse_sparse
doc: "Strain Prediction and Analysis with Representative SEquences\n\nTool homepage:
  https://github.com/zheminzhou/SPARSE/"
inputs:
  - id: command
    type: string
    doc: Command to execute (init, index, query, update, mapDB, predict, mash, 
      extract, report)
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
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse.out
