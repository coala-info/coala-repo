cwlVersion: v1.2
class: CommandLineTool
baseCommand: t1k-build.pl
label: t1k_t1k-build.pl
doc: "The provided text does not contain help information for the tool; it contains
  container runtime log messages and a fatal error regarding an OCI image build failure.\n
  \nTool homepage: https://github.com/mourisl/T1K"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
stdout: t1k_t1k-build.pl.out
