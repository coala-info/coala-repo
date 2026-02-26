cwlVersion: v1.2
class: CommandLineTool
baseCommand: wshfl
label: bart_wshfl
doc: "Perform a wave-shuffling reconstruction.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: maps
    type: File
    doc: Input maps file
    inputBinding:
      position: 1
  - id: wave
    type: File
    doc: Input wave file
    inputBinding:
      position: 2
  - id: phi
    type: File
    doc: Input phi file
    inputBinding:
      position: 3
  - id: reorder
    type: File
    doc: Input reorder file
    inputBinding:
      position: 4
  - id: table
    type: File
    doc: Input table file
    inputBinding:
      position: 5
  - id: apply_real_valued_constraint
    type:
      - 'null'
      - boolean
    doc: Apply real valued constraint on coefficients.
    inputBinding:
      position: 106
      prefix: -v
  - id: block_dim
    type:
      - 'null'
      - int
    doc: Block size for locally low rank.
    inputBinding:
      position: 106
      prefix: -b
  - id: continuation_value
    type:
      - 'null'
      - float
    doc: Continuation value for IST/FISTA.
    inputBinding:
      position: 106
      prefix: -c
  - id: forward_coeffs_path
    type:
      - 'null'
      - string
    doc: Go from shfl-coeffs to data-table. Pass in coeffs path.
    inputBinding:
      position: 106
      prefix: -F
  - id: gpu_device_number
    type:
      - 'null'
      - int
    doc: GPU device number.
    inputBinding:
      position: 106
      prefix: -g
  - id: initial_guess_path
    type:
      - 'null'
      - string
    doc: Initialize reconstruction with guess.
    inputBinding:
      position: 106
      prefix: -O
  - id: max_eigenvalue
    type:
      - 'null'
      - float
    doc: Maximum eigenvalue of normal operator, if known.
    inputBinding:
      position: 106
      prefix: -e
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations.
    inputBinding:
      position: 106
      prefix: -i
  - id: soft_threshold_lambda
    type:
      - 'null'
      - float
    doc: Soft threshold lambda for wavelet or locally low rank.
    inputBinding:
      position: 106
      prefix: -r
  - id: step_size
    type:
      - 'null'
      - float
    doc: Step size for iterative method.
    inputBinding:
      position: 106
      prefix: -s
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Tolerance convergence condition for iterative method.
    inputBinding:
      position: 106
      prefix: -t
  - id: use_fista
    type:
      - 'null'
      - boolean
    doc: Reconstruct using FISTA instead of IST.
    inputBinding:
      position: 106
      prefix: -f
  - id: use_hogwild
    type:
      - 'null'
      - boolean
    doc: Use hogwild in IST/FISTA.
    inputBinding:
      position: 106
      prefix: -H
  - id: use_locally_low_rank
    type:
      - 'null'
      - boolean
    doc: Use locally low rank.
    inputBinding:
      position: 106
      prefix: -l
  - id: use_wavelet
    type:
      - 'null'
      - boolean
    doc: Use wavelet.
    inputBinding:
      position: 106
      prefix: -w
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
