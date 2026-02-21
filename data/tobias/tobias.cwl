cwlVersion: v1.2
class: CommandLineTool
baseCommand: tobias
label: tobias
doc: "TOBIAS (Transcription factor Occupancy prediction By Investigation of ATAC-seq
  Signal)\n\nTool homepage: https://github.molgen.mpg.de/loosolab/TOBIAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tobias:0.17.3--py39hff726c5_1
stdout: tobias.out
