cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, wshfl]
requirements:
  - class: InlineJavascriptRequirement
label: bart_wshfl
doc: "Perform a wave-shuffling reconstruction.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: maps
    type: File
    doc: Input maps file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: wave
    type: File
    doc: Input wave file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: phi
    type: File
    doc: Input phi file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: reorder
    type: File
    doc: Input reorder file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 13
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: table
    type: File
    doc: Input table file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 14
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 15
  - id: apply_real_valued_constraint
    type:
      - 'null'
      - boolean
    doc: Apply real valued constraint on coefficients.
    inputBinding:
      position: 1
      prefix: -v
  - id: block_dim
    type:
      - 'null'
      - int
    doc: Block size for locally low rank.
    inputBinding:
      position: 1
      prefix: -b
  - id: continuation_value
    type:
      - 'null'
      - float
    doc: Continuation value for IST/FISTA.
    inputBinding:
      position: 1
      prefix: -c
  - id: forward_coeffs_path
    type:
      - 'null'
      - File
    doc: Go from shfl-coeffs to data-table. Pass in coeffs path.
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -F
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: gpu_device_number
    type:
      - 'null'
      - int
    doc: GPU device number.
    inputBinding:
      position: 1
      prefix: -g
  - id: initial_guess_path
    type:
      - 'null'
      - File
    doc: Initialize reconstruction with guess.
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -O
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: max_eigenvalue
    type:
      - 'null'
      - float
    doc: Maximum eigenvalue of normal operator, if known.
    inputBinding:
      position: 1
      prefix: -e
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations.
    inputBinding:
      position: 1
      prefix: -i
  - id: soft_threshold_lambda
    type:
      - 'null'
      - float
    doc: Soft threshold lambda for wavelet or locally low rank.
    inputBinding:
      position: 1
      prefix: -r
  - id: step_size
    type:
      - 'null'
      - float
    doc: Step size for iterative method.
    inputBinding:
      position: 1
      prefix: -s
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Tolerance convergence condition for iterative method.
    inputBinding:
      position: 1
      prefix: -t
  - id: use_fista
    type:
      - 'null'
      - boolean
    doc: Reconstruct using FISTA instead of IST.
    inputBinding:
      position: 1
      prefix: -f
  - id: use_hogwild
    type:
      - 'null'
      - boolean
    doc: Use hogwild in IST/FISTA.
    inputBinding:
      position: 1
      prefix: -H
  - id: use_locally_low_rank
    type:
      - 'null'
      - boolean
    doc: Use locally low rank.
    inputBinding:
      position: 1
      prefix: -l
  - id: use_wavelet
    type:
      - 'null'
      - boolean
    doc: Use wavelet.
    inputBinding:
      position: 1
      prefix: -w
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
