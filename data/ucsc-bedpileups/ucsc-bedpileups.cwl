cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-bedpileups
label: ucsc-bedpileups
doc: "The provided text is a system error log indicating a failure to build or run
  the container (no space left on device) and does not contain the help text or usage
  information for the tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedpileups:482--h0b57e2e_0
stdout: ucsc-bedpileups.out
