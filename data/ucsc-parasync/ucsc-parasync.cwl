cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraSync
label: ucsc-parasync
doc: "A tool for parallel rsync, typically used for downloading data from UCSC genome
  browser servers.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parasync:482--h0b57e2e_0
stdout: ucsc-parasync.out
