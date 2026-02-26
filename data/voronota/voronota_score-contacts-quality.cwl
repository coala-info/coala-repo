cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_score-contacts-quality
label: voronota_score-contacts-quality
doc: "Calculates weighted average local score based on atom energy descriptors.\n\n\
  Tool homepage: https://www.voronota.com/"
inputs:
  - id: input_descriptors
    type:
      - 'null'
      - type: array
        items: File
    doc: list of atom energy descriptors
    inputBinding:
      position: 1
  - id: default_mean
    type:
      - 'null'
      - float
    doc: default mean parameter
    inputBinding:
      position: 102
      prefix: --default-mean
  - id: default_sd
    type:
      - 'null'
      - float
    doc: default standard deviation parameter
    inputBinding:
      position: 102
      prefix: --default-sd
  - id: external_weights_file
    type:
      - 'null'
      - File
    doc: file path to input external weights for global scoring
    inputBinding:
      position: 102
      prefix: --external-weights-file
  - id: mean_shift
    type:
      - 'null'
      - float
    doc: mean shift in standard deviations
    inputBinding:
      position: 102
      prefix: --mean-shift
  - id: means_and_sds_file
    type:
      - 'null'
      - File
    doc: file path to input atomic mean and sd parameters
    inputBinding:
      position: 102
      prefix: --means-and-sds-file
  - id: smoothing_window
    type:
      - 'null'
      - int
    doc: window to smooth residue quality scores along sequence
    inputBinding:
      position: 102
      prefix: --smoothing-window
outputs:
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
