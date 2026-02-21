cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfhethomratio
label: vcflib_vcfhethomratio
doc: "Calculate the heterozygosity/homozygosity ratio for each sample in a VCF file.\n
  \nTool homepage: https://github.com/vcflib/vcflib"
inputs:
  - id: vcf_file
    type: File
    doc: The VCF file to analyze
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfhethomratio.out
