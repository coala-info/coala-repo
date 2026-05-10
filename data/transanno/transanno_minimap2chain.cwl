cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - minimap2chain
label: transanno_minimap2chain
doc: "Convert minimap2 result to chain file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: paf
    type: File
    doc: Input paf file
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output chain file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
