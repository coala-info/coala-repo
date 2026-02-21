cwlVersion: v1.2
class: CommandLineTool
baseCommand: monophylizer.pl
label: perl-bio-monophylizer_monophylizer.pl
doc: "A tool for monophyly analysis (Note: The provided text contains container build
  logs and error messages rather than the tool's help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://metacpan.org/pod/Bio::Monophylizer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-monophylizer:1.0.0--hdfd78af_0
stdout: perl-bio-monophylizer_monophylizer.pl.out
