cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStart
label: ucsc-paranodestart
doc: "A tool from the UCSC Genome Browser utilities. Note: The provided help text
  contains only container execution logs and no usage information.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestart:482--h0b57e2e_0
stdout: ucsc-paranodestart.out
