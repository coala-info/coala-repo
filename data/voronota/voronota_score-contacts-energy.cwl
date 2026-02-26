cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_score-contacts-energy
label: voronota_score-contacts-energy
doc: "Calculates contact energies based on Voronota analysis.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_contacts
    type: File
    doc: "list of contacts (line format: 'annotation1 annotation2 conditions area')"
    inputBinding:
      position: 1
  - id: depth
    type:
      - 'null'
      - int
    doc: neighborhood normalization depth
    inputBinding:
      position: 102
      prefix: --depth
  - id: ignorable_max_seq_sep
    type:
      - 'null'
      - int
    doc: maximum residue sequence separation for ignorable contacts
    inputBinding:
      position: 102
      prefix: --ignorable-max-seq-sep
  - id: potential_file
    type: File
    doc: file path to input potential values
    inputBinding:
      position: 102
      prefix: --potential-file
outputs:
  - id: inter_atom_scores_file
    type:
      - 'null'
      - File
    doc: file path to output inter-atom scores
    outputBinding:
      glob: $(inputs.inter_atom_scores_file)
  - id: atom_scores_file
    type:
      - 'null'
      - File
    doc: file path to output atom scores
    outputBinding:
      glob: $(inputs.atom_scores_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
