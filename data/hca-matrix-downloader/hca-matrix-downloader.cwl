cwlVersion: v1.2
class: CommandLineTool
baseCommand: hca-matrix-downloader
label: hca-matrix-downloader
doc: "A tool for downloading expression matrices from the Human Cell Atlas (HCA).\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/hca-matrix-downloader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hca-matrix-downloader:0.0.4--py_0
stdout: hca-matrix-downloader.out
