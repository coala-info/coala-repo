cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - ModelSegments
label: gatk_ModelSegments
doc: Models segmented copy ratios from denoised copy ratios and segmented 
  minor-allele fractions from allelic counts; if multiple samples are specified,
  finds a joint segmentation that can be used in subsequent runs to perform 
  modeling of each sample
inputs:
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
  - id: allelic_counts
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files containing allelic counts (output of CollectAllelicCounts).
    inputBinding:
      position: 101
      prefix: --allelic-counts
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: denoised_copy_ratios
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files containing denoised copy ratios (output of 
      DenoiseReadCounts).
    inputBinding:
      position: 101
      prefix: --denoised-copy-ratios
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
  - id: genotyping_base_error_rate
    type:
      - 'null'
      - float
    doc: Maximum base-error rate for genotyping and filtering homozygous allelic
      counts, if available.
    inputBinding:
      position: 101
      prefix: --genotyping-base-error-rate
  - id: genotyping_homozygous_log_ratio_threshold
    type:
      - 'null'
      - float
    doc: Log-ratio threshold for genotyping and filtering homozygous allelic 
      counts, if available.
    inputBinding:
      position: 101
      prefix: --genotyping-homozygous-log-ratio-threshold
  - id: kernel_approximation_dimension
    type:
      - 'null'
      - int
    doc: Dimension of the kernel approximation.
    inputBinding:
      position: 101
      prefix: --kernel-approximation-dimension
  - id: kernel_scaling_allele_fraction
    type:
      - 'null'
      - float
    doc: Relative scaling S of the kernel K_AF for allele-fraction segmentation 
      to the kernel K_CR for copy-ratio segmentation.
    inputBinding:
      position: 101
      prefix: --kernel-scaling-allele-fraction
  - id: kernel_variance_allele_fraction
    type:
      - 'null'
      - float
    doc: Variance of Gaussian kernel for allele-fraction segmentation, if 
      performed.
    inputBinding:
      position: 101
      prefix: --kernel-variance-allele-fraction
  - id: kernel_variance_copy_ratio
    type:
      - 'null'
      - float
    doc: Variance of Gaussian kernel for copy-ratio segmentation, if performed.
    inputBinding:
      position: 101
      prefix: --kernel-variance-copy-ratio
  - id: maximum_number_of_segments_per_chromosome
    type:
      - 'null'
      - int
    doc: Maximum number of segments allowed per chromosome.
    inputBinding:
      position: 101
      prefix: --maximum-number-of-segments-per-chromosome
  - id: maximum_number_of_smoothing_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations allowed for segmentation smoothing.
    inputBinding:
      position: 101
      prefix: --maximum-number-of-smoothing-iterations
  - id: minimum_total_allele_count_case
    type:
      - 'null'
      - int
    doc: Minimum total count for filtering allelic counts in the case sample, if
      available.
    inputBinding:
      position: 101
      prefix: --minimum-total-allele-count-case
  - id: minimum_total_allele_count_normal
    type:
      - 'null'
      - int
    doc: Minimum total count for filtering allelic counts in the matched-normal 
      sample, if available.
    inputBinding:
      position: 101
      prefix: --minimum-total-allele-count-normal
  - id: minor_allele_fraction_prior_alpha
    type:
      - 'null'
      - float
    doc: Alpha hyperparameter for the 4-parameter beta-distribution prior on 
      segment minor-allele fraction.
    inputBinding:
      position: 101
      prefix: --minor-allele-fraction-prior-alpha
  - id: normal_allelic_counts
    type:
      - 'null'
      - File
    doc: Input file containing allelic counts for a matched normal (output of 
      CollectAllelicCounts).
    inputBinding:
      position: 101
      prefix: --normal-allelic-counts
  - id: number_of_burn_in_samples_allele_fraction
    type:
      - 'null'
      - int
    doc: Number of burn-in samples to discard for allele-fraction model.
    inputBinding:
      position: 101
      prefix: --number-of-burn-in-samples-allele-fraction
  - id: number_of_burn_in_samples_copy_ratio
    type:
      - 'null'
      - int
    doc: Number of burn-in samples to discard for copy-ratio model.
    inputBinding:
      position: 101
      prefix: --number-of-burn-in-samples-copy-ratio
  - id: number_of_changepoints_penalty_factor
    type:
      - 'null'
      - float
    doc: Factor A for the penalty on the number of changepoints per chromosome 
      for segmentation.
    inputBinding:
      position: 101
      prefix: --number-of-changepoints-penalty-factor
  - id: number_of_samples_allele_fraction
    type:
      - 'null'
      - int
    doc: Total number of MCMC samples for allele-fraction model.
    inputBinding:
      position: 101
      prefix: --number-of-samples-allele-fraction
  - id: number_of_samples_copy_ratio
    type:
      - 'null'
      - int
    doc: Total number of MCMC samples for copy-ratio model.
    inputBinding:
      position: 101
      prefix: --number-of-samples-copy-ratio
  - id: number_of_smoothing_iterations_per_fit
    type:
      - 'null'
      - int
    doc: Number of segmentation-smoothing iterations per MCMC model refit.
    inputBinding:
      position: 101
      prefix: --number-of-smoothing-iterations-per-fit
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: smoothing_credible_interval_threshold_allele_fraction
    type:
      - 'null'
      - float
    doc: Number of 10% equal-tailed credible-interval widths to use for 
      allele-fraction segmentation smoothing.
    inputBinding:
      position: 101
      prefix: --smoothing-credible-interval-threshold-allele-fraction
  - id: smoothing_credible_interval_threshold_copy_ratio
    type:
      - 'null'
      - float
    doc: Number of 10% equal-tailed credible-interval widths to use for 
      copy-ratio segmentation smoothing.
    inputBinding:
      position: 101
      prefix: --smoothing-credible-interval-threshold-copy-ratio
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
  - id: window_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Window sizes to use for calculating local changepoint costs.
    inputBinding:
      position: 101
      prefix: --window-size
  - id: segments
    type:
      - 'null'
      - File
    doc: Input Picard interval-list file specifying segments. If provided, 
      kernel segmentation will be skipped.
    inputBinding:
      position: 101
      prefix: --segments
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
