cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastaIndex
label: fastaindex_FastaIndex
doc: "Create an index for a FASTA file.\n\nTool homepage: https://github.com/lpryszcz/FastaIndex"
inputs:
  - id: fasta_file
    type: File
    doc: The FASTA file to index.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the index file if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output index file. Defaults to <fasta_file>.fai.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaindex:0.11c--py36_0
