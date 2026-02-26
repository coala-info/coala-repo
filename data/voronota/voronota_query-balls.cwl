cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_query-balls
label: voronota_query-balls
doc: "Query a list of balls based on various criteria and modify them.\n\nTool homepage:
  https://www.voronota.com/"
inputs:
  - id: stdin
    type:
      - 'null'
      - string
    doc: "list of balls (line format: 'annotation x y z r tags adjuncts')"
    inputBinding:
      position: 1
  - id: chains_seq_identity
    type:
      - 'null'
      - float
    doc: sequence identity threshold for chains summary, default is 0.9
    default: 0.9
    inputBinding:
      position: 102
      prefix: --chains-seq-identity
  - id: drop_adjuncts
    type:
      - 'null'
      - boolean
    doc: flag to drop all adjuncts from input
    inputBinding:
      position: 102
      prefix: --drop-adjuncts
  - id: drop_altloc_indicators
    type:
      - 'null'
      - boolean
    doc: flag to drop alternate location indicators from input
    inputBinding:
      position: 102
      prefix: --drop-altloc-indicators
  - id: drop_atom_serials
    type:
      - 'null'
      - boolean
    doc: flag to drop atom serial numbers from input
    inputBinding:
      position: 102
      prefix: --drop-atom-serials
  - id: drop_tags
    type:
      - 'null'
      - boolean
    doc: flag to drop all tags from input
    inputBinding:
      position: 102
      prefix: --drop-tags
  - id: guess_chain_names
    type:
      - 'null'
      - boolean
    doc: flag to assign input chain names based on residue numbering
    inputBinding:
      position: 102
      prefix: --guess-chain-names
  - id: invert
    type:
      - 'null'
      - boolean
    doc: flag to invert selection
    inputBinding:
      position: 102
      prefix: --invert
  - id: match
    type:
      - 'null'
      - string
    doc: selection
    inputBinding:
      position: 102
      prefix: --match
  - id: match_adjuncts
    type:
      - 'null'
      - string
    doc: adjuncts intervals to match
    inputBinding:
      position: 102
      prefix: --match-adjuncts
  - id: match_adjuncts_not
    type:
      - 'null'
      - string
    doc: adjuncts intervals to not match
    inputBinding:
      position: 102
      prefix: --match-adjuncts-not
  - id: match_external_annotations
    type:
      - 'null'
      - File
    doc: file path to input matchable annotations
    inputBinding:
      position: 102
      prefix: --match-external-annotations
  - id: match_not
    type:
      - 'null'
      - string
    doc: negative selection
    inputBinding:
      position: 102
      prefix: --match-not
  - id: match_tags
    type:
      - 'null'
      - string
    doc: tags to match
    inputBinding:
      position: 102
      prefix: --match-tags
  - id: match_tags_not
    type:
      - 'null'
      - string
    doc: tags to not match
    inputBinding:
      position: 102
      prefix: --match-tags-not
  - id: rename_chains
    type:
      - 'null'
      - boolean
    doc: flag to rename input chains to be in interval from 'A' to 'Z'
    inputBinding:
      position: 102
      prefix: --rename-chains
  - id: renumber_from_adjunct
    type:
      - 'null'
      - string
    doc: adjunct name to use for input residue renumbering
    inputBinding:
      position: 102
      prefix: --renumber-from-adjunct
  - id: renumber_positively
    type:
      - 'null'
      - boolean
    doc: flag to increment residue numbers to make them positive
    inputBinding:
      position: 102
      prefix: --renumber-positively
  - id: reset_serials
    type:
      - 'null'
      - boolean
    doc: flag to reset atom serial numbers
    inputBinding:
      position: 102
      prefix: --reset-serials
  - id: set_adjuncts
    type:
      - 'null'
      - string
    doc: set adjuncts instead of filtering
    inputBinding:
      position: 102
      prefix: --set-adjuncts
  - id: set_dssp_info
    type:
      - 'null'
      - File
    doc: file path to input DSSP file
    inputBinding:
      position: 102
      prefix: --set-dssp-info
  - id: set_external_adjuncts
    type:
      - 'null'
      - File
    doc: file path to input external adjuncts
    inputBinding:
      position: 102
      prefix: --set-external-adjuncts
  - id: set_external_adjuncts_name
    type:
      - 'null'
      - string
    doc: name for external adjuncts
    inputBinding:
      position: 102
      prefix: --set-external-adjuncts-name
  - id: set_ref_seq_num_adjunct
    type:
      - 'null'
      - File
    doc: file path to input reference sequence
    inputBinding:
      position: 102
      prefix: --set-ref-seq-num-adjunct
  - id: set_seq_pos_adjunct
    type:
      - 'null'
      - boolean
    doc: flag to set normalized sequence position adjunct
    inputBinding:
      position: 102
      prefix: --set-seq-pos-adjunct
  - id: set_tags
    type:
      - 'null'
      - string
    doc: set tags instead of filtering
    inputBinding:
      position: 102
      prefix: --set-tags
  - id: whole_residues
    type:
      - 'null'
      - boolean
    doc: flag to select whole residues
    inputBinding:
      position: 102
      prefix: --whole-residues
outputs:
  - id: ref_seq_alignment
    type:
      - 'null'
      - File
    doc: file path to output alignment with reference
    outputBinding:
      glob: $(inputs.ref_seq_alignment)
  - id: seq_output
    type:
      - 'null'
      - File
    doc: file path to output query result sequence string
    outputBinding:
      glob: $(inputs.seq_output)
  - id: chains_summary_output
    type:
      - 'null'
      - File
    doc: file path to output chains summary
    outputBinding:
      glob: $(inputs.chains_summary_output)
  - id: stdout
    type:
      - 'null'
      - File
    doc: "list of balls (line format: 'annotation x y z r tags adjuncts')"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
