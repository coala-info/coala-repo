cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-pod-coverage
label: perl-test-pod-coverage
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log indicating a failure to build or extract a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/gooselinux/perl-Test-Pod-Coverage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-pod-coverage:1.10--pl526_1
stdout: perl-test-pod-coverage.out
