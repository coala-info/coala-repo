cwlVersion: v1.2
class: CommandLineTool
baseCommand: population_template
label: mrtrix3_population_template
doc: "Generates an unbiased group-average template from a series of images\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: input_dir
    type: Directory
    doc: "Input directory containing all images used to build the template"
    inputBinding:
      position: 1
  - id: template
    type: string
    doc: "Corresponding output template image. For multi-contrast registration, provide multiple paired input_dir and template arguments. Example: WM_dir WM_template.mif GM_dir GM_template.mif"
    inputBinding:
      position: 2
  - id: type
    type: ['null', string]
    doc: "Specify the types of registration stages to perform. Options are \"rigid\" (perform rigid registration only which might be useful for intra-subject registration in longitudinal analysis), \"affine\" (perform affine registration) and \"nonlinear\" as well as cominations of registration types: \"rigid_affine\", \"rigid_nonlinear\", \"affine_nonlinear\", \"rigid_affine_nonlinear\". Default: rigid_affine_nonlinear"
    inputBinding:
      position: 10
      prefix: -type
  - id: voxel_size
    type: ['null', string]
    doc: "Define the template voxel size in mm. Use either a single value for isotropic voxels or 3 comma separated values."
    inputBinding:
      position: 10
      prefix: -voxel_size
  - id: initial_alignment
    type: ['null', string]
    doc: "Method of alignment to form the initial template. Options are \"mass\" (default), \"robust_mass\" (requires masks), \"geometric\" and \"none\"."
    inputBinding:
      position: 10
      prefix: -initial_alignment
  - id: mask_dir
    type: ['null', Directory]
    doc: "Optionally input a set of masks inside a single directory, one per input image (with the same file name prefix). Using masks will speed up registration significantly. Note that masks are used for registration, not for aggregation. To exclude areas from aggregation, NaN-mask your input images."
    inputBinding:
      position: 10
      prefix: -mask_dir
  - id: warp_dir
    type: ['null', string]
    doc: "Output a directory containing warps from each input to the template. If the folder does not exist it will be created"
    inputBinding:
      position: 10
      prefix: -warp_dir
  - id: transformed_dir
    type: ['null', string]
    doc: "Output a directory containing the input images transformed to the template. If the folder does not exist it will be created. For multi-contrast registration, provide comma separated list of directories."
    inputBinding:
      position: 10
      prefix: -transformed_dir
  - id: linear_transformations_dir
    type: ['null', string]
    doc: "Output a directory containing the linear transformations used to generate the template. If the folder does not exist it will be created"
    inputBinding:
      position: 10
      prefix: -linear_transformations_dir
  - id: template_mask
    type: ['null', string]
    doc: "Output a template mask. Only works if -mask_dir has been input. The template mask is computed as the intersection of all subject masks in template space."
    inputBinding:
      position: 10
      prefix: -template_mask
  - id: noreorientation
    type: ['null', boolean]
    doc: "Turn off FOD reorientation in mrregister. Reorientation is on by default if the number of volumes in the 4th dimension corresponds to the number of coefficients in an antipodally symmetric spherical harmonic series (i.e. 6, 15, 28, 45, 66 etc)"
    inputBinding:
      position: 10
      prefix: -noreorientation
  - id: leave_one_out
    type: ['null', string]
    doc: "Register each input image to a template that does not contain that image. Valid choices: 0, 1, auto. (Default: auto (true if n_subjects larger than 2 and smaller than 15))"
    inputBinding:
      position: 10
      prefix: -leave_one_out
  - id: aggregate
    type: ['null', string]
    doc: "Measure used to aggregate information from transformed images to the template image. Valid choices: mean, median. Default: mean"
    inputBinding:
      position: 10
      prefix: -aggregate
  - id: aggregation_weights
    type: ['null', File]
    doc: "Comma separated file containing weights used for weighted image aggregation. Each row must contain the identifiers of the input image and its weight. Note that this weighs intensity values not transformations (shape)."
    inputBinding:
      position: 10
      prefix: -aggregation_weights
  - id: nanmask
    type: ['null', boolean]
    doc: "Optionally apply masks to (transformed) input images using NaN values to specify include areas for registration and aggregation. Only works if -mask_dir has been input."
    inputBinding:
      position: 10
      prefix: -nanmask
  - id: copy_input
    type: ['null', boolean]
    doc: "Copy input images and masks into local scratch directory."
    inputBinding:
      position: 10
      prefix: -copy_input
  - id: nl_scale
    type: ['null', string]
    doc: "Specify the multi-resolution pyramid used to build the non-linear template, in the form of a list of scale factors (default: 0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0). This implicitly defines the number of template levels"
    inputBinding:
      position: 10
      prefix: -nl_scale
  - id: nl_lmax
    type: ['null', string]
    doc: "Specify the lmax used for non-linear registration for each scale factor, in the form of a list of integers (default: 2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4). The list must be the same length as the nl_scale factor list"
    inputBinding:
      position: 10
      prefix: -nl_lmax
  - id: nl_niter
    type: ['null', string]
    doc: "Specify the number of registration iterations used within each level before updating the template, in the form of a list of integers (default: 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5). The list must be the same length as the nl_scale factor list"
    inputBinding:
      position: 10
      prefix: -nl_niter
  - id: nl_update_smooth
    type: ['null', float]
    doc: "Regularise the gradient update field with Gaussian smoothing (standard deviation in voxel units, Default 2.0 x voxel_size)"
    inputBinding:
      position: 10
      prefix: -nl_update_smooth
  - id: nl_disp_smooth
    type: ['null', float]
    doc: "Regularise the displacement field with Gaussian smoothing (standard deviation in voxel units, Default 1.0 x voxel_size)"
    inputBinding:
      position: 10
      prefix: -nl_disp_smooth
  - id: nl_grad_step
    type: ['null', float]
    doc: "The gradient step size for non-linear registration (Default: 0.5)"
    inputBinding:
      position: 10
      prefix: -nl_grad_step
  - id: linear_no_pause
    type: ['null', boolean]
    doc: "Do not pause the script if a linear registration seems implausible"
    inputBinding:
      position: 10
      prefix: -linear_no_pause
  - id: linear_estimator
    type: ['null', string]
    doc: "Specify estimator for intensity difference metric. Valid choices are: l1 (least absolute: |x|), l2 (ordinary least squares), lp (least powers: |x|^1.2), Default: None (no robust estimator used)"
    inputBinding:
      position: 10
      prefix: -linear_estimator
  - id: rigid_scale
    type: ['null', string]
    doc: "Specify the multi-resolution pyramid used to build the rigid template, in the form of a list of scale factors (default: 0.3,0.4,0.6,0.8,1.0,1.0). This and affine_scale implicitly define the number of template levels"
    inputBinding:
      position: 10
      prefix: -rigid_scale
  - id: rigid_lmax
    type: ['null', string]
    doc: "Specify the lmax used for rigid registration for each scale factor, in the form of a list of integers (default: 2,2,2,4,4,4). The list must be the same length as the linear_scale factor list"
    inputBinding:
      position: 10
      prefix: -rigid_lmax
  - id: rigid_niter
    type: ['null', string]
    doc: "Specify the number of registration iterations used within each level before updating the template, in the form of a list of integers (default:50 for each scale). This must be a single number or a list of same length as the linear_scale factor list"
    inputBinding:
      position: 10
      prefix: -rigid_niter
  - id: affine_scale
    type: ['null', string]
    doc: "Specify the multi-resolution pyramid used to build the affine template, in the form of a list of scale factors (default: 0.3,0.4,0.6,0.8,1.0,1.0). This and rigid_scale implicitly define the number of template levels"
    inputBinding:
      position: 10
      prefix: -affine_scale
  - id: affine_lmax
    type: ['null', string]
    doc: "Specify the lmax used for affine registration for each scale factor, in the form of a list of integers (default: 2,2,2,4,4,4). The list must be the same length as the linear_scale factor list"
    inputBinding:
      position: 10
      prefix: -affine_lmax
  - id: affine_niter
    type: ['null', string]
    doc: "Specify the number of registration iterations used within each level before updating the template, in the form of a list of integers (default:500 for each scale). This must be a single number or a list of same length as the linear_scale factor list"
    inputBinding:
      position: 10
      prefix: -affine_niter
  - id: mc_weight_initial_alignment
    type: ['null', string]
    doc: "Weight contribution of each contrast to the initial alignment. Comma separated, default: 1.0"
    inputBinding:
      position: 10
      prefix: -mc_weight_initial_alignment
  - id: mc_weight_rigid
    type: ['null', string]
    doc: "Weight contribution of each contrast to the objective of rigid registration. Comma separated, default: 1.0"
    inputBinding:
      position: 10
      prefix: -mc_weight_rigid
  - id: mc_weight_affine
    type: ['null', string]
    doc: "Weight contribution of each contrast to the objective of affine registration. Comma separated, default: 1.0"
    inputBinding:
      position: 10
      prefix: -mc_weight_affine
  - id: mc_weight_nl
    type: ['null', string]
    doc: "Weight contribution of each contrast to the objective of nonlinear registration. Comma separated, default: 1.0"
    inputBinding:
      position: 10
      prefix: -mc_weight_nl
  - id: nocleanup
    type: ['null', boolean]
    doc: "do not delete intermediate files during script execution, and do not delete scratch directory at script completion."
    inputBinding:
      position: 10
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: "manually specify the path in which to generate the scratch directory."
    inputBinding:
      position: 10
      prefix: -scratch
  - id: continue
    type: ['null', continue_record]
    doc: "continue the script from a previous execution; must provide the scratch directory path, and the name of the last successfully-generated file."
    inputBinding:
      position: 10
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status. Alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non- empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: template_file
    type: File
    doc: Output file given by template.
    outputBinding:
      glob: $(inputs.template)
  - id: warp_dir_dir
    type: ['null', Directory]
    doc: Output directory given by -warp_dir.
    outputBinding:
      glob: $(inputs.warp_dir)
  - id: transformed_dir_dir
    type: ['null', Directory]
    doc: Output directory given by -transformed_dir.
    outputBinding:
      glob: $(inputs.transformed_dir)
  - id: linear_transformations_dir_dir
    type: ['null', Directory]
    doc: Output directory given by -linear_transformations_dir.
    outputBinding:
      glob: $(inputs.linear_transformations_dir)
  - id: template_mask_file
    type: ['null', File]
    doc: Output file given by -template_mask.
    outputBinding:
      glob: $(inputs.template_mask)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: continue_record
        type: record
        fields:
          - name: scratch_dir
            type: string
            inputBinding:
              position: 1
          - name: last_file
            type: string
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
