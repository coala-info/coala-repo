cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-indirect
label: perl-indirect
doc: "A Perl module to lexically warn about using the indirect object syntax. (Note:
  The provided text appears to be a system error log regarding container execution
  and does not contain CLI help documentation.)\n\nTool homepage: http://search.cpan.org/dist/indirect/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-indirect:0.39--pl5321h7b50bb2_6
stdout: perl-indirect.out
