cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtopo
label: svtopo
doc: "A tool for visualizing structural variant topology (Note: The provided text
  contained container build logs rather than CLI help documentation; no arguments
  could be extracted).\n\nTool homepage: https://github.com/PacificBiosciences/HiFi-SVTopo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtopo:0.3.0--h9ee0642_0
stdout: svtopo.out
