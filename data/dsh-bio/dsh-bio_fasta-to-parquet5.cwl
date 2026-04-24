cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fasta-to-parquet5
label: dsh-bio_fasta-to-parquet5
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
    doc: input FASTA path, default stdin
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
outputs:
  - id: output_parquet_file
    type: File
    doc: output Parquet file
    outputBinding:
      glob: $(inputs.output_parquet_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
