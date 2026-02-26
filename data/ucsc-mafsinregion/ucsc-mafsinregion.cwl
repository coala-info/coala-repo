cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafsInRegion
label: ucsc-mafsinregion
doc: "Extract MAF blocks that overlap regions in a BED file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: regions_bed
    type: File
    doc: BED file containing regions to extract
    inputBinding:
      position: 1
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 2
  - id: keep_empty
    type:
      - 'null'
      - boolean
    doc: Keep regions that don't overlap any MAF blocks.
    inputBinding:
      position: 103
      prefix: -keepEmpty
outputs:
  - id: out_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '*.out'
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output to a directory, one file per region. out.maf is ignored.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafsinregion:482--h0b57e2e_0
