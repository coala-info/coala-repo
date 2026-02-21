cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedExtendRanges
label: ucsc-bedextendranges
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedextendranges:482--h0b57e2e_0
stdout: ucsc-bedextendranges.out
