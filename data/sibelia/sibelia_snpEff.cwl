cwlVersion: v1.2
class: CommandLineTool
baseCommand: sibelia_snpEff
label: sibelia_snpEff
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error message regarding an OCI image build
  failure.\n\nTool homepage: https://github.com/bioinf/Sibelia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibelia:3.0.7--0
stdout: sibelia_snpEff.out
