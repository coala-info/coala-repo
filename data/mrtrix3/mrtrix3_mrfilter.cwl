cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrfilter]
label: mrtrix3_mrfilter
doc: |-
  Perform filtering operations on 3D / 4D MR images

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image.
    inputBinding:
      position: 1
  - id: filter
    type: string
    doc: 'the type of filter to be applied (choices: fft gradient median smooth normalise zclean)'
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output image.
    inputBinding:
      position: 3
  - id: axes
    type: ['null', string]
    doc: the axes along which to apply the Fourier Transform. By default, the transform is applied along
      the three spatial axes. Provide as a comma-separate list of axis indices.
    inputBinding:
      prefix: -axes
  - id: inverse
    type: ['null', boolean]
    doc: apply the inverse FFT
    inputBinding:
      prefix: -inverse
  - id: magnitude
    type: ['null', boolean]
    doc: output a magnitude image rather than a complex-valued image
    inputBinding:
      prefix: -magnitude
  - id: centre_zero
    type: ['null', boolean]
    doc: re-arrange the FFT results so that the zero-frequency component appears in the centre of the
      image, rather than at the edges
    inputBinding:
      prefix: -centre_zero
  - id: stdev
    type: ['null', string]
    doc: the standard deviation of the Gaussian kernel used to smooth the input image (in mm). The image
      is smoothed to reduced large spurious gradients caused by noise. Use this option to override the
      default stdev of 1 voxel. This can be specified either as a single value to be used for all 3 axes,
      or as a comma-separated list of 3 values, one for each axis.
    inputBinding:
      prefix: -stdev
  - id: scanner
    type: ['null', boolean]
    doc: define the gradient with respect to the scanner coordinate frame of reference.
    inputBinding:
      prefix: -scanner
  - id: extent
    type: ['null', string]
    doc: 'specify extent of median filtering neighbourhood in voxels. This can be specified either as
      a single value to be used for all 3 axes, or as a comma-separated list of 3 values, one for each
      axis (default: 3x3x3).'
    inputBinding:
      prefix: -extent
  - id: fwhm
    type: ['null', string]
    doc: apply Gaussian smoothing with the specified full-width half maximum. The FWHM is defined in mm
      (Default 1 voxel * 2.3548). This can be specified either as a single value to be used for all axes,
      or as a comma-separated list of the FWHM for each axis.
    inputBinding:
      prefix: -fwhm
  - id: zupper
    type: ['null', float]
    doc: 'define high intensity outliers: default: 2.5'
    inputBinding:
      prefix: -zupper
  - id: zlower
    type: ['null', float]
    doc: 'define low intensity outliers: default: 2.5'
    inputBinding:
      prefix: -zlower
  - id: bridge
    type: ['null', int]
    doc: 'number of voxels to gap to fill holes in mask: default: 4'
    inputBinding:
      prefix: -bridge
  - id: maskin
    type: ['null', File]
    doc: initial mask that defines the maximum spatial extent and the region from which to smaple the
      intensity range.
    inputBinding:
      prefix: -maskin
  - id: maskout
    type: ['null', string]
    doc: Output a refined mask based on a spatially coherent region with normal intensity range.
    inputBinding:
      prefix: -maskout
  - id: strides
    type: ['null', string]
    doc: specify the strides of the output data in memory; either as a comma-separated list of (signed)
      integers, or as a template image from which the strides shall be extracted and used. The actual
      strides produced will depend on whether the output image format can support it.
    inputBinding:
      prefix: -strides
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
    doc: 'Output: the output image.'
    outputBinding:
      glob: $(inputs.output)
  - id: maskout_out
    type: ['null', File]
    doc: 'Output file for -maskout: Output a refined mask based on a spatially coherent region with normal
      intensity range.'
    outputBinding:
      glob: $(inputs.maskout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
