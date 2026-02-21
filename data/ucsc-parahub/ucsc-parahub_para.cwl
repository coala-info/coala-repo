cwlVersion: v1.2
class: CommandLineTool
baseCommand: para
label: ucsc-parahub_para
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_para.out
