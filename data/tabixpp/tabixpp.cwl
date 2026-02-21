cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabixpp
label: tabixpp
doc: "The provided text does not contain help information or usage instructions for
  tabixpp; it contains container runtime log messages and a fatal error regarding
  an OCI image build failure.\n\nTool homepage: https://github.com/ekg/tabixpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabixpp:1.1.2--hbefcdb2_4
stdout: tabixpp.out
