cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigMafToMaf
label: ucsc-bigmaftomaf
doc: "Convert bigMaf to maf file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: big_maf
    type: File
    doc: "Input bigMaf (bigBed) file"
    inputBinding:
      position: 1
  - id: output_maf
    type: string
    doc: "Name of the output MAF file"
    inputBinding:
      position: 2
outputs:
  - id: out_output_maf
    type: File
    doc: "Output MAF file"
    outputBinding:
      glob: $(inputs.output_maf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigmaftomaf:482--h0b57e2e_0
