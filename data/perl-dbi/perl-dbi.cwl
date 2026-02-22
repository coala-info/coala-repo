cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-dbi
doc: "The Perl Database Interface (DBI) is a database access module for the Perl programming
  language. Note: The provided text contains system error messages regarding disk
  space and container conversion rather than tool help documentation.\n\nTool homepage:
  http://dbi.perl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dbi:1.643--pl5321hec16e2b_1
stdout: perl-dbi.out
