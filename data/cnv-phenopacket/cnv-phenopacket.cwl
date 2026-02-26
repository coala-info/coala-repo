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
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output Phenopacket JSON file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-phenopacket:1.0.2
