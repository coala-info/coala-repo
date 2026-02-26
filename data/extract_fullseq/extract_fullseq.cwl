cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_fullseq
label: extract_fullseq
doc: Extracts full sequences from a FASTA file.
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing sequences.
    inputBinding:
      position: 1
  - id: sequence_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of sequence IDs to extract. If not provided, all 
      sequences will be extracted.
    inputBinding:
      position: 102
      prefix: --ids
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file to write the extracted full sequences.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
