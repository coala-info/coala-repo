cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - score-contacts-energy
label: voronota_score-contacts-energy
doc: "Calculates an energy-like score of contacts using a potential.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_contacts
    type: File
    doc: "list of contacts with conditions (stdin)"
  - id: potential_file
    type: File
    doc: "file path to input potential values"
    inputBinding:
      position: 101
      prefix: --potential-file
  - id: ignorable_max_seq_sep
    type:
      - 'null'
      - int
    doc: "maximum residue sequence separation for ignorable contacts"
    inputBinding:
      position: 101
      prefix: --ignorable-max-seq-sep
  - id: inter_atom_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output inter-atom scores"
    inputBinding:
      position: 101
      prefix: --inter-atom-scores-file
  - id: atom_scores_file_path
    type:
      - 'null'
      - string
    doc: "file path to output atom scores"
    inputBinding:
      position: 101
      prefix: --atom-scores-file
  - id: depth
    type:
      - 'null'
      - int
    doc: "neighborhood normalization depth"
    inputBinding:
      position: 101
      prefix: --depth
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
  - id: atom_scores_file
    type:
      - 'null'
      - File
    doc: "file path to output atom scores"
    outputBinding:
      glob: $(inputs.atom_scores_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_contacts.path)
stdout: voronota_score-contacts-energy.out
