cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_fastq-to-fasta.py
label: khmer_fastq-to-fasta.py
doc: "Convert FASTQ files to FASTA format.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs:
  - id: input_filenames
    type:
      type: array
      items: File
    doc: Input FASTQ file(s)
    inputBinding:
      position: 1
  - id: no_discard
    type:
      - 'null'
      - boolean
    doc: Do not discard sequences containing Ns
    inputBinding:
      position: 102
      prefix: --no-discard
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
