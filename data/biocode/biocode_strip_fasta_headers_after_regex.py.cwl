cwlVersion: v1.2
class: CommandLineTool
baseCommand: strip_fasta_headers_after_regex.py
label: biocode_strip_fasta_headers_after_regex.py
doc: "Modified the headers of a FASTA file based on user options\n\nTool homepage:
  http://github.com/jorvis/biocode"
inputs:
  - id: include
    type: string
    doc: Include the regex portion in the output? Values are yes or no
    inputBinding:
      position: 101
      prefix: --include
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
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to an output file to be created
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
