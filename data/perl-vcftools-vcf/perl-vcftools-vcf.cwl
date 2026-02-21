cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-vcftools-vcf
label: perl-vcftools-vcf
doc: "The provided help text indicates a fatal error where the executable was not
  found. No usage information or arguments are available in the provided output.\n
  \nTool homepage: https://github.com/vcftools/vcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-vcftools-vcf:0.953--pl5.22.0_1
stdout: perl-vcftools-vcf.out
