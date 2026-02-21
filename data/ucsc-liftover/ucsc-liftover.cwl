cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftOver
label: ucsc-liftover
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error regarding an image build failure.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-liftover:482--h0b57e2e_0
stdout: ucsc-liftover.out
