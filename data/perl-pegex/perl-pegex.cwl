cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegex
label: perl-pegex
doc: "Pegex is a PEG (Parsing Expression Grammar) parser generator framework for Perl.
  (Note: The provided help text contains only system error messages and no command-line
  usage information).\n\nTool homepage: https://metacpan.org/dist/Pegex/view/lib/Pegex.pod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pegex:0.75--pl5321hdfd78af_0
stdout: perl-pegex.out
