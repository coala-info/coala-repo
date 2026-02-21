cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapToLift
label: ucsc-gaptolift
doc: "Convert a gap file to a liftOver chain file. (Note: The provided help text contains
  only container execution errors and does not list specific arguments.)\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gaptolift:482--h0b57e2e_0
stdout: ucsc-gaptolift.out
