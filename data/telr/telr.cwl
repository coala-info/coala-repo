cwlVersion: v1.2
class: CommandLineTool
baseCommand: telr
label: telr
doc: "A tool for Transposable Element (TE) detection and analysis.\n\nTool homepage:
  https://github.com/bergmanlab/telr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
stdout: telr.out
