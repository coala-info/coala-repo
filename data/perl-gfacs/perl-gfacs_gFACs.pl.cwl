cwlVersion: v1.2
class: CommandLineTool
baseCommand: gFACs.pl
label: perl-gfacs_gFACs.pl
doc: "The provided text does not contain help information or usage instructions; it
  is an error log reporting a 'no space left on device' failure during a container
  image build.\n\nTool homepage: https://gitlab.com/PlantGenomicsLab/gFACs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gfacs:1.1.1--hdfd78af_1
stdout: perl-gfacs_gFACs.pl.out
