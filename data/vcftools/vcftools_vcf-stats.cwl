cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-stats
label: vcftools_vcf-stats
doc: "A tool from the VCFtools suite for calculating statistics on VCF files. (Note:
  The provided help text contained only container execution errors and no usage information.)\n
  \nTool homepage: https://github.com/vcftools/vcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcftools:0.1.17--pl5321h077b44d_0
stdout: vcftools_vcf-stats.out
