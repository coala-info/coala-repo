cwlVersion: v1.2
class: CommandLineTool
baseCommand: edlib-aligner
label: edlib-aligner
doc: "A tool for sequence alignment using the Edlib library.\n\nTool homepage: https://github.com/Martinsos/edlib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/edlib-aligner:v1.2.4-1-deb_cv1
stdout: edlib-aligner.out
