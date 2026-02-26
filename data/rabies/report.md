# rabies CWL Generation Report

## rabies_preprocess

### Tool Description
Apply preprocessing with only EPI scans. Commonspace registration is executed directly using the corrected EPI 3D reference images. The commonspace registration simultaneously applies distortion correction. Nativespace is always the original EPI space.

### Metadata
- **Docker Image**: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
- **Homepage**: https://github.com/CoBrALab/RABIES
- **Package**: https://anaconda.org/channels/bioconda/packages/rabies/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rabies/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-12-26
- **GitHub**: https://github.com/CoBrALab/RABIES
- **Stars**: N/A
### Original Help Text
```text
usage: rabies preprocess [-h] [--bids_filter BIDS_FILTER] [--bold_only]
                         [--bold_nativespace] [--anat_autobox]
                         [--bold_autobox]
                         [--oblique2card {none,affine,3dWarp}]
                         [--apply_despiking]
                         [--HMC_option {intraSubjectBOLD,0,1,2,3,optim}]
                         [--isotropic_HMC] [--voxelwise_motion]
                         [--apply_slice_mc] [--detect_dummy] [--log_transform]
                         [--anat_inho_cor ANAT_INHO_COR]
                         [--anat_robust_inho_cor ANAT_ROBUST_INHO_COR]
                         [--bold_inho_cor BOLD_INHO_COR]
                         [--bold_robust_inho_cor BOLD_ROBUST_INHO_COR]
                         [--commonspace_reg COMMONSPACE_REG]
                         [--inherit_unbiased_template INHERIT_UNBIASED_TEMPLATE]
                         [--bold2anat_coreg BOLD2ANAT_COREG]
                         [--resampling_space {common_only,native_only,both}]
                         [--nativespace_resampling NATIVESPACE_RESAMPLING]
                         [--commonspace_resampling COMMONSPACE_RESAMPLING]
                         [--anatomical_resampling ANATOMICAL_RESAMPLING]
                         [--apply_STC] [--TR TR]
                         [--tpattern {alt-z,alt-z2,seq-z,alt+z,alt+z2,seq+z}]
                         [--stc_axis {X,Y,Z}]
                         [--interp_method {linear,cubic,quintic,heptic,wsinc5,wsinc9,fourier}]
                         [--anat_template ANAT_TEMPLATE]
                         [--brain_mask BRAIN_MASK] [--WM_mask WM_MASK]
                         [--CSF_mask CSF_MASK] [--vascular_mask VASCULAR_MASK]
                         [--labels LABELS]
                         bids_dir output_dir

positional arguments:
  bids_dir              The root folder of the BIDS-formated input data directory.
                        
  output_dir            the output path to drop outputs from major preprocessing steps.
                        

optional arguments:
  -h, --help            show this help message and exit
  --bids_filter BIDS_FILTER
                        Allows to provide additional BIDS specifications (found within the input BIDS directory) 
                        for selected a subset of functional and/or anatomical images. Takes as input a JSON file 
                        containing the set of parameters for functional image under 'func' and under 'anat' for the 
                        anatomical image. See online documentation for an example. 
                        (default: {'func': {'suffix': ['bold', 'cbv']}, 'anat': {'suffix': ['T1w', 'T2w']}})
                        
  --bold_only           Apply preprocessing with only EPI scans. Commonspace registration is executed directly using
                        the corrected EPI 3D reference images. The commonspace registration simultaneously applies
                        distortion correction. Nativespace is always the original EPI space.
                        (default: False)
                        
  --bold_nativespace    Select this option to define nativespace as the original space of the input functional scan, as opposed
                        to the anatomical space of the structural scan which is by default the nativespace.
                        The main difference is that distortion correction is no longer carried in the nativespace, which is 
                        the result of registration to the structural scan, but the commonspace still includes distortion correction. 
                        If using --bold_only, this parameter has no effect. 
                        (default: False)
                        
  --anat_autobox        Crops out extra space around the brain on the structural image using AFNI's 3dAutobox
                        https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dAutobox.html.
                        (default: False)
                        
  --bold_autobox        Crops out extra space around the brain on the EPI image using AFNI's 3dAutobox
                        https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dAutobox.html.
                        (default: False)
                        
  --oblique2card {none,affine,3dWarp}
                        Correct for oblique coordinates on all structural and functional data. 
                           WARNING: these corrections are suboptimal, and may alter the data. Only apply if necessary. 
                        
                        affine: only the affine matrix is changed to cardinal axes. 
                        
                        3dWarp: Applies AFNI's 3dWarp -oblique2card. This involves resampling the 
                        data on a new isotropic grid.
                        (default: none)
                        
  --apply_despiking     Applies AFNI's 3dDespike https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDespike.html.
                        (default: False)
                        
  --HMC_option {intraSubjectBOLD,0,1,2,3,optim}
                        Select a pre-built option for registration during head motion realignment. 'optim' was customized
                        as documented in https://github.com/CoBrALab/RABIES/discussions/259. Other options were taken from 
                        https://github.com/ANTsX/ANTsR/blob/master/R/ants_motion_estimation.R.
                        (default: optim)
                        
  --isotropic_HMC       Whether to resample the EPI to isotropic resolution (taking the size of the axis with highest 
                        resolution) for the estimation of motion parameters. This should greatly mitigating registration 
                        'noise' which arise from partial volume effects, or poor image resolution (see online post on 
                        this topic https://github.com/CoBrALab/RABIES/discussions/288). This option will increase 
                        computational time, given the higher image resolution. 
                        (default: False)
                        
  --voxelwise_motion    Whether to output estimates of absolute displacement and framewise displacement at each voxel. 
                        This will generate 4D nifti files representing motion timeseries derived from the 6 motion  
                        parameters. This is handled by antsMotionCorrStats. 
                        (default: False)
                        
  --apply_slice_mc      Whether to apply a slice-specific motion correction after initial volumetric HMC. This can 
                        correct for interslice misalignment resulting from within-TR motion. With this option, 
                        motion corrections and the subsequent resampling from registration are applied sequentially
                        since the 2D slice registrations cannot be concatenate with 3D transforms. 
                        (default: False)
                        
  --detect_dummy        Detect and remove initial dummy volumes from the EPI, and generate a reference EPI based on
                        these volumes if detected. Dummy volumes will be removed from the output preprocessed EPI.
                        (default: False)
                        
  --log_transform       The functional and structural image intensity will be log transformed before registration. 
                        The preprocessed functional timeseries will retain the original intensity values. 
                        This parameter can support registration of fUSI images.
                        (default: False)
                        

Registration Options:
  Customize registration operations and troubleshoot registration failures.

  --anat_inho_cor ANAT_INHO_COR
                        Select options for the inhomogeneity correction of the structural image.
                        * method: specify which registration strategy is employed for providing a brain mask.
                        *** Rigid: conducts only rigid registration.
                        *** Affine: conducts Rigid then Affine registration.
                        *** SyN: conducts Rigid, Affine then non-linear registration.
                        *** no_reg: skip registration.
                        *** N4_reg: previous correction script prior to version 0.3.1.
                        *** disable: disables the inhomogeneity correction.
                        * otsu_thresh: The inhomogeneity correction script necessitates an initial correction with a 
                         Otsu masking strategy (prior to registration of an anatomical mask). This option sets the 
                         Otsu threshold level to capture the right intensity distribution. 
                        *** Specify an integer among [0,1,2,3,4]. 
                        * multiotsu: Select this option to perform a staged inhomogeneity correction, where only 
                         lower intensities are initially corrected, then higher intensities are iteratively 
                         included to eventually correct the whole image. This technique may help with images with 
                         particularly strong inhomogeneity gradients and very low intensities.
                        *** Specify 'true' or 'false'. 
                        (default: method=SyN,otsu_thresh=2,multiotsu=false)
                        
  --anat_robust_inho_cor ANAT_ROBUST_INHO_COR
                        When selecting this option, inhomogeneity correction is executed twice to optimize 
                        outcomes. After completing an initial inhomogeneity correction step, the corrected outputs 
                        are co-registered to generate an unbiased template, using the same method as the commonspace 
                        registration. This template is then masked, and is used as a new target for masking during a 
                        second iteration of inhomogeneity correction. Using this dataset-specific template should 
                        improve the robustness of masking for inhomogeneity correction.
                        * apply: select 'true' to apply this option. 
                         *** Specify 'true' or 'false'. 
                        * stages: Registration stages for generating the unbiased template. 
                        *** Each stage must be among the following: 'rigid','similarity','affine' or 'nlin' (non-linear). The syntax must follows this example: rigid-affine-nlin. 
                        * masking: Combine masks derived from the inhomogeneity correction step to support 
                         registration during the generation of the unbiased template, and then during template 
                         registration.
                         *** Specify 'true' or 'false'. 
                        * brain_extraction: conducts brain extraction prior to template registration based on the 
                         combined masks from inhomogeneity correction. This will enhance brain edge-matching, but 
                         requires good quality masks. This must be selected along the 'masking' option.
                         *** Specify 'true' or 'false'. 
                        * keep_mask_after_extract: If using brain_extraction, use the mask to compute the registration metric 
                         within the mask only. Choose to prevent stretching of the images beyond the limit of the brain mask 
                         (e.g. if the moving and target images don't have the same brain coverage).
                        *** Specify 'true' or 'false'. 
                        * template_registration: Specify a registration script for the alignment of the 
                         dataset-generated unbiased template to a reference template for masking.
                        *** Rigid: conducts only rigid registration.
                        *** Affine: conducts Rigid then Affine registration.
                        *** SyN: conducts Rigid, Affine then non-linear registration.
                        *** no_reg: skip registration.
                        * winsorize_lower_bound: the lower bound for the antsRegistration winsorize-image-intensities option, useful for fUS images with intensity outliers. 
                        * winsorize_upper_bound: the upper bound for the antsRegistration winsorize-image-intensities option, useful for fUS images with intensity outliers. 
                        (default: apply=false,stages=rigid-affine-nlin,masking=false,brain_extraction=false,keep_mask_after_extract=false,template_registration=SyN,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0)
                        
  --bold_inho_cor BOLD_INHO_COR
                        Same as --anat_inho_cor, but for the EPI images.
                        (default: method=Rigid,otsu_thresh=2,multiotsu=false)
                        
  --bold_robust_inho_cor BOLD_ROBUST_INHO_COR
                        Same as --anat_robust_inho_cor, but for the EPI images.
                        (default: apply=false,stages=rigid-affine-nlin,masking=false,brain_extraction=false,keep_mask_after_extract=false,template_registration=SyN,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0)
                        
  --commonspace_reg COMMONSPACE_REG
                        Specify registration options for the commonspace registration.
                        * stages: Registration stages for generating the unbiased template. 
                        *** Each stage must be among the following: 'rigid','similarity','affine' or 'nlin' (non-linear). The syntax must follows this example: rigid-affine-nlin. 
                        * masking: Combine masks derived from the inhomogeneity correction step to support 
                         registration during the generation of the unbiased template, and then during template 
                         registration.
                        *** Specify 'true' or 'false'. 
                        * brain_extraction: conducts brain extraction prior to template registration based on the 
                         combined masks from inhomogeneity correction. This will enhance brain edge-matching, but 
                         requires good quality masks. This must be selected along the 'masking' option.
                        *** Specify 'true' or 'false'. 
                        * keep_mask_after_extract: If using brain_extraction, use the mask to compute the registration metric 
                         within the mask only. Choose to prevent stretching of the images beyond the limit of the brain mask 
                         (e.g. if the moving and target images don't have the same brain coverage).
                        *** Specify 'true' or 'false'. 
                        * template_registration: Specify a registration script for the alignment of the 
                         dataset-generated unbiased template to the commonspace atlas.
                        *** Rigid: conducts only rigid registration.
                        *** Affine: conducts Rigid then Affine registration.
                        *** SyN: conducts Rigid, Affine then non-linear registration.
                        *** no_reg: skip registration.
                        * fast_commonspace: Skip the generation of a dataset-generated unbiased template, and 
                         instead, register each scan independently directly onto the commonspace atlas, using the 
                         template_registration. This option can be faster, but may decrease the quality of 
                         alignment between subjects. 
                        *** Specify 'true' or 'false'. 
                        * winsorize_lower_bound: the lower bound for the antsRegistration winsorize-image-intensities option, useful for fUS images with intensity outliers. 
                        * winsorize_upper_bound: the upper bound for the antsRegistration winsorize-image-intensities option, useful for fUS images with intensity outliers. 
                        (default: stages=rigid-affine-nlin,masking=false,brain_extraction=false,keep_mask_after_extract=false,template_registration=SyN,fast_commonspace=false,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0)
                        
  --inherit_unbiased_template INHERIT_UNBIASED_TEMPLATE
                        Provide a path to a previous RABIES preprocessing output folder to inherit the unbiased template 
                        generated in that previous run, as well as the registration to the external atlas. In place of 
                        conducting unbiased template generation, each scan is registered to this pre-generated template 
                        with registration parameters that are consistent with that of the previous run. The atlas registration 
                        is also inherited, and won't be conducted again. 
                        By selecting this option, the following preprocessing parameters will be overriden to enforce 
                        consistency with the previous run: --anatomical_resampling, --commonspace_reg, --anat_template, 
                        --brain_mask, --WM_mask, --CSF_mask, --vascular_mask, --labels 
                        (default: none)
                        
  --bold2anat_coreg BOLD2ANAT_COREG
                        Specify the registration script for cross-modal alignment between the EPI and structural
                        images. This operation is responsible for correcting EPI susceptibility distortions.
                        * masking: With this option, the brain masks obtained from the EPI inhomogeneity correction 
                         step are used to support registration.
                        *** Specify 'true' or 'false'. 
                        * brain_extraction: conducts brain extraction prior to registration using the EPI masks from 
                         inhomogeneity correction. This will enhance brain edge-matching, but requires good quality 
                         masks. This must be selected along the 'masking' option.
                        *** Specify 'true' or 'false'. 
                        * winsorize_lower_bound: the lower bound for the antsRegistration winsorize-image-intensities option. 
                        * winsorize_upper_bound: the upper bound for the antsRegistration winsorize-image-intensities option. 
                        * keep_mask_after_extract: If using brain_extraction, use the mask to compute the registration metric 
                         within the mask only. Choose to prevent stretching of the images beyond the limit of the brain mask 
                         (e.g. if the moving and target images don't have the same brain coverage).
                        *** Specify 'true' or 'false'. 
                        * registration: Specify a registration script.
                        *** Rigid: conducts only rigid registration.
                        *** Affine: conducts Rigid then Affine registration.
                        *** SyN: conducts Rigid, Affine then non-linear registration.
                        *** no_reg: skip registration.
                        (default: masking=false,brain_extraction=false,keep_mask_after_extract=false,registration=SyN,winsorize_lower_bound=0.0,winsorize_upper_bound=1.0)
                        

Resampling Options:
  The following options handle resampling to common and/or nativespaces and the resolution for registration.
  The resampling syntax for voxel dimensions must be 'dim1xdim2xdim3' (in mm), follwing the RAS axis convention
  (dim1=Right-Left, dim2=Anterior-Posterior, dim3=Superior-Inferior). If 'inputs_defined'
  is provided instead of axis dimensions, the original dimensions are preserved.

  --resampling_space {common_only,native_only,both}
                        Determine whether preprocessed timeseries should be generated in commonspace only ('common_only'), 
                        nativespace only ('native_only'), or for both native and commonspaces ('both'). Generating timeseries 
                        only in the desired space will save memory and computational time.
                        (default: common_only)
                        
  --nativespace_resampling NATIVESPACE_RESAMPLING
                        Can specify a resampling dimension for the nativespace fMRI outputs.
                        (default: inputs_defined)
                        
  --commonspace_resampling COMMONSPACE_RESAMPLING
                        Can specify a resampling dimension for the commonspace fMRI outputs.
                        (default: inputs_defined)
                        
  --anatomical_resampling ANATOMICAL_RESAMPLING
                        
                        This specifies resampling dimensions for the anatomical registration targets. By 
                        default, images are resampled to isotropic resolution based on the smallest dimension
                        among the provided anatomical images (EPI images instead if --bold_only is True). 
                        Increasing voxel resampling size will increase registration speed at the cost of 
                        accuracy.
                        (default: inputs_defined)
                        

STC Options:
  Specify Slice Timing Correction (STC) info that is fed to AFNI's 3dTshift
  (https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTshift.html). The STC is applied
  in the anterior-posterior orientation, and thus RABIES assumes slices were acquired in
  this direction.

  --apply_STC           Select this option to apply the STC step.
                        (default: False)
                        
  --TR TR               Specify repetition time (TR) in seconds. (e.g. --TR 1.2). 'auto' will read the TR from 
                        the nifti header. 
                        (default: auto)
                        
  --tpattern {alt-z,alt-z2,seq-z,alt+z,alt+z2,seq+z}
                        Specify if interleaved ('alt') or sequential ('seq') acquisition, and specify in which 
                        direction (- or +) to apply the correction. If slices were acquired from front to back, 
                        the correction should be in the negative (-) direction. If slices were collected in an interleaved 
                        order starting with the second or (second-to-last) slice, use 'alt+z2' or 'alt-z2'. Refer to this discussion on the 
                        topic for more information https://github.com/CoBrALab/RABIES/discussions/217.
                        (default: alt-z)
                        
  --stc_axis {X,Y,Z}    Can specify over which axis of the image the STC must be applied. Generally, the correction 
                        should be over the Y axis, which corresponds to the anteroposterior axis in RAS convention. 
                        (default: Y)
                        
  --interp_method {linear,cubic,quintic,heptic,wsinc5,wsinc9,fourier}
                        Can specify the interpolation method used for STC. Polynomial methods (e.g., linear, cubic, etc.) 
                        will introduce greater autocorrelation to the interpolated timeseries, while wsinc and fourier methods 
                        will introduce less (or none). Refer to this discussion on the topic for more information 
                        https://github.com/CoBrALab/RABIES/discussions/267. 
                        (default: fourier)
                        

Template Files:
  Specify commonspace template and associated mask/label files. By default, RABIES
  provides the mouse DSURQE atlas
  https://wiki.mouseimaging.ca/display/MICePub/Mouse+Brain+Atlases.

  --anat_template ANAT_TEMPLATE
                        Anatomical file for the commonspace atlas.
                        (default: /root/.local/share/rabies/DSURQE_40micron_average.nii.gz)
                        
  --brain_mask BRAIN_MASK
                        Brain mask aligned with the template.
                        (default: /root/.local/share/rabies/DSURQE_40micron_mask.nii.gz)
                        
  --WM_mask WM_MASK     (OPTIONAL) White matter mask aligned with the template.
                        If no input is provided and the default --anat_template is not used, 
                        the core pipeline will run, but downstream functions that rely on 
                        this file will be disabled. 
                        (default: /root/.local/share/rabies/DSURQE_40micron_eroded_WM_mask.nii.gz)
                        
  --CSF_mask CSF_MASK   (OPTIONAL) CSF mask aligned with the template.
                        If no input is provided and the default --anat_template is not used, 
                        the core pipeline will run, but downstream functions that rely on 
                        this file will be disabled. 
                        (default: /root/.local/share/rabies/DSURQE_40micron_eroded_CSF_mask.nii.gz)
                        
  --vascular_mask VASCULAR_MASK
                        (OPTIONAL) Can provide a mask of major blood vessels to compute associated nuisance timeseries.
                        The default mask was generated by applying MELODIC ICA and selecting the resulting 
                        component mapping onto major brain vessels.
                        If no input is provided and the default --anat_template is not used, 
                        the core pipeline will run, but downstream functions that rely on 
                        this file will be disabled. 
                        (default: /root/.local/share/rabies/vascular_mask.nii.gz)
                        
  --labels LABELS       (OPTIONAL) Labels file providing the atlas anatomical annotations.
                        If no input is provided and the default --anat_template is not used, 
                        the core pipeline will run, but downstream functions that rely on 
                        this file will be disabled. 
                        (default: /root/.local/share/rabies/DSURQE_40micron_labels.nii.gz)
```


## rabies_confound_correction

### Tool Description
Conduct confound correction and analysis in native space.

### Metadata
- **Docker Image**: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
- **Homepage**: https://github.com/CoBrALab/RABIES
- **Package**: https://anaconda.org/channels/bioconda/packages/rabies/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rabies confound_correction [-h] [--nativespace_analysis]
                                  [--resample_to_commonspace]
                                  [--image_scaling {None,global_variance,voxelwise_standardization,grand_mean_scaling,voxelwise_mean}]
                                  [--scale_variance_voxelwise]
                                  [--detrending DETRENDING]
                                  [--conf_list [{WM_signal,CSF_signal,vascular_signal,global_signal,aCompCor_percent,aCompCor_5,mot_6,mot_24} ...]]
                                  [--frame_censoring FRAME_CENSORING]
                                  [--TR TR] [--highpass HIGHPASS]
                                  [--lowpass LOWPASS]
                                  [--edge_cutoff EDGE_CUTOFF]
                                  [--smoothing_filter SMOOTHING_FILTER]
                                  [--match_number_timepoints]
                                  [--ica_aroma ICA_AROMA] [--read_datasink]
                                  [--timeseries_interval TIMESERIES_INTERVAL]
                                  [--generate_CR_null]
                                  preprocess_out output_dir

positional arguments:
  preprocess_out        path to RABIES preprocessing output directory.
                        
  output_dir            path for confound correction output directory.
                        

optional arguments:
  -h, --help            show this help message and exit
  --nativespace_analysis
                        Conduct confound correction and analysis in native space.
                        (default: False)
                        
  --resample_to_commonspace
                        If using --nativespace_analysis, use this parameter to also generate cleaned timeseries 
                        resampled to commonspace after denoising is carried in nativespace. 
                        Using this option is necessary to enable group ICA at the analysis stage after using --nativespace_analysis.
                        (default: False)
                        
  --image_scaling {None,global_variance,voxelwise_standardization,grand_mean_scaling,voxelwise_mean}
                        Select an option for scaling the image variance to match the intensity profile of 
                        different scans and avoid biases in data variance and amplitude estimation during analysis.
                        The variance explained from confound regression is also scaled accordingly for later use with 
                        --data_diagnosis. 
                        *** None: No scaling is applied, only detrending.
                        *** global_variance: After applying confound correction, the cleaned timeseries are scaled 
                           according to the total standard deviation of all voxels, to scale total variance to 1. 
                        *** voxelwise_standardization: After applying confound correction, each voxel is separately 
                           scaled to unit variance (z-scoring). 
                        *** grand_mean_scaling: Timeseries are divided by the mean signal across voxel, and 
                           multiplied by 100 to obtain percent BOLD fluctuations. 
                        *** voxelwise_mean: each voxel is seperataly scaled according to its mean intensity, 
                           a method suggested with AFNI https://afni.nimh.nih.gov/afni/community/board/read.php?1,161862,161864. 
                           Timeseries are then multiplied by 100 to obtain percent BOLD fluctuations. 
                        (default: grand_mean_scaling)
                        
  --scale_variance_voxelwise
                        
                        If scaling was not applied voxelwise with voxelwise_standardization or voxelwise_mean, this option 
                        standardize the variance at each voxel to be equal, while preserving to total variance of the 
                        4D timeseries (i.e. voxels have same variance, but not unit variance).
                        (default: False)
                        
  --detrending DETRENDING
                        Detrend the voxel timeseries. 
                        * order: Specify the polynomial order for detrending as a integer. 
                        *** 0 for no detrending, 1 for linear detrending, 2 for quadratic etc. 
                        * time_interval: the time interval over which the trend is computed. 
                         Note the trend is always subtracted from the whole timeseries. 
                        *** 0-80 will take the first 80 timepoints (e.g. baseline), compute their trend, then subtract it from the whole timeseries.(default: order=1,time_interval=all)
                        
  --conf_list [{WM_signal,CSF_signal,vascular_signal,global_signal,aCompCor_percent,aCompCor_5,mot_6,mot_24} ...]
                        Select list of nuisance regressors that will be applied on voxel timeseries, i.e., confound
                        regression.
                        *** WM/CSF/vascular/global_signal: correspond to mean signal from WM/CSF/vascular/brain 
                           masks.
                        *** mot_6: 6 rigid head motion correction parameters.
                        *** mot_24: mot_6 + their temporal derivative, then all 12 parameters squared, as in 
                           Friston et al. (1996, Magnetic Resonance in Medicine).
                        *** aCompCor_percent: method from Muschelli et al. (2014, Neuroimage), where component timeseries
                           are obtained using PCA, conducted on the combined WM and CSF masks voxel timeseries. 
                           Components adding up to 50 percent of the variance are included.
                        *** aCompCor_5: aCompCor method, but taking 5 first principal components. 
                        (default: [])
                        
  --frame_censoring FRAME_CENSORING
                        Censor frames that are highly corrupted (i.e. 'scrubbing'). 
                        * FD_censoring: Apply frame censoring based on a framewise displacement threshold. The frames 
                         that exceed the given threshold, together with 1 back and 2 forward frames will be masked 
                         out, as in Power et al. (2012, Neuroimage).
                        *** Specify 'true' or 'false'. 
                        * FD_threshold: the FD threshold in mm. 
                        * DVARS_censoring: Will remove timepoints that present outlier values on the DVARS metric 
                         (temporal derivative of global signal). This method will censor timepoints until the 
                         distribution of DVARS values across time does not contain outliers values above or below 2.5 
                         standard deviations.
                        *** Specify 'true' or 'false'. 
                        * minimum_timepoint: Can set a minimum number of timepoints remaining after frame censoring. 
                         If the threshold is not met, an empty file is generated and the scan is not considered in 
                         further steps. 
                        (default: FD_censoring=false,FD_threshold=0.05,DVARS_censoring=false,minimum_timepoint=3)
                        
  --TR TR               Specify repetition time (TR) in seconds. (e.g. --TR 1.2). 'auto' will read the TR from 
                        the nifti header. 
                        (default: auto)
                        
  --highpass HIGHPASS   Specify highpass filter frequency.
                        (default: None)
                        
  --lowpass LOWPASS     Specify lowpass filter frequency.
                        (default: None)
                        
  --edge_cutoff EDGE_CUTOFF
                        Specify the number of seconds to cut at beginning and end of acquisition if applying a
                        frequency filter. Highpass filters generate edge effects at begining and end of the
                        timeseries. We recommend to cut those timepoints (around 30sec at both end for 0.01Hz 
                        highpass.).
                        (default: 0)
                        
  --smoothing_filter SMOOTHING_FILTER
                        Specify filter size in mm for spatial smoothing. Will apply nilearn's function 
                        https://nilearn.github.io/modules/generated/nilearn.image.smooth_img.html
                        (default: None)
                        
  --match_number_timepoints
                        With this option, only a subset of the timepoints are kept post-censoring to match the 
                        --minimum_timepoint number for all scans. This can be conducted to avoid inconsistent 
                        temporal degrees of freedom (tDOF) between scans during downstream analysis. We recommend 
                        selecting this option if a significant confounding effect of tDOF is detected during --data_diagnosis.
                        The extra timepoints removed are randomly selected among the set available post-censoring.
                        (default: False)
                        
  --ica_aroma ICA_AROMA
                        Apply ICA-AROMA denoising (Pruim et al. 2015). The original classifier was modified to incorporate 
                        rodent-adapted masks and classification hyperparameters.
                        * apply: apply the denoising.
                        *** Specify 'true' or 'false'. 
                        * dim: Specify a pre-determined number of MELODIC components to derive. '0' will use an automatic 
                         estimator. 
                        * random_seed: For reproducibility, this option sets a fixed random seed for MELODIC. 
                        (default: apply=false,dim=0,random_seed=1)
                        
  --read_datasink       
                        Choose this option to read preprocessing outputs from datasinks instead of the saved 
                        preprocessing workflow graph. This allows to run confound correction without having 
                        available RABIES preprocessing folders, but the targetted datasink folders must follow the
                        structure of RABIES preprocessing.
                        (default: False)
                        
  --timeseries_interval TIMESERIES_INTERVAL
                        Before confound correction, can crop the timeseries within a specific interval.
                        e.g. '0,80' for timepoint 0 to 80.
                        (default: all)
                        
  --generate_CR_null    Estimate overfitting from confound regression by generating phase randomised regressors,
                        following the method by Bright and Murphy (2015), NeuroImage. By selecting this option, 
                        an additional figure will be generated to display the variance explained by the real 
                        regressors VS the randomized regressors to assess overfitting. 
                        (default: False)
```


## rabies_analysis

### Tool Description
Performs various neuroimaging analysis tasks, including confound correction, data diagnosis, dual regression, and neural prior recovery.

### Metadata
- **Docker Image**: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
- **Homepage**: https://github.com/CoBrALab/RABIES
- **Package**: https://anaconda.org/channels/bioconda/packages/rabies/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rabies analysis [-h] [--resample_to_commonspace]
                       [--prior_maps PRIOR_MAPS]
                       [--prior_bold_idx [PRIOR_BOLD_IDX ...]]
                       [--prior_confound_idx [PRIOR_CONFOUND_IDX ...]]
                       [--data_diagnosis] [--group_avg_prior]
                       [--scan_QC_thresholds SCAN_QC_THRESHOLDS]
                       [--outlier_threshold OUTLIER_THRESHOLD] [--extended_QC]
                       [--seed_list [SEED_LIST ...]]
                       [--seed_prior_list [SEED_PRIOR_LIST ...]]
                       [--plot_seed_frequencies PLOT_SEED_FREQUENCIES]
                       [--FC_matrix] [--ROI_type {parcellated,voxelwise}]
                       [--ROI_csv ROI_CSV] [--group_ica GROUP_ICA] [--DR_ICA]
                       [--NPR_temporal_comp NPR_TEMPORAL_COMP]
                       [--NPR_spatial_comp NPR_SPATIAL_COMP]
                       [--optimize_NPR OPTIMIZE_NPR]
                       [--network_weighting {absolute,relative}]
                       [--brainmap_percent_threshold BRAINMAP_PERCENT_THRESHOLD]
                       confound_correction_out output_dir

positional arguments:
  confound_correction_out
                        path to RABIES confound correction output directory.
                        
  output_dir            path for analysis outputs.
                        

optional arguments:
  -h, --help            show this help message and exit
  --resample_to_commonspace
                        If the input cleaned timeseries are in nativespace, meaning that connectivity is computed in nativespace, 
                        this option will resample analysis outputs into commonspace (both nativespace and commonspace versions 
                        are thus generated).
                        (default: False)
                        
  --prior_maps PRIOR_MAPS
                        Provide a 4D nifti image with a series of spatial priors representing common sources of
                        signal (e.g. ICA components from a group-ICA run). This 4D prior map file will be used for 
                        Dual regression, Dual ICA and --data_diagnosis. The RABIES default corresponds to a MELODIC 
                        run on a combined group of anesthetized-ventilated and awake mice. Confound correction 
                        consisted of highpass at 0.01 Hz, FD censoring at 0.03mm, DVARS censoring, and 
                        mot_6,WM_signal,CSF_signal as regressors.
                        (default: /root/.local/share/rabies/melodic_IC.nii.gz)
                        
  --prior_bold_idx [PRIOR_BOLD_IDX ...]
                        Specify the indices for the priors corresponding to BOLD sources of interest from --prior_maps. 
                        This will determine the set of networks analyzed for --data_diagnosis. 
                        IMPORTANT: index counting starts at 0 (i.e. the first component is selected with 0, not 1) 
                        SYNTAX: Note that the syntax should follow the example of '--prior_bold_idx 5 12 19', and not 
                        '--prior_bold_idx [5, 12, 19]'. 
                        (default: [5, 12, 19])
                        
  --prior_confound_idx [PRIOR_CONFOUND_IDX ...]
                        Specify the indices for the confound components from --prior_maps. This is pertinent for 
                        evaluating features in the --data_diagnosis outputs.
                        IMPORTANT: index counting starts at 0 (i.e. the first component is selected with 0, not 1) 
                        SYNTAX: Note that the syntax should follow the example of '--prior_bold_idx 5 12 19', and not 
                        '--prior_bold_idx [5, 12, 19]'. 
                        (default: [0, 2, 6, 7, 8, 9, 10, 11, 13, 14, 21, 22, 24, 26, 28, 29])
                        
  --data_diagnosis      Generates a set of data quality assessment reports as described in Desrosiers-Gregoire et al. 2024. 
                        These reports aim to support interpreting connectivity results and account for data quality issues, 
                        and include: 1) a scan-level qualitative diagnosis report, 2) a quantitative distribution report, 3) a 
                        group-level statistical report for network analysis. 
                        Note that all brain maps are displayed in commonspace, and analysis outputs in nativespace are thus 
                        first resampled before plotting.
                        (default: False)
                        
  --group_avg_prior     Select this option to use the group average (the median across subject) as a reference prior network map 
                        instead of providing an external image. This option will circumvent --seed_prior_list, and the ICA 
                        components selected with --prior_bold_idx won't be used for computing Dice overlap measures during QC. 
                        (default: False)
                        
  --scan_QC_thresholds SCAN_QC_THRESHOLDS
                        Option to specify scan-level thresholds to remove scans from the dataset QC report.
                        This can be specified for a given set of network analyses among DR (dual regression), SBC (seed 
                        connectivity), or NPR. For each analysis, the following QC parameters can be specified: 
                        * Dice: Threshold for the minimum network detectability computed as Dice overlap with the prior. 
                        *** Specify a list of thresholds between 0 and 1. The order of thresholds provided within the list 
                            will be matched to the list of networks for the corresponding analysis (for DR/NPR, this 
                            will be matched to the --prior_bold_idx list, and for SBC it will be matched to --seed_list). 
                            If the list is empty, no thresholding is applied, otherwise, the length of the lists for the  
                            thresholds and networks must match. 
                        * Conf: Threshold for the maximum temporal correlation with DR confound timecourses. 
                        *** Specify a list of thresholds between 0 and 1. The same rules as Dice are followed for specifying 
                            the order of thresholds within the list. 
                        * Amp: Whether to automatically remove outliers from the network amplitude measure. 
                        *** Specify 'true' or 'false'. 
                        The expression for the parameters must follow a dictionary syntax, as with this example:  
                        '{DR:{Dice:[0.3],Conf:[0.25],Amp:false},SBC:{Dice:[0.3]}}'. 
                        Note that the expression must be written within ' '.
                        (default: {})
                        
  --outlier_threshold OUTLIER_THRESHOLD
                        The modified Z-score threshold for detecting outliers during dataset QC when using 
                        --data_diagnosis. The default of 3.5 is recommended in https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h.htm. 
                        (default: 3.5)
                        
  --extended_QC         Select this option to output the network correlation with the original image intensity (calculated 
                        during detrending) and the BOLDsd (signal variability). These two additional features allow to 
                        further inspect potential issues of signal amplitude scaling between scans. However, it is unclear 
                        whether signal of interest (i.e. neural metabolism) contribute to each measure, so these outputs should 
                        be interpreted with caution. 
                        (default: False)
                        
  --seed_list [SEED_LIST ...]
                        Can provide a list of Nifti files providing a mask for an anatomical seed, which will be used
                        to evaluate seed-based connectivity maps using on Pearson's r. Each seed must consist of 
                        a binary mask representing the ROI in commonspace.
                        (default: [])
                        
  --seed_prior_list [SEED_PRIOR_LIST ...]
                        For analysis QC of seed-based FC during --data_diagnosis, prior network maps are required for 
                        each seed provided in --seed_list. Provide the list of prior files in matching order of the 
                        --seed_list arguments to match corresponding seed maps.
                        (default: [])
                        
  --plot_seed_frequencies PLOT_SEED_FREQUENCIES
                        With this option it is possible to plot the frequency spectrum of specific seed timecourses obtained from 
                        --seed_list in the --data_diagnosis report. 
                        The input must follow this example syntax SS=0,ACA=1, which defines a set of seed_name=seed_index (e.g. SS=0) 
                        pairs, where the seed name will be used for plotting in the legend and the seed index (starting from 0) will 
                        select the associated seed from --seed_list based on the order of seed provided. 
                        (default: )
                        
  --FC_matrix           Compute whole-brain connectivity matrices using Pearson's r between ROI timeseries.
                        (default: False)
                        
  --ROI_type {parcellated,voxelwise}
                        Define ROIs for --FC_matrix between 'parcellated' from the provided atlas during preprocessing,
                        or 'voxelwise' to derive the correlations between every voxel.(default: parcellated)
                        
  --ROI_csv ROI_CSV     A CSV file with the ROI names matching the ROI index numbers in the atlas labels Nifti file. 
                        A copy of this file is provided along the FC matrix generated for each subject.
                        (default: /root/.local/share/rabies/DSURQE_40micron_R_mapping.csv)
                        
  --group_ica GROUP_ICA
                        Perform group-ICA using FSL's MELODIC on the whole dataset's cleaned timeseries.
                        Note that confound correction must have been conducted on commonspace outputs.
                        * apply: compute group-ICA.
                        *** Specify 'true' or 'false'. 
                        * dim: Specify a pre-determined number of MELODIC components to derive. '0' will use an automatic 
                         estimator. 
                        * random_seed: For reproducibility, this option sets a fixed random seed for MELODIC. 
                        * disableMigp: Whether to disable the MIGP method for lowering the memory load of data concatenation. 
                        (default: apply=false,dim=0,random_seed=1,disableMigp=false)
                        
  --DR_ICA              Conduct dual regression on each subject timeseries, using the priors from --prior_maps. The
                        linear coefficients from both the first and second regressions will be provided as outputs.
                        Requires that confound correction was conducted on commonspace outputs.
                        (default: False)
                        
  --NPR_temporal_comp NPR_TEMPORAL_COMP
                        Option for performing Neural Prior Recovery (NPR). Specify with this option how many extra 
                        subject-specific sources will be computed to account for non-prior confounds. This options 
                        specifies the number of temporal components to compute. After computing 
                        these sources, NPR will provide a fit for each prior in --prior_maps indexed by --prior_bold_idx.
                        Specify at least 0 extra sources to run NPR.
                        (default: -1)
                        
  --NPR_spatial_comp NPR_SPATIAL_COMP
                        Same as --NPR_temporal_comp, but specify how many spatial components to compute (which are 
                        additioned to the temporal components).
                        (default: -1)
                        
  --optimize_NPR OPTIMIZE_NPR
                        This option handles the automated dimensionality estimation when carrying out NPR. NPR will be 
                        carried out iteratively while incrementing the number of non-prior components fitted, until 
                        convergence criteria are met (see below). A convergence report is generated to visualize the 
                        results across iterations. 
                        
                        Convergence criterion 1: Iterations continue until the correlation between the fitted component 
                        and the prior does not reach the specified minimum.
                        
                        Convergence Criterion 2: At each iteration, the difference between the previous and new output 
                        is evaluated (0=perfectly correlated; 1=uncorrelated). The forming set of successive iterations 
                        (within a certain window length) is evaluated, and when a set respects the convergence threshold 
                        for each iteration within the window, the iteration preceding that window is selected as optimal 
                        output. We take the iteration preceding the  window, as this corresponds to the last iteration 
                        which generated changes above threshold. The sliding-window approach is employed to prevent 
                        falling within a local minima, when further ameliorations may be possible with further iterations.
                        
                        When multiple priors are fitted, they are all simultaneously subjected to the evaluation of 
                        convergence, and as long as one prior fit does not meet the thresholds, iterations continue.
                        
                        * apply: select 'true' to apply this option. If selected, this option overrides --NPR_spatial_comp 
                         and --NPR_spatial_comp. 
                        *** Specify 'true' or 'false'. 
                        * window_size: Window size for criterion 2. 
                        *** Must provide an integer. 
                        * min_prior_corr: Threshold for criterion 1. 
                        *** Must provide a float. 
                        * diff_thresh: Threshold for criterion 2. 
                        *** Must provide a float. 
                        * max_iter: Maximum number of iterations. 
                        *** Must provide an integer. 
                        * compute_max: select 'true' to visualize all iterations until max_iter in the report. 
                        *** Specify 'true' or 'false'. 
                        (default: apply=false,window_size=5,min_prior_corr=0.5,diff_thresh=0.03,max_iter=20,compute_max=false)
                        
  --network_weighting {absolute,relative}
                        Whether to derive absolute or relative (variance-normalized) network maps, representing 
                        respectively network amplitude + shape or network shape only. This option applies to both 
                        dual regression (DR) and Neural Prior Recovery (NPR) analyses. 
                        (default: absolute)
                        
  --brainmap_percent_threshold BRAINMAP_PERCENT_THRESHOLD
                        Specify the percentage of voxels with highest intensity included when thresholding brain maps 
                        (e.g. an input of 10 means that the top 10 percent of voxels with highest values are included).
                        This is used within --data_diagnosis for plotting brain maps and computing Dice overlap coefficients. 
                        (default: 10)
```

