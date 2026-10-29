cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_bin_stack
label: relion_relion_tomo_bin_stack
doc: "Bin a tilt-series image stack by real-space or Fourier cropping.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: input
    type: File
    doc: Tilt sequence image stack (e.g. *.st:mrc)
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type: string
    doc: Output stack filename
    inputBinding:
      position: 101
      prefix: --o
  - id: zero_dc
    type:
      - 'null'
      - boolean
    doc: Zero the DC component of each frame
    inputBinding:
      position: 101
      prefix: --0dc
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning (pixel spacing) (RELION default: 8.0)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: fourier_crop
    type:
      - 'null'
      - boolean
    doc: 'Use Fourier cropping to downsample (warning: can produce an inexact aspect ratio)'
    inputBinding:
      position: 101
      prefix: --F
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
outputs:
  - id: binned_stack
    type: File
    doc: Binned tilt series stack
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_bin_stack.out
