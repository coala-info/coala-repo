cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_resolve_overlaps.py
label: ncrf_ncrf_resolve_overlaps.py
doc: "A tool to resolve overlaps in NCRF (Noise-Cancelling Repeat Finder) output.\n
  \nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_resolve_overlaps.py.out
