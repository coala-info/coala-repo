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
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
