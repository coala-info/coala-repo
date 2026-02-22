cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-business-isbn
label: perl-business-isbn
doc: "A Perl module/tool for working with International Standard Book Numbers (ISBNs).
  Note: The provided text contains system error messages regarding container image
  retrieval and does not include specific command-line usage or argument definitions.\n\
  \nTool homepage: https://github.com/briandfoy/business-isbn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-business-isbn:3.007--pl5321hdfd78af_0
stdout: perl-business-isbn.out
