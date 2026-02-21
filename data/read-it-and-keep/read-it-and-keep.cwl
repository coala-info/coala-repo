cwlVersion: v1.2
class: CommandLineTool
baseCommand: read-it-and-keep
label: read-it-and-keep
doc: "The provided text does not contain help documentation or usage instructions;
  it consists of container runtime logs and a fatal error message regarding an OCI
  image build failure.\n\nTool homepage: https://github.com/GenomePathogenAnalysisService/read-it-and-keep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read-it-and-keep:0.3.0--h5ca1c30_3
stdout: read-it-and-keep.out
