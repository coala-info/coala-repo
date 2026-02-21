cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-genome-download
label: ncbi-genome-download
doc: "Download genome data from NCBI\n\nTool homepage: https://github.com/kblin/ncbi-genome-download/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-genome-download:0.3.3--pyh7cba7a3_0
stdout: ncbi-genome-download.out
