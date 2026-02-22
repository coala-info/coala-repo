cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-aceperl
label: perl-aceperl
doc: "AcePerl is a Perl interface to the AceDB database system. (Note: The provided
  text contains system error messages regarding disk space and container image handling
  rather than command-line help documentation.)\n\nTool homepage: https://github.com/WormBase/AcePerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-aceperl:1.92--pl5321h7b50bb2_8
stdout: perl-aceperl.out
