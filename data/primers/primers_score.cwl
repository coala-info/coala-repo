cwlVersion: v1.2
class: CommandLineTool
baseCommand: primers score
label: primers_score
doc: "Score primers based on amplification and off-target binding.\n\nTool homepage:
  https://github.com/Lattice-Automation/primers"
inputs:
  - id: primer_sequences
    type:
      type: array
      items: string
    doc: primer sequences
    inputBinding:
      position: 1
  - id: amplified_sequence
    type:
      - 'null'
      - string
    doc: the sequence that was amplified
    inputBinding:
      position: 102
      prefix: -s
  - id: no_json
    type:
      - 'null'
      - boolean
    doc: do not write the primers to a JSON array
    inputBinding:
      position: 102
      prefix: --no-json
  - id: off_target_sequence
    type:
      - 'null'
      - string
    doc: sequence to check for off-target binding sites
    inputBinding:
      position: 102
      prefix: -t
  - id: write_json
    type:
      - 'null'
      - boolean
    doc: write the primers to a JSON array
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primers:0.5.10--pyhdfd78af_0
stdout: primers_score.out
