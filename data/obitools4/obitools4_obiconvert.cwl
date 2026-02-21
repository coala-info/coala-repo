cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiconvert
label: obitools4_obiconvert
doc: "Converts sequence files to different formats (part of OBITools4)\n\nTool homepage:
  https://obitools4.metabarcoding.org"
inputs:
  - id: input
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output using gzip
    inputBinding:
      position: 102
      prefix: --compress
  - id: embl_output
    type:
      - 'null'
      - boolean
    doc: Output in EMBL format
    inputBinding:
      position: 102
      prefix: --embl-output
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Output in FASTA format
    inputBinding:
      position: 102
      prefix: --fasta-output
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Output in FASTQ format
    inputBinding:
      position: 102
      prefix: --fastq-output
  - id: genbank_output
    type:
      - 'null'
      - boolean
    doc: Output in GenBank format
    inputBinding:
      position: 102
      prefix: --genbank-output
  - id: obi_output
    type:
      - 'null'
      - boolean
    doc: Output in OBI format (binary)
    inputBinding:
      position: 102
      prefix: --obi-output
  - id: skip_errors
    type:
      - 'null'
      - boolean
    doc: Skip sequences with errors
    inputBinding:
      position: 102
      prefix: --skip-errors
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
