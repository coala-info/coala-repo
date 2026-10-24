cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedJoinTabOffset
label: ucsc-bedjointaboffset
doc: "Given a bed file and tab file where each have a column with matching values:
  first get the value of column0, the offset and line length from inTabFile. Then
  go over the bed file, use the name field and append its offset and length to the
  bed file as two separate fields. Write the new bed file to outBed.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_tab_file
    type: File
    doc: Tab-separated file with the key column.
    inputBinding:
      position: 1
  - id: in_bed_file
    type: File
    doc: Input BED file.
    inputBinding:
      position: 2
  - id: out_bed_file
    type: string
    doc: Name of the output BED file.
    inputBinding:
      position: 3
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug messages.
    inputBinding:
      position: 0
      prefix: -d
  - id: tab_key_field
    type:
      - 'null'
      - int
    doc: The index of the key field in the tab file that matches the key field in
      the bed file (default 0).
    inputBinding:
      position: 0
      prefix: -t
  - id: bed_key_field
    type:
      - 'null'
      - int
    doc: The index of the key field in the bed file that matches the key field in
      the tab file (default 3).
    inputBinding:
      position: 0
      prefix: -b
outputs:
  - id: output_bed
    type: File
    doc: BED file with the offset and length of each key appended.
    outputBinding:
      glob: $(inputs.out_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedjointaboffset:377--h199ee4e_0
