cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp
label: perl-par-packer_pp
doc: "PAR Packager - Utility to create standalone executable from Perl programs\n\n
  Tool homepage: https://github.com/rschupp/PAR-Packer"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input Perl files to be packed
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-par-packer:1.036--pl5321h7b50bb2_6
stdout: perl-par-packer_pp.out
