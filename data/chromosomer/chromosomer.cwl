cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosomer
label: chromosomer
doc: "A tool for chromosome-level assembly scaffolding.\n\nTool homepage: https://github.com/gtamazian/chromosomer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
stdout: chromosomer.out
