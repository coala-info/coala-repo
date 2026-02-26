cwlVersion: v1.2
class: CommandLineTool
baseCommand: bialign.py
label: bialign_bialign.py
doc: "Bialignment.\n\nTool homepage: https://github.com/s-will/BiAlign"
inputs:
  - id: seqA
    type: string
    doc: sequence A
    inputBinding:
      position: 1
  - id: seqB
    type: string
    doc: sequence B
    inputBinding:
      position: 2
  - id: fileinput
    type:
      - 'null'
      - boolean
    doc: Read sequence and structure input from file
    inputBinding:
      position: 103
      prefix: --fileinput
  - id: gap_cost
    type:
      - 'null'
      - float
    doc: Similarity of a single gap position
    inputBinding:
      position: 103
      prefix: --gap_cost
  - id: gap_opening_cost
    type:
      - 'null'
      - float
    doc: Similarity of opening a gap (turns on affine gap cost if not 0)
    inputBinding:
      position: 103
      prefix: --gap_opening_cost
  - id: max_shift
    type:
      - 'null'
      - int
    doc: Maximal number of shifts away from the diagonal in either direction
    inputBinding:
      position: 103
      prefix: --max_shift
  - id: name_a
    type:
      - 'null'
      - string
    doc: name A
    inputBinding:
      position: 103
      prefix: --nameA
  - id: name_b
    type:
      - 'null'
      - string
    doc: name B
    inputBinding:
      position: 103
      prefix: --nameB
  - id: nodescription
    type:
      - 'null'
      - boolean
    doc: Don't prefix the strings in output alignment with descriptions
    inputBinding:
      position: 103
      prefix: --nodescription
  - id: outmode
    type:
      - 'null'
      - string
    doc: Output mode [call --outmode help for a list of options]
    inputBinding:
      position: 103
      prefix: --outmode
  - id: sequence_match_similarity
    type:
      - 'null'
      - float
    doc: Similarity of matching nucleotides
    inputBinding:
      position: 103
      prefix: --sequence_match_similarity
  - id: sequence_mismatch_similarity
    type:
      - 'null'
      - float
    doc: Similarity of mismatching nucleotides
    inputBinding:
      position: 103
      prefix: --sequence_mismatch_similarity
  - id: shift_cost
    type:
      - 'null'
      - float
    doc: Similarity of shifting the two scores against each other
    inputBinding:
      position: 103
      prefix: --shift_cost
  - id: simmatrix
    type:
      - 'null'
      - File
    doc: Similarity matrix
    inputBinding:
      position: 103
      prefix: --simmatrix
  - id: structure_a
    type:
      - 'null'
      - string
    doc: structure A
    inputBinding:
      position: 103
      prefix: --strA
  - id: structure_b
    type:
      - 'null'
      - string
    doc: structure B
    inputBinding:
      position: 103
      prefix: --strB
  - id: structure_weight
    type:
      - 'null'
      - float
    doc: Weighting factor for structure similarity
    inputBinding:
      position: 103
      prefix: --structure_weight
  - id: type
    type:
      - 'null'
      - string
    doc: 'Type of molecule: RNA or Protein'
    inputBinding:
      position: 103
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bialign:0.3--py310hec16e2b_0
stdout: bialign_bialign.py.out
