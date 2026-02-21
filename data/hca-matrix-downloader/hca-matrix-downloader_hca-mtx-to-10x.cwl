cwlVersion: v1.2
class: CommandLineTool
baseCommand: hca-mtx-to-10x
label: hca-matrix-downloader_hca-mtx-to-10x
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log indicating a failure to build a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/ebi-gene-expression-group/hca-matrix-downloader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hca-matrix-downloader:0.0.4--py_0
stdout: hca-matrix-downloader_hca-mtx-to-10x.out
