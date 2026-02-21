cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-checkos
label: perl-devel-checkos
doc: "A tool (likely based on the Perl module Devel::CheckOS) to check the current
  operating system against a list of platforms.\n\nTool homepage: http://metacpan.org/pod/Devel::CheckOS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-checkos:1.81--pl526_0
stdout: perl-devel-checkos.out
