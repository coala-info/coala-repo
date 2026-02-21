cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-compare
label: vcftools_vcf-compare
doc: "The provided text does not contain help information for the tool, but rather
  container runtime log messages and a fatal error during image retrieval.\n\nTool
  homepage: https://github.com/vcftools/vcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcftools:0.1.17--pl5321h077b44d_0
stdout: vcftools_vcf-compare.out
