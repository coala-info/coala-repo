cwlVersion: v1.2
class: CommandLineTool
baseCommand: gci_filter_bam.py
label: gci_filter_bam.py
doc: "Filter BAM files (Note: The provided text contains container runtime error messages
  rather than tool help documentation).\n\nTool homepage: https://github.com/yeeus/GCI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gci:1.0--hdfd78af_0
stdout: gci_filter_bam.py.out
