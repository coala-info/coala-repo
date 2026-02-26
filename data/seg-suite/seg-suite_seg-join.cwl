cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-join
label: seg-suite_seg-join
doc: "Read two SEG files, and write their JOIN.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: file1_seg
    type: File
    doc: First SEG file
    inputBinding:
      position: 1
  - id: file2_seg
    type: File
    doc: Second SEG file
    inputBinding:
      position: 2
  - id: complete_records_file_num
    type:
      - 'null'
      - int
    doc: only use complete/contained records of file FILENUM
    inputBinding:
      position: 103
      prefix: -c
  - id: complete_records_overlap_other
    type:
      - 'null'
      - int
    doc: write complete records of file FILENUM, that overlap anything in the 
      other file
    inputBinding:
      position: 103
      prefix: -f
  - id: file2_covered_percent
    type:
      - 'null'
      - float
    doc: write each record of file 2, if at least PERCENT of it is covered by 
      file 1
    inputBinding:
      position: 103
      prefix: -n
  - id: file2_not_covered_percent
    type:
      - 'null'
      - float
    doc: write each record of file 2, if at most PERCENT of it is covered by 
      file 1
    inputBinding:
      position: 103
      prefix: -x
  - id: join_on_whole_segment_tuples
    type:
      - 'null'
      - boolean
    doc: join on whole segment-tuples, not just first segments
    inputBinding:
      position: 103
      prefix: -w
  - id: unjoinable_parts_file_num
    type:
      - 'null'
      - int
    doc: only write unjoinable parts of file FILENUM
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-join.out
