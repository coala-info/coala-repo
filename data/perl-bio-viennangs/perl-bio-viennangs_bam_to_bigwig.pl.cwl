cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_bam_to_bigwig.pl
label: perl-bio-viennangs_bam_to_bigwig.pl
doc: "A script from the Bio-ViennaNGS suite to convert BAM files to BigWig format.
  Note: The provided help text contains system error logs and does not list specific
  command-line arguments.\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_bam_to_bigwig.pl.out
