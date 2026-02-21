cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst_mlst.py
label: metamlst_mlst.py
doc: "MetaMLST: Multi-Locus Sequence Typing from metagenomic data (Note: The provided
  text contains system error logs rather than help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_mlst.py.out
