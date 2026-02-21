cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-checker
label: perl-pod-checker
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/marcgreen/perl-pod-checker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-checker:1.60--pl5.22.0_0
stdout: perl-pod-checker.out
