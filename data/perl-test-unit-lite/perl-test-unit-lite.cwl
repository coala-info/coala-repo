cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-unit-lite
label: perl-test-unit-lite
doc: "A unit testing framework for Perl. (Note: The provided text is an error log
  indicating the executable was not found, rather than the help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-unit-lite:0.1202--pl5.22.0_0
stdout: perl-test-unit-lite.out
