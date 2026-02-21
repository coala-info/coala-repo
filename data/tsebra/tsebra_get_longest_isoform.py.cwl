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
outputs:
  - id: output
    type: File
    doc: Output GTF file containing only the longest isoform per gene
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
