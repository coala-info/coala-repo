cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fasta-to-parquet2
label: dsh-bio_fasta-to-parquet2
doc: "Converts FASTA files to Parquet format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: input FASTA alphabet { dna, protein }
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: input_fasta_path
    type:
      - 'null'
      - File
    doc: input FASTA path
    inputBinding:
      position: 101
      prefix: --input-fasta-path
  - id: row_group_size
    type:
      - 'null'
      - int
    doc: row group size
    inputBinding:
      position: 101
      prefix: --row-group-size
  - id: transaction_size
    type:
      - 'null'
      - int
    doc: transaction size
    inputBinding:
      position: 101
      prefix: --transaction-size
  - id: output_parquet_file_path
    type: string
    doc: Output or path parameter `output_parquet_file_path`
    inputBinding:
      position: 102
      prefix: --output-parquet-file
outputs:
  - id: output_parquet_file
    type: File
    doc: output Parquet file
    outputBinding:
      glob: $(inputs.output_parquet_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
