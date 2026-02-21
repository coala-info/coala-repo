cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-set-scalar
label: perl-set-scalar
doc: "A Perl-based tool for set operations (Note: The provided help text contains
  only system error logs and does not list specific command-line arguments).\n\nTool
  homepage: https://github.com/pld-linux/perl-Set-Scalar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-set-scalar:1.29--0
stdout: perl-set-scalar.out
