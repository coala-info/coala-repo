cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraTestJob
label: ucsc-paranode_paraTestJob
doc: "A test job utility for the UCSC ParaNode system. (Note: The provided help text
  contains only container execution logs and no usage information.)\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode_paraTestJob.out
