cwlVersion: v1.2
class: CommandLineTool
baseCommand: faststructure
label: faststructure
doc: "A tool for inferring population structure from large SNP genotype data. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/rajanil/fastStructure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
stdout: faststructure.out
