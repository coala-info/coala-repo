cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-file
label: perl-test-file
doc: "A Perl utility for testing file attributes. (Note: The provided text contains
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/briandfoy/test-file"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-file:1.995--pl5321hdfd78af_0
stdout: perl-test-file.out
