cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesList
label: ucsc-mafspecieslist
doc: "Scan maf and output all species used in it.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: out_lst
    type: string
    doc: Output list file name
    inputBinding:
      position: 2
  - id: ignore_first
    type:
      - 'null'
      - boolean
    doc: If true ignore first species in each maf, useful when this is a mafFrags
      result that puts gene id there.
    inputBinding:
      position: 101
      prefix: -ignoreFirst
outputs:
  - id: out_out_lst
    type: File
    doc: Output species list
    outputBinding:
      glob: $(inputs.out_lst)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspecieslist:482--h0b57e2e_0
