cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToGenePred
label: ucsc-bedtogenepred
doc: "Convert a BED file to a genePred file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
outputs:
  - id: output_genepred
    type: File
    doc: Output genePred file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtogenepred:482--h0b57e2e_0
