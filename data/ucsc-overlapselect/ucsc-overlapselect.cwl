cwlVersion: v1.2
class: CommandLineTool
baseCommand: overlapSelect
label: ucsc-overlapselect
doc: "Select records from one file that overlap with records in another.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: select_file
    type: File
    doc: File containing records to overlap against (select file).
    inputBinding:
      position: 1
  - id: in_file
    type: File
    doc: Input file to be filtered/selected.
    inputBinding:
      position: 2
  - id: id_threshold
    type:
      - 'null'
      - float
    doc: Minimum fraction of inFile record ID that must overlap selectFile 
      record.
    inputBinding:
      position: 103
      prefix: -idThreshold
  - id: in_fmt
    type:
      - 'null'
      - string
    doc: 'Input file format: genePred, psl, bed, or chain.'
    inputBinding:
      position: 103
      prefix: -inFmt
  - id: merge_output
    type:
      - 'null'
      - boolean
    doc: Merge overlapping records in selectFile before selecting.
    inputBinding:
      position: 103
      prefix: -mergeOutput
  - id: non_overlapping
    type:
      - 'null'
      - boolean
    doc: Select records that do not overlap.
    inputBinding:
      position: 103
      prefix: -nonOverlapping
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: Only consider overlaps on the opposite strand.
    inputBinding:
      position: 103
      prefix: -oppositeStrand
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: Minimum fraction of inFile record that must overlap selectFile record.
    inputBinding:
      position: 103
      prefix: -overlapThreshold
  - id: select_fmt
    type:
      - 'null'
      - string
    doc: 'Select file format: genePred, psl, bed, or chain.'
    inputBinding:
      position: 103
      prefix: -selectFmt
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Only consider overlaps on the same strand.
    inputBinding:
      position: 103
      prefix: -strand
outputs:
  - id: out_file
    type: File
    doc: Output file for selected records.
    outputBinding:
      glob: '*.out'
  - id: stats
    type:
      - 'null'
      - File
    doc: Write statistics to specified file.
    outputBinding:
      glob: $(inputs.stats)
  - id: dropped
    type:
      - 'null'
      - File
    doc: Write records that were not selected to specified file.
    outputBinding:
      glob: $(inputs.dropped)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-overlapselect:482--h0b57e2e_0
