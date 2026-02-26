cwlVersion: v1.2
class: CommandLineTool
baseCommand: mfqe
label: mfqe
doc: "Extract multiple sets of fastq or fasta reads by name\n\nTool homepage: https://github.com/wwood/mfqe"
inputs:
  - id: fasta_read_name_lists
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files each containing sequence IDs [alias for 
      --sequence-name-lists]
    inputBinding:
      position: 101
      prefix: --fasta-read-name-lists
  - id: fastq_read_name_lists
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files each containing sequence IDs [alias for 
      --sequence-name-lists]
    inputBinding:
      position: 101
      prefix: --fastq-read-name-lists
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: 'File containing uncompressed input FASTA sequences [default: Use STDIN]'
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_fastq
    type:
      - 'null'
      - File
    doc: 'File containing uncompressed input FASTQ sequences [default: Use STDIN]'
    inputBinding:
      position: 101
      prefix: --input-fastq
  - id: output_uncompressed
    type:
      - 'null'
      - boolean
    doc: 'Output sequences uncompressed [default: gzip compress outputs]'
    inputBinding:
      position: 101
      prefix: --output-uncompressed
  - id: sequence_name_lists
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files each containing sequence IDs
    inputBinding:
      position: 101
      prefix: --sequence-name-lists
outputs:
  - id: output_fasta_files
    type:
      - 'null'
      - File
    doc: List of files to write FASTA to
    outputBinding:
      glob: $(inputs.output_fasta_files)
  - id: output_fastq_files
    type:
      - 'null'
      - File
    doc: List of files to write FASTQ to
    outputBinding:
      glob: $(inputs.output_fastq_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mfqe:0.5.0--h7b50bb2_5
