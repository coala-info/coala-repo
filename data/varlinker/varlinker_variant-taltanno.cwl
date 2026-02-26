cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlinker_variant-taltanno
label: varlinker_variant-taltanno
doc: "extract the annotation of the specific alt allele\n\nTool homepage: https://github.com/IBCHgenomic/varlinker"
inputs:
  - id: vcffile
    type: File
    doc: variant VCF file
    inputBinding:
      position: 1
  - id: altallele
    type: string
    doc: alt allele
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
stdout: varlinker_variant-taltanno.out
