cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst_metamlst.py
label: metamlst_metamlst.py
doc: "Metagenomic Multi-Locus Sequence Typing (metaMLST). Note: The provided help
  text contains only system error messages regarding container execution and does
  not list available command-line arguments.\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_metamlst.py.out
