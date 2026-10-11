cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_to_bed
label: ncrf_ncrf_to_bed.py
doc: "Converts NCRF output to BED format.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: ncrf_file
    type: File
    doc: "Output from ncrf_cat (or NCRF), read from standard input"
  - id: minmratio
    type:
      - 'null'
      - string
    doc: "discard alignments with a low frequency of matches; ratio between 0 and 1 (e.g. 0.85) or a percentage (e.g. 85%)"
    inputBinding:
      position: 10
      prefix: "--minmratio="
      separate: false
  - id: maxnoise
    type:
      - 'null'
      - string
    doc: "same as --minmratio but with 1-ratio"
    inputBinding:
      position: 10
      prefix: "--maxnoise="
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdin: $(inputs.ncrf_file.path)
stdout: ncrf_ncrf_to_bed.py.out
