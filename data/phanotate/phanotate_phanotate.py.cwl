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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Path to the output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phanotate:1.6.7--py310h184ae93_1
