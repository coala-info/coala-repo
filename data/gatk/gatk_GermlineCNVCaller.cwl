cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - GermlineCNVCaller
label: gatk_GermlineCNVCaller
doc: Calls copy-number variants in germline samples given their counts and the 
  output of DetermineGermlineContigPloidy
inputs:
  - id: contig_ploidy_calls
    type: Directory
    doc: Input contig-ploidy calls directory (output of 
      DetermineGermlineContigPloidy).
    inputBinding:
      position: 101
      prefix: --contig-ploidy-calls
  - id: input
    type:
      type: array
      items: string
    doc: Input paths for read-count files containing integer read counts in 
      genomic intervals for all samples.
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output directory. This will be created if it does not exist.
    inputBinding:
      position: 101
      prefix: --output
  - id: output_prefix
    type: string
    doc: Prefix for output filenames.
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: run_mode
    type: string
    doc: 'Tool run-mode. Possible values: {COHORT, CASE}'
    inputBinding:
      position: 101
      prefix: --run-mode
  - id: active_class_padding_hybrid_mode
    type:
      - 'null'
      - int
    doc: If copy-number-posterior-expectation-mode is set to HYBRID, CNV-active 
      intervals determined at any time will be padded by this value (in the 
      units of bp).
    inputBinding:
      position: 101
      prefix: --active-class-padding-hybrid-mode
  - id: adamax_beta_1
    type:
      - 'null'
      - float
    doc: Adamax optimizer first moment estimation forgetting factor.
    inputBinding:
      position: 101
      prefix: --adamax-beta-1
  - id: adamax_beta_2
    type:
      - 'null'
      - float
    doc: Adamax optimizer second moment estimation forgetting factor.
    inputBinding:
      position: 101
      prefix: --adamax-beta-2
  - id: annotated_intervals
    type:
      - 'null'
      - File
    doc: Input annotated-intervals file containing annotations for GC content in
      genomic intervals (output of AnnotateIntervals).
    inputBinding:
      position: 101
      prefix: --annotated-intervals
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: caller_external_admixing_rate
    type:
      - 'null'
      - float
    doc: Admixing ratio of new and old called posteriors after convergence.
    inputBinding:
      position: 101
      prefix: --caller-external-admixing-rate
  - id: caller_internal_admixing_rate
    type:
      - 'null'
      - float
    doc: Admixing ratio of new and old called posteriors for internal 
      convergence loops.
    inputBinding:
      position: 101
      prefix: --caller-internal-admixing-rate
  - id: caller_update_convergence_threshold
    type:
      - 'null'
      - float
    doc: Maximum tolerated calling update size for convergence.
    inputBinding:
      position: 101
      prefix: --caller-update-convergence-threshold
  - id: class_coherence_length
    type:
      - 'null'
      - float
    doc: Coherence length of CNV-active and CNV-silent domains (in the units of 
      bp).
    inputBinding:
      position: 101
      prefix: --class-coherence-length
  - id: cnv_coherence_length
    type:
      - 'null'
      - float
    doc: Coherence length of CNV events (in the units of bp).
    inputBinding:
      position: 101
      prefix: --cnv-coherence-length
  - id: convergence_snr_averaging_window
    type:
      - 'null'
      - int
    doc: Averaging window for calculating training signal-to-noise ratio (SNR) 
      for convergence checking.
    inputBinding:
      position: 101
      prefix: --convergence-snr-averaging-window
  - id: convergence_snr_countdown_window
    type:
      - 'null'
      - int
    doc: The number of ADVI iterations during which the SNR is required to stay 
      below the set threshold for convergence.
    inputBinding:
      position: 101
      prefix: --convergence-snr-countdown-window
  - id: convergence_snr_trigger_threshold
    type:
      - 'null'
      - float
    doc: The SNR threshold to be reached before triggering the convergence 
      countdown.
    inputBinding:
      position: 101
      prefix: --convergence-snr-trigger-threshold
  - id: copy_number_posterior_expectation_mode
    type:
      - 'null'
      - string
    doc: 'The strategy for calculating copy number posterior expectations in the coverage
      denoising model. Possible values: {MAP, EXACT, HYBRID}'
    inputBinding:
      position: 101
      prefix: --copy-number-posterior-expectation-mode
  - id: depth_correction_tau
    type:
      - 'null'
      - float
    doc: Precision of read depth pinning to its global value.
    inputBinding:
      position: 101
      prefix: --depth-correction-tau
  - id: disable_annealing
    type:
      - 'null'
      - boolean
    doc: Disable annealing.
    inputBinding:
      position: 101
      prefix: --disable-annealing
  - id: disable_caller
    type:
      - 'null'
      - boolean
    doc: Disable caller.
    inputBinding:
      position: 101
      prefix: --disable-caller
  - id: disable_sampler
    type:
      - 'null'
      - boolean
    doc: Disable sampler.
    inputBinding:
      position: 101
      prefix: --disable-sampler
  - id: enable_bias_factors
    type:
      - 'null'
      - boolean
    doc: Enable discovery of bias factors.
    inputBinding:
      position: 101
      prefix: --enable-bias_factors
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --exclude-intervals
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: gc_curve_standard_deviation
    type:
      - 'null'
      - float
    doc: Prior standard deviation of the GC curve from flat.
    inputBinding:
      position: 101
      prefix: --gc-curve-standard-deviation
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 101
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: init_ard_rel_unexplained_variance
    type:
      - 'null'
      - float
    doc: Initial value of ARD prior precisions relative to the scale of 
      interval-specific unexplained variance.
    inputBinding:
      position: 101
      prefix: --init-ard-rel-unexplained-variance
  - id: initial_temperature
    type:
      - 'null'
      - float
    doc: Initial temperature (for DA-ADVI).
    inputBinding:
      position: 101
      prefix: --initial-temperature
  - id: interval_exclusion_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are excluding.
    inputBinding:
      position: 101
      prefix: --interval-exclusion-padding
  - id: interval_merging_rule
    type:
      - 'null'
      - string
    doc: 'Interval merging rule for abutting intervals. Possible values: {ALL, OVERLAPPING_ONLY}'
    inputBinding:
      position: 101
      prefix: --interval-merging-rule
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are including.
    inputBinding:
      position: 101
      prefix: --interval-padding
  - id: interval_psi_scale
    type:
      - 'null'
      - float
    doc: Typical scale of interval-specific unexplained variance.
    inputBinding:
      position: 101
      prefix: --interval-psi-scale
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: 'Set merging approach to use for combining interval inputs. Possible values:
      {UNION, INTERSECTION}'
    inputBinding:
      position: 101
      prefix: --interval-set-rule
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Adamax optimizer learning rate.
    inputBinding:
      position: 101
      prefix: --learning-rate
  - id: log_emission_samples_per_round
    type:
      - 'null'
      - int
    doc: Log emission samples drawn per round of sampling.
    inputBinding:
      position: 101
      prefix: --log-emission-samples-per-round
  - id: log_emission_sampling_median_rel_error
    type:
      - 'null'
      - float
    doc: Maximum tolerated median relative error in log emission sampling.
    inputBinding:
      position: 101
      prefix: --log-emission-sampling-median-rel-error
  - id: log_emission_sampling_rounds
    type:
      - 'null'
      - int
    doc: Log emission maximum sampling rounds.
    inputBinding:
      position: 101
      prefix: --log-emission-sampling-rounds
  - id: log_mean_bias_standard_deviation
    type:
      - 'null'
      - float
    doc: Standard deviation of log mean bias.
    inputBinding:
      position: 101
      prefix: --log-mean-bias-standard-deviation
  - id: mapping_error_rate
    type:
      - 'null'
      - float
    doc: Typical mapping error rate.
    inputBinding:
      position: 101
      prefix: --mapping-error-rate
  - id: max_advi_iter_first_epoch
    type:
      - 'null'
      - int
    doc: Maximum ADVI iterations in the first epoch.
    inputBinding:
      position: 101
      prefix: --max-advi-iter-first-epoch
  - id: max_advi_iter_subsequent_epochs
    type:
      - 'null'
      - int
    doc: Maximum ADVI iterations in subsequent epochs.
    inputBinding:
      position: 101
      prefix: --max-advi-iter-subsequent-epochs
  - id: max_bias_factors
    type:
      - 'null'
      - int
    doc: Maximum number of bias factors.
    inputBinding:
      position: 101
      prefix: --max-bias-factors
  - id: max_calling_iters
    type:
      - 'null'
      - int
    doc: Maximum number of internal self-consistency iterations within each 
      calling step.
    inputBinding:
      position: 101
      prefix: --max-calling-iters
  - id: max_copy_number
    type:
      - 'null'
      - int
    doc: Highest allowed copy-number state.
    inputBinding:
      position: 101
      prefix: --max-copy-number
  - id: max_training_epochs
    type:
      - 'null'
      - int
    doc: Maximum number of training epochs.
    inputBinding:
      position: 101
      prefix: --max-training-epochs
  - id: min_training_epochs
    type:
      - 'null'
      - int
    doc: Minimum number of training epochs.
    inputBinding:
      position: 101
      prefix: --min-training-epochs
  - id: model
    type:
      - 'null'
      - Directory
    doc: Input denoising-model directory. In CASE mode, this argument is 
      required.
    inputBinding:
      position: 101
      prefix: --model
  - id: num_gc_bins
    type:
      - 'null'
      - int
    doc: Number of bins used to represent the GC-bias curves.
    inputBinding:
      position: 101
      prefix: --num-gc-bins
  - id: num_samples_copy_ratio_approx
    type:
      - 'null'
      - int
    doc: Number of samples to draw from the final model approximation to 
      estimate denoised copy number ratios.
    inputBinding:
      position: 101
      prefix: --num-samples-copy-ratio-approx
  - id: num_thermal_advi_iters
    type:
      - 'null'
      - int
    doc: Number of thermal ADVI iterations (for DA-ADVI).
    inputBinding:
      position: 101
      prefix: --num-thermal-advi-iters
  - id: p_active
    type:
      - 'null'
      - float
    doc: Prior probability of treating an interval as CNV-active.
    inputBinding:
      position: 101
      prefix: --p-active
  - id: p_alt
    type:
      - 'null'
      - float
    doc: Total prior probability of alternative copy-number states.
    inputBinding:
      position: 101
      prefix: --p-alt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: sample_psi_scale
    type:
      - 'null'
      - float
    doc: Typical scale of sample-specific correction to the unexplained 
      variance.
    inputBinding:
      position: 101
      prefix: --sample-psi-scale
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-inflater
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output
    type: Directory
    doc: Output directory. This will be created if it does not exist.
    outputBinding:
      glob: $(inputs.output)
  - id: output_output_prefix
    type: File[]
    doc: Prefix for output filenames.
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
