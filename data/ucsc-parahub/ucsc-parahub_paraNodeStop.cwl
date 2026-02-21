cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStop
label: ucsc-parahub_paraNodeStop
doc: "A tool within the UCSC ParaHub suite, likely used to stop a processing node.\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_paraNodeStop.out
