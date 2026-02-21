cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraTestJob
label: ucsc-parahub_paraTestJob
doc: "A tool from the UCSC ParaHub suite, likely used for testing parallel jobs. (Note:
  The provided help text contains only container environment logs and a fatal error,
  so no arguments could be extracted.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_paraTestJob.out
