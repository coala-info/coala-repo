cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig
label: ucsc-wigtobigwig
doc: "Convert wig file to BigWig file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wigtobigwig:482--hdc0a859_1
stdout: ucsc-wigtobigwig.out
