cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrregister]
label: mrtrix3_mrregister
doc: |-
  Register two images together using a symmetric rigid, affine or non-linear transformation model

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: mrregister_transformed_midway_rec
        type: record
        fields:
          - name: image1_transformed
            type: string
            doc: image1_transformed
            inputBinding:
              position: 1
          - name: image2_transformed
            type: string
            doc: image2_transformed
            inputBinding:
              position: 2
      - name: mrregister_nl_warp_rec
        type: record
        fields:
          - name: warp1
            type: string
            doc: warp1
            inputBinding:
              position: 1
          - name: warp2
            type: string
            doc: warp2
            inputBinding:
              position: 2
inputs:
  - id: images
    type:
      type: array
      items: File
    doc: input image 1 ('moving') and input image 2 ('template'), optionally followed by pairs of additional
      contrasts (contrast1 contrast2 ...).
    inputBinding:
      position: 1
  - id: type
    type: ['null', string]
    doc: 'the registration type. Valid choices are: rigid, affine, nonlinear, rigid_affine, rigid_nonlinear,
      affine_nonlinear, rigid_affine_nonlinear (Default: affine_nonlinear) (choices: rigid affine nonlinear
      rigid_affine rigid_nonlinear affine_nonlinear rigid_affine_nonlinear)'
    inputBinding:
      prefix: -type
  - id: transformed
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -transformed
    doc: image1 after registration transformed and regridded to the space of image2. Note that -transformed
      needs to be repeated for each contrast if multi-contrast registration is used.
  - id: transformed_midway
    type:
      - 'null'
      - type: array
        items: mrregister_transformed_midway_rec
        inputBinding:
          prefix: -transformed_midway
    doc: image1 and image2 after registration transformed and regridded to the midway space. Note that
      -transformed_midway needs to be repeated for each contrast if multi-contrast registration is used.
  - id: mask1
    type: ['null', File]
    doc: a mask to define the region of image1 to use for optimisation.
    inputBinding:
      prefix: -mask1
  - id: mask2
    type: ['null', File]
    doc: a mask to define the region of image2 to use for optimisation.
    inputBinding:
      prefix: -mask2
  - id: nan
    type: ['null', boolean]
    doc: 'use NaN as out of bounds value. (Default: 0.0)'
    inputBinding:
      prefix: -nan
  - id: rigid
    type: ['null', string]
    doc: the output text file containing the rigid transformation as a 4x4 matrix
    inputBinding:
      prefix: -rigid
  - id: rigid_1tomidway
    type: ['null', string]
    doc: the output text file containing the rigid transformation that aligns image1 to image2 in their
      common midway space as a 4x4 matrix
    inputBinding:
      prefix: -rigid_1tomidway
  - id: rigid_2tomidway
    type: ['null', string]
    doc: the output text file containing the rigid transformation that aligns image2 to image1 in their
      common midway space as a 4x4 matrix
    inputBinding:
      prefix: -rigid_2tomidway
  - id: rigid_init_translation
    type: ['null', string]
    doc: 'initialise the translation and centre of rotation Valid choices are: mass (aligns the centers
      of mass of both images, default), geometric (aligns geometric image centres) and none. (choices:
      mass geometric none)'
    inputBinding:
      prefix: -rigid_init_translation
  - id: rigid_init_rotation
    type: ['null', string]
    doc: 'initialise the rotation Valid choices are: search (search for the best rotation using mean squared
      residuals), moments (rotation based on directions of intensity variance with respect to centre of
      mass), none (default). (choices: search moments none)'
    inputBinding:
      prefix: -rigid_init_rotation
  - id: rigid_init_matrix
    type: ['null', File]
    doc: initialise either the rigid, affine, or syn registration with the supplied rigid transformation
      (as a 4x4 matrix in scanner coordinates). Note that this overrides rigid_init_translation and rigid_init_rotation
      initialisation
    inputBinding:
      prefix: -rigid_init_matrix
  - id: rigid_scale
    type: ['null', string]
    doc: 'use a multi-resolution scheme by defining a scale factor for each level using comma separated
      values (Default: 0.25,0.5,1.0)'
    inputBinding:
      prefix: -rigid_scale
  - id: rigid_niter
    type: ['null', string]
    doc: 'the maximum number of gradient descent iterations per stage. This can be specified either as
      a single number for all multi-resolution levels, or a single value for each level. (Default: 1000)'
    inputBinding:
      prefix: -rigid_niter
  - id: rigid_metric
    type: ['null', string]
    doc: 'valid choices are: diff (intensity differences), Default: diff (choices: diff ncc)'
    inputBinding:
      prefix: -rigid_metric
  - id: rigid_metric_diff_estimator
    type: ['null', string]
    doc: 'Valid choices are: l1 (least absolute: |x|), l2 (ordinary least squares), lp (least powers:
      |x|^1.2), Default: l2 (choices: l1 l2 lp)'
    inputBinding:
      prefix: -rigid_metric.diff.estimator
  - id: rigid_lmax
    type: ['null', string]
    doc: explicitly set the lmax to be used per scale factor in rigid FOD registration. By default FOD
      registration will use lmax 0,2,4 with default scale factors 0.25,0.5,1.0 respectively. Note that
      no reorientation will be performed with lmax = 0.
    inputBinding:
      prefix: -rigid_lmax
  - id: rigid_log
    type: ['null', string]
    doc: write gradient descent parameter evolution to log file
    inputBinding:
      prefix: -rigid_log
  - id: affine
    type: ['null', string]
    doc: the output text file containing the affine transformation as a 4x4 matrix
    inputBinding:
      prefix: -affine
  - id: affine_1tomidway
    type: ['null', string]
    doc: the output text file containing the affine transformation that aligns image1 to image2 in their
      common midway space as a 4x4 matrix
    inputBinding:
      prefix: -affine_1tomidway
  - id: affine_2tomidway
    type: ['null', string]
    doc: the output text file containing the affine transformation that aligns image2 to image1 in their
      common midway space as a 4x4 matrix
    inputBinding:
      prefix: -affine_2tomidway
  - id: affine_init_translation
    type: ['null', string]
    doc: 'initialise the translation and centre of rotation Valid choices are: mass (aligns the centers
      of mass of both images), geometric (aligns geometric image centres) and none. (Default: mass) (choices:
      mass geometric none)'
    inputBinding:
      prefix: -affine_init_translation
  - id: affine_init_rotation
    type: ['null', string]
    doc: 'initialise the rotation Valid choices are: search (search for the best rotation using mean squared
      residuals), moments (rotation based on directions of intensity variance with respect to centre of
      mass), none (Default: none). (choices: search moments none)'
    inputBinding:
      prefix: -affine_init_rotation
  - id: affine_init_matrix
    type: ['null', File]
    doc: initialise either the affine, or syn registration with the supplied affine transformation (as
      a 4x4 matrix in scanner coordinates). Note that this overrides affine_init_translation and affine_init_rotation
      initialisation
    inputBinding:
      prefix: -affine_init_matrix
  - id: affine_scale
    type: ['null', string]
    doc: 'use a multi-resolution scheme by defining a scale factor for each level using comma separated
      values (Default: 0.25,0.5,1.0)'
    inputBinding:
      prefix: -affine_scale
  - id: affine_niter
    type: ['null', string]
    doc: 'the maximum number of gradient descent iterations per stage. This can be specified either as
      a single number for all multi-resolution levels, or a single value for each level. (Default: 1000)'
    inputBinding:
      prefix: -affine_niter
  - id: affine_metric
    type: ['null', string]
    doc: 'valid choices are: diff (intensity differences), Default: diff (choices: diff ncc)'
    inputBinding:
      prefix: -affine_metric
  - id: affine_metric_diff_estimator
    type: ['null', string]
    doc: 'Valid choices are: l1 (least absolute: |x|), l2 (ordinary least squares), lp (least powers:
      |x|^1.2), Default: l2 (choices: l1 l2 lp)'
    inputBinding:
      prefix: -affine_metric.diff.estimator
  - id: affine_lmax
    type: ['null', string]
    doc: explicitly set the lmax to be used per scale factor in affine FOD registration. By default FOD
      registration will use lmax 0,2,4 with default scale factors 0.25,0.5,1.0 respectively. Note that
      no reorientation will be performed with lmax = 0.
    inputBinding:
      prefix: -affine_lmax
  - id: affine_log
    type: ['null', string]
    doc: write gradient descent parameter evolution to log file
    inputBinding:
      prefix: -affine_log
  - id: init_translation_unmasked1
    type: ['null', boolean]
    doc: disregard mask1 for the translation initialisation (affects 'mass')
    inputBinding:
      prefix: -init_translation.unmasked1
  - id: init_translation_unmasked2
    type: ['null', boolean]
    doc: disregard mask2 for the translation initialisation (affects 'mass')
    inputBinding:
      prefix: -init_translation.unmasked2
  - id: init_rotation_unmasked1
    type: ['null', boolean]
    doc: disregard mask1 for the rotation initialisation (affects 'search' and 'moments')
    inputBinding:
      prefix: -init_rotation.unmasked1
  - id: init_rotation_unmasked2
    type: ['null', boolean]
    doc: disregard mask2 for the rotation initialisation (affects 'search' and 'moments')
    inputBinding:
      prefix: -init_rotation.unmasked2
  - id: init_rotation_search_angles
    type: ['null', string]
    doc: 'rotation angles for the local search in degrees between 0 and 180. (Default: 2,5,10,15,20)'
    inputBinding:
      prefix: -init_rotation.search.angles
  - id: init_rotation_search_scale
    type: ['null', float]
    doc: 'relative size of the images used for the rotation search. (Default: 0.15)'
    inputBinding:
      prefix: -init_rotation.search.scale
  - id: init_rotation_search_directions
    type: ['null', int]
    doc: 'number of rotation axis for local search. (Default: 250)'
    inputBinding:
      prefix: -init_rotation.search.directions
  - id: init_rotation_search_run_global
    type: ['null', boolean]
    doc: 'perform a global search. (Default: local)'
    inputBinding:
      prefix: -init_rotation.search.run_global
  - id: init_rotation_search_global_iterations
    type: ['null', int]
    doc: 'number of rotations to investigate (Default: 10000)'
    inputBinding:
      prefix: -init_rotation.search.global.iterations
  - id: linstage_iterations
    type: ['null', string]
    doc: 'number of iterations for each registration stage, not to be confused with -rigid_niter or -affine_niter.
      This can be used to generate intermediate diagnostics images (-linstage.diagnostics.prefix) or to
      change the cost function optimiser during registration (without the need to repeatedly resize the
      images). (Default: 1 == no repetition)'
    inputBinding:
      prefix: -linstage.iterations
  - id: linstage_optimiser_first
    type: ['null', string]
    doc: 'Cost function optimisation algorithm to use at first iteration of all stages. Valid choices:
      bbgd (Barzilai-Borwein gradient descent) or gd (simple gradient descent). (Default: bbgd) (choices:
      bbgd gd)'
    inputBinding:
      prefix: -linstage.optimiser.first
  - id: linstage_optimiser_last
    type: ['null', string]
    doc: 'Cost function optimisation algorithm to use at last iteration of all stages (if there are more
      than one). Valid choices: bbgd (Barzilai-Borwein gradient descent) or gd (simple gradient descent).
      (Default: bbgd) (choices: bbgd gd)'
    inputBinding:
      prefix: -linstage.optimiser.last
  - id: linstage_optimiser_default
    type: ['null', string]
    doc: 'Cost function optimisation algorithm to use at any stage iteration other than first or last
      iteration. Valid choices: bbgd (Barzilai-Borwein gradient descent) or gd (simple gradient descent).
      (Default: bbgd) (choices: bbgd gd)'
    inputBinding:
      prefix: -linstage.optimiser.default
  - id: linstage_diagnostics_prefix
    type: ['null', string]
    doc: generate diagnostics images after every registration stage
    inputBinding:
      prefix: -linstage.diagnostics.prefix
  - id: nl_warp
    type: ['null', mrregister_nl_warp_rec]
    doc: the non-linear warp output defined as two deformation fields, where warp1 can be used to transform
      image1->image2 and warp2 to transform image2->image1. The deformation fields also encapsulate any
      linear transformation estimated prior to non-linear registration.
    inputBinding:
      prefix: -nl_warp
  - id: nl_warp_full
    type: ['null', string]
    doc: 'output all warps used during registration. This saves four different warps that map each image
      to a midway space and their inverses in a single 5D image file. The 4th image dimension indexes
      the x,y,z component of the deformation vector and the 5th dimension indexes the field in this order:
      image1->midway, midway->image1, image2->midway, midway->image2. Where image1->midway defines the
      field that maps image1 onto the midway space using the reverse convention When linear registration
      is performed first, the estimated linear transform will be included in the comments of the image
      header, and therefore the entire linear and non-linear transform can be applied (in either direction)
      using this output warp file with mrtransform'
    inputBinding:
      prefix: -nl_warp_full
  - id: nl_init
    type: ['null', File]
    doc: initialise the non-linear registration with the supplied warp image. The supplied warp must be
      in the same format as output using the -nl_warp_full option (i.e. have 4 deformation fields with
      the linear transforms in the image header)
    inputBinding:
      prefix: -nl_init
  - id: nl_scale
    type: ['null', string]
    doc: 'use a multi-resolution scheme by defining a scale factor for each level using comma separated
      values (Default: 0.25,0.5,1.0)'
    inputBinding:
      prefix: -nl_scale
  - id: nl_niter
    type: ['null', string]
    doc: 'the maximum number of iterations. This can be specified either as a single number for all multi-resolution
      levels, or a single value for each level. (Default: 50)'
    inputBinding:
      prefix: -nl_niter
  - id: nl_update_smooth
    type: ['null', float]
    doc: regularise the gradient update field with Gaussian smoothing (standard deviation in voxel units,
      Default 2.0)
    inputBinding:
      prefix: -nl_update_smooth
  - id: nl_disp_smooth
    type: ['null', float]
    doc: regularise the displacement field with Gaussian smoothing (standard deviation in voxel units,
      Default 1.0)
    inputBinding:
      prefix: -nl_disp_smooth
  - id: nl_grad_step
    type: ['null', float]
    doc: 'the gradient step size for non-linear registration (Default: 0.5)'
    inputBinding:
      prefix: -nl_grad_step
  - id: nl_lmax
    type: ['null', string]
    doc: explicitly set the lmax to be used per scale factor in non-linear FOD registration. By default
      FOD registration will use lmax 0,2,4 with default scale factors 0.25,0.5,1.0 respectively. Note
      that no reorientation will be performed with lmax = 0.
    inputBinding:
      prefix: -nl_lmax
  - id: diagnostics_image
    type: ['null', string]
    doc: write intermediate images for diagnostics purposes
    inputBinding:
      prefix: -diagnostics_image
  - id: directions
    type: ['null', File]
    doc: 'the directions used for FOD reorientation using apodised point spread functions (Default: 60
      directions)'
    inputBinding:
      prefix: -directions
  - id: noreorientation
    type: ['null', boolean]
    doc: turn off FOD reorientation. Reorientation is on by default if the number of volumes in the 4th
      dimension corresponds to the number of coefficients in an antipodally symmetric spherical harmonic
      series (i.e. 6, 15, 28, 45, 66 etc)
    inputBinding:
      prefix: -noreorientation
  - id: mc_weights
    type: ['null', string]
    doc: 'relative weight of images used for multi-contrast registration. Default: 1.0 (equal weighting)'
    inputBinding:
      prefix: -mc_weights
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
  - id: transformed_out
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Output file for -transformed: image1 after registration transformed and regridded to the space
      of image2. Note that -transformed needs to be repeated for each contrast if multi-contrast registration
      is used.'
    outputBinding:
      glob: $(inputs.transformed)
  - id: rigid_out
    type: ['null', File]
    doc: 'Output file for -rigid: the output text file containing the rigid transformation as a 4x4 matrix'
    outputBinding:
      glob: $(inputs.rigid)
  - id: rigid_1tomidway_out
    type: ['null', File]
    doc: 'Output file for -rigid_1tomidway: the output text file containing the rigid transformation that
      aligns image1 to image2 in their common midway space as a 4x4 matrix'
    outputBinding:
      glob: $(inputs.rigid_1tomidway)
  - id: rigid_2tomidway_out
    type: ['null', File]
    doc: 'Output file for -rigid_2tomidway: the output text file containing the rigid transformation that
      aligns image2 to image1 in their common midway space as a 4x4 matrix'
    outputBinding:
      glob: $(inputs.rigid_2tomidway)
  - id: rigid_log_out
    type: ['null', File]
    doc: 'Output file for -rigid_log: write gradient descent parameter evolution to log file'
    outputBinding:
      glob: $(inputs.rigid_log)
  - id: affine_out
    type: ['null', File]
    doc: 'Output file for -affine: the output text file containing the affine transformation as a 4x4
      matrix'
    outputBinding:
      glob: $(inputs.affine)
  - id: affine_1tomidway_out
    type: ['null', File]
    doc: 'Output file for -affine_1tomidway: the output text file containing the affine transformation
      that aligns image1 to image2 in their common midway space as a 4x4 matrix'
    outputBinding:
      glob: $(inputs.affine_1tomidway)
  - id: affine_2tomidway_out
    type: ['null', File]
    doc: 'Output file for -affine_2tomidway: the output text file containing the affine transformation
      that aligns image2 to image1 in their common midway space as a 4x4 matrix'
    outputBinding:
      glob: $(inputs.affine_2tomidway)
  - id: affine_log_out
    type: ['null', File]
    doc: 'Output file for -affine_log: write gradient descent parameter evolution to log file'
    outputBinding:
      glob: $(inputs.affine_log)
  - id: nl_warp_warp1_out
    type: ['null', File]
    doc: 'Output warp1 of -nl_warp: the non-linear warp output defined as two deformation fields, where
      warp1 can be used to transform image1->image2 and warp2 to transform image2->image1. The deformation
      fields also encapsulate any linear transformation estimated prior to non-linear registration.'
    outputBinding:
      glob: '$(inputs.nl_warp ? inputs.nl_warp.warp1 : null)'
  - id: nl_warp_warp2_out
    type: ['null', File]
    doc: 'Output warp2 of -nl_warp: the non-linear warp output defined as two deformation fields, where
      warp1 can be used to transform image1->image2 and warp2 to transform image2->image1. The deformation
      fields also encapsulate any linear transformation estimated prior to non-linear registration.'
    outputBinding:
      glob: '$(inputs.nl_warp ? inputs.nl_warp.warp2 : null)'
  - id: nl_warp_full_out
    type: ['null', File]
    doc: 'Output file for -nl_warp_full: output all warps used during registration. This saves four different
      warps that map each image to a midway space and their inverses in a single 5D image file. The 4th
      image dimension indexes the x,y,z component of the deformation vector and the 5th dimension indexes
      the field in this order: image1->midway, midway->image1, image2->midway, midway->image2. Where image1->midway
      defines the field that maps image1 onto the midway space using the reverse convention When linear
      registration is performed first, the estimated linear transform will be included in the comments
      of the image header, and therefore the entire linear and non-linear transform can be applied (in
      either direction) using this output warp file with mrtransform'
    outputBinding:
      glob: $(inputs.nl_warp_full)
  - id: transformed_midway_out
    type:
      - 'null'
      - type: array
        items: File
    doc: Images transformed to the midway space (-transformed_midway).
    outputBinding:
      glob: '$(inputs.transformed_midway ? inputs.transformed_midway.reduce(function(a, r) { return a.concat([r.image1_transformed,
        r.image2_transformed]); }, []) : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
