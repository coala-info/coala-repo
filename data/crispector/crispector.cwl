cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispector
label: crispector
doc: "Accurate estimation of genome editing translocation and NHEJ off-target activity
  from comparative NGS data\n\nTool homepage: https://github.com/YakhiniGroup/crispector"
inputs:
  - id: amplicon_min_score
    type:
      - 'null'
      - float
    doc: Minimum normalized alignment score to consider a read alignment as 
      valid. Normalized alignment score is defined as the Needleman-Wunch 
      alignment score divided by the maximum possible score. Below this 
      alignment threshold, reads are discarded.
    inputBinding:
      position: 101
      prefix: --amplicon_min_score
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: Confidence interval for the evaluated editing activity
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
  - id: max_edit_distance_on_primers
    type:
      - 'null'
      - int
    doc: Maximum edit distance to consider a read prefix (or suffix) as a match 
      for a primer.
    inputBinding:
      position: 101
      prefix: --max_edit_distance_on_primers
  - id: min_editing_activity
    type:
      - 'null'
      - float
    doc: Minimum editing activity (%). Sites with editing activity lower than 
      the minimum, will be discarded from the translocation detection.
    inputBinding:
      position: 101
      prefix: --min_editing_activity
  - id: min_num_of_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads (per locus site) to evaluate edit events
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
    inputBinding:
      position: 101
      prefix: --translocation_amplicon_min_score
  - id: translocation_p_value
    type:
      - 'null'
      - float
    doc: Translocations statistical significance level. This threshold is 
      applied on the corrected p_value,FDR (false discovery rate).
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
    dockerPull: quay.io/biocontainers/crispector:1.0.7--pyhdfd78af_0
