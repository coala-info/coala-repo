cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStart
label: ucsc-para_paraNodeStart
doc: "UCSC paraNodeStart tool (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_paraNodeStart.out
