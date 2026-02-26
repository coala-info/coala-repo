cwlVersion: v1.2
class: CommandLineTool
baseCommand: barseqcount.py
label: barseqcount
doc: "Analysis of DNA barcode sequencing experiments. For full documentation, visit:
  https://barseqcount.readthedocs.io\n\nTool homepage: https://github.com/damienmarsic/barseqcount"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run: count or analyze'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
stdout: barseqcount.out
