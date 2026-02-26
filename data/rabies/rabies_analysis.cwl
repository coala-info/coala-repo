cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabies analysis
label: rabies_analysis
doc: "Performs various neuroimaging analysis tasks, including confound correction,
  data diagnosis, dual regression, and neural prior recovery.\n\nTool homepage: https://github.com/CoBrALab/RABIES"
inputs:
  - id: confound_correction_out
    type: Directory
    doc: path to RABIES confound correction output directory.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: path for analysis outputs.
    inputBinding:
      position: 2
  - id: brainmap_percent_threshold
    type:
      - 'null'
      - int
    doc: Specify the percentage of voxels with highest intensity included when 
      thresholding brain maps (e.g. an input of 10 means that the top 10 percent
      of voxels with highest values are included). This is used within 
      --data_diagnosis for plotting brain maps and computing Dice overlap 
      coefficients.
    default: 10
    inputBinding:
      position: 103
      prefix: --brainmap_percent_threshold
  - id: data_diagnosis
    type:
      - 'null'
      - boolean
    doc: 'Generates a set of data quality assessment reports as described in Desrosiers-Gregoire
      et al. 2024. These reports aim to support interpreting connectivity results
      and account for data quality issues, and include: 1) a scan-level qualitative
      diagnosis report, 2) a quantitative distribution report, 3) a group-level statistical
      report for network analysis. Note that all brain maps are displayed in commonspace,
      and analysis outputs in nativespace are thus first resampled before plotting.'
    default: false
    inputBinding:
      position: 103
      prefix: --data_diagnosis
  - id: dr_ica
    type:
      - 'null'
      - boolean
    doc: Conduct dual regression on each subject timeseries, using the priors 
      from --prior_maps. The linear coefficients from both the first and second 
      regressions will be provided as outputs. Requires that confound correction
      was conducted on commonspace outputs.
    default: false
    inputBinding:
      position: 103
      prefix: --DR_ICA
  - id: extended_qc
    type:
      - 'null'
      - boolean
    doc: Select this option to output the network correlation with the original 
      image intensity (calculated during detrending) and the BOLDsd (signal 
      variability). These two additional features allow to further inspect 
      potential issues of signal amplitude scaling between scans. However, it is
      unclear whether signal of interest (i.e. neural metabolism) contribute to 
      each measure, so these outputs should be interpreted with caution.
    default: false
    inputBinding:
      position: 103
      prefix: --extended_QC
  - id: fc_matrix
    type:
      - 'null'
      - boolean
    doc: Compute whole-brain connectivity matrices using Pearson's r between ROI
      timeseries.
    default: false
    inputBinding:
      position: 103
      prefix: --FC_matrix
  - id: group_avg_prior
    type:
      - 'null'
      - boolean
    doc: Select this option to use the group average (the median across subject)
      as a reference prior network map instead of providing an external image. 
      This option will circumvent --seed_prior_list, and the ICA components 
      selected with --prior_bold_idx won't be used for computing Dice overlap 
      measures during QC.
    default: false
    inputBinding:
      position: 103
      prefix: --group_avg_prior
  - id: group_ica
    type:
      - 'null'
      - string
    doc: "Perform group-ICA using FSL's MELODIC on the whole dataset's cleaned timeseries.
      Note that confound correction must have been conducted on commonspace outputs.
      * apply: compute group-ICA. *** Specify 'true' or 'false'. * dim: Specify a
      pre-determined number of MELODIC components to derive. '0' will use an automatic
      estimator. * random_seed: For reproducibility, this option sets a fixed random
      seed for MELODIC. * disableMigp: Whether to disable the MIGP method for lowering
      the memory load of data concatenation."
    default: apply=false,dim=0,random_seed=1,disableMigp=false
    inputBinding:
      position: 103
      prefix: --group_ica
  - id: network_weighting
    type:
      - 'null'
      - string
    doc: Whether to derive absolute or relative (variance-normalized) network 
      maps, representing respectively network amplitude + shape or network shape
      only. This option applies to both dual regression (DR) and Neural Prior 
      Recovery (NPR) analyses.
    default: absolute
    inputBinding:
      position: 103
      prefix: --network_weighting
  - id: npr_spatial_comp
    type:
      - 'null'
      - int
    doc: Same as --NPR_temporal_comp, but specify how many spatial components to
      compute (which are additioned to the temporal components).
    default: -1
    inputBinding:
      position: 103
      prefix: --NPR_spatial_comp
  - id: npr_temporal_comp
    type:
      - 'null'
      - int
    doc: Option for performing Neural Prior Recovery (NPR). Specify with this 
      option how many extra subject-specific sources will be computed to account
      for non-prior confounds. This options specifies the number of temporal 
      components to compute. After computing these sources, NPR will provide a 
      fit for each prior in --prior_maps indexed by --prior_bold_idx. Specify at
      least 0 extra sources to run NPR.
    default: -1
    inputBinding:
      position: 103
      prefix: --NPR_temporal_comp
  - id: optimize_npr
    type:
      - 'null'
      - string
    doc: "This option handles the automated dimensionality estimation when carrying
      out NPR. NPR will be carried out iteratively while incrementing the number of
      non-prior components fitted, until convergence criteria are met (see below).
      A convergence report is generated to visualize the results across iterations.
      Convergence criterion 1: Iterations continue until the correlation between the
      fitted component and the prior does not reach the specified minimum. Convergence
      Criterion 2: At each iteration, the difference between the previous and new
      output is evaluated (0=perfectly correlated; 1=uncorrelated). The forming set
      of successive iterations (within a certain window length) is evaluated, and
      when a set respects the convergence threshold for each iteration within the
      window, the iteration preceding that window is selected as optimal output. We
      take the iteration preceding the window, as this corresponds to the last iteration
      which generated changes above threshold. The sliding-window approach is employed
      to prevent falling within a local minima, when further ameliorations may be
      possible with further iterations. When multiple priors are fitted, they are
      all simultaneously subjected to the evaluation of convergence, and as long as
      one prior fit does not meet the thresholds, iterations continue. * apply: select
      'true' to apply this option. If selected, this option overrides --NPR_spatial_comp
      and --NPR_spatial_comp. *** Specify 'true' or 'false'. * window_size: Window
      size for criterion 2. *** Must provide an integer. * min_prior_corr: Threshold
      for criterion 1. *** Must provide a float. * diff_thresh: Threshold for criterion
      2. *** Must provide a float. * max_iter: Maximum number of iterations. *** Must
      provide an integer. * compute_max: select 'true' to visualize all iterations
      until max_iter in the report. *** Specify 'true' or 'false'."
    default: 
      apply=false,window_size=5,min_prior_corr=0.5,diff_thresh=0.03,max_iter=20,compute_max=false
    inputBinding:
      position: 103
      prefix: --optimize_NPR
  - id: outlier_threshold
    type:
      - 'null'
      - float
    doc: The modified Z-score threshold for detecting outliers during dataset QC
      when using --data_diagnosis. The default of 3.5 is recommended in 
      https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h.htm.
    default: 3.5
    inputBinding:
      position: 103
      prefix: --outlier_threshold
  - id: plot_seed_frequencies
    type:
      - 'null'
      - string
    doc: With this option it is possible to plot the frequency spectrum of 
      specific seed timecourses obtained from --seed_list in the 
      --data_diagnosis report. The input must follow this example syntax 
      SS=0,ACA=1, which defines a set of seed_name=seed_index (e.g. SS=0) pairs,
      where the seed name will be used for plotting in the legend and the seed 
      index (starting from 0) will select the associated seed from --seed_list 
      based on the order of seed provided.
    default: ''
    inputBinding:
      position: 103
      prefix: --plot_seed_frequencies
  - id: prior_bold_idx
    type:
      - 'null'
      - type: array
        items: int
    doc: "Specify the indices for the priors corresponding to BOLD sources of interest
      from --prior_maps. This will determine the set of networks analyzed for --data_diagnosis.
      IMPORTANT: index counting starts at 0 (i.e. the first component is selected
      with 0, not 1) SYNTAX: Note that the syntax should follow the example of '--prior_bold_idx
      5 12 19', and not '--prior_bold_idx [5, 12, 19]'."
    default:
      - 5
      - 12
      - 19
    inputBinding:
      position: 103
      prefix: --prior_bold_idx
  - id: prior_confound_idx
    type:
      - 'null'
      - type: array
        items: int
    doc: "Specify the indices for the confound components from --prior_maps. This
      is pertinent for evaluating features in the --data_diagnosis outputs. IMPORTANT:
      index counting starts at 0 (i.e. the first component is selected with 0, not
      1) SYNTAX: Note that the syntax should follow the example of '--prior_bold_idx
      5 12 19', and not '--prior_bold_idx [5, 12, 19]'."
    default:
      - 0
      - 2
      - 6
      - 7
      - 8
      - 9
      - 10
      - 11
      - 13
      - 14
      - 21
      - 22
      - 24
      - 26
      - 28
      - 29
    inputBinding:
      position: 103
      prefix: --prior_confound_idx
  - id: prior_maps
    type:
      - 'null'
      - File
    doc: Provide a 4D nifti image with a series of spatial priors representing 
      common sources of signal (e.g. ICA components from a group-ICA run). This 
      4D prior map file will be used for Dual regression, Dual ICA and 
      --data_diagnosis. The RABIES default corresponds to a MELODIC run on a 
      combined group of anesthetized-ventilated and awake mice. Confound 
      correction consisted of highpass at 0.01 Hz, FD censoring at 0.03mm, DVARS
      censoring, and mot_6,WM_signal,CSF_signal as regressors.
    default: /root/.local/share/rabies/melodic_IC.nii.gz
    inputBinding:
      position: 103
      prefix: --prior_maps
  - id: resample_to_commonspace
    type:
      - 'null'
      - boolean
    doc: If the input cleaned timeseries are in nativespace, meaning that 
      connectivity is computed in nativespace, this option will resample 
      analysis outputs into commonspace (both nativespace and commonspace 
      versions are thus generated).
    default: false
    inputBinding:
      position: 103
      prefix: --resample_to_commonspace
  - id: roi_csv
    type:
      - 'null'
      - File
    doc: A CSV file with the ROI names matching the ROI index numbers in the 
      atlas labels Nifti file. A copy of this file is provided along the FC 
      matrix generated for each subject.
    default: /root/.local/share/rabies/DSURQE_40micron_R_mapping.csv
    inputBinding:
      position: 103
      prefix: --ROI_csv
  - id: roi_type
    type:
      - 'null'
      - string
    doc: Define ROIs for --FC_matrix between 'parcellated' from the provided 
      atlas during preprocessing, or 'voxelwise' to derive the correlations 
      between every voxel.
    default: parcellated
    inputBinding:
      position: 103
      prefix: --ROI_type
  - id: scan_qc_thresholds
    type:
      - 'null'
      - string
    doc: "Option to specify scan-level thresholds to remove scans from the dataset
      QC report. This can be specified for a given set of network analyses among DR
      (dual regression), SBC (seed connectivity), or NPR. For each analysis, the following
      QC parameters can be specified: * Dice: Threshold for the minimum network detectability
      computed as Dice overlap with the prior. *** Specify a list of thresholds between
      0 and 1. The order of thresholds provided within the list will be matched to
      the list of networks for the corresponding analysis (for DR/NPR, this will be
      matched to the --prior_bold_idx list, and for SBC it will be matched to --seed_list).
      If the list is empty, no thresholding is applied, otherwise, the length of the
      lists for the thresholds and networks must match. * Conf: Threshold for the
      maximum temporal correlation with DR confound timecourses. *** Specify a list
      of thresholds between 0 and 1. The same rules as Dice are followed for specifying
      the order of thresholds within the list. * Amp: Whether to automatically remove
      outliers from the network amplitude measure. *** Specify 'true' or 'false'.
      The expression for the parameters must follow a dictionary syntax, as with this
      example: '{DR:{Dice:[0.3],Conf:[0.25],Amp:false},SBC:{Dice:[0.3]}}'. Note that
      the expression must be written within ' '."
    default: '{}'
    inputBinding:
      position: 103
      prefix: --scan_QC_thresholds
  - id: seed_list
    type:
      - 'null'
      - type: array
        items: File
    doc: Can provide a list of Nifti files providing a mask for an anatomical 
      seed, which will be used to evaluate seed-based connectivity maps using on
      Pearson's r. Each seed must consist of a binary mask representing the ROI 
      in commonspace.
    default: []
    inputBinding:
      position: 103
      prefix: --seed_list
  - id: seed_prior_list
    type:
      - 'null'
      - type: array
        items: File
    doc: For analysis QC of seed-based FC during --data_diagnosis, prior network
      maps are required for each seed provided in --seed_list. Provide the list 
      of prior files in matching order of the --seed_list arguments to match 
      corresponding seed maps.
    default: []
    inputBinding:
      position: 103
      prefix: --seed_prior_list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
stdout: rabies_analysis.out
