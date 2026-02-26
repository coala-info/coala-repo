cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_compare-contacts
label: voronota_compare-contacts
doc: "Compares contacts from two Voronota models.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_contacts
    type:
      type: array
      items: File
    doc: "list of model contacts (line format: 'annotation1 annotation2 area')"
    inputBinding:
      position: 1
  - id: chains_renaming_file
    type:
      - 'null'
      - File
    doc: file path to input chains renaming
    inputBinding:
      position: 102
      prefix: --chains-renaming-file
  - id: depth
    type:
      - 'null'
      - int
    doc: local neighborhood depth
    inputBinding:
      position: 102
      prefix: --depth
  - id: detailed_output
    type:
      - 'null'
      - boolean
    doc: flag to enable detailed output
    inputBinding:
      position: 102
      prefix: --detailed-output
  - id: ignore_residue_names
    type:
      - 'null'
      - boolean
    doc: flag to consider just residue numbers and ignore residue names
    inputBinding:
      position: 102
      prefix: --ignore-residue-names
  - id: remap_chains
    type:
      - 'null'
      - boolean
    doc: flag to calculate optimal chains remapping
    inputBinding:
      position: 102
      prefix: --remap-chains
  - id: remap_chains_log
    type:
      - 'null'
      - boolean
    doc: flag output remapping progress to stderr
    inputBinding:
      position: 102
      prefix: --remap-chains-log
  - id: residue_level_only
    type:
      - 'null'
      - boolean
    doc: flag to output only residue-level results
    inputBinding:
      position: 102
      prefix: --residue-level-only
  - id: smoothing_window
    type:
      - 'null'
      - int
    doc: window to smooth residue scores along sequence
    inputBinding:
      position: 102
      prefix: --smoothing-window
  - id: target_contacts_file
    type: File
    doc: file path to input target contacts
    inputBinding:
      position: 102
      prefix: --target-contacts-file
outputs:
  - id: inter_atom_scores_file
    type:
      - 'null'
      - File
    doc: file path to output inter-atom scores
    outputBinding:
      glob: $(inputs.inter_atom_scores_file)
  - id: inter_residue_scores_file
    type:
      - 'null'
      - File
    doc: file path to output inter-residue scores
    outputBinding:
      glob: $(inputs.inter_residue_scores_file)
  - id: atom_scores_file
    type:
      - 'null'
      - File
    doc: file path to output atom scores
    outputBinding:
      glob: $(inputs.atom_scores_file)
  - id: residue_scores_file
    type:
      - 'null'
      - File
    doc: file path to output residue scores
    outputBinding:
      glob: $(inputs.residue_scores_file)
  - id: smoothed_scores_file
    type:
      - 'null'
      - File
    doc: file path to output smoothed residue scores
    outputBinding:
      glob: $(inputs.smoothed_scores_file)
  - id: remapped_chains_file
    type:
      - 'null'
      - File
    doc: file path to output calculated chains remapping
    outputBinding:
      glob: $(inputs.remapped_chains_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
