cwlVersion: v1.2
class: CommandLineTool
baseCommand: geno2phenotb
label: geno2phenotb
doc: "A tool for predicting phenotypes from genotypes in Mycobacterium tuberculosis.
  (Note: The provided help text contains only system error logs and no usage information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/msmdev/geno2phenoTB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geno2phenotb:1.0.1--pyhdfd78af_1
stdout: geno2phenotb.out
