cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LAsort
label: daligner_LAsort
doc: "Sort each .las alignment file. For an input X.las the sorted result is
  written as X.S.las.\n\nTool homepage: https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.alignments)
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
  - id: alignments
    type:
      type: array
      items: File
    doc: One or more .las alignment files to sort
    inputBinding:
      position: 2
      valueFrom: '${ return self.map(function(f) { return f.basename; }); }'
outputs:
  - id: sorted_alignments
    type:
      type: array
      items: File
    doc: Sorted alignment files (<name>.S.las)
    outputBinding:
      glob: '*.S.las'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
