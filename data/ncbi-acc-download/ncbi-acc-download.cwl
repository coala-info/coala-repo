cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-acc-download
label: ncbi-acc-download
doc: "Download sequences from NCBI by accession number.\n\nTool homepage: https://github.com/kblin/ncbi-acc-download/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-acc-download:0.2.8--pyh5e36f6f_0
stdout: ncbi-acc-download.out
