cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-crtreesearchbed
label: ucsc-crtreesearchbed
doc: "The provided text does not contain help information as it is an error log from
  a failed container build/fetch process. No arguments or tool descriptions could
  be extracted.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-crtreesearchbed:482--h0b57e2e_0
stdout: ucsc-crtreesearchbed.out
