cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_to_bed
label: ncrf_ncrf_to_bed.py
doc: "Converts NCRF output to BED format.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: input_stream
    type: string
    doc: Input from ncrf_cat
    inputBinding:
      position: 1
  - id: max_noise_ratio
    type:
      - 'null'
      - float
    doc: Same as --minmratio but with 1-ratio
    inputBinding:
      position: 102
      prefix: --maxnoise
  - id: min_match_ratio
    type:
      - 'null'
      - float
    doc: Discard alignments with a low frequency of matches; ratio can be 
      between 0 and 1 (e.g. "0.85"), or can be expressed as a percentage (e.g. 
      "85%")
    inputBinding:
      position: 102
      prefix: --minmratio
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_to_bed.py.out
