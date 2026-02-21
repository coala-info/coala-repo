cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabix
label: perl-bio-samtools_tabix
doc: "The provided text is a system error log from an Apptainer/Singularity build
  process and does not contain help documentation or usage information for the tool.
  Consequently, no arguments could be extracted.\n\nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_tabix.out
