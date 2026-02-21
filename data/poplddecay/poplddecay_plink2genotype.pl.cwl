cwlVersion: v1.2
class: CommandLineTool
baseCommand: poplddecay_plink2genotype.pl
label: poplddecay_plink2genotype.pl
doc: "A script to convert Plink genotype data for PopLDDecay. Note: The provided help
  text contains only container runtime error messages and no usage information.\n\n
  Tool homepage: https://github.com/BGI-shenzhen/PopLDdecay"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poplddecay:3.43--hdcf5f25_1
stdout: poplddecay_plink2genotype.pl.out
