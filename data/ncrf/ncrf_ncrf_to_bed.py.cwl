cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_ncrf_to_bed.py
label: ncrf_ncrf_to_bed.py
doc: "Convert NCRF (Noise-Cancelling Repeater Finder) output to BED format.\n\nTool
  homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_to_bed.py.out
