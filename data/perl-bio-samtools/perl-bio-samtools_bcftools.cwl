cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools
label: perl-bio-samtools_bcftools
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from an Apptainer/Singularity image build
  process that failed due to insufficient disk space.\n\nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_bcftools.out
