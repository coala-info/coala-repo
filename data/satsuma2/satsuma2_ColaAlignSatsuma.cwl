cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ColaAlignSatsuma]
label: satsuma2_ColaAlignSatsuma
doc: "Realigns global alignment in satsuma format with Cola.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: query
    type: File
    doc: "query sequence"
    inputBinding:
      position: 1
      prefix: -q
  - id: target
    type: File
    doc: "target sequence"
    inputBinding:
      position: 2
      prefix: -t
  - id: summary_file
    type: File
    doc: "satsuma summary file"
    inputBinding:
      position: 3
      prefix: -s
  - id: aligner_type
    type: ['null', int]
    doc: "Aligner type - Choose 1 : NSGA , 2 : NS , 3 : SWGA, 4 : SW  (def=1)"
    inputBinding:
      position: 4
      prefix: -a
  - id: output_mode
    type: ['null', int]
    doc: "Output mode - 0:Full  1:Summary CSV  2:MultiAlignFormat (def=2)"
    inputBinding:
      position: 5
      prefix: -m
  - id: combined_output
    type: ['null', string]
    doc: "combined output file (def=)"
    inputBinding:
      position: 6
      prefix: -o
  - id: realign_output
    type: ['null', string]
    doc: "realignment output file (def=reAlign.out)"
    inputBinding:
      position: 7
      prefix: -r
  - id: gap_output
    type: ['null', string]
    doc: "gap output file (def=gapAlign.out)"
    inputBinding:
      position: 8
      prefix: -g
  - id: merge_boundary
    type: ['null', int]
    doc: "Merge Boundary for merging consecutive blocks (def=5)"
    inputBinding:
      position: 9
      prefix: -b
  - id: threads
    type: ['null', int]
    doc: "Number of cores to run with (def=2)"
    inputBinding:
      position: 10
      prefix: -T
outputs:
  - id: combined_alignment
    type: ['null', File]
    doc: "Combined output file (when -o is set)"
    outputBinding:
      glob: "$(inputs.combined_output)"
  - id: realign_file
    type: ['null', File]
    doc: "Realignment output file"
    outputBinding:
      glob: "$(inputs.realign_output || 'reAlign.out')"
  - id: gap_file
    type: ['null', File]
    doc: "Gap output file"
    outputBinding:
      glob: "$(inputs.gap_output || 'gapAlign.out')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
