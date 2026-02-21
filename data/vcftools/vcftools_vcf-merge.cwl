cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-merge
label: vcftools_vcf-merge
doc: "Merge VCF files. (Note: The provided input text is a container runtime error
  log and does not contain the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/vcftools/vcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcftools:0.1.17--pl5321h077b44d_0
stdout: vcftools_vcf-merge.out
