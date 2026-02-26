cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools
label: perl-bio-samtools_bcftools
doc: "Tools for data in the VCF/BCF formats\n\nTool homepage: https://www.htslib.org/"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (view, index, cat, ld, ldpair)
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_bcftools.out
