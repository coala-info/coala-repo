cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigMafToMaf
label: ucsc-bigmaftomaf
doc: "Convert a bigMaf file (bigBed format) to a MAF file.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_big_maf
    type: File
    doc: Input bigMaf file (usually .bb or .bigMaf)
    inputBinding:
      position: 1
outputs:
  - id: output_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigmaftomaf:482--h0b57e2e_0
