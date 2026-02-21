cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-builder-tester
label: perl-test-builder-tester
doc: The provided text does not contain help information for the tool. It appears
  to be an error log indicating that the executable was not found in the environment.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-builder-tester:1.23_002--pl526_1
stdout: perl-test-builder-tester.out
