cwlVersion: v1.2
class: CommandLineTool
baseCommand: dashing
label: dashing_dashing_s512
doc: "Dashing is a fast and accurate tool for estimating genomic distances.\n\nTool
  homepage: https://github.com/dnbaker/dashing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_dashing_s512.out
