cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - score-contacts-quality
label: voronota_score-contacts-quality
doc: "Calculates quality scores from atom energy descriptors.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_descriptors
    type: File
    doc: "list of atom energy descriptors (stdin)"
  - id: default_mean
    type:
      - 'null'
      - float
    doc: "default mean parameter"
    inputBinding:
      position: 101
      prefix: --default-mean
  - id: default_sd
    type:
      - 'null'
      - float
    doc: "default standard deviation parameter"
    inputBinding:
      position: 101
      prefix: --default-sd
  - id: means_and_sds_file
    type:
      - 'null'
      - File
    doc: "file path to input atomic mean and sd parameters"
    inputBinding:
      position: 101
      prefix: --means-and-sds-file
  - id: mean_shift
    type:
      - 'null'
      - float
    doc: "mean shift in standard deviations"
    inputBinding:
      position: 101
      prefix: --mean-shift
  - id: external_weights_file
    type:
      - 'null'
      - File
    doc: "file path to input external weights for global scoring"
    inputBinding:
      position: 101
      prefix: --external-weights-file
  - id: smoothing_window
    type:
      - 'null'
      - int
    doc: "window to smooth residue quality scores along sequence"
    inputBinding:
      position: 101
      prefix: --smoothing-window
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_descriptors.path)
stdout: voronota_score-contacts-quality.out
