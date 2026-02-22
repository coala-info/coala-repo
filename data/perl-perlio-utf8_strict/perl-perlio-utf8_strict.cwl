cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-perlio-utf8_strict
doc: "Fast and correct UTF-8 I/O (Note: The provided text is an error message and
  does not contain CLI help information).\n\nTool homepage: https://metacpan.org/pod/PerlIO::utf8_strict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl:5.32
stdout: perl-perlio-utf8_strict.out
