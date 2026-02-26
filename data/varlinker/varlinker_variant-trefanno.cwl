cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlinker_variant-trefanno
label: varlinker_variant-trefanno
doc: "extract the annotation of the specific ref allele\n\nTool homepage: https://github.com/IBCHgenomic/varlinker"
inputs:
  - id: vcffile
    type: File
    doc: variant VCF file
    inputBinding:
      position: 1
  - id: refallele
    type: string
    doc: ref allele
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
stdout: varlinker_variant-trefanno.out
