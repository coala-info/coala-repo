cwlVersion: v1.2
class: CommandLineTool
baseCommand: CPC2.py
label: cpc2
doc: "CPC2 (Coding Potential Calculator 2) is a fast and accurate tool to assess the
  coding potential of RNA sequences.\n\nTool homepage: https://github.com/gao-lab/CPC2_standalone"
inputs:
  - id: input_file
    type: File
    doc: Input sequence in FASTA format
    inputBinding:
      position: 101
      prefix: --input
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Output file to write the results
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpc2:1.0.1--hdfd78af_0
