cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2maf-umccr_vcf2maf.pl
label: vcf2maf-umccr_vcf2maf.pl
doc: "A tool to convert VCF files to MAF (Mutation Annotation Format). Note: The provided
  text contains container runtime error logs rather than the tool's help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/umccr/vcf2maf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf-umccr:1.6.21.20230511--hdfd78af_0
stdout: vcf2maf-umccr_vcf2maf.pl.out
