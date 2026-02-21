cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadMaf
label: ucsc-hgloadmaf
doc: "The provided text is a container runtime error log and does not contain the
  help documentation for the tool. No arguments could be extracted.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadmaf:482--h0b57e2e_0
stdout: ucsc-hgloadmaf.out
