cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - score-contacts-potential
label: voronota_score-contacts-potential
doc: "Calculates a knowledge-based potential from contacts.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_contacts
    type: File
    doc: "list of contacts with conditions (stdin)"
  - id: input_file_list
    type:
      - 'null'
      - boolean
    doc: "flag to read file list from stdin"
    inputBinding:
      position: 101
      prefix: --input-file-list
  - id: input_contributions
    type:
      - 'null'
      - File
    doc: "file path to input contact types contributions"
    inputBinding:
      position: 101
      prefix: --input-contributions
  - id: input_fixed_types
    type:
      - 'null'
      - File
    doc: "file path to input fixed types"
    inputBinding:
      position: 101
      prefix: --input-fixed-types
  - id: input_seq_pairs_stats
    type:
      - 'null'
      - File
    doc: "file path to input sequence pairings statistics"
    inputBinding:
      position: 101
      prefix: --input-seq-pairs-stats
  - id: potential_file_path
    type:
      - 'null'
      - string
    doc: "file path to output potential values"
    inputBinding:
      position: 101
      prefix: --potential-file
  - id: probabilities_file_path
    type:
      - 'null'
      - string
    doc: "file path to output observed and expected probabilities"
    inputBinding:
      position: 101
      prefix: --probabilities-file
  - id: single_areas_file_path
    type:
      - 'null'
      - string
    doc: "file path to output single type total areas"
    inputBinding:
      position: 101
      prefix: --single-areas-file
  - id: contributions_file_path
    type:
      - 'null'
      - string
    doc: "file path to output contact types contributions"
    inputBinding:
      position: 101
      prefix: --contributions-file
  - id: multiply_areas
    type:
      - 'null'
      - float
    doc: "coefficient to multiply output areas"
    inputBinding:
      position: 101
      prefix: --multiply-areas
  - id: toggling_list
    type:
      - 'null'
      - string
    doc: "list of toggling subtags"
    inputBinding:
      position: 101
      prefix: --toggling-list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: potential_file
    type:
      - 'null'
      - File
    doc: "file path to output potential values"
    outputBinding:
      glob: $(inputs.potential_file_path)
  - id: probabilities_file
    type:
      - 'null'
      - File
    doc: "file path to output observed and expected probabilities"
    outputBinding:
      glob: $(inputs.probabilities_file_path)
  - id: single_areas_file
    type:
      - 'null'
      - File
    doc: "file path to output single type total areas"
    outputBinding:
      glob: $(inputs.single_areas_file_path)
  - id: contributions_file
    type:
      - 'null'
      - File
    doc: "file path to output contact types contributions"
    outputBinding:
      glob: $(inputs.contributions_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_contacts.path)
stdout: voronota_score-contacts-potential.out
