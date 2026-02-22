cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-graph-readwrite
label: perl-graph-readwrite
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a failed container image
  pull/build due to insufficient disk space.\n\nTool homepage: https://github.com/neilb/Graph-ReadWrite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-graph-readwrite:2.10--pl5321hdfd78af_0
stdout: perl-graph-readwrite.out
