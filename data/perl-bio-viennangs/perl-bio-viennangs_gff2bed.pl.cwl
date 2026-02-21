cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_gff2bed.pl
label: perl-bio-viennangs_gff2bed.pl
doc: "A script to convert GFF files to BED format, part of the Bio-ViennaNGS suite.\n
  \nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_gff2bed.pl.out
