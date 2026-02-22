cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-sketcher
label: bactopia-sketcher
doc: "A tool for creating sketches (e.g., Mash or Sourmash) of genomic data within
  the Bactopia framework.\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-sketcher:1.0.2--hdfd78af_0
stdout: bactopia-sketcher.out
