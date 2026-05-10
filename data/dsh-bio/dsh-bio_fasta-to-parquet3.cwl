cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fasta-to-parquet3
label: dsh-bio_fasta-to-parquet3
doc: "Converts FASTA files to Parquet format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: input FASTA alphabet { dna, protein }, default dna
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
  - id: partition_size
    type:
      - 'null'
      - int
    doc: partition size, default 1228800
    inputBinding:
      position: 101
      prefix: --partition-size
  - id: row_group_size
    type:
      - 'null'
      - int
    doc: row group size, default 122880
    inputBinding:
      position: 101
      prefix: --row-group-size
  - id: output_parquet_file_path
    type: string
    doc: Output or path parameter `output_parquet_file_path`
    inputBinding:
      position: 102
      prefix: --output-parquet-file
outputs:
  - id: output_parquet_file
    type: Directory
    doc: output Parquet file, will be created as a directory, overwriting if 
      necessary
    outputBinding:
      glob: $(inputs.output_parquet_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
