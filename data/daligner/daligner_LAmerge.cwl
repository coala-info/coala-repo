cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LAmerge
label: daligner_LAmerge
doc: "Merge sorted .las alignment files into one sorted .las file.\n\nTool
  homepage: https://github.com/thegenemyers/DALIGNER"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 1
      prefix: -v
  - id: sort_by_a_position
    type:
      - 'null'
      - boolean
    doc: Sort .las by A-read,A-position pairs for map usecase (off = sort by 
      A,B-read pairs for overlap piles).
    inputBinding:
      position: 1
      prefix: -a
  - id: merge_dir
    type:
      - 'null'
      - string
    doc: Do any intermediate merging in directory -P. Default /tmp.
    inputBinding:
      position: 1
      prefix: -P
      separate: false
  - id: merge
    type: string
    doc: Name of the merged output .las file
    inputBinding:
      position: 2
  - id: parts
    type:
      type: array
      items: File
    doc: Sorted .las files to merge
    inputBinding:
      position: 3
outputs:
  - id: merged_alignments
    type: File
    doc: Merged alignment file
    outputBinding:
      glob: '$(inputs.merge.replace(/\.las$/, "") + ".las")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
