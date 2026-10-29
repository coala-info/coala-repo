cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_dark_erase
label: relion_relion_tomo_dark_erase
doc: "Erase dark regions (for example the edge of the field of view) of a tilt-series stack by filling\
  \ them with noise.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: tilt_series
    type: File
    doc: Tilt sequence image stack (e.g. *.st:mrc)
    inputBinding:
      position: 101
      prefix: --ts
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Threshold value (in sigma) (RELION default: -2.5)'
    inputBinding:
      position: 101
      prefix: --th
  - id: fill_radius
    type:
      - 'null'
      - float
    doc: 'Fill radius (in pixels) (RELION default: 32.0)'
    inputBinding:
      position: 101
      prefix: --r
  - id: visualise
    type:
      - 'null'
      - boolean
    doc: Only write out a normalized stack to assist in finding an optimal threshold value
    inputBinding:
      position: 101
      prefix: --vis
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic data
    inputBinding:
      position: 101
      prefix: --diag
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
outputs:
  - id: output_stack
    type: File
    doc: Stack with the dark regions filled
    outputBinding:
      glob: $(inputs.output)
  - id: diagnostics
    type:
      type: array
      items: File
    doc: Diagnostic output (with --diag)
    outputBinding:
      glob:
        - '*_diag*'
        - diag*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_dark_erase.out
