cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_codon_conservation
doc: "Calculates codon conservation scores for SVHIP analysis.\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: input_file
    type: File
    doc: The input directory or file (Required).
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
    type: Directory
    doc: Name for the output directory (Required).
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
