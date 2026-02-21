cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cpan-shell
label: perl-cpan-shell
doc: "The CPAN shell is an interactive interface for managing Perl modules from the
  Comprehensive Perl Archive Network.\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cpan-shell:5.5004--pl5.22.0_0
stdout: perl-cpan-shell.out
