cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsebra_get_longest_isoform.py
label: tsebra_get_longest_isoform.py
doc: "Filter a GTF file for the longest isoform of each gene.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: gtf
    type: File
    doc: Input GTF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output GTF file containing only the longest isoform per gene
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
