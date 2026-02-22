cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-datetime
doc: "The perl-datetime package provides the DateTime suite of modules for Perl, which
  allows for precise date and time manipulation. Note: The provided text contains
  system error messages regarding container execution and does not include specific
  CLI help documentation.\n\nTool homepage: https://metacpan.org/dist/DateTime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-datetime:1.66--pl5321h9948957_0
stdout: perl-datetime.out
