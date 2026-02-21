cwlVersion: v1.2
class: CommandLineTool
baseCommand: raToLines
label: ucsc-linestora_raToLines
doc: "The provided help text contains only container execution logs and error messages,
  and does not include usage information or a description for the tool.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-linestora:482--h0b57e2e_0
stdout: ucsc-linestora_raToLines.out
