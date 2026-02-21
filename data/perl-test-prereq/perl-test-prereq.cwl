cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-prereq
label: perl-test-prereq
doc: "A tool to check if all prerequisites of a Perl distribution are satisfied. (Note:
  The provided text was an error log and did not contain usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/briandfoy/test-prereq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-prereq:2.002--pl526_3
stdout: perl-test-prereq.out
