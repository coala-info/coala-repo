cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viloca
  - run
label: viloca_run
doc: "Run VILOCA\n\nTool homepage: https://github.com/cbg-ethz/VILOCA"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: sorted bam format alignment file
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: reference genome in fasta format
    inputBinding:
      position: 2
  - id: NO_strand_bias_filter
    type:
      - 'null'
      - boolean
    doc: Do NOT filter out mutations that do not pass the strand bias filter. 
      The strand bias filter is only recommended for paired-end Illumina reads.
    inputBinding:
      position: 103
      prefix: --NO-strand_bias_filter
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha
    inputBinding:
      position: 103
      prefix: --alpha
  - id: conv_thres
    type:
      - 'null'
      - float
    doc: convergence threshold for inference.
    inputBinding:
      position: 103
      prefix: --conv_thres
  - id: exclude_non_var_pos_threshold
    type:
      - 'null'
      - float
    doc: Runs exclude non-variable positions mode. Set percentage threshold for 
      exclusion.
    inputBinding:
      position: 103
      prefix: --exclude_non_var_pos_threshold
  - id: extended_window_mode
    type:
      - 'null'
      - boolean
    doc: Runs b2w in extended window mode where fake inserations are placed into
      reference and read.
    inputBinding:
      position: 103
      prefix: --extended_window_mode
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: ignore SNVs adjacent to insertions/deletions (legacy behaviour of 
      'fil', ignore this option if you don't understand)
    inputBinding:
      position: 103
      prefix: --ignore_indels
  - id: insert_file
    type:
      - 'null'
      - File
    doc: path to an (optional) insert file (primer tiling strategy)
    inputBinding:
      position: 103
      prefix: --insert-file
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: keep all intermediate files
    inputBinding:
      position: 103
      prefix: --keep_files
  - id: maxcov
    type:
      - 'null'
      - int
    doc: approximate max read coverage per position allowed
    inputBinding:
      position: 103
      prefix: --maxcov
  - id: min_windows_coverage
    type:
      - 'null'
      - int
    doc: Number of windows that need to cover a mutation to have it called.
    inputBinding:
      position: 103
      prefix: --min_windows_coverage
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode in which to run VILOCA: shorah, learn_error_params, use_quality_scores,
      ShoRAH refers to the method from https://github.com/cbg-ethz/shorah.'
    inputBinding:
      position: 103
      prefix: --mode
  - id: n_max_haplotypes
    type:
      - 'null'
      - int
    doc: Guess of maximal guess of haplotypes. If VILOCA returns the maximal 
      number of haplotypes then this number was choosen to little and needs to 
      be increased.
    inputBinding:
      position: 103
      prefix: --n_max_haplotypes
  - id: n_mfa_starts
    type:
      - 'null'
      - int
    doc: Number of starts for inference type mean_field_approximation.
    inputBinding:
      position: 103
      prefix: --n_mfa_starts
  - id: non_unique_modus
    type:
      - 'null'
      - boolean
    doc: 'For inference: Make read set unique with read weights. Cannot be used with
      --mode shorah.'
    inputBinding:
      position: 103
      prefix: --non-unique_modus
  - id: out_format
    type:
      - 'null'
      - type: array
        items: string
    doc: output format of called SNVs
    inputBinding:
      position: 103
      prefix: --out_format
  - id: record_history
    type:
      - 'null'
      - boolean
    doc: When enabled, this option saves the history of the parameter values 
      learned during the inference process.
    inputBinding:
      position: 103
      prefix: --record_history
  - id: region
    type:
      - 'null'
      - string
    doc: region in format 'chr:start-stop', e.g. 'chrm:1000-3000'
    inputBinding:
      position: 103
      prefix: --region
  - id: reuse_files
    type:
      - 'null'
      - boolean
    doc: Enabling this option allows the command line tool to reuse files that 
      were generated in previous runs. When set to true, the tool will check for
      existing output files and reuse them instead of regenerating the data. 
      This can help improve performance by avoiding redundant file generation 
      processes.
    inputBinding:
      position: 103
      prefix: --reuse_files
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for reproducible results
    inputBinding:
      position: 103
      prefix: --seed
  - id: sigma
    type:
      - 'null'
      - float
    doc: sigma value to use when calling SNVs
    inputBinding:
      position: 103
      prefix: --sigma
  - id: threads
    type:
      - 'null'
      - int
    doc: 'limit maximum number of parallel threads (0: CPUs count-1, n: limit to n)'
    inputBinding:
      position: 103
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: pos threshold when calling variants from support files
    inputBinding:
      position: 103
      prefix: --threshold
  - id: win_coverage
    type:
      - 'null'
      - int
    doc: coverage threshold. Omit windows with low coverage
    inputBinding:
      position: 103
      prefix: --win_coverage
  - id: win_min_ext
    type:
      - 'null'
      - float
    doc: 'win_min_ext: Minimum percentage of bases to overlap between reference and
      read to be considered in a window. The rest (i.e. non-overlapping part) will
      be filled with Ns.'
    inputBinding:
      position: 103
      prefix: --win_min_ext
  - id: windowsize
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 103
      prefix: --windowsize
  - id: winshifts
    type:
      - 'null'
      - int
    doc: number of window shifts
    inputBinding:
      position: 103
      prefix: --winshifts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viloca:1.1.0--pyhdfd78af_0
stdout: viloca_run.out
