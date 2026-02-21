cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoquant.py
label: isoquant_isoquant.py
doc: "IsoQuant is a tool for the genome-based analysis of long-read RNA-seq data.\n
  \nTool homepage: https://github.com/ablab/IsoQuant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoquant:3.10.0--hdfd78af_0
stdout: isoquant_isoquant.py.out
