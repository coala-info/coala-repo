cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispector
label: crispector2_crispector
doc: "Accurate estimation of genome editing translocation and NHEJ off-target activity
  from comparative NGS data\n\nTool homepage: https://github.com/theAguy/crispector2"
inputs:
  - id: allele
    type:
      - 'null'
      - boolean
    doc: Flag for analyzing alleles. The default is False, however if alleles 
      are needed, set the flag
    inputBinding:
      position: 101
      prefix: --allele
  - id: amplicon_min_score
    type:
      - 'null'
      - float
    doc: Minimum normalized alignment score to consider a read alignment as 
      valid. Normalized alignment score is defined as the Needleman-Wunch 
      alignment score divided by the maximum possible score. Below this 
      alignment threshold, reads are discarded.
    default: 30
    inputBinding:
      position: 101
      prefix: --amplicon_min_score
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: Confidence interval for the evaluated editing activity
    default: 0.95
    inputBinding:
      position: 101
      prefix: --confidence_interval
  - id: crispector_config
    type:
      - 'null'
      - File
    doc: Path to crispector configuration in YAML format.See "Advanced usage" 
      section in README on GitHub for further.
    inputBinding:
      position: 101
      prefix: --crispector_config
  - id: cut_site_position
    type:
      - 'null'
      - int
    doc: Expected cut-site position with respect to the 3' end of the provided 
      sgRNA sequence. Note, the sgRNA sequence must be entered without the PAM.
    default: -3
    inputBinding:
      position: 101
      prefix: --cut_site_position
  - id: disable_translocations
    type:
      - 'null'
      - boolean
    doc: Disable translocations detection
    inputBinding:
      position: 101
      prefix: --disable_translocations
  - id: enable_substitutions
    type:
      - 'null'
      - boolean
    doc: Enable substitutions events for the quantification of edit events
    inputBinding:
      position: 101
      prefix: --enable_substitutions
  - id: experiment_config
    type: File
    doc: 'A CSV (Comma Separated Values‏) file with the experiment data. Table has
      11 columns: SiteName, AmpliconReference, gRNA, OnTarget, ForwardPrimer, ReversePrimer,TxInput1Path
      TxInput2Path, MockInput1Path, MockInput2Path, DonorReference. The first 4 columns
      are required, the rest are optional. Header should be specified by the above
      order. Please check the README on GitHub further details and examples.'
    inputBinding:
      position: 101
      prefix: --experiment_config
  - id: fastp_options_string
    type:
      - 'null'
      - string
    doc: Try "fastp --help" for more details
    inputBinding:
      position: 101
      prefix: --fastp_options_string
  - id: keep_intermediate_files
    type: boolean
    doc: Keep intermediate files for debug purposes
    inputBinding:
      position: 101
      prefix: --keep_intermediate_files
  - id: max_allele_mismatches
    type:
      - 'null'
      - int
    doc: maximum mismatches allowed when aligning guide to amplicon (both mock 
      and tx) in the allelic case
    default: 5
    inputBinding:
      position: 101
      prefix: --max_allele_mismatches
  - id: max_edit_distance_on_primers
    type:
      - 'null'
      - int
    doc: Maximum edit distance to consider a read prefix (or suffix) as a match 
      for a primer.
    default: 8
    inputBinding:
      position: 101
      prefix: --max_edit_distance_on_primers
  - id: max_len_snv_ctc
    type:
      - 'null'
      - int
    doc: maximum length from cut site to snv that consider to be close to 
      cut-site (ctc)
    default: 10
    inputBinding:
      position: 101
      prefix: --max_len_snv_ctc
  - id: max_potential_snvs
    type:
      - 'null'
      - int
    doc: Maximum possible SNVs that may be occur in the experiment. Above that -
      certainly noise.
    default: 5
    inputBinding:
      position: 101
      prefix: --max_potential_snvs
  - id: min_editing_activity
    type:
      - 'null'
      - float
    doc: Minimum editing activity (%). Sites with editing activity lower than 
      the minimum, will be discarded from the translocation detection.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_editing_activity
  - id: min_num_of_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads (per locus site) to evaluate edit events
    default: 500
    inputBinding:
      position: 101
      prefix: --min_num_of_reads
  - id: min_read_length_without_primers
    type:
      - 'null'
      - int
    doc: Filter out any read shorter than min_read_length_without_primers + 
      length of forward and reverse primers. This threshold filters 
      primer-dimmer effect reads.
    default: 10
    inputBinding:
      position: 101
      prefix: --min_read_length_without_primers
  - id: mock_in1
    type:
      - 'null'
      - File
    doc: Mock read 1 input path or mock merged FASTQ file
    inputBinding:
      position: 101
      prefix: --mock_in1
  - id: mock_in2
    type:
      - 'null'
      - File
    doc: Mock read read 2 input path, if FASTQ files aren't merged [OPTIONAL]
    inputBinding:
      position: 101
      prefix: --mock_in2
  - id: override_noise_estimation
    type:
      - 'null'
      - boolean
    doc: Override noise estimation with default q parameter from 
      crispector_config file. It's advisable to set this flag for experiment 
      with a low number of off-target sites (<5). q is defined as the 
      probability of an indel to occur through an edit event. Check CRISPECTOR 
      paper for more details.
    inputBinding:
      position: 101
      prefix: --override_noise_estimation
  - id: random_reads_percentage_threshold
    type:
      - 'null'
      - float
    doc: The percentage of reads that if the algorithm cannot decide to which 
      allele to classify them, this site won't be analyzed in the allele case
    default: 0.5
    inputBinding:
      position: 101
      prefix: --random_reads_percentage_threshold
  - id: snv_ratio
    type:
      - 'null'
      - string
    doc: For a single position along single amplicon's data reads, if the 
      entropy of the ratio is lower than the given ratio, don't count this 
      position as potential snv. Has to be tuple that sums to 1
    default: (0.8,0.2)
    inputBinding:
      position: 101
      prefix: --snv_ratio
  - id: suppress_site_output
    type:
      - 'null'
      - boolean
    doc: Do not create plots for sites (save memory and runtime)
    inputBinding:
      position: 101
      prefix: --suppress_site_output
  - id: translocation_amplicon_min_score
    type:
      - 'null'
      - float
    doc: Minimum alignment score to consider a read with primer inconsistency as
      a possible translocation. Should be higher than --amplicon_min_score, 
      because translocations reads are noisier.Score is normalized between 0 
      (not even one bp match) to 100 (read is identical to the reference)
    default: 80
    inputBinding:
      position: 101
      prefix: --translocation_amplicon_min_score
  - id: translocation_p_value
    type:
      - 'null'
      - float
    doc: Translocations statistical significance level. This threshold is 
      applied on the corrected p_value,FDR (false discovery rate).
    default: 0.05
    inputBinding:
      position: 101
      prefix: --translocation_p_value
  - id: tx_in1
    type:
      - 'null'
      - File
    doc: Tx read 1 input path or Tx merged FASTQ file
    inputBinding:
      position: 101
      prefix: --tx_in1
  - id: tx_in2
    type:
      - 'null'
      - File
    doc: Tx read 2 input path, if FASTQ files aren't merged [OPTIONAL]
    inputBinding:
      position: 101
      prefix: --tx_in2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Higher verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: report_output
    type:
      - 'null'
      - Directory
    doc: Path to output folder
    outputBinding:
      glob: $(inputs.report_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispector2:2.1.2--pyhdfd78af_0
