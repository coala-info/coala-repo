cwlVersion: v1.2
class: CommandLineTool
baseCommand: HmnRandomRead
label: hmnrandomread_HmnRandomRead
doc: "Generate random reads from reference sequences with specified insert sizes and
  error profiles.\n\nTool homepage: https://github.com/guillaume-gricourt/HmnRandomRead"
inputs:
  - id: length_reads
    type:
      - 'null'
      - int
    doc: Reads Size
    inputBinding:
      position: 101
      prefix: --length-reads
  - id: mean_insert_size
    type:
      - 'null'
      - int
    doc: Mean Insert Size
    inputBinding:
      position: 101
      prefix: --mean-insert-size
  - id: profile_diversity
    type:
      - 'null'
      - File
    doc: Name file with profile diversity
    inputBinding:
      position: 101
      prefix: --profile-diversity
  - id: profile_error
    type:
      - 'null'
      - File
    doc: Name file with profile error
    inputBinding:
      position: 101
      prefix: --profile-error
  - id: profile_error_id
    type:
      - 'null'
      - string
    doc: Id error profile to apply (required if -profileError)
    inputBinding:
      position: 101
      prefix: --profile-error-id
  - id: reference
    type: string
    doc: Reference(s) path with number sequence
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed number
    inputBinding:
      position: 101
      prefix: --seed
  - id: std_insert_size
    type:
      - 'null'
      - int
    doc: Standard Deviation Insert Size
    inputBinding:
      position: 101
      prefix: --std-insert-size
outputs:
  - id: read_forward
    type: File
    doc: Name Read Forward output
    outputBinding:
      glob: $(inputs.read_forward)
  - id: read_reverse
    type: File
    doc: Name Read Reverse output
    outputBinding:
      glob: $(inputs.read_reverse)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnrandomread:0.10.0--h9948957_4
