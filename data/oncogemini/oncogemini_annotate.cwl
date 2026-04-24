cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini annotate
label: oncogemini_annotate
doc: "Annotate variants with information from a BED file.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be updated.
    inputBinding:
      position: 1
  - id: anno_file
    type: File
    doc: The TABIX'ed BED file containing the annotations
    inputBinding:
      position: 102
      prefix: -f
  - id: annotation_mode
    type:
      - 'null'
      - string
    doc: How should the annotation file be used? (def. extract)
    inputBinding:
      position: 102
      prefix: -a
  - id: col_extracts
    type:
      - 'null'
      - type: array
        items: string
    doc: Column(s) to extract information from for list annotations.If the input
      is VCF, then this defaults to the fields specified in `-c`.
    inputBinding:
      position: 102
      prefix: -e
  - id: col_names
    type:
      - 'null'
      - type: array
        items: string
    doc: The name(s) of the BED column(s) to be added to the variant table.If 
      the input file is a VCF, then this is the name of the info field to pull.
    inputBinding:
      position: 102
      prefix: -c
  - id: col_operations
    type:
      - 'null'
      - type: array
        items: string
    doc: Operation(s) to apply to the extract column values in the event that a 
      variant overlaps multiple annotations in your annotation file (-f).Any of 
      {sum, mean, median, min, max, mode, list, uniq_list, first, last}
    inputBinding:
      position: 102
      prefix: -o
  - id: col_types
    type:
      - 'null'
      - type: array
        items: string
    doc: What data type(s) should be used to represent the new values in the 
      database? Any of {integer, float, text}
    inputBinding:
      position: 102
      prefix: -t
  - id: region_only
    type:
      - 'null'
      - boolean
    doc: If set, only region coordinates will be considered when annotating 
      variants.The default is to annotate using region coordinates as well as 
      REF and ALT variant valuesThis option is only valid if annotation is a VCF
      file
    inputBinding:
      position: 102
      prefix: --region-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_annotate.out
