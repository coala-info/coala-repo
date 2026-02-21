cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_trim_split.pl
label: perl-bio-viennangs_trim_split.pl
doc: "A tool from the Bio-ViennaNGS suite. Note: The provided help text contains system
  error logs regarding a failed container build (no space left on device) and does
  not contain the actual command usage or argument descriptions.\n\nTool homepage:
  http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_trim_split.pl.out
