cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr
label: superstr
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container build logs and a fatal error message regarding an
  OCI image fetch failure.\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
stdout: superstr.out
