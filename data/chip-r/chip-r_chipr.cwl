cwlVersion: v1.2
class: CommandLineTool
baseCommand: chipr
label: chip-r_chipr
doc: "ChIP-seq Reproducibility (chipr) is a tool to evaluate the reproducibility of
  high-throughput sequencing experiments such as ChIP-seq.\n\nTool homepage: https://github.com/rhysnewell/ChIP-R"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chip-r:1.2.0--pyh3252c3a_0
stdout: chip-r_chipr.out
