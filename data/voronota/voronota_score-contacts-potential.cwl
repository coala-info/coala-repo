cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_score-contacts-potential
label: voronota_score-contacts-potential
doc: "Calculates potential values for contacts based on various input files and outputs
  summary statistics.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: stdin_contacts
    type:
      - 'null'
      - File
    doc: "list of contacts (line format: 'annotation1 annotation2 conditions area')"
    inputBinding:
      position: 1
  - id: input_contributions
    type:
      - 'null'
      - File
    doc: file path to input contact types contributions
    inputBinding:
      position: 102
      prefix: --input-contributions
  - id: input_fixed_types
    type:
      - 'null'
      - File
    doc: file path to input fixed types
    inputBinding:
      position: 102
      prefix: --input-fixed-types
  - id: input_seq_pairs_stats
    type:
      - 'null'
      - File
    doc: file path to input sequence pairings statistics
    inputBinding:
      position: 102
      prefix: --input-seq-pairs-stats
  - id: multiply_areas
    type:
      - 'null'
      - float
    doc: coefficient to multiply output areas
    inputBinding:
      position: 102
      prefix: --multiply-areas
  - id: read_file_list_from_stdin
    type:
      - 'null'
      - boolean
    doc: flag to read file list from stdin
    inputBinding:
      position: 102
      prefix: --input-file-list
  - id: toggling_list
    type:
      - 'null'
      - string
    doc: list of toggling subtags
    inputBinding:
      position: 102
      prefix: --toggling-list
outputs:
  - id: potential_file
    type:
      - 'null'
      - File
    doc: file path to output potential values
    outputBinding:
      glob: $(inputs.potential_file)
  - id: probabilities_file
    type:
      - 'null'
      - File
    doc: file path to output observed and expected probabilities
    outputBinding:
      glob: $(inputs.probabilities_file)
  - id: single_areas_file
    type:
      - 'null'
      - File
    doc: file path to output single type total areas
    outputBinding:
      glob: $(inputs.single_areas_file)
  - id: contributions_file
    type:
      - 'null'
      - File
    doc: file path to output contact types contributions
    outputBinding:
      glob: $(inputs.contributions_file)
  - id: stdout_summaries
    type:
      - 'null'
      - File
    doc: "line of contact type area summaries (line format: 'annotation1 annotation2
      conditions area')"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
