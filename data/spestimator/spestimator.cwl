cwlVersion: v1.2
class: CommandLineTool
baseCommand: spestimator
label: spestimator
doc: "The provided text does not contain help information or a description of the
  tool; it contains container build logs and a fatal error message.\n\nTool homepage:
  https://github.com/erinyoung/Spestimator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spestimator:0.1.0.232--pyhdfd78af_0
stdout: spestimator.out
