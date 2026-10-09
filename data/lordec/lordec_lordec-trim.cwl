cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-trim
label: lordec_lordec-trim
doc: "Scan a set of corrected long reads and output them trimmed to the regions that have been corrected.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: input_file
    type: File
    doc: FASTA-file
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: output-file
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: output-file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
