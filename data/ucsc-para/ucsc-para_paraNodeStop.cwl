cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStop
label: ucsc-para_paraNodeStop
doc: "A tool from the UCSC para suite, likely used to stop a node in a parallel processing
  cluster. Note: The provided help text contains only container runtime error messages
  and no usage information.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_paraNodeStop.out
