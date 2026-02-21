cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_ncrf_consensus_filter.py
label: ncrf_ncrf_consensus_filter.py
doc: "Filter NCRF (Noise-Cancelling Repeat Finder) alignments based on consensus.
  (Note: The provided text contains system error messages and does not include usage
  instructions or argument definitions).\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_consensus_filter.py.out
