cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_fasta_by_header_regex.py
label: biocode_filter_fasta_by_header_regex.py
doc: "Filters a FASTA file by user-supplied regular expression to match the headers\n
  \nTool homepage: http://github.com/jorvis/biocode"
inputs:
  - id: input_file
    type: File
    doc: Path to an input FASTA file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: regex
    type: string
    doc: Regular expression to match against each header
    inputBinding:
      position: 101
      prefix: --regex
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to an output file to be created
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
