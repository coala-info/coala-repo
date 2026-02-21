cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_assembly_stats.pl
label: perl-bio-viennangs_assembly_stats.pl
doc: "A script to calculate assembly statistics. Note: The provided help text contains
  only system error messages regarding a container build failure ('no space left on
  device') and does not list specific command-line arguments.\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_assembly_stats.pl.out
