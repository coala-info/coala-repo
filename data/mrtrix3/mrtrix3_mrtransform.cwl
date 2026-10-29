cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrtransform]
label: mrtrix3_mrtransform
doc: |-
  Apply spatial transformations to an image

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: mrtransform_fslgrad_rec
        type: record
        fields:
          - name: bvecs
            type: File
            doc: bvecs
            inputBinding:
              position: 1
          - name: bvals
            type: File
            doc: bvals
            inputBinding:
              position: 2
      - name: mrtransform_export_grad_fsl_rec
        type: record
        fields:
          - name: bvecs_path
            type: string
            doc: bvecs_path
            inputBinding:
              position: 1
          - name: bvals_path
            type: string
            doc: bvals_path
            inputBinding:
              position: 2
inputs:
  - id: input
    type: File
    doc: input image to be transformed.
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: the output image.
    inputBinding:
      position: 2
  - id: linear
    type: ['null', File]
    doc: specify a linear transform to apply, in the form of a 3x4 or 4x4 ascii file. Note the standard
      'reverse' convention is used, where the transform maps points in the template image to the moving
      image. Note that the reverse convention is still assumed even if no -template image is supplied
    inputBinding:
      prefix: -linear
  - id: flip
    type: ['null', string]
    doc: flip the specified axes, provided as a comma-separated list of indices (0:x, 1:y, 2:z).
    inputBinding:
      prefix: -flip
  - id: inverse
    type: ['null', boolean]
    doc: apply the inverse transformation
    inputBinding:
      prefix: -inverse
  - id: half
    type: ['null', boolean]
    doc: apply the matrix square root of the transformation. This can be combined with the inverse option.
    inputBinding:
      prefix: -half
  - id: replace
    type: ['null', File]
    doc: replace the linear transform of the original image by that specified, rather than applying it
      to the original image. The specified transform can be either a template image, or a 3x4 or 4x4 ascii
      file.
    inputBinding:
      prefix: -replace
  - id: identity
    type: ['null', boolean]
    doc: set the header transform of the image to the identity matrix
    inputBinding:
      prefix: -identity
  - id: template
    type: ['null', File]
    doc: reslice the input image to match the specified template image grid.
    inputBinding:
      prefix: -template
  - id: midway_space
    type: ['null', boolean]
    doc: reslice the input image to the midway space. Requires either the -template or -warp option. If
      used with -template and -linear option the input image will be resliced onto the grid halfway between
      the input and template. If used with the -warp option the input will be warped to the midway space
      defined by the grid of the input warp (i.e. half way between image1 and image2)
    inputBinding:
      prefix: -midway_space
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
  - id: warp
    type: ['null', File]
    doc: apply a non-linear 4D deformation field to warp the input image. Each voxel in the deformation
      field must define the scanner space position that will be used to interpolate the input image during
      warping (i.e. pull-back/reverse warp convention). If the -template image is also supplied the deformation
      field will be resliced first to the template image grid. If no -template option is supplied then
      the output image will have the same image grid as the deformation field. This option can be used
      in combination with the -affine option, in which case the affine will be applied first)
    inputBinding:
      prefix: -warp
  - id: warp_full
    type: ['null', File]
    doc: warp the input image using a 5D warp file output from mrregister. Any linear transforms in the
      warp image header will also be applied. The -warp_full option must be used in combination with either
      the -template option or the -midway_space option. If a -template image is supplied then the full
      warp will be used. By default the image1->image2 transform will be applied, however the -from 2
      option can be used to apply the image2->image1 transform. Use the -midway_space option to warp the
      input image to the midway space. The -from option can also be used to define which warp to use when
      transforming to midway space
    inputBinding:
      prefix: -warp_full
  - id: from
    type: ['null', int]
    doc: used to define which space the input image is when using the -warp_mid option. Use -from 1 to
      warp from image1 or -from 2 to warp from image2
    inputBinding:
      prefix: -from
  - id: modulate
    type: ['null', string]
    doc: 'Valid choices are: fod and jac. fod: modulate FODs during reorientation to preserve the apparent
      fibre density across fibre bundle widths before and after the transformation. jac: modulate the
      image intensity with the determinant of the Jacobian of the warp of linear transformation to preserve
      the total intensity before and after the transformation. (choices: fod jac)'
    inputBinding:
      prefix: -modulate
  - id: directions
    type: ['null', File]
    doc: 'directions defining the number and orientation of the apodised point spread functions used in
      FOD reorientation (Default: 300 directions)'
    inputBinding:
      prefix: -directions
  - id: reorient_fod
    type: ['null', string]
    doc: specify whether to perform FOD reorientation. This is required if the number of volumes in the
      4th dimension corresponds to the number of coefficients in an antipodally symmetric spherical harmonic
      series with lmax >= 2 (i.e. 6, 15, 28, 45, 66 volumes).
    inputBinding:
      prefix: -reorient_fod
  - id: grad
    type: ['null', File]
    doc: Provide the diffusion-weighted gradient scheme used in the acquisition in a text file. This should
      be supplied as a 4xN text file with each line is in the format [ X Y Z b ], where [ X Y Z ] describe
      the direction of the applied gradient, and b gives the b-value in units of s/mm^2. If a diffusion
      gradient scheme is present in the input image header, the data provided with this option will be
      instead used.
    inputBinding:
      prefix: -grad
  - id: fslgrad
    type: ['null', mrtransform_fslgrad_rec]
    doc: Provide the diffusion-weighted gradient scheme used in the acquisition in FSL bvecs/bvals format
      files. If a diffusion gradient scheme is present in the input image header, the data provided with
      this option will be instead used.
    inputBinding:
      prefix: -fslgrad
  - id: export_grad_mrtrix
    type: ['null', string]
    doc: export the diffusion-weighted gradient table to file in MRtrix format
    inputBinding:
      prefix: -export_grad_mrtrix
  - id: export_grad_fsl
    type: ['null', mrtransform_export_grad_fsl_rec]
    doc: export the diffusion-weighted gradient table to files in FSL (bvecs / bvals) format
    inputBinding:
      prefix: -export_grad_fsl
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
  - id: strides
    type: ['null', string]
    doc: specify the strides of the output data in memory; either as a comma-separated list of (signed)
      integers, or as a template image from which the strides shall be extracted and used. The actual
      strides produced will depend on whether the output image format can support it.
    inputBinding:
      prefix: -strides
  - id: nan
    type: ['null', boolean]
    doc: 'Use NaN as the out of bounds value (Default: 0.0)'
    inputBinding:
      prefix: -nan
  - id: no_reorientation
    type: ['null', boolean]
    doc: deprecated, use -reorient_fod instead
    inputBinding:
      prefix: -no_reorientation
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
  - id: export_grad_mrtrix_out
    type: ['null', File]
    doc: 'Output file for -export_grad_mrtrix: export the diffusion-weighted gradient table to file in
      MRtrix format'
    outputBinding:
      glob: $(inputs.export_grad_mrtrix)
  - id: export_grad_fsl_bvecs_path_out
    type: ['null', File]
    doc: 'Output bvecs_path of -export_grad_fsl: export the diffusion-weighted gradient table to files
      in FSL (bvecs / bvals) format'
    outputBinding:
      glob: '$(inputs.export_grad_fsl ? inputs.export_grad_fsl.bvecs_path : null)'
  - id: export_grad_fsl_bvals_path_out
    type: ['null', File]
    doc: 'Output bvals_path of -export_grad_fsl: export the diffusion-weighted gradient table to files
      in FSL (bvecs / bvals) format'
    outputBinding:
      glob: '$(inputs.export_grad_fsl ? inputs.export_grad_fsl.bvals_path : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
