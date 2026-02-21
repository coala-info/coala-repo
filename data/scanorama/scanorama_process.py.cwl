cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanorama_process.py
label: scanorama_process.py
doc: "A tool for processing and integrating single-cell RNA-seq datasets using Scanorama.\n
  \nTool homepage: https://github.com/brianhie/scanorama/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanorama:1.7.4--pyhdfd78af_0
stdout: scanorama_process.py.out
