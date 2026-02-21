cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr
label: samestr
doc: "The provided text does not contain a description of the tool, as it consists
  of container environment logs and a fatal error message during an image build process.\n
  \nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
stdout: samestr.out
