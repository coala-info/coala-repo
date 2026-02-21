cwlVersion: v1.2
class: CommandLineTool
baseCommand: overlapSelect
label: ucsc-overlapselect
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-overlapselect:482--h0b57e2e_0
stdout: ucsc-overlapselect.out
