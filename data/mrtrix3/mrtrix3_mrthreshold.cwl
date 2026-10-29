cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrthreshold]
label: mrtrix3_mrthreshold
doc: |-
  Create bitwise image by thresholding image intensity

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image to be thresholded
    inputBinding:
      position: 1
  - id: output
    type: ['null', string]
    doc: the (optional) output binary image mask
    inputBinding:
      position: 2
  - id: abs
    type: ['null', float]
    doc: specify threshold value as absolute intensity
    inputBinding:
      prefix: -abs
  - id: percentile
    type: ['null', float]
    doc: determine threshold based on some percentile of the image intensity distribution
    inputBinding:
      prefix: -percentile
  - id: top
    type: ['null', int]
    doc: determine threshold that will result in selection of some number of top-valued voxels
    inputBinding:
      prefix: -top
  - id: bottom
    type: ['null', int]
    doc: 'determine & apply threshold resulting in selection of some number of bottom-valued voxels (note:
      implies threshold application operator of "le" unless otherwise specified)'
    inputBinding:
      prefix: -bottom
  - id: allvolumes
    type: ['null', boolean]
    doc: compute a single threshold for all image volumes, rather than an individual threshold per volume
    inputBinding:
      prefix: -allvolumes
  - id: ignorezero
    type: ['null', boolean]
    doc: ignore zero-valued input values during threshold determination
    inputBinding:
      prefix: -ignorezero
  - id: mask
    type: ['null', File]
    doc: compute the threshold based only on values within an input mask image
    inputBinding:
      prefix: -mask
  - id: comparison
    type: ['null', string]
    doc: 'comparison operator to use when applying the threshold; options are: lt,le,ge,gt (default =
      "le" for -bottom; "ge" otherwise) (choices: lt le ge gt)'
    inputBinding:
      prefix: -comparison
  - id: invert
    type: ['null', boolean]
    doc: invert the output binary mask (equivalent to flipping the operator; provided for backwards compatibility)
    inputBinding:
      prefix: -invert
  - id: out_masked
    type: ['null', boolean]
    doc: mask the output image based on the provided input mask image
    inputBinding:
      prefix: -out_masked
  - id: nan
    type: ['null', boolean]
    doc: set voxels that fail the threshold to NaN rather than zero (output image will be floating-point
      rather than binary)
    inputBinding:
      prefix: -nan
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
    type: ['null', File]
    doc: 'Output: the (optional) output binary image mask'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
