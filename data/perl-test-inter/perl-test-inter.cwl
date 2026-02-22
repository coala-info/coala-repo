cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-inter
label: perl-test-inter
doc: "A Perl framework for writing and running tests (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments).\n\nTool homepage: https://metacpan.org/pod/Test::Inter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-inter:1.12--pl5321hdfd78af_0
stdout: perl-test-inter.out
