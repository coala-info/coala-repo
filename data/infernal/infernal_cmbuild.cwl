cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmbuild
label: infernal_cmbuild
doc: "Build covariance models from annotated RNA multiple sequence alignments\n\n
  Tool homepage: http://eddylab.org/infernal"
inputs:
  - id: msafile
    type: File
    doc: Input multiple sequence alignment file
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to the output file instead of overwriting
    inputBinding:
      position: 102
      prefix: -A
  - id: effective_sequences
    type:
      - 'null'
      - boolean
    doc: Set effective sequence number to the actual number of sequences
    inputBinding:
      position: 102
      prefix: --enone
  - id: force
    type:
      - 'null'
      - boolean
    doc: Allow overwriting of the output file
    inputBinding:
      position: 102
      prefix: -F
  - id: hand_model
    type:
      - 'null'
      - boolean
    doc: Manually specify model architecture using RF annotation
    inputBinding:
      position: 102
      prefix: --hand
  - id: name
    type:
      - 'null'
      - string
    doc: Name the CM <s>
    inputBinding:
      position: 102
      prefix: -n
  - id: no_secondary_structure
    type:
      - 'null'
      - boolean
    doc: Ignore secondary structure annotation and build a profile HMM
    inputBinding:
      position: 102
      prefix: --noss
outputs:
  - id: cmfile_out
    type: File
    doc: Output covariance model file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
