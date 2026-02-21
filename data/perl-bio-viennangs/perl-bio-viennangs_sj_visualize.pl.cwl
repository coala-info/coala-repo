cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_sj_visualize.pl
label: perl-bio-viennangs_sj_visualize.pl
doc: "A tool for visualizing splice junctions (Note: The provided text contained only
  system error messages and no usage information).\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_sj_visualize.pl.out
