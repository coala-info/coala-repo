cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinamo
label: dinamo
doc: "Finds motifs in sequences.\n\nTool homepage: https://github.com/bonsai-team/DiNAMO/"
inputs:
  - id: degeneration_level
    type:
      - 'null'
      - int
    doc: Limits the degeneration to at most k positions.
    default: k
    inputBinding:
      position: 101
      prefix: --degeneration-level
  - id: motif_length
    type: int
    doc: Length of the motifs to find (k).
    inputBinding:
      position: 101
      prefix: --motif-length
  - id: negative_file
    type: File
    doc: Path to the negative sequences file.
    inputBinding:
      position: 101
      prefix: --negative-file
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Prevents the log output from being displayed.
    inputBinding:
      position: 101
      prefix: --no-log
  - id: norc
    type:
      - 'null'
      - boolean
    doc: 'When -p is not used, prevents dinamo to link motif to their reverse complement
      (Please be warned : not linking the motif to their reverse complement usually
      doubles memory usage).'
    inputBinding:
      position: 101
      prefix: --norc
  - id: position
    type:
      - 'null'
      - int
    doc: 'Only process motif that end at position k in the sequence. (Important note
      : position 0 corresponds to the last motif of each sequence)'
    inputBinding:
      position: 101
      prefix: --position
  - id: positive_file
    type: File
    doc: Path to the positive sequences file.
    inputBinding:
      position: 101
      prefix: --positive-file
  - id: threshold
    type:
      - 'null'
      - float
    doc: Sets the pvalue threshold to r (0 <= r <= 1).
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output the meme file to the desired path (has no effect when -p option 
      is used).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinamo:1.0--h9948957_8
