cwlVersion: v1.2
class: CommandLineTool
baseCommand: gzrt
label: gzrt
doc: "Gzip Recovery Toolkit (Note: The provided text contains container runtime error
  messages rather than tool help text, so no arguments could be extracted).\n\nTool
  homepage: https://www.urbanophile.com/arenn/hacking/gzrt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gzrt:0.9.1--h577a1d6_0
stdout: gzrt.out
