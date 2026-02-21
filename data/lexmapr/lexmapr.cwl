cwlVersion: v1.2
class: CommandLineTool
baseCommand: lexmapr
label: lexmapr
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding container execution
  (no space left on device).\n\nTool homepage: https://github.com/LexMapr/lexmapr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexmapr:0.7.1--py36heb1dbbb_0
stdout: lexmapr.out
