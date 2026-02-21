cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifold
label: rnastructure_bifold
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error regarding an OCI image build failure.\n
  \nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_bifold.out
