cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-more
label: perl-test-more
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating that the executable 'perl-test-more' was not found in
  the system PATH.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-more:1.001002--pl526_1
stdout: perl-test-more.out
