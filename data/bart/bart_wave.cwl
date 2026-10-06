cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, wave]
requirements:
  - class: InlineJavascriptRequirement
label: bart_wave
doc: "Perform a wave-caipi reconstruction.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: maps
    type: File
    doc: Input maps file with dimensions (sx, sy, sz, nc, md)
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: wave
    type: File
    doc: Input wave file with dimensions (wx, sy, sz, 1, 1)
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: kspace
    type: File
    doc: Input k-space file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
  - id: continuation_value
    type:
      - 'null'
      - float
    doc: Continuation value for IST/FISTA.
    inputBinding:
      position: 1
      prefix: -c
  - id: gpu_device_number
    type:
      - 'null'
      - int
    doc: GPU device number.
    inputBinding:
      position: 1
      prefix: -g
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
  - id: real_valued_constraint
    type:
      - 'null'
      - boolean
    doc: Apply real valued constraint on coefficients.
    inputBinding:
      position: 1
      prefix: -v
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
    doc: Output file with dimensions (sx, sy, sz, 1, md)
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
