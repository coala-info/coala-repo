cwlVersion: v1.2
class: CommandLineTool
baseCommand: insilicoseq
label: insilicoseq
doc: "InSilicoSeq is a tool for simulating Illumina reads. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list command-line arguments.)\n\nTool homepage: https://github.com/HadrienG/InSilicoSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insilicoseq:2.0.1--pyh7cba7a3_0
stdout: insilicoseq.out
