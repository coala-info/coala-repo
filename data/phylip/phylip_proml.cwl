cwlVersion: v1.2
class: CommandLineTool
baseCommand: proml
label: phylip_proml
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime logs and a fatal error message regarding an image build failure.\n
  \nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_proml.out
