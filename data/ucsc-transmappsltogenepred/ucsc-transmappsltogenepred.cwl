cwlVersion: v1.2
class: CommandLineTool
baseCommand: transMapPslToGenePred
label: ucsc-transmappsltogenepred
doc: "Convert transMap PSL files to genePred format.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 1
  - id: map
    type: File
    doc: Mapping file.
    inputBinding:
      position: 2
  - id: all_non_canon
    type:
      - 'null'
      - boolean
    doc: Include all non-canonical splice sites.
    inputBinding:
      position: 103
      prefix: -allNonCanon
  - id: no_gap_fill
    type:
      - 'null'
      - boolean
    doc: Do not fill gaps.
    inputBinding:
      position: 103
      prefix: -noGapFill
  - id: non_canon
    type:
      - 'null'
      - boolean
    doc: Include non-canonical splice sites.
    inputBinding:
      position: 103
      prefix: -nonCanon
outputs:
  - id: gene_pred
    type: File
    doc: Output genePred file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-transmappsltogenepred:482--h0b57e2e_1
