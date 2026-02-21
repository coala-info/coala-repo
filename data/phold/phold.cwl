cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold
label: phold
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding an
  OCI image build failure.\n\nTool homepage: https://github.com/gbouras13/phold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold.out
