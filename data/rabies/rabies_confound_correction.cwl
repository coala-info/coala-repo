cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabies confound_correction
label: rabies_confound_correction
doc: "Conduct confound correction and analysis in native space.\n\nTool homepage:
  https://github.com/CoBrALab/RABIES"
inputs:
  - id: preprocess_out
    type: Directory
    doc: path to RABIES preprocessing output directory.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: path for confound correction output directory.
    inputBinding:
      position: 2
  - id: TR
    type:
      - 'null'
      - string
    doc: Specify repetition time (TR) in seconds. (e.g. --TR 1.2). 'auto' will 
      read the TR from the nifti header.
    default: auto
    inputBinding:
      position: 103
      prefix: --TR
  - id: conf_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Select list of nuisance regressors that will be applied on voxel timeseries,
      i.e., confound regression. *** WM/CSF/vascular/global_signal: correspond to
      mean signal from WM/CSF/vascular/brain masks. *** mot_6: 6 rigid head motion
      correction parameters. *** mot_24: mot_6 + their temporal derivative, then all
      12 parameters squared, as in Friston et al. (1996, Magnetic Resonance in Medicine).
      *** aCompCor_percent: method from Muschelli et al. (2014, Neuroimage), where
      component timeseries are obtained using PCA, conducted on the combined WM and
      CSF masks voxel timeseries. Components adding up to 50 percent of the variance
      are included. *** aCompCor_5: aCompCor method, but taking 5 first principal
      components.'
    default: []
    inputBinding:
      position: 103
      prefix: --conf_list
  - id: detrending
    type:
      - 'null'
      - string
    doc: 'Detrend the voxel timeseries. * order: Specify the polynomial order for
      detrending as a integer. *** 0 for no detrending, 1 for linear detrending, 2
      for quadratic etc. * time_interval: the time interval over which the trend is
      computed. Note the trend is always subtracted from the whole timeseries. ***
      0-80 will take the first 80 timepoints (e.g. baseline), compute their trend,
      then subtract it from the whole timeseries.'
    default: order=1,time_interval=all
    inputBinding:
      position: 103
      prefix: --detrending
  - id: edge_cutoff
    type:
      - 'null'
      - float
    doc: Specify the number of seconds to cut at beginning and end of 
      acquisition if applying a frequency filter. Highpass filters generate edge
      effects at begining and end of the timeseries. We recommend to cut those 
      timepoints (around 30sec at both end for 0.01Hz highpass.).
    default: 0
    inputBinding:
      position: 103
      prefix: --edge_cutoff
  - id: frame_censoring
    type:
      - 'null'
      - string
    doc: "Censor frames that are highly corrupted (i.e. 'scrubbing'). * FD_censoring:
      Apply frame censoring based on a framewise displacement threshold. The frames
      that exceed the given threshold, together with 1 back and 2 forward frames will
      be masked out, as in Power et al. (2012, Neuroimage). *** Specify 'true' or
      'false'. * FD_threshold: the FD threshold in mm. * DVARS_censoring: Will remove
      timepoints that present outlier values on the DVARS metric (temporal derivative
      of global signal). This method will censor timepoints until the distribution
      of DVARS values across time does not contain outliers values above or below
      2.5 standard deviations. *** Specify 'true' or 'false'. * minimum_timepoint:
      Can set a minimum number of timepoints remaining after frame censoring. If the
      threshold is not met, an empty file is generated and the scan is not considered
      in further steps."
    default: 
      FD_censoring=false,FD_threshold=0.05,DVARS_censoring=false,minimum_timepoint=3
    inputBinding:
      position: 103
      prefix: --frame_censoring
  - id: generate_CR_null
    type:
      - 'null'
      - boolean
    doc: Estimate overfitting from confound regression by generating phase 
      randomised regressors, following the method by Bright and Murphy (2015), 
      NeuroImage. By selecting this option, an additional figure will be 
      generated to display the variance explained by the real regressors VS the 
      randomized regressors to assess overfitting.
    default: false
    inputBinding:
      position: 103
      prefix: --generate_CR_null
  - id: highpass
    type:
      - 'null'
      - string
    doc: Specify highpass filter frequency.
    default: None
    inputBinding:
      position: 103
      prefix: --highpass
  - id: ica_aroma
    type:
      - 'null'
      - string
    doc: "Apply ICA-AROMA denoising (Pruim et al. 2015). The original classifier was
      modified to incorporate rodent-adapted masks and classification hyperparameters.
      * apply: apply the denoising. *** Specify 'true' or 'false'. * dim: Specify
      a pre-determined number of MELODIC components to derive. '0' will use an automatic
      estimator. * random_seed: For reproducibility, this option sets a fixed random
      seed for MELODIC."
    default: apply=false,dim=0,random_seed=1
    inputBinding:
      position: 103
      prefix: --ica_aroma
  - id: image_scaling
    type:
      - 'null'
      - string
    doc: 'Select an option for scaling the image variance to match the intensity profile
      of different scans and avoid biases in data variance and amplitude estimation
      during analysis. The variance explained from confound regression is also scaled
      accordingly for later use with --data_diagnosis. *** None: No scaling is applied,
      only detrending. *** global_variance: After applying confound correction, the
      cleaned timeseries are scaled according to the total standard deviation of all
      voxels, to scale total variance to 1. *** voxelwise_standardization: After applying
      confound correction, each voxel is separately scaled to unit variance (z-scoring).
      *** grand_mean_scaling: Timeseries are divided by the mean signal across voxel,
      and multiplied by 100 to obtain percent BOLD fluctuations. *** voxelwise_mean:
      each voxel is seperataly scaled according to its mean intensity, a method suggested
      with AFNI https://afni.nimh.nih.gov/afni/community/board/read.php?1,161862,161864.
      Timeseries are then multiplied by 100 to obtain percent BOLD fluctuations.'
    default: grand_mean_scaling
    inputBinding:
      position: 103
      prefix: --image_scaling
  - id: lowpass
    type:
      - 'null'
      - string
    doc: Specify lowpass filter frequency.
    default: None
    inputBinding:
      position: 103
      prefix: --lowpass
  - id: match_number_timepoints
    type:
      - 'null'
      - boolean
    doc: With this option, only a subset of the timepoints are kept 
      post-censoring to match the --minimum_timepoint number for all scans. This
      can be conducted to avoid inconsistent temporal degrees of freedom (tDOF) 
      between scans during downstream analysis. We recommend selecting this 
      option if a significant confounding effect of tDOF is detected during 
      --data_diagnosis. The extra timepoints removed are randomly selected among
      the set available post-censoring.
    default: false
    inputBinding:
      position: 103
      prefix: --match_number_timepoints
  - id: nativespace_analysis
    type:
      - 'null'
      - boolean
    doc: Conduct confound correction and analysis in native space.
    default: false
    inputBinding:
      position: 103
      prefix: --nativespace_analysis
  - id: read_datasink
    type:
      - 'null'
      - boolean
    doc: Choose this option to read preprocessing outputs from datasinks instead
      of the saved preprocessing workflow graph. This allows to run confound 
      correction without having available RABIES preprocessing folders, but the 
      targetted datasink folders must follow the structure of RABIES 
      preprocessing.
    default: false
    inputBinding:
      position: 103
      prefix: --read_datasink
  - id: resample_to_commonspace
    type:
      - 'null'
      - boolean
    doc: If using --nativespace_analysis, use this parameter to also generate 
      cleaned timeseries resampled to commonspace after denoising is carried in 
      nativespace. Using this option is necessary to enable group ICA at the 
      analysis stage after using --nativespace_analysis.
    default: false
    inputBinding:
      position: 103
      prefix: --resample_to_commonspace
  - id: scale_variance_voxelwise
    type:
      - 'null'
      - boolean
    doc: If scaling was not applied voxelwise with voxelwise_standardization or 
      voxelwise_mean, this option standardize the variance at each voxel to be 
      equal, while preserving to total variance of the 4D timeseries (i.e. 
      voxels have same variance, but not unit variance).
    default: false
    inputBinding:
      position: 103
      prefix: --scale_variance_voxelwise
  - id: smoothing_filter
    type:
      - 'null'
      - string
    doc: Specify filter size in mm for spatial smoothing. Will apply nilearn's 
      function 
      https://nilearn.github.io/modules/generated/nilearn.image.smooth_img.html
    default: None
    inputBinding:
      position: 103
      prefix: --smoothing_filter
  - id: timeseries_interval
    type:
      - 'null'
      - string
    doc: Before confound correction, can crop the timeseries within a specific 
      interval. e.g. '0,80' for timepoint 0 to 80.
    default: all
    inputBinding:
      position: 103
      prefix: --timeseries_interval
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
stdout: rabies_confound_correction.out
