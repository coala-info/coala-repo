cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabies_preprocess
label: rabies_preprocess
doc: "Apply preprocessing with only EPI scans. Commonspace registration is executed
  directly using the corrected EPI 3D reference images. The commonspace registration
  simultaneously applies distortion correction. Nativespace is always the original
  EPI space.\n\nTool homepage: https://github.com/CoBrALab/RABIES"
inputs:
  - id: bids_dir
    type: Directory
    doc: The root folder of the BIDS-formated input data directory.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: the output path to drop outputs from major preprocessing steps.
    inputBinding:
      position: 2
  - id: anat_autobox
    type:
      - 'null'
      - boolean
    doc: Crops out extra space around the brain on the structural image using 
      AFNI's 3dAutobox 
      https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dAutobox.html.
    default: false
    inputBinding:
      position: 103
      prefix: --anat_autobox
  - id: anat_inho_cor
    type:
      - 'null'
      - string
    doc: "Select options for the inhomogeneity correction of the structural image.
      * method: specify which registration strategy is employed for providing a brain
      mask. *** Rigid: conducts only rigid registration. *** Affine: conducts Rigid
      then Affine registration. *** SyN: conducts Rigid, Affine then non-linear registration.
      *** no_reg: skip registration. *** N4_reg: previous correction script prior
      to version 0.3.1. *** disable: disables the inhomogeneity correction. * otsu_thresh:
      The inhomogeneity correction script necessitates an initial correction with
      a Otsu masking strategy (prior to registration of an anatomical mask). This
      option sets the Otsu threshold level to capture the right intensity distribution.
      *** Specify an integer among [0,1,2,3,4]. * multiotsu: Select this option to
      perform a staged inhomogeneity correction, where only lower intensities are
      initially corrected, then higher intensities are iteratively included to eventually
      correct the whole image. This technique may help with images with particularly
      strong inhomogeneity gradients and very low intensities. *** Specify 'true'
      or 'false'."
    default: method=SyN,otsu_thresh=2,multiotsu=false
    inputBinding:
      position: 103
      prefix: --anat_inho_cor
  - id: anat_robust_inho_cor
    type:
      - 'null'
      - string
    doc: "When selecting this option, inhomogeneity correction is executed twice to
      optimize outcomes. After completing an initial inhomogeneity correction step,
      the corrected outputs are co-registered to generate an unbiased template, using
      the same method as the commonspace registration. This template is then masked,
      and is used as a new target for masking during a second iteration of inhomogeneity
      correction. Using this dataset-specific template should improve the robustness
      of masking for inhomogeneity correction. * apply: select 'true' to apply this
      option. *** Specify 'true' or 'false'. * stages: Registration stages for generating
      the unbiased template. *** Each stage must be among the following: 'rigid','similarity','affine'
      or 'nlin' (non-linear). The syntax must follows this example: rigid-affine-nlin.
      * masking: Combine masks derived from the inhomogeneity correction step to support
      registration during the generation of the unbiased template, and then during
      template registration. *** Specify 'true' or 'false'. * brain_extraction: conducts
      brain extraction prior to template registration based on the combined masks
      from inhomogeneity correction. This will enhance brain edge-matching, but requires
      good quality masks. This must be selected along the 'masking' option. *** Specify
      'true' or 'false'. * keep_mask_after_extract: If using brain_extraction, use
      the mask to compute the registration metric within the mask only. Choose to
      prevent stretching of the images beyond the limit of the brain mask (e.g. if
      the moving and target images don't have the same brain coverage). *** Specify
      'true' or 'false'. * template_registration: Specify a registration script for
      the alignment of the dataset-generated unbiased template to a reference template
      for masking. *** Rigid: conducts only rigid registration. *** Affine: conducts
      Rigid then Affine registration. *** SyN: conducts Rigid, Affine then non-linear
      registration. *** no_reg: skip registration. * winsorize_lower_bound: the lower
      bound for the antsRegistration winsorize-image-intensities option, useful for
      fUS images with intensity outliers. * winsorize_upper_bound: the upper bound
      for the antsRegistration winsorize-image-intensities option, useful for fUS
      images with intensity outliers."
    default: 
      apply=false,stages=rigid-affine-nlin,masking=false,brain_extraction=false,keep_mask_after_extract=false,template_registration=SyN,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0
    inputBinding:
      position: 103
      prefix: --anat_robust_inho_cor
  - id: anat_template
    type:
      - 'null'
      - File
    doc: Anatomical file for the commonspace atlas.
    default: /root/.local/share/rabies/DSURQE_40micron_average.nii.gz
    inputBinding:
      position: 103
      prefix: --anat_template
  - id: anatomical_resampling
    type:
      - 'null'
      - string
    doc: This specifies resampling dimensions for the anatomical registration 
      targets. By default, images are resampled to isotropic resolution based on
      the smallest dimension among the provided anatomical images (EPI images 
      instead if --bold_only is True). Increasing voxel resampling size will 
      increase registration speed at the cost of accuracy.
    default: inputs_defined
    inputBinding:
      position: 103
      prefix: --anatomical_resampling
  - id: apply_despiking
    type:
      - 'null'
      - boolean
    doc: Applies AFNI's 3dDespike 
      https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDespike.html.
    default: false
    inputBinding:
      position: 103
      prefix: --apply_despiking
  - id: apply_slice_mc
    type:
      - 'null'
      - boolean
    doc: Whether to apply a slice-specific motion correction after initial 
      volumetric HMC. This can correct for interslice misalignment resulting 
      from within-TR motion. With this option, motion corrections and the 
      subsequent resampling from registration are applied sequentially since the
      2D slice registrations cannot be concatenate with 3D transforms.
    default: false
    inputBinding:
      position: 103
      prefix: --apply_slice_mc
  - id: apply_stc
    type:
      - 'null'
      - boolean
    doc: Select this option to apply the STC step.
    default: false
    inputBinding:
      position: 103
      prefix: --apply_STC
  - id: bids_filter
    type:
      - 'null'
      - File
    doc: Allows to provide additional BIDS specifications (found within the 
      input BIDS directory) for selected a subset of functional and/or 
      anatomical images. Takes as input a JSON file containing the set of 
      parameters for functional image under 'func' and under 'anat' for the 
      anatomical image. See online documentation for an example.
    inputBinding:
      position: 103
      prefix: --bids_filter
  - id: bold2anat_coreg
    type:
      - 'null'
      - string
    doc: "Specify the registration script for cross-modal alignment between the EPI
      and structural images. This operation is responsible for correcting EPI susceptibility
      distortions. * masking: With this option, the brain masks obtained from the
      EPI inhomogeneity correction step are used to support registration. *** Specify
      'true' or 'false'. * brain_extraction: conducts brain extraction prior to registration
      using the EPI masks from inhomogeneity correction. This will enhance brain edge-matching,
      but requires good quality masks. This must be selected along the 'masking' option.
      *** Specify 'true' or 'false'. * winsorize_lower_bound: the lower bound for
      the antsRegistration winsorize-image-intensities option. * winsorize_upper_bound:
      the upper bound for the antsRegistration winsorize-image-intensities option.
      * keep_mask_after_extract: If using brain_extraction, use the mask to compute
      the registration metric within the mask only. Choose to prevent stretching of
      the images beyond the limit of the brain mask (e.g. if the moving and target
      images don't have the same brain coverage). *** Specify 'true' or 'false'. *
      registration: Specify a registration script. *** Rigid: conducts only rigid
      registration. *** Affine: conducts Rigid then Affine registration. *** SyN:
      conducts Rigid, Affine then non-linear registration. *** no_reg: skip registration."
    default: 
      masking=false,brain_extraction=false,keep_mask_after_extract=false,registration=SyN,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0
    inputBinding:
      position: 103
      prefix: --bold2anat_coreg
  - id: bold_autobox
    type:
      - 'null'
      - boolean
    doc: Crops out extra space around the brain on the EPI image using AFNI's 
      3dAutobox 
      https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dAutobox.html.
    default: false
    inputBinding:
      position: 103
      prefix: --bold_autobox
  - id: bold_inho_cor
    type:
      - 'null'
      - string
    doc: Same as --anat_inho_cor, but for the EPI images.
    default: method=Rigid,otsu_thresh=2,multiotsu=false
    inputBinding:
      position: 103
      prefix: --bold_inho_cor
  - id: bold_nativespace
    type:
      - 'null'
      - boolean
    doc: Select this option to define nativespace as the original space of the 
      input functional scan, as opposed to the anatomical space of the 
      structural scan which is by default the nativespace. The main difference 
      is that distortion correction is no longer carried in the nativespace, 
      which is the result of registration to the structural scan, but the 
      commonspace still includes distortion correction. If using --bold_only, 
      this parameter has no effect.
    default: false
    inputBinding:
      position: 103
      prefix: --bold_nativespace
  - id: bold_only
    type:
      - 'null'
      - boolean
    doc: Apply preprocessing with only EPI scans. Commonspace registration is 
      executed directly using the corrected EPI 3D reference images. The 
      commonspace registration simultaneously applies distortion correction. 
      Nativespace is always the original EPI space.
    default: false
    inputBinding:
      position: 103
      prefix: --bold_only
  - id: bold_robust_inho_cor
    type:
      - 'null'
      - string
    doc: Same as --anat_robust_inho_cor, but for the EPI images.
    default: 
      apply=false,stages=rigid-affine-nlin,masking=false,brain_extraction=false,keep_mask_after_extract=false,template_registration=SyN,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0
    inputBinding:
      position: 103
      prefix: --bold_robust_inho_cor
  - id: brain_mask
    type:
      - 'null'
      - File
    doc: Brain mask aligned with the template.
    default: /root/.local/share/rabies/DSURQE_40micron_mask.nii.gz
    inputBinding:
      position: 103
      prefix: --brain_mask
  - id: commonspace_reg
    type:
      - 'null'
      - string
    doc: "Specify registration options for the commonspace registration. * stages:
      Registration stages for generating the unbiased template. *** Each stage must
      be among the following: 'rigid','similarity','affine' or 'nlin' (non-linear).
      The syntax must follows this example: rigid-affine-nlin. * masking: Combine
      masks derived from the inhomogeneity correction step to support registration
      during the generation of the unbiased template, and then during template registration.
      *** Specify 'true' or 'false'. * brain_extraction: conducts brain extraction
      prior to template registration based on the combined masks from inhomogeneity
      correction. This will enhance brain edge-matching, but requires good quality
      masks. This must be selected along the 'masking' option. *** Specify 'true'
      or 'false'. * keep_mask_after_extract: If using brain_extraction, use the mask
      to compute the registration metric within the mask only. Choose to prevent stretching
      of the images beyond the limit of the brain mask (e.g. if the moving and target
      images don't have the same brain coverage). *** Specify 'true' or 'false'. *
      template_registration: Specify a registration script for the alignment of the
      dataset-generated unbiased template to the commonspace atlas. *** Rigid: conducts
      only rigid registration. *** Affine: conducts Rigid then Affine registration.
      *** SyN: conducts Rigid, Affine then non-linear registration. *** no_reg: skip
      registration. * fast_commonspace: Skip the generation of a dataset-generated
      unbiased template, and instead, register each scan independently directly onto
      the commonspace atlas, using the template_registration. This option can be faster,
      but may decrease the quality of alignment between subjects. *** Specify 'true'
      or 'false'. * winsorize_lower_bound: the lower bound for the antsRegistration
      winsorize-image-intensities option, useful for fUS images with intensity outliers.
      * winsorize_upper_bound: the upper bound for the antsRegistration winsorize-image-intensities
      option, useful for fUS images with intensity outliers."
    default: 
      stages=rigid-affine-nlin,masking=false,brain_extraction=false,keep_mask_after_extract=false,template_registration=SyN,fast_commonspace=false,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0
    inputBinding:
      position: 103
      prefix: --commonspace_reg
  - id: commonspace_resampling
    type:
      - 'null'
      - string
    doc: Can specify a resampling dimension for the commonspace fMRI outputs.
    default: inputs_defined
    inputBinding:
      position: 103
      prefix: --commonspace_resampling
  - id: csf_mask
    type:
      - 'null'
      - File
    doc: (OPTIONAL) CSF mask aligned with the template. If no input is provided 
      and the default --anat_template is not used, the core pipeline will run, 
      but downstream functions that rely on this file will be disabled.
    default: /root/.local/share/rabies/DSURQE_40micron_eroded_CSF_mask.nii.gz
    inputBinding:
      position: 103
      prefix: --CSF_mask
  - id: detect_dummy
    type:
      - 'null'
      - boolean
    doc: Detect and remove initial dummy volumes from the EPI, and generate a 
      reference EPI based on these volumes if detected. Dummy volumes will be 
      removed from the output preprocessed EPI.
    default: false
    inputBinding:
      position: 103
      prefix: --detect_dummy
  - id: hmc_option
    type:
      - 'null'
      - string
    doc: Select a pre-built option for registration during head motion 
      realignment. 'optim' was customized as documented in 
      https://github.com/CoBrALab/RABIES/discussions/259. Other options were 
      taken from 
      https://github.com/ANTsX/ANTsR/blob/master/R/ants_motion_estimation.R.
    default: optim
    inputBinding:
      position: 103
      prefix: --HMC_option
  - id: inherit_unbiased_template
    type:
      - 'null'
      - Directory
    doc: "Provide a path to a previous RABIES preprocessing output folder to inherit
      the unbiased template generated in that previous run, as well as the registration
      to the external atlas. In place of conducting unbiased template generation,
      each scan is registered to this pre-generated template with registration parameters
      that are consistent with that of the previous run. The atlas registration is
      also inherited, and won't be conducted again. By selecting this option, the
      following preprocessing parameters will be overriden to enforce consistency
      with the previous run: --anatomical_resampling, --commonspace_reg, --anat_template,
      --brain_mask, --WM_mask, --CSF_mask, --vascular_mask, --labels"
    default: none
    inputBinding:
      position: 103
      prefix: --inherit_unbiased_template
  - id: interp_method
    type:
      - 'null'
      - string
    doc: Can specify the interpolation method used for STC. Polynomial methods 
      (e.g., linear, cubic, etc.) will introduce greater autocorrelation to the 
      interpolated timeseries, while wsinc and fourier methods will introduce 
      less (or none). Refer to this discussion on the topic for more information
      https://github.com/CoBrALab/RABIES/discussions/267.
    default: fourier
    inputBinding:
      position: 103
      prefix: --interp_method
  - id: isotropic_hmc
    type:
      - 'null'
      - boolean
    doc: Whether to resample the EPI to isotropic resolution (taking the size of
      the axis with highest resolution) for the estimation of motion parameters.
      This should greatly mitigating registration 'noise' which arise from 
      partial volume effects, or poor image resolution (see online post on this 
      topic https://github.com/CoBrALab/RABIES/discussions/288). This option 
      will increase computational time, given the higher image resolution.
    default: false
    inputBinding:
      position: 103
      prefix: --isotropic_HMC
  - id: labels
    type:
      - 'null'
      - File
    doc: (OPTIONAL) Labels file providing the atlas anatomical annotations. If 
      no input is provided and the default --anat_template is not used, the core
      pipeline will run, but downstream functions that rely on this file will be
      disabled.
    default: /root/.local/share/rabies/DSURQE_40micron_labels.nii.gz
    inputBinding:
      position: 103
      prefix: --labels
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: The functional and structural image intensity will be log transformed 
      before registration. The preprocessed functional timeseries will retain 
      the original intensity values. This parameter can support registration of 
      fUSI images.
    default: false
    inputBinding:
      position: 103
      prefix: --log_transform
  - id: nativespace_resampling
    type:
      - 'null'
      - string
    doc: Can specify a resampling dimension for the nativespace fMRI outputs.
    default: inputs_defined
    inputBinding:
      position: 103
      prefix: --nativespace_resampling
  - id: oblique2card
    type:
      - 'null'
      - string
    doc: "Correct for oblique coordinates on all structural and functional data. WARNING:
      these corrections are suboptimal, and may alter the data. Only apply if necessary.
      affine: only the affine matrix is changed to cardinal axes. 3dWarp: Applies
      AFNI's 3dWarp -oblique2card. This involves resampling the data on a new isotropic
      grid."
    default: none
    inputBinding:
      position: 103
      prefix: --oblique2card
  - id: resampling_space
    type:
      - 'null'
      - string
    doc: Determine whether preprocessed timeseries should be generated in 
      commonspace only ('common_only'), nativespace only ('native_only'), or for
      both native and commonspaces ('both'). Generating timeseries only in the 
      desired space will save memory and computational time.
    default: common_only
    inputBinding:
      position: 103
      prefix: --resampling_space
  - id: stc_axis
    type:
      - 'null'
      - string
    doc: Can specify over which axis of the image the STC must be applied. 
      Generally, the correction should be over the Y axis, which corresponds to 
      the anteroposterior axis in RAS convention.
    default: Y
    inputBinding:
      position: 103
      prefix: --stc_axis
  - id: tpattern
    type:
      - 'null'
      - string
    doc: Specify if interleaved ('alt') or sequential ('seq') acquisition, and 
      specify in which direction (- or +) to apply the correction. If slices 
      were acquired from front to back, the correction should be in the negative
      (-) direction. If slices were collected in an interleaved order starting 
      with the second or (second-to-last) slice, use 'alt+z2' or 'alt-z2'. Refer
      to this discussion on the topic for more information 
      https://github.com/CoBrALab/RABIES/discussions/217.
    default: alt-z
    inputBinding:
      position: 103
      prefix: --tpattern
  - id: tr
    type:
      - 'null'
      - string
    doc: Specify repetition time (TR) in seconds. (e.g. --TR 1.2). 'auto' will 
      read the TR from the nifti header.
    default: auto
    inputBinding:
      position: 103
      prefix: --TR
  - id: vascular_mask
    type:
      - 'null'
      - File
    doc: (OPTIONAL) Can provide a mask of major blood vessels to compute 
      associated nuisance timeseries. The default mask was generated by applying
      MELODIC ICA and selecting the resulting component mapping onto major brain
      vessels. If no input is provided and the default --anat_template is not 
      used, the core pipeline will run, but downstream functions that rely on 
      this file will be disabled.
    default: /root/.local/share/rabies/vascular_mask.nii.gz
    inputBinding:
      position: 103
      prefix: --vascular_mask
  - id: voxelwise_motion
    type:
      - 'null'
      - boolean
    doc: Whether to output estimates of absolute displacement and framewise 
      displacement at each voxel. This will generate 4D nifti files representing
      motion timeseries derived from the 6 motion parameters. This is handled by
      antsMotionCorrStats.
    default: false
    inputBinding:
      position: 103
      prefix: --voxelwise_motion
  - id: wm_mask
    type:
      - 'null'
      - File
    doc: (OPTIONAL) White matter mask aligned with the template. If no input is 
      provided and the default --anat_template is not used, the core pipeline 
      will run, but downstream functions that rely on this file will be 
      disabled.
    default: /root/.local/share/rabies/DSURQE_40micron_eroded_WM_mask.nii.gz
    inputBinding:
      position: 103
      prefix: --WM_mask
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
stdout: rabies_preprocess.out
