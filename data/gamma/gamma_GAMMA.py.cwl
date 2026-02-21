cwlVersion: v1.2
class: CommandLineTool
baseCommand: gamma_GAMMA.py
label: gamma_GAMMA.py
doc: "GAMMA (Gene Allele Mutation Mapping Algorithm) is a tool for identifying genes
  and their mutations in bacterial genomes. Note: The provided help text contains
  only system error messages and no usage information.\n\nTool homepage: https://github.com/rastanton/GAMMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gamma:2.2--hdfd78af_1
stdout: gamma_GAMMA.py.out
