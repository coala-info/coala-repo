cwlVersion: v1.2
class: CommandLineTool
baseCommand: [maskfilter]
label: mrtrix3_maskfilter
doc: |-
  Perform filtering operations on 3D / 4D mask images

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image.
    inputBinding:
      position: 1
  - id: filter
    type: string
    doc: 'the type of filter to be applied (clean, connect, dilate, erode, median) (choices: clean connect
      dilate erode median)'
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output image.
    inputBinding:
      position: 3
  - id: scale
    type: ['null', int]
    doc: 'the maximum scale used to cut bridges. A certain maximum scale cuts bridges up to a width (in
      voxels) of 2x the provided scale. (Default: 2)'
    inputBinding:
      prefix: -scale
  - id: axes
    type: ['null', string]
    doc: specify which axes should be included in the connected components. By default only the first
      3 axes are included. The axes should be provided as a comma-separated list of values.
    inputBinding:
      prefix: -axes
  - id: largest
    type: ['null', boolean]
    doc: only retain the largest connected component
    inputBinding:
      prefix: -largest
  - id: connectivity
    type: ['null', boolean]
    doc: 'use 26-voxel-neighbourhood connectivity (Default: 6)'
    inputBinding:
      prefix: -connectivity
  - id: npass
    type: ['null', int]
    doc: the number of times to repeatedly apply the filter
    inputBinding:
      prefix: -npass
  - id: extent
    type: ['null', string]
    doc: specify the extent (width) of kernel size in voxels. This can be specified either as a single
      value to be used for all axes, or as a comma-separated list of the extent for each axis. The default
      is 3x3x3.
    inputBinding:
      prefix: -extent
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
