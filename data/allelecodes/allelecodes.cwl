cwlVersion: v1.2
class: CommandLineTool
baseCommand: allelecodes
label: allelecodes
doc: "A tool for standardizing allele codes (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/ncezid-biome/AlleleCodes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allelecodes:2.1--py313hdfd78af_0
stdout: allelecodes.out
