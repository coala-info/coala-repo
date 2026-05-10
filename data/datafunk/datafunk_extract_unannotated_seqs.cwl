cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk extract_unannotated_seqs
label: datafunk_extract_unannotated_seqs
doc: "extract sequences with an empty cell in a specified cell in a metadata table\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: index_column
    type: string
    doc: metadata column to match to fasta file
    inputBinding:
      position: 101
      prefix: --index-column
  - id: input_fasta
    type: File
    doc: fasta file to extract sequences from
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_metadata
    type: File
    doc: input metadata file
    inputBinding:
      position: 101
      prefix: --input-metadata
  - id: input_metadata_file
    type: File
    doc: metadata whose columns and rows will be checked
    inputBinding:
      position: 101
      prefix: --input-metadata
  - id: input_tree
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input-tree
  - id: null_column
    type: string
    doc: metadata column which will be checked as empty
    inputBinding:
      position: 101
      prefix: --null-column
  - id: output_fasta_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_fasta_path`
    inputBinding:
      position: 102
      prefix: --output-fasta
  - id: output_metadata_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_metadata_path`
    inputBinding:
      position: 103
      prefix: --output-metadata
  - id: output_tree_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_tree_path`
    inputBinding:
      position: 104
      prefix: --output-tree
outputs:
  - id: output_tree
    type: File
    doc: output tree file
    outputBinding:
      glob: $(inputs.output_tree_path)
  - id: output_metadata
    type: File
    doc: output metadata file
    outputBinding:
      glob: $(inputs.output_metadata_path)
  - id: output_fasta
    type: File
    doc: fasta file to write
    outputBinding:
      glob: $(inputs.output_fasta_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
