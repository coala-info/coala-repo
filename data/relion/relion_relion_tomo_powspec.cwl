cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_powspec
label: relion_relion_tomo_powspec
doc: "Compute the power spectrum of tilt-series stacks (optionally per frame, or as a ratio to a frame).\n\
  \nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: tilt_series
    type:
      type: array
      items: File
    doc: Tilt stack(s) (e.g. 'a.mrc,b.mrc')
    inputBinding:
      position: 101
      prefix: --ts
      itemSeparator: ','
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: separate_frames
    type:
      - 'null'
      - boolean
    doc: Compute separate spectra for all frames
    inputBinding:
      position: 101
      prefix: --sep
  - id: resolution
    type:
      - 'null'
      - float
    doc: 'Resolution (in pixels) (RELION default: 512)'
    inputBinding:
      position: 101
      prefix: --r
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in Å (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: ratio_frame
    type:
      - 'null'
      - float
    doc: 'Compute the ratio against this frame (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --ratio
outputs:
  - id: power_spectrum
    type: File
    doc: Power spectrum table
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_powspec.out
