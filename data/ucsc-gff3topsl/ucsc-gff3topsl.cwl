cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToPsl
label: ucsc-gff3topsl
doc: "Convert GFF3 file to PSL format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: gff3_file
    type: File
    doc: Input GFF3 file
    inputBinding:
      position: 1
outputs:
  - id: psl_file
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gff3topsl:482--h0b57e2e_0
