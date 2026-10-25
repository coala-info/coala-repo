cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToPsl
label: ucsc-maftopsl
doc: "Convert maf to psl format\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: query_src
    type: string
    doc: Query src, either an organism prefix (hg17), or a full src sequence name
      (hg17.chr11), or just the sequence name if the MAF does not contain organism
      prefixes
    inputBinding:
      position: 1
  - id: target_src
    type: string
    doc: Target src, in the same forms as the query src
    inputBinding:
      position: 2
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 3
  - id: out_psl
    type: string
    doc: Output PSL file name
    inputBinding:
      position: 4
outputs:
  - id: out_out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: $(inputs.out_psl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftopsl:482--h0b57e2e_0
