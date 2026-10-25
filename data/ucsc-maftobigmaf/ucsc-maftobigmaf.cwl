cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToBigMaf
label: ucsc-maftobigmaf
doc: "Put ucsc standard maf file into bigMaf format\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: reference_db
    type: string
    doc: Reference database name (the prefix of the reference sequence source names
      in the maf)
    inputBinding:
      position: 1
  - id: input_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    doc: Output bigMaf-style BED file name (text, to be converted with bedToBigBed)
    inputBinding:
      position: 3
outputs:
  - id: out_out_bed
    type: File
    doc: Output bigMaf BED file
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftobigmaf:482--h0b57e2e_0
