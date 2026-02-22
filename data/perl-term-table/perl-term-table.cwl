cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-term-table
label: perl-term-table
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to container execution and disk space issues.\n\
  \nTool homepage: http://metacpan.org/pod/Term::Table"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-term-table:0.028--pl5321hdfd78af_0
stdout: perl-term-table.out
