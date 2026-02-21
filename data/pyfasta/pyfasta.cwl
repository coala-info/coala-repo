cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfasta
label: pyfasta
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a set of system logs and a fatal error message regarding
  a container image build failure.\n\nTool homepage: https://github.com/brentp/pyfasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta.out
