cwlVersion: v1.2
class: CommandLineTool
baseCommand: sspace
label: sspace
doc: "SSPACE (Scaffolding Pre-Assembled Contigs after Extension) is a tool for extending
  and scaffolding pre-assembled contigs using paired-read data.\n\nTool homepage:
  https://github.com/imhuay/sspace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sspace:v2.1.1dfsg-4-deb_cv1
stdout: sspace.out
