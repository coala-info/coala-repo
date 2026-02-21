cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - gff2bed
label: bioformats_gff2bed
doc: "Convert a GFF3 file to the BED format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: gff_file
    type: File
    doc: a GFF3 file
    inputBinding:
      position: 1
  - id: type
    type: string
    doc: type of features to be processed
    inputBinding:
      position: 2
  - id: attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: attributes to include to the output BED file
    inputBinding:
      position: 103
      prefix: --attributes
  - id: genes
    type:
      - 'null'
      - boolean
    doc: output a BED12 file of genes
    default: false
    inputBinding:
      position: 103
      prefix: --genes
  - id: missing_value
    type:
      - 'null'
      - string
    doc: the missing tag value
    default: NA
    inputBinding:
      position: 103
      prefix: --missing_value
  - id: name_tag
    type:
      - 'null'
      - string
    doc: an attribute tag of a feature name
    inputBinding:
      position: 103
      prefix: --name_tag
  - id: no_order_check
    type:
      - 'null'
      - boolean
    doc: do not check the order of GFF3 file records
    default: false
    inputBinding:
      position: 103
      prefix: --no_order_check
  - id: parent_tag
    type:
      - 'null'
      - string
    doc: an attribute tag of exon genes
    default: Parent
    inputBinding:
      position: 103
      prefix: --parent_tag
outputs:
  - id: output_file
    type: File
    doc: the output file in the BED format
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
