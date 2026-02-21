cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-log4perl
label: perl-tie-log4perl
doc: "Tie::Log4perl - Tie variables to Log4perl\n\nTool homepage: http://metacpan.org/pod/Tie::Log4perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-log4perl:0.1--pl5.22.0_0
stdout: perl-tie-log4perl.out
