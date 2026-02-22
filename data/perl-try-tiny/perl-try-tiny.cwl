cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-try-tiny
label: perl-try-tiny
doc: "A Perl module that provides minimal try/catch/finally blocks. Note: The provided
  text contains system error messages regarding container image retrieval and does
  not contain CLI help documentation.\n\nTool homepage: https://github.com/karenetheridge/Try-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-try-tiny:0.31--pl5321hdfd78af_1
stdout: perl-try-tiny.out
