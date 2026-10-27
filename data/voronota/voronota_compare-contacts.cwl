cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - compare-contacts
label: voronota_compare-contacts
doc: "Compares model contacts with target contacts (CAD-score).

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_contacts
    type: File
    doc: "list of model contacts (stdin)"
  - id: target_contacts_file
    type: File
    doc: "file path to input target contacts"
    inputBinding:
      position: 101
      prefix: --target-contacts-file
  - id: inter_atom_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output inter-atom scores"
    inputBinding:
      position: 101
      prefix: --inter-atom-scores-file
  - id: inter_residue_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output inter-residue scores"
    inputBinding:
      position: 101
      prefix: --inter-residue-scores-file
  - id: atom_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output atom scores"
    inputBinding:
      position: 101
      prefix: --atom-scores-file
  - id: residue_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output residue scores"
    inputBinding:
      position: 101
      prefix: --residue-scores-file
  - id: depth
    type:
      - 'null'
      - int
    doc: "local neighborhood depth"
    inputBinding:
      position: 101
      prefix: --depth
  - id: smoothing_window
    type:
      - 'null'
      - int
    doc: "window to smooth residue scores along sequence"
    inputBinding:
      position: 101
      prefix: --smoothing-window
  - id: smoothed_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output smoothed residue scores"
    inputBinding:
      position: 101
      prefix: --smoothed-scores-file
  - id: ignore_residue_names
    type:
      - 'null'
      - boolean
    doc: "flag to consider just residue numbers and ignore residue names"
    inputBinding:
      position: 101
      prefix: --ignore-residue-names
  - id: residue_level_only
    type:
      - 'null'
      - boolean
    doc: "flag to output only residue-level results"
    inputBinding:
      position: 101
      prefix: --residue-level-only
  - id: detailed_output
    type:
      - 'null'
      - boolean
    doc: "flag to enable detailed output"
    inputBinding:
      position: 101
      prefix: --detailed-output
  - id: chains_renaming_file
    type:
      - 'null'
      - File
    doc: "file path to input chains renaming"
    inputBinding:
      position: 101
      prefix: --chains-renaming-file
  - id: remap_chains
    type:
      - 'null'
      - boolean
    doc: "flag to calculate optimal chains remapping"
    inputBinding:
      position: 101
      prefix: --remap-chains
  - id: remap_chains_log
    type:
      - 'null'
      - boolean
    doc: "flag output remapping progress to stderr"
    inputBinding:
      position: 101
      prefix: --remap-chains-log
  - id: remapped_chains_file_path
    type:
      - 'null'
      - string
    doc: "file path to output calculated chains remapping"
    inputBinding:
      position: 101
      prefix: --remapped-chains-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: inter_atom_scores_file
    type:
      - 'null'
      - File
    doc: "file path to output inter-atom scores"
    outputBinding:
      glob: $(inputs.inter_atom_scores_file_path)
  - id: inter_residue_scores_file
    type:
      - 'null'
      - File
    doc: "file path to output inter-residue scores"
    outputBinding:
      glob: $(inputs.inter_residue_scores_file_path)
  - id: atom_scores_file
    type:
      - 'null'
      - File
    doc: "file path to output atom scores"
    outputBinding:
      glob: $(inputs.atom_scores_file_path)
  - id: residue_scores_file
    type:
      - 'null'
      - File
    doc: "file path to output residue scores"
    outputBinding:
      glob: $(inputs.residue_scores_file_path)
  - id: smoothed_scores_file
    type:
      - 'null'
      - File
    doc: "file path to output smoothed residue scores"
    outputBinding:
      glob: $(inputs.smoothed_scores_file_path)
  - id: remapped_chains_file
    type:
      - 'null'
      - File
    doc: "file path to output calculated chains remapping"
    outputBinding:
      glob: $(inputs.remapped_chains_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_contacts.path)
stdout: voronota_compare-contacts.out
