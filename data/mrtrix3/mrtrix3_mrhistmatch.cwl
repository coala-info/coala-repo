cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrhistmatch]
label: mrtrix3_mrhistmatch
doc: |-
  Modify the intensities of one image to match the histogram of another

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: type
    type: string
    doc: 'type of histogram matching to perform; options are: scale,linear,nonlinear (choices: scale linear
      nonlinear)'
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: the input image to be modified
    inputBinding:
      position: 2
  - id: target
    type: File
    doc: the input image from which to derive the target histogram
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: the output image
    inputBinding:
      position: 4
  - id: mask_input
    type: ['null', File]
    doc: only generate input histogram based on a specified binary mask image
    inputBinding:
      prefix: -mask_input
  - id: mask_target
    type: ['null', File]
    doc: only generate target histogram based on a specified binary mask image
    inputBinding:
      prefix: -mask_target
  - id: bins
    type: ['null', int]
    doc: the number of bins to use to generate the histograms
    inputBinding:
      prefix: -bins
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status; alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: 'force overwrite of output files (caution: using the same file as input and output might cause
      unexpected behaviour).'
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: output_out
    type: File
    doc: 'Output: the output image'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
