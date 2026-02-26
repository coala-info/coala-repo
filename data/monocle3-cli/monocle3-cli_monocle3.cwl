cwlVersion: v1.2
class: CommandLineTool
baseCommand: monocle3
label: monocle3-cli_monocle3
doc: "Monocle 3 command-line interface\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: command
    type: string
    doc: The command to run (create, preprocess, reduceDim, partition, 
      topMarkers, learnGraph, orderCells, diffExp, plotCells)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
stdout: monocle3-cli_monocle3.out
