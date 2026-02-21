cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_bam_split.pl
label: perl-bio-viennangs_bam_split.pl
doc: "A tool from the Bio-ViennaNGS suite, likely used for splitting BAM files. Note:
  The provided help text contains only system error messages regarding container extraction
  and does not list specific command-line arguments.\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_bam_split.pl.out
