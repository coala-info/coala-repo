cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-version
label: perl-perl-version
doc: "A tool for parsing and manipulating Perl version strings. (Note: The provided
  text contained system error messages rather than help documentation, so no arguments
  could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Perl::Version"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perl-version:1.018--pl5321hdfd78af_0
stdout: perl-perl-version.out
