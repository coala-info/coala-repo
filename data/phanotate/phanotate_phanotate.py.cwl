cwlVersion: v1.2
class: CommandLineTool
baseCommand: phanotate.py
label: phanotate_phanotate.py
doc: "PHANOTATE is a tool for identifying genes in phage genomes. It uses a probabilistic
  graphical model to predict gene locations.\n\nTool homepage: https://github.com/deprekate/PHANOTATE"
inputs:
  - id: input_fasta
    type: File
    doc: Path to the input fasta file containing the phage genome
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (fasta, gbk, tabular, or dnaplustxt)
    inputBinding:
      position: 102
      prefix: --format
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Path to the output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phanotate:1.6.7--py310h184ae93_1
