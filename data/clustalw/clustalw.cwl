cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalw
label: clustalw
doc: "ClustalW is a general purpose multiple sequence alignment program for DNA or
  proteins.\n\nTool homepage: https://github.com/coldfunction/CUDA-clustalW"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clustalw:2.1--h9948957_12
stdout: clustalw.out
