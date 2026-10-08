cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - logo-sequence
label: dr-disco_logo-sequence
doc: "Extracts the genomic sequence before (negative file) or after (positive file) a given genomic location, in order to be used for creating sequence logos.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: region
    type: string
    doc: Region to generate logo sequence for.
    inputBinding:
      position: 1
  - id: fasta_input_file
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Input FASTA file.
    inputBinding:
      position: 2
  - id: fasta_output_file_negative_path
    type: string
    doc: Output FASTA file with the sequence before the location (negative file).
    inputBinding:
      position: 3
  - id: fasta_output_file_positive_path
    type: string
    doc: Output FASTA file with the sequence after the location (positive file).
    inputBinding:
      position: 4
  - id: offset_negative
    type:
      - 'null'
      - int
    doc: 'Offset for negative logo sequence (default: 10).'
    inputBinding:
      position: 103
      prefix: --offset-negative
  - id: offset_positive
    type:
      - 'null'
      - int
    doc: 'Offset for positive logo sequence (default: 10).'
    inputBinding:
      position: 103
      prefix: --offset-positive
outputs:
  - id: fasta_output_file_negative
    type: File
    doc: Output FASTA file for negative logo sequence.
    outputBinding:
      glob: $(inputs.fasta_output_file_negative_path)
  - id: fasta_output_file_positive
    type: File
    doc: Output FASTA file for positive logo sequence.
    outputBinding:
      glob: $(inputs.fasta_output_file_positive_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
