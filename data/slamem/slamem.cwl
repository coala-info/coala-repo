cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamem
label: slamem
doc: "SLAM-seq Mapping and Expression Measurement (Note: The provided text contains
  container build logs and error messages rather than tool help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/sguizard/slaMEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamem:v0.8.5--h779adbc_0
stdout: slamem.out
