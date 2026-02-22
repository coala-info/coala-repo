cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-role-tiny
label: perl-role-tiny
doc: "A minimalist role composition tool for Perl. (Note: The provided text contains
  system error messages regarding disk space and container conversion rather than
  command-line help documentation.)\n\nTool homepage: http://metacpan.org/pod/Role-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-role-tiny:2.002004--pl5321hdfd78af_0
stdout: perl-role-tiny.out
