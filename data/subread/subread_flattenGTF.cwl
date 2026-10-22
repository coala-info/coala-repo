cwlVersion: v1.2
class: CommandLineTool
baseCommand: flattenGTF
label: subread_flattenGTF
doc: "Flatten features included in a GTF annotation and save the modified annotation to a SAF format file.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: annotation
    type: File
    doc: Name of an annotation file in GTF/GFF format.
    inputBinding:
      position: 1
      prefix: -a
  - id: output_file
    type: string
    doc: Name of output file.
    inputBinding:
      position: 1
      prefix: -o
  - id: feature_type
    type:
      - 'null'
      - string
    doc: "Feature type in a GTF annotation. 'exon' by default."
    inputBinding:
      position: 1
      prefix: -t
  - id: attribute_type
    type:
      - 'null'
      - string
    doc: "Attribute type in GTF annotation, used to group features into meta-features. 'gene_id' by default."
    inputBinding:
      position: 1
      prefix: -g
  - id: merge_exons
    type:
      - 'null'
      - boolean
    doc: Merge overlapping exons into multiple non-overlapping exons but all the edges are kept.
    inputBinding:
      position: 1
      prefix: -C
outputs:
  - id: saf
    type: File
    doc: Flattened annotation in SAF format
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
