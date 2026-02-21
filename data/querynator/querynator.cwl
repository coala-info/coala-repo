cwlVersion: v1.2
class: CommandLineTool
baseCommand: querynator
label: querynator
doc: "The provided text does not contain help information or a description of the
  tool; it contains container environment logs and a fatal error message regarding
  an OCI image build failure.\n\nTool homepage: https://github.com/qbic-pipelines/querynator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
stdout: querynator.out
