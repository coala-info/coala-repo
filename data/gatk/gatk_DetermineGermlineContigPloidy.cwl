cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - DetermineGermlineContigPloidy
label: gatk_DetermineGermlineContigPloidy
doc: Determines the baseline contig ploidy for germline samples given counts 
  data
inputs:
  - id: input
    type:
      type: array
      items: File
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
    doc: Admixing ratio of new and old called posteriors (between 0 and 1; 
      larger values implies using more of the new posterior and less of the old 
      posterior) after convergence.
    inputBinding:
      position: 101
      prefix: --caller-external-admixing-rate
  - id: caller_internal_admixing_rate
    type:
      - 'null'
      - float
    doc: Admixing ratio of new and old called posteriors (between 0 and 1; 
      larger values implies using more of the new posterior and less of the old 
      posterior) for internal convergence loops.
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
  - id: contig_ploidy_priors
    type:
      - 'null'
      - File
    doc: Input file specifying contig-ploidy priors. If only a single sample is 
      specified, this input should not be provided. If multiple samples are 
      specified, this input is required.
    inputBinding:
      position: 101
      prefix: --contig-ploidy-priors
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
  - id: disable_annealing
    type:
      - 'null'
      - boolean
    doc: (advanced) Disable annealing.
    inputBinding:
      position: 101
      prefix: --disable-annealing
  - id: disable_caller
    type:
      - 'null'
      - boolean
    doc: (advanced) Disable caller.
    inputBinding:
      position: 101
      prefix: --disable-caller
  - id: disable_sampler
    type:
      - 'null'
      - boolean
    doc: (advanced) Disable sampler.
    inputBinding:
      position: 101
      prefix: --disable-sampler
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
  - id: global_psi_scale
    type:
      - 'null'
      - float
    doc: Prior scale of contig coverage unexplained variance. If a single sample
      is provided, this input will be ignored.
    inputBinding:
      position: 101
      prefix: --global-psi-scale
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
    doc: Interval merging rule for abutting intervals
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
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: Set merging approach to use for combining interval inputs
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
  - id: max_calling_iters
    type:
      - 'null'
      - int
    doc: Maximum number of internal self-consistency iterations within each 
      calling step.
    inputBinding:
      position: 101
      prefix: --max-calling-iters
  - id: max_training_epochs
    type:
      - 'null'
      - int
    doc: Maximum number of training epochs.
    inputBinding:
      position: 101
      prefix: --max-training-epochs
  - id: mean_bias_standard_deviation
    type:
      - 'null'
      - float
    doc: Prior standard deviation of the contig-level mean coverage bias. If a 
      single sample is provided, this input will be ignored.
    inputBinding:
      position: 101
      prefix: --mean-bias-standard-deviation
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
    doc: Input ploidy-model directory. If only a single sample is specified, 
      this input is required. If multiple samples are specified, this input 
      should not be provided.
    inputBinding:
      position: 101
      prefix: --model
  - id: num_thermal_advi_iters
    type:
      - 'null'
      - int
    doc: Number of thermal ADVI iterations (for DA-ADVI).
    inputBinding:
      position: 101
      prefix: --num-thermal-advi-iters
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
    doc: Prior scale of the sample-specific correction to the coverage 
      unexplained variance.
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
