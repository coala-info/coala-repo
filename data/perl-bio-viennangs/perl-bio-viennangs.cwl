cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs
label: perl-bio-viennangs
doc: "Bio-ViennaNGS is a collection of Perl modules and scripts for Next-Generation
  Sequencing (NGS) data analysis, specifically designed to work with the ViennaRNA
  package. Note: The provided text is a container build error log and does not contain
  command-line help information.\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs.out
