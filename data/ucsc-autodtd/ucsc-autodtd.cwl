cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoDtd
label: ucsc-autodtd
doc: "The provided text is an error log indicating a failure to build or extract the
  container image ('no space left on device') and does not contain the help text for
  the tool. Based on the tool name, it is a UCSC Genome Browser utility used to automatically
  create a DTD from XML files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autodtd:482--h0b57e2e_0
stdout: ucsc-autodtd.out
