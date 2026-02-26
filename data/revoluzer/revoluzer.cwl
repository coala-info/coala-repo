cwlVersion: v1.2
class: CommandLineTool
baseCommand: revoluzer_sim
label: revoluzer
doc: "Simulates rearrangements on a genome.\n\nTool homepage: https://gitlab.com/Bernt/revoluzer/"
inputs:
  - id: input_file
    type: File
    doc: Input file specifying the genome and rearrangements.
    inputBinding:
      position: 1
  - id: circular_genomes
    type:
      - 'null'
      - boolean
    doc: Circular genomes.
    inputBinding:
      position: 102
      prefix: -C
  - id: intersection_mode
    type:
      - 'null'
      - boolean
    doc: Use intersection mode (default union).
    default: false
    inputBinding:
      position: 102
      prefix: -i
  - id: use_reversals_on_same_component
    type:
      - 'null'
      - boolean
    doc: Use reversals on the same unor. component (default false).
    default: false
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
stdout: revoluzer.out
