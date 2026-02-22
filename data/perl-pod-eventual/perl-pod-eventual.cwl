cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-eventual
label: perl-pod-eventual
doc: "Pod::Eventual reads a POD document as a series of events. (Note: The provided
  text contains system error messages regarding disk space and does not include the
  tool's help documentation or usage instructions.)\n\nTool homepage: https://github.com/rjbs/Pod-Eventual"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-pod-eventual:0.094003--pl5321hdfd78af_0
stdout: perl-pod-eventual.out
