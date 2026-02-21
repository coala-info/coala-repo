cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent
label: md-cogent
doc: "A tool for COGENT (COding GENome Reconstruction Tool) processing.\n\nTool homepage:
  https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent.out
