cwlVersion: v1.2
class: CommandLineTool
baseCommand: satsuma2
label: satsuma2
doc: "The provided text does not contain help information or a description of the
  tool; it contains container environment logs and a fatal error message regarding
  an OCI image build failure.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
stdout: satsuma2.out
