cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrhistogram]
label: mrtrix3_mrhistogram
doc: |-
  Generate a histogram of image intensities

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: image
    type: File
    doc: the input image from which the histogram will be computed
    inputBinding:
      position: 1
  - id: hist
    type: string
    doc: the output histogram file
    inputBinding:
      position: 2
  - id: bins
    type: ['null', int]
    doc: Manually set the number of bins to use to generate the histogram.
    inputBinding:
      prefix: -bins
  - id: template
    type: ['null', File]
    doc: Use an existing histogram file as the template for histogram formation
    inputBinding:
      prefix: -template
  - id: mask
    type: ['null', File]
    doc: Calculate the histogram only within a mask image.
    inputBinding:
      prefix: -mask
  - id: ignorezero
    type: ['null', boolean]
    doc: ignore zero-valued data during histogram construction.
    inputBinding:
      prefix: -ignorezero
  - id: allvolumes
    type: ['null', boolean]
    doc: generate one histogram across all image volumes, rather than one per image volume
    inputBinding:
      prefix: -allvolumes
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
  - id: hist_out
    type: File
    doc: 'Output: the output histogram file'
    outputBinding:
      glob: $(inputs.hist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
