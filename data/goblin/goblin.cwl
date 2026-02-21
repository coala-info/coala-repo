cwlVersion: v1.2
class: CommandLineTool
baseCommand: goblin
label: goblin
doc: "A tool for genomic analysis (description not provided in help text)\n\nTool
  homepage: https://github.com/rpetit3/goblin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goblin:1.0.0--hdfd78af_0
stdout: goblin.out
