cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gdi
  - load
  - vcf
label: genomics-data-index_gdi load vcf
doc: "Load VCF files into the Genomics Data Index.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
inputs:
  - id: vcf_fofns
    type: File
    doc: File of VCF files to load
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi load vcf.out
