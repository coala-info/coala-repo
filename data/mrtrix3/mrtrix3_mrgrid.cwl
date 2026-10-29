cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrgrid]
label: mrtrix3_mrgrid
doc: |-
  Modify the grid of an image without interpolation (cropping or padding) or by regridding to an image grid with modified orientation, location and or resolution. The image content remains in place in real world coordinates.

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: mrgrid_axis_rec
        type: record
        fields:
          - name: index
            type: int
            doc: index
            inputBinding:
              position: 1
          - name: spec
            type: string
            doc: spec
            inputBinding:
              position: 2
inputs:
  - id: input
    type: File
    doc: input image to be regridded.
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: 'the operation to be performed, one of: regrid, crop, pad. (choices: regrid crop pad)'
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output image.
    inputBinding:
      position: 3
  - id: template
    type: ['null', File]
    doc: match the input image grid (voxel spacing, image size, header transformation) to that of a reference
      image. The image resolution relative to the template image can be changed with one of -size, -voxel,
      -scale.
    inputBinding:
      prefix: -template
  - id: size
    type: ['null', string]
    doc: define the size (number of voxels) in each spatial dimension for the output image. This should
      be specified as a comma-separated list.
    inputBinding:
      prefix: -size
  - id: voxel
    type: ['null', string]
    doc: define the new voxel size for the output image. This can be specified either as a single value
      to be used for all spatial dimensions, or as a comma-separated list of the size for each voxel dimension.
    inputBinding:
      prefix: -voxel
  - id: scale
    type: ['null', string]
    doc: scale the image resolution by the supplied factor. This can be specified either as a single value
      to be used for all dimensions, or as a comma-separated list of scale factors for each dimension.
    inputBinding:
      prefix: -scale
  - id: interp
    type: ['null', string]
    doc: 'set the interpolation method to use when reslicing (choices: nearest, linear, cubic, sinc. Default:
      cubic). (choices: nearest linear cubic sinc)'
    inputBinding:
      prefix: -interp
  - id: oversample
    type: ['null', string]
    doc: set the amount of over-sampling (in the target space) to perform when regridding. This is particularly
      relevant when downsamping a high-resolution image to a low-resolution image, to avoid aliasing artefacts.
      This can consist of a single integer, or a comma-separated list of 3 integers if different oversampling
      factors are desired along the different axes. Default is determined from ratio of voxel dimensions
      (disabled for nearest-neighbour interpolation).
    inputBinding:
      prefix: -oversample
  - id: as
    type: ['null', File]
    doc: pad or crop the input image on the upper bound to match the specified reference image grid. This
      operation ignores differences in image transformation between input and reference image.
    inputBinding:
      prefix: -as
  - id: uniform
    type: ['null', int]
    doc: pad or crop the input image by a uniform number of voxels on all sides
    inputBinding:
      prefix: -uniform
  - id: mask
    type: ['null', File]
    doc: crop the input image according to the spatial extent of a mask image. The mask must share a common
      voxel grid with the input image but differences in image transformations are ignored. Note that
      even though only 3 dimensions are cropped when using a mask, the bounds are computed by checking
      the extent for all dimensions. Note that by default a gap of 1 voxel is left at all edges of the
      image to allow valid trilinear interpolation. This gap can be modified with the -uniform option
      but by default it does not extend beyond the FOV unless -crop_unbound is used.
    inputBinding:
      prefix: -mask
  - id: crop_unbound
    type: ['null', boolean]
    doc: Allow padding beyond the original FOV when cropping.
    inputBinding:
      prefix: -crop_unbound
  - id: axis
    type:
      - 'null'
      - type: array
        items: mrgrid_axis_rec
        inputBinding:
          prefix: -axis
    doc: pad or crop the input image along the provided axis (defined by index). The specifier argument
      defines the number of voxels added or removed on the lower or upper end of the axis (-axis index
      delta_lower,delta_upper) or acts as a voxel selection range (-axis index start:stop). In both modes,
      values are relative to the input image (overriding all other extent-specifying options). Negative
      delta specifier values trigger the inverse operation (pad instead of crop and vice versa) and negative
      range specifier trigger padding. Note that the deprecated commands 'mrcrop' and 'mrpad' used range-based
      and delta-based -axis indices, respectively.
  - id: all_axes
    type: ['null', boolean]
    doc: Crop or pad all, not just spatial axes.
    inputBinding:
      prefix: -all_axes
  - id: fill
    type: ['null', float]
    doc: 'Use number as the out of bounds value. nan, inf and -inf are valid arguments. (Default: 0.0)'
    inputBinding:
      prefix: -fill
  - id: strides
    type: ['null', string]
    doc: specify the strides of the output data in memory; either as a comma-separated list of (signed)
      integers, or as a template image from which the strides shall be extracted and used. The actual
      strides produced will depend on whether the output image format can support it.
    inputBinding:
      prefix: -strides
  - id: datatype
    type: ['null', string]
    doc: 'specify output image data type. Valid choices are: float32, float32le, float32be, float64, float64le,
      float64be, int64, uint64, int64le, uint64le, int64be, uint64be, int32, uint32, int32le, uint32le,
      int32be, uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32, cfloat32le, cfloat32be,
      cfloat64, cfloat64le, cfloat64be, int8, uint8, bit. (choices: float32 float32le float32be float64
      float64le float64be int64 uint64 int64le uint64le int64be uint64be int32 uint32 int32le uint32le
      int32be uint32be int16 uint16 int16le uint16le int16be uint16be cfloat32 cfloat32le cfloat32be cfloat64
      cfloat64le cfloat64be int8 uint8 bit)'
    inputBinding:
      prefix: -datatype
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
