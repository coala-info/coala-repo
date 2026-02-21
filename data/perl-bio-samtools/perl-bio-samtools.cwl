cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-samtools
label: perl-bio-samtools
doc: "The provided text is a log of a failed container build process and does not
  contain help documentation or command-line arguments for the tool.\n\nTool homepage:
  https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools.out
