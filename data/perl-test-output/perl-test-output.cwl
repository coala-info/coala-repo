cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-output
label: perl-test-output
doc: "The provided text does not contain help documentation. It consists of container
  runtime logs indicating that the executable 'perl-test-output' was not found in
  the system PATH.\n\nTool homepage: https://github.com/briandfoy/test-output"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-output:1.031--pl526_0
stdout: perl-test-output.out
