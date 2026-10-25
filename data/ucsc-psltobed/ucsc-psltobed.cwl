cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToBed
label: ucsc-psltobed
doc: "Transform a PSL format file to a BED format file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: bed
    type: string
    doc: Output BED file name.
    inputBinding:
      position: 11
  - id: cds
    type:
      - 'null'
      - File
    doc: Input CDS tab-separated file with genbank-style CDS records showing
      cdsStart..cdsEnd, e.g. NM_123456 34..305. Coordinates are in the query
      coordinate system of the PSL, like those created from genePredToFakePsl.
    inputBinding:
      position: 1
      prefix: -cds=
      separate: false
  - id: pos_name
    type:
      - 'null'
      - boolean
    doc: Change the qName field to qName:qStart-qEnd (can be used to create links
      to the query position on the details page).
    inputBinding:
      position: 2
      prefix: -posName
outputs:
  - id: bed_out
    type: File
    doc: Output BED file.
    outputBinding:
      glob: $(inputs.bed)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobed:482--h0b57e2e_0
