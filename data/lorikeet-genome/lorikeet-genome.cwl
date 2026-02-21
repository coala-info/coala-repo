cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorikeet-genome
label: lorikeet-genome
doc: "A tool for strain-level assembly and variant calling from metagenomes (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
stdout: lorikeet-genome.out
