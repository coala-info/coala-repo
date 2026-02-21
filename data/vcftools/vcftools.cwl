cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcftools
label: vcftools
doc: "A program package designed for working with VCF files, such as those generated
  by the 1000 Genomes Project. The aim of VCFtools is to provide easily accessible
  methods for working with complex genetic variation data in the form of VCF files.\n
  \nTool homepage: https://github.com/vcftools/vcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcftools:0.1.17--pl5321h077b44d_0
stdout: vcftools.out
