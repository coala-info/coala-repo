cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-assembler
label: bactopia-assembler
doc: "A tool for assembling bacterial genomes, typically used within the Bactopia
  framework.\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-assembler:1.0.4--hdfd78af_0
stdout: bactopia-assembler.out
