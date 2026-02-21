cwlVersion: v1.2
class: CommandLineTool
baseCommand: moods
label: moods
doc: "MOODS (Motif Occurrence Detection Suite) is a software package for finding transcription
  factor binding sites (TFBS) in DNA sequences.\n\nTool homepage: https://www.cs.helsinki.fi/group/pssmfind/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moods:1.9.4.2--py39h2de1943_3
stdout: moods.out
