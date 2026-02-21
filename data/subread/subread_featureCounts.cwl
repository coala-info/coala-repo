cwlVersion: v1.2
class: CommandLineTool
baseCommand: featureCounts
label: subread_featureCounts
doc: "The provided text does not contain help information for the tool, but appears
  to be a set of system logs and a fatal error message regarding a container image
  build failure.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread_featureCounts.out
