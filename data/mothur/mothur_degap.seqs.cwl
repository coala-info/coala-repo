cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_degap.seqs
doc: "Degaps sequences.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: input_file
    type: File
    doc: Input file containing sequences to degap.
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for degapped sequences.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
