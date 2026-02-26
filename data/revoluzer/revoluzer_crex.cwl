cwlVersion: v1.2
class: CommandLineTool
baseCommand: crex
label: revoluzer_crex
doc: "Process gene orders in a file or process random rearrangement scenario and compare
  with reconstruction.\n\nTool homepage: https://gitlab.com/Bernt/revoluzer/"
inputs:
  - id: filename
    type: File
    doc: Specify a filename
    inputBinding:
      position: 1
  - id: affect
    type:
      - 'null'
      - int
    doc: max number of elements affected by a rearrangement
    inputBinding:
      position: 102
      prefix: --affect
  - id: complete_gene_order
    type:
      - 'null'
      - boolean
    doc: TDRLs affect complete gene order
    inputBinding:
      position: 102
      prefix: --comp
  - id: compute_breakpoint_scenario
    type:
      - 'null'
      - boolean
    doc: compute with breakpoint scenario [ZhaoBourque07]
    default: false
    inputBinding:
      position: 102
      prefix: --bp
  - id: compute_crex1
    type:
      - 'null'
      - boolean
    doc: compute with CREx1
    default: false
    inputBinding:
      position: 102
      prefix: --crex1
  - id: events
    type:
      - 'null'
      - int
    doc: number of random events to apply
    inputBinding:
      position: 102
      prefix: --events
  - id: file
    type:
      - 'null'
      - boolean
    doc: specify a filename
    inputBinding:
      position: 102
      prefix: --file
  - id: length
    type:
      - 'null'
      - int
    doc: length of the generated gene orders
    inputBinding:
      position: 102
      prefix: --length
  - id: linear
    type:
      - 'null'
      - boolean
    doc: handle genomes as linear
    default: false
    inputBinding:
      position: 102
      prefix: --linear
  - id: no_alternatives_linear_nodes
    type:
      - 'null'
      - boolean
    doc: don't compute alternatives for linear nodes
    inputBinding:
      position: 102
      prefix: --noalt
  - id: print_no_breakpoint_scenario_prime_nodes
    type:
      - 'null'
      - boolean
    doc: don't construct breakpoint scenario for prime nodes
    inputBinding:
      position: 102
      prefix: --prinobp
  - id: repeat
    type:
      - 'null'
      - int
    doc: number of repetitions
    inputBinding:
      position: 102
      prefix: --repeat
  - id: weight_inverse_transposition
    type:
      - 'null'
      - float
    doc: weight of an inverse transposition
    inputBinding:
      position: 102
      prefix: --wiT
  - id: weight_inversion
    type:
      - 'null'
      - float
    doc: weight of an inversion
    inputBinding:
      position: 102
      prefix: --wI
  - id: weight_tdrl
    type:
      - 'null'
      - float
    doc: weight of a TDRL
    inputBinding:
      position: 102
      prefix: --wTDRL
  - id: weight_transposition
    type:
      - 'null'
      - float
    doc: weight of a transposition
    inputBinding:
      position: 102
      prefix: --wT
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
stdout: revoluzer_crex.out
