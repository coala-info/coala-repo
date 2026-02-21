cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplotype-lso
label: haplotype-lso
doc: "A tool for haplotype-based local search optimization (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/holtgrewe/haplotype-lso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
stdout: haplotype-lso.out
