cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-common-sense
label: perl-common-sense
doc: "The perl-common-sense package (common::sense) implements some sane defaults
  for Perl programs. Note: The provided text appears to be a system error log regarding
  a container build failure rather than a CLI help menu.\n\nTool homepage: http://search.cpan.org/~mlehmann/common-sense-3.74/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-common-sense:3.75--pl5321hdfd78af_0
stdout: perl-common-sense.out
