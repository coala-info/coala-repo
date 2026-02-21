cwlVersion: v1.2
class: CommandLineTool
baseCommand: strucvis
label: strucvis
doc: "A tool for visualizing RNA secondary structures and alignments.\n\nTool homepage:
  https://github.com/MikeAxtell/strucVis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strucvis:0.9--hdfd78af_0
stdout: strucvis.out
