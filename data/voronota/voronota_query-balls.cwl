cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - query-balls
label: voronota_query-balls
doc: "Selects and edits balls.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (stdin)"
  - id: match
    type:
      - 'null'
      - string
    doc: "selection"
    inputBinding:
      position: 101
      prefix: --match
  - id: match_not
    type:
      - 'null'
      - string
    doc: "negative selection"
    inputBinding:
      position: 101
      prefix: --match-not
  - id: match_tags
    type:
      - 'null'
      - string
    doc: "tags to match"
    inputBinding:
      position: 101
      prefix: --match-tags
  - id: match_tags_not
    type:
      - 'null'
      - string
    doc: "tags to not match"
    inputBinding:
      position: 101
      prefix: --match-tags-not
  - id: match_adjuncts
    type:
      - 'null'
      - string
    doc: "adjuncts intervals to match"
    inputBinding:
      position: 101
      prefix: --match-adjuncts
  - id: match_adjuncts_not
    type:
      - 'null'
      - string
    doc: "adjuncts intervals to not match"
    inputBinding:
      position: 101
      prefix: --match-adjuncts-not
  - id: match_external_annotations
    type:
      - 'null'
      - File
    doc: "file path to input matchable annotations"
    inputBinding:
      position: 101
      prefix: --match-external-annotations
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "flag to invert selection"
    inputBinding:
      position: 101
      prefix: --invert
  - id: whole_residues
    type:
      - 'null'
      - boolean
    doc: "flag to select whole residues"
    inputBinding:
      position: 101
      prefix: --whole-residues
  - id: drop_atom_serials
    type:
      - 'null'
      - boolean
    doc: "flag to drop atom serial numbers from input"
    inputBinding:
      position: 101
      prefix: --drop-atom-serials
  - id: drop_altloc_indicators
    type:
      - 'null'
      - boolean
    doc: "flag to drop alternate location indicators from input"
    inputBinding:
      position: 101
      prefix: --drop-altloc-indicators
  - id: drop_tags
    type:
      - 'null'
      - boolean
    doc: "flag to drop all tags from input"
    inputBinding:
      position: 101
      prefix: --drop-tags
  - id: drop_adjuncts
    type:
      - 'null'
      - boolean
    doc: "flag to drop all adjuncts from input"
    inputBinding:
      position: 101
      prefix: --drop-adjuncts
  - id: set_tags
    type:
      - 'null'
      - string
    doc: "set tags instead of filtering"
    inputBinding:
      position: 101
      prefix: --set-tags
  - id: set_dssp_info
    type:
      - 'null'
      - File
    doc: "file path to input DSSP file"
    inputBinding:
      position: 101
      prefix: --set-dssp-info
  - id: set_adjuncts
    type:
      - 'null'
      - string
    doc: "set adjuncts instead of filtering"
    inputBinding:
      position: 101
      prefix: --set-adjuncts
  - id: set_external_adjuncts
    type:
      - 'null'
      - File
    doc: "file path to input external adjuncts"
    inputBinding:
      position: 101
      prefix: --set-external-adjuncts
  - id: set_external_adjuncts_name
    type:
      - 'null'
      - string
    doc: "name for external adjuncts"
    inputBinding:
      position: 101
      prefix: --set-external-adjuncts-name
  - id: rename_chains
    type:
      - 'null'
      - boolean
    doc: "flag to rename input chains to be in interval from 'A' to 'Z'"
    inputBinding:
      position: 101
      prefix: --rename-chains
  - id: guess_chain_names
    type:
      - 'null'
      - boolean
    doc: "flag to assign input chain names based on residue numbering"
    inputBinding:
      position: 101
      prefix: --guess-chain-names
  - id: renumber_from_adjunct
    type:
      - 'null'
      - string
    doc: "adjunct name to use for input residue renumbering"
    inputBinding:
      position: 101
      prefix: --renumber-from-adjunct
  - id: renumber_positively
    type:
      - 'null'
      - boolean
    doc: "flag to increment residue numbers to make them positive"
    inputBinding:
      position: 101
      prefix: --renumber-positively
  - id: reset_serials
    type:
      - 'null'
      - boolean
    doc: "flag to reset atom serial numbers"
    inputBinding:
      position: 101
      prefix: --reset-serials
  - id: set_seq_pos_adjunct
    type:
      - 'null'
      - boolean
    doc: "flag to set normalized sequence position adjunct"
    inputBinding:
      position: 101
      prefix: --set-seq-pos-adjunct
  - id: set_ref_seq_num_adjunct
    type:
      - 'null'
      - File
    doc: "file path to input reference sequence"
    inputBinding:
      position: 101
      prefix: --set-ref-seq-num-adjunct
  - id: ref_seq_alignment_path
    type:
      - 'null'
      - string
    doc: "file path to output alignment with reference"
    inputBinding:
      position: 101
      prefix: --ref-seq-alignment
  - id: seq_output_path
    type:
      - 'null'
      - string
    doc: "file path to output query result sequence string"
    inputBinding:
      position: 101
      prefix: --seq-output
  - id: chains_summary_output_path
    type:
      - 'null'
      - string
    doc: "file path to output chains summary"
    inputBinding:
      position: 101
      prefix: --chains-summary-output
  - id: chains_seq_identity
    type:
      - 'null'
      - float
    doc: "sequence identity threshold for chains summary, default is 0.9"
    inputBinding:
      position: 101
      prefix: --chains-seq-identity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: ref_seq_alignment
    type:
      - 'null'
      - File
    doc: "file path to output alignment with reference"
    outputBinding:
      glob: $(inputs.ref_seq_alignment_path)
  - id: seq_output
    type:
      - 'null'
      - File
    doc: "file path to output query result sequence string"
    outputBinding:
      glob: $(inputs.seq_output_path)
  - id: chains_summary_output
    type:
      - 'null'
      - File
    doc: "file path to output chains summary"
    outputBinding:
      glob: $(inputs.chains_summary_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_balls.path)
stdout: voronota_query-balls.out
