cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_bed2gff.pl
label: perl-bio-viennangs_bed2gff.pl
doc: "A script from the Bio-ViennaNGS suite to convert BED files to GFF format. (Note:
  The provided help text contains system error logs and does not list specific command-line
  arguments.)\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_bed2gff.pl.out
