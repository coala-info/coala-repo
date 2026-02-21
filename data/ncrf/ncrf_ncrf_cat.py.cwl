cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_ncrf_cat.py
label: ncrf_ncrf_cat.py
doc: "A tool for concatenating NCRF (Noise-Cancelling Repeat Finder) output files.
  Note: The provided help text contains only system error messages regarding container
  execution and does not list specific arguments.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_cat.py.out
