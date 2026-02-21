cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu
label: unifrac-binaries_ssu
doc: "A tool for computing UniFrac distances, typically used in microbial ecology
  for comparing biological communities.\n\nTool homepage: https://github.com/biocore/unifrac-binaries"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac-binaries:1.6--h9d55e78_0
stdout: unifrac-binaries_ssu.out
