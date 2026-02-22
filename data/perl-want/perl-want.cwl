cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-want
label: perl-want
doc: "The perl-want package (likely referring to the Perl module 'Want' which provides
  a generalisation of wantarray). Note: The provided text contains system error messages
  regarding container extraction and does not include specific CLI usage instructions.\n\
  \nTool homepage: https://github.com/lunnar211/fb-brute"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-want:0.29--pl5321h7b50bb2_7
stdout: perl-want.out
