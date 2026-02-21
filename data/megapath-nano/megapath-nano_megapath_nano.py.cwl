cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath_nano.py
label: megapath-nano_megapath_nano.py
doc: "MegaPath-Nano: A tool for metagenomic analysis of Nanopore data.\n\nTool homepage:
  https://github.com/HKU-BAL/MegaPath-Nano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
stdout: megapath-nano_megapath_nano.py.out
