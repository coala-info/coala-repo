cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-www-mechanize_perl
doc: "WWW::Mechanize is a Perl module for stateful programmatic web browsing, used
  for automating interaction with websites.\n\nTool homepage: https://metacpan.org/pod/WWW::Mechanize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-www-mechanize:2.20--pl5321hdfd78af_0
stdout: perl-www-mechanize_perl.out
