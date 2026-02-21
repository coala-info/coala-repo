cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: perl-bio-samtools_samtools
doc: "Note: The provided text contains error logs from a container build process (Apptainer/Singularity)
  rather than the help documentation for the tool. As a result, no command-line arguments
  or usage instructions could be extracted.\n\nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_samtools.out
