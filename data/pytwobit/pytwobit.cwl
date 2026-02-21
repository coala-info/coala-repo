cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytwobit
label: pytwobit
doc: "The provided text does not contain help documentation for the tool; it consists
  of container runtime logs and a fatal error message during an image build process.\n
  \nTool homepage: https://github.com/jrobinso/pytwobit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytwobit:0.3.1--pyhdfd78af_0
stdout: pytwobit.out
