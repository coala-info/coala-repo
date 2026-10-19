cwlVersion: v1.2
class: CommandLineTool
baseCommand: rearrangement
label: rearr_rearrangement
doc: "Perform rearrangement analysis\n\nTool homepage: https://github.com/ljw20180420/rearr"
inputs:
  - id: input_file
    type: File
    doc: "Input file read from stdin: tab-separated query, count (#) and reference index (id, 0-based row of the reference file)"
  - id: reference_file
    type: File
    doc: "Reference file read from file descriptor 3: tab-separated start1, ref1, end1, start2, ref2, end2 per row"
  - id: gap_extending_penalty
    type:
      - 'null'
      - int
    doc: Gap-extending penalty.
    inputBinding:
      position: 103
      prefix: -u
  - id: gap_extending_unaligned_query
    type:
      - 'null'
      - int
    doc: Gap-extending penalty for unaligned query parts.
    inputBinding:
      position: 103
      prefix: -qu
  - id: gap_extending_unaligned_ref_ends
    type:
      - 'null'
      - int
    doc: Gap-extending penalty for unaligned reference ends.
    inputBinding:
      position: 103
      prefix: -ru
  - id: gap_opening_penalty
    type:
      - 'null'
      - int
    doc: Gap-opening penalty.
    inputBinding:
      position: 103
      prefix: -v
  - id: gap_opening_unaligned_query
    type:
      - 'null'
      - int
    doc: Gap-opening penalty for unaligned query parts.
    inputBinding:
      position: 103
      prefix: -qv
  - id: gap_opening_unaligned_ref_ends
    type:
      - 'null'
      - int
    doc: Gap-opening penalty for unaligned reference ends.
    inputBinding:
      position: 103
      prefix: -rv
  - id: matching_score_extension
    type:
      - 'null'
      - int
    doc: Matching score for extension reference part.
    inputBinding:
      position: 103
      prefix: -s2
  - id: matching_score_non_extension
    type:
      - 'null'
      - int
    doc: Matching score for non-extension reference part.
    inputBinding:
      position: 103
      prefix: -s1
  - id: mismatching_score
    type:
      - 'null'
      - int
    doc: Mismatching score.
    inputBinding:
      position: 103
      prefix: -s0
arguments:
  - position: 200
    shellQuote: false
    valueFrom: 3< $(inputs.reference_file.path)
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rearr:1.0.11--h9948957_0
stdout: rearr_rearrangement.out
stdin: $(inputs.input_file.path)
