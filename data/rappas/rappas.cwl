cwlVersion: v1.2
class: CommandLineTool
baseCommand: rappas
label: rappas
doc: "Rapid Alignment-free Phylogenetic Placement via Ancestral Sequences\n\nTool
  homepage: https://github.com/blinard-BIOINFO/RAPPAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rappas:1.22--hdfd78af_0
stdout: rappas.out
