cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigCorrelate
label: ucsc-wigcorrelate
doc: "Produce a table of Pearson correlation coefficients for a set of wig files.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: Wig files to correlate
    inputBinding:
      position: 1
  - id: clamp_max
    type:
      - 'null'
      - float
    doc: Values greater than this are set to this
    inputBinding:
      position: 102
      prefix: -clampMax
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wigcorrelate:482--h0b57e2e_0
stdout: ucsc-wigcorrelate.out
