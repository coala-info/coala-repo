cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_query-contacts
label: voronota_query-contacts
doc: "Query contacts based on various criteria and modify them.\n\nTool homepage:
  https://www.voronota.com/"
inputs:
  - id: input_contacts
    type:
      type: array
      items: File
    doc: "list of contacts (line format: 'annotation1 annotation2 area distance tags
      adjuncts [graphics]')"
    inputBinding:
      position: 1
  - id: drop_adjuncts
    type:
      - 'null'
      - boolean
    doc: flag to drop all adjuncts from input
    inputBinding:
      position: 102
      prefix: --drop-adjuncts
  - id: drop_tags
    type:
      - 'null'
      - boolean
    doc: flag to drop all tags from input
    inputBinding:
      position: 102
      prefix: --drop-tags
  - id: ignore_dist_for_solvent
    type:
      - 'null'
      - boolean
    doc: flag to ignore distance for solvent contacts
    inputBinding:
      position: 102
      prefix: --ignore-dist-for-solvent
  - id: ignore_seq_sep_for_solvent
    type:
      - 'null'
      - boolean
    doc: flag to ignore sequence separation for solvent contacts
    inputBinding:
      position: 102
      prefix: --ignore-seq-sep-for-solvent
  - id: inter_residue
    type:
      - 'null'
      - boolean
    doc: flag to convert input to inter-residue contacts
    inputBinding:
      position: 102
      prefix: --inter-residue
  - id: inter_residue_after
    type:
      - 'null'
      - boolean
    doc: flag to convert output to inter-residue contacts
    inputBinding:
      position: 102
      prefix: --inter-residue-after
  - id: inter_residue_hbplus_tags
    type:
      - 'null'
      - boolean
    doc: flag to set inter-residue H-bond tags
    inputBinding:
      position: 102
      prefix: --inter-residue-hbplus-tags
  - id: invert
    type:
      - 'null'
      - boolean
    doc: flag to invert selection
    inputBinding:
      position: 102
      prefix: --invert
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
  - id: match_external_first
    type:
      - 'null'
      - File
    doc: file path to input matchable annotations
    inputBinding:
      position: 102
      prefix: --match-external-first
  - id: match_external_pairs
    type:
      - 'null'
      - File
    doc: file path to input matchable annotation pairs
    inputBinding:
      position: 102
      prefix: --match-external-pairs
  - id: match_external_second
    type:
      - 'null'
      - File
    doc: file path to input matchable annotations
    inputBinding:
      position: 102
      prefix: --match-external-second
  - id: match_first
    type:
      - 'null'
      - string
    doc: selection for first contacting group
    inputBinding:
      position: 102
      prefix: --match-first
  - id: match_first_not
    type:
      - 'null'
      - string
    doc: negative selection for first contacting group
    inputBinding:
      position: 102
      prefix: --match-first-not
  - id: match_max_area
    type:
      - 'null'
      - string
    doc: maximum contact area
    inputBinding:
      position: 102
      prefix: --match-max-area
  - id: match_max_dist
    type:
      - 'null'
      - string
    doc: maximum distance
    inputBinding:
      position: 102
      prefix: --match-max-dist
  - id: match_max_seq_sep
    type:
      - 'null'
      - string
    doc: maximum residue sequence separation
    inputBinding:
      position: 102
      prefix: --match-max-seq-sep
  - id: match_min_area
    type:
      - 'null'
      - string
    doc: minimum contact area
    inputBinding:
      position: 102
      prefix: --match-min-area
  - id: match_min_dist
    type:
      - 'null'
      - string
    doc: minimum distance
    inputBinding:
      position: 102
      prefix: --match-min-dist
  - id: match_min_seq_sep
    type:
      - 'null'
      - string
    doc: minimum residue sequence separation
    inputBinding:
      position: 102
      prefix: --match-min-seq-sep
  - id: match_second
    type:
      - 'null'
      - string
    doc: selection for second contacting group
    inputBinding:
      position: 102
      prefix: --match-second
  - id: match_second_not
    type:
      - 'null'
      - string
    doc: negative selection for second contacting group
    inputBinding:
      position: 102
      prefix: --match-second-not
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
  - id: no_poly_bonds
    type:
      - 'null'
      - boolean
    doc: flag to not include peptide and nucleic polymerization bonds
    inputBinding:
      position: 102
      prefix: --no-poly-bonds
  - id: no_same_chain
    type:
      - 'null'
      - boolean
    doc: flag to not include same chain contacts
    inputBinding:
      position: 102
      prefix: --no-same-chain
  - id: no_solvent
    type:
      - 'null'
      - boolean
    doc: flag to not include solvent accessible areas
    inputBinding:
      position: 102
      prefix: --no-solvent
  - id: preserve_graphics
    type:
      - 'null'
      - boolean
    doc: flag to preserve graphics in output
    inputBinding:
      position: 102
      prefix: --preserve-graphics
  - id: renaming_map
    type:
      - 'null'
      - File
    doc: file path to input atoms renaming map
    inputBinding:
      position: 102
      prefix: --renaming-map
  - id: set_adjuncts
    type:
      - 'null'
      - string
    doc: set adjuncts instead of filtering
    inputBinding:
      position: 102
      prefix: --set-adjuncts
  - id: set_distance_bins_tags
    type:
      - 'null'
      - string
    doc: list of distance thresholds
    inputBinding:
      position: 102
      prefix: --set-distance-bins-tags
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
  - id: set_external_means
    type:
      - 'null'
      - File
    doc: file path to input external values for averaging
    inputBinding:
      position: 102
      prefix: --set-external-means
  - id: set_external_means_name
    type:
      - 'null'
      - string
    doc: name for external means
    inputBinding:
      position: 102
      prefix: --set-external-means-name
  - id: set_hbplus_tags
    type:
      - 'null'
      - File
    doc: file path to input HBPLUS file
    inputBinding:
      position: 102
      prefix: --set-hbplus-tags
  - id: set_tags
    type:
      - 'null'
      - string
    doc: set tags instead of filtering
    inputBinding:
      position: 102
      prefix: --set-tags
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: flag to output only summary of matched contacts
    inputBinding:
      position: 102
      prefix: --summarize
  - id: summarize_by_first
    type:
      - 'null'
      - boolean
    doc: flag to output only summary of matched contacts by first identifier
    inputBinding:
      position: 102
      prefix: --summarize-by-first
  - id: summing_exceptions
    type:
      - 'null'
      - File
    doc: file path to input inter-residue summing exceptions annotations
    inputBinding:
      position: 102
      prefix: --summing-exceptions
outputs:
  - id: output_contacts
    type: File
    doc: "list of contacts (line format: 'annotation1 annotation2 area distance tags
      adjuncts [graphics]')"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
