cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-coverage
label: perl-pod-coverage
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/richardc/perl-pod-coverage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-coverage:0.23--pl5.22.0_0
stdout: perl-pod-coverage.out
