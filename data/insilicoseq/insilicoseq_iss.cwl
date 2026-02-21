cwlVersion: v1.2
class: CommandLineTool
baseCommand: iss
label: insilicoseq_iss
doc: "InSilicoSeq: a software for simulating Illumina reads from metagenomes\n\nTool
  homepage: https://github.com/HadrienG/InSilicoSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insilicoseq:2.0.1--pyh7cba7a3_0
stdout: insilicoseq_iss.out
