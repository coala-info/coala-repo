cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2maf-umccr_maf2maf.pl
label: vcf2maf-umccr_maf2maf.pl
doc: "The provided text is a container execution error log and does not contain help
  documentation or argument definitions for the tool.\n\nTool homepage: https://github.com/umccr/vcf2maf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf-umccr:1.6.21.20230511--hdfd78af_0
stdout: vcf2maf-umccr_maf2maf.pl.out
