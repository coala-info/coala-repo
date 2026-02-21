cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-samtools_minimap2
label: perl-bio-samtools_minimap2
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message regarding a failed container build due
  to insufficient disk space.\n\nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_minimap2.out
