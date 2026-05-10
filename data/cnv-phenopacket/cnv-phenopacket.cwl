cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv-phenopacket
label: cnv-phenopacket
doc: "Convert TSV metadata to Phenopacket JSON\n\nTool homepage: https://github.com/conda-forge/cnv-phenopacket-feedstock"
inputs:
  - id: input
    type: File
    doc: Input TSV metadata file name
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output Phenopacket JSON file name
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-phenopacket:1.0.2
