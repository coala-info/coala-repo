cwlVersion: v1.2
class: CommandLineTool
baseCommand: pints_caller
label: pypints_pints_caller
doc: "Peak Identifier for Nascent Transcripts Starts\n\nTool homepage: https://pints.yulab.org"
inputs:
  - id: adjust_method
    type:
      - 'null'
      - string
    doc: method for calculating adjusted p-vals
    default: fdr_bh
    inputBinding:
      position: 101
      prefix: --adjust-method
  - id: annotation_gtf
    type:
      - 'null'
      - File
    doc: Gene annotation file (gtf) format for learning the threshold for edge 
      trimming. If this is specified, other related parameters like 
      --donor-tolerance will be ignored.
    default: None
    inputBinding:
      position: 101
      prefix: --annotation-gtf
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: input bam file, if you want to use bigwig files, please use --bw-pl and
      --bw-mn
    default: None
    inputBinding:
      position: 101
      prefix: --bam-file
  - id: bw_mn
    type:
      - 'null'
      - type: array
        items: File
    doc: Bigwig for minus strand. If you want to use bigwig instead of BAM, 
      please set bam_file to bigwig
    default: None
    inputBinding:
      position: 101
      prefix: --bw-mn
  - id: bw_pl
    type:
      - 'null'
      - type: array
        items: File
    doc: Bigwig for plus strand. If you want to use bigwig instead of BAM, 
      please set bam_file to bigwig
    default: None
    inputBinding:
      position: 101
      prefix: --bw-pl
  - id: ce_trigger
    type:
      - 'null'
      - int
    doc: Trigger for receptor tolerance checking
    default: 3
    inputBinding:
      position: 101
      prefix: --ce-trigger
  - id: chromosome_startswith
    type:
      - 'null'
      - string
    doc: Only keep reads mapped to chromosomes with this prefix
    default: ''
    inputBinding:
      position: 101
      prefix: --chromosome-start-with
  - id: close_threshold
    type:
      - 'null'
      - int
    doc: Distance threshold for two peaks (on opposite strands) to be merged
    default: 300
    inputBinding:
      position: 101
      prefix: --close-threshold
  - id: ct_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Bam file for input/control (minus strand). If you want to use bigwig 
      instead of BAM, please use --input-bw-pl and --input-bw-mn
    default: None
    inputBinding:
      position: 101
      prefix: --ct-bam
  - id: ct_bw_mn
    type:
      - 'null'
      - type: array
        items: File
    doc: Bigwig for input/control (minus strand). If you want to use bigwig 
      instead of BAM, please use --input-bw-pl and --input-bw-mn
    default: None
    inputBinding:
      position: 101
      prefix: --ct-bw-mn
  - id: ct_bw_pl
    type:
      - 'null'
      - type: array
        items: File
    doc: Bigwig for control/input (plus strand). If you want to use bigwig 
      instead of BAM, please use --ct-bam
    default: None
    inputBinding:
      position: 101
      prefix: --ct-bw-pl
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Save diagnostics (independent filtering and pval dist) to local folder
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_eler
    type:
      - 'null'
      - boolean
    doc: Disable Enhanced Local Environment Refinement
    default: true
    inputBinding:
      position: 101
      prefix: --disable-eler
  - id: disable_ler
    type:
      - 'null'
      - boolean
    doc: Disable Local Environment Refinement
    default: false
    inputBinding:
      position: 101
      prefix: --disable-ler
  - id: disable_qc
    type:
      - 'null'
      - boolean
    doc: Disable on-the-fly quality control
    default: false
    inputBinding:
      position: 101
      prefix: --disable-qc
  - id: disable_small
    type:
      - 'null'
      - boolean
    doc: Set this switch to prevent PINTS from reporting very short 
      peaks(shorter than --small-peak-threshold)
    default: false
    inputBinding:
      position: 101
      prefix: --disable-small
  - id: div_size_min
    type:
      - 'null'
      - int
    doc: Min size for a divergent peak
    default: 0
    inputBinding:
      position: 101
      prefix: --div-size-min
  - id: donor_tolerance
    type:
      - 'null'
      - float
    doc: The stringency for PINTS to cluster nearby TSSs into a peak. 0 is the 
      least stringent; 1 is the most stringent.
    default: 0.3
    inputBinding:
      position: 101
      prefix: --alpha
  - id: dont_borrow_info_reps
    type:
      - 'null'
      - boolean
    doc: Don't borrow information from reps to refine calling of divergent 
      elements
    default: true
    inputBinding:
      position: 101
      prefix: --dont-borrow-info-reps
  - id: dont_check_updates
    type:
      - 'null'
      - boolean
    doc: Set this switch to disable update check.
    default: true
    inputBinding:
      position: 101
      prefix: --dont-check-updates
  - id: dont_merge_reps
    type:
      - 'null'
      - boolean
    doc: Don't merge replicates (this is the default setting for the previous 
      versions)
    default: true
    inputBinding:
      position: 101
      prefix: --dont-merge-reps
  - id: dont_output_chrom_size
    type:
      - 'null'
      - boolean
    doc: Don't write chromosome dict to local folder (not recommended)
    default: true
    inputBinding:
      position: 101
      prefix: --dont-output-chrom-size
  - id: eler_lower_bound
    type:
      - 'null'
      - float
    doc: Lower bound of the empirical estimation for the density of potential 
      true peaks in the local background.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --eler-lower-bound
  - id: epig_annotation
    type:
      - 'null'
      - string
    doc: Refine peak calls with compiled epigenomic annotation from the PINTS 
      web server. Values should be the name of the biosample, for example, K562.
    default: None
    inputBinding:
      position: 101
      prefix: --epig-annotation
  - id: exp_type
    type:
      - 'null'
      - string
    doc: "Type of experiment. If the experiment is not listed as a choice, or you
      know the position of RNA ends on the reads and you want to override the defaults,
      you can specify: R_5 (5' of the read for single-end lib), R_3 (3' of the read
      for single-end lib), R1_5 (5' of the read1 for paired-end lib), R1_3 (3' of
      the read1 for paired-end lib), R2_5 (5' of the read2 for paired-end lib), or
      R2_3 (3' of the read2 for paired-end lib)"
    default: CoPRO
    inputBinding:
      position: 101
      prefix: --exp-type
  - id: fc_cutoff
    type:
      - 'null'
      - float
    doc: When using the sensitive mode, this sets the cutoff for applying the 
      likelihood ratio test.
    default: 1.5
    inputBinding:
      position: 101
      prefix: --fc
  - id: fdr_target
    type:
      - 'null'
      - float
    doc: FDR target for multiple testing
    default: 0.1
    inputBinding:
      position: 101
      prefix: --fdr-target
  - id: file_prefix
    type: string
    doc: prefix to all intermediate files
    default: '1'
    inputBinding:
      position: 101
      prefix: --file-prefix
  - id: filters
    type:
      - 'null'
      - type: array
        items: string
    doc: reads from chromosomes whose names contain any matches in filters will 
      be ignored
    default: '[]'
    inputBinding:
      position: 101
      prefix: --filters
  - id: focused_chrom
    type:
      - 'null'
      - string
    doc: If --annotation-gtf is specified, you use this parameter to change 
      which chromosome the tool should learn the values from.
    default: chr1
    inputBinding:
      position: 101
      prefix: --focused-chrom
  - id: init_dens_cutoff
    type:
      - 'null'
      - float
    doc: Peaks with initiation density lower than this cutoff will not be tested
      in the sensitive mode.
    default: 0.25
    inputBinding:
      position: 101
      prefix: --init-dens-cutoff
  - id: init_height_cutoff
    type:
      - 'null'
      - int
    doc: Peaks with initiation summit lower than this cutoff will not be tested 
      in the sensitive mode.
    default: 4
    inputBinding:
      position: 101
      prefix: --init-height-cutoff
  - id: iqr_strategy
    type:
      - 'null'
      - string
    doc: IQR strategy, can be bgIQR (more robust) or pkIQR (more efficient)
    default: bgIQR
    inputBinding:
      position: 101
      prefix: --IQR-strategy
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 30
    inputBinding:
      position: 101
      prefix: --mapq-threshold
  - id: min_len_opposite_peaks
    type:
      - 'null'
      - int
    doc: Minimum length requirement for peaks on the opposite strand to be 
      paired, set it to 0 to loose this requirement
    default: 0
    inputBinding:
      position: 101
      prefix: --min-length-opposite-peaks
  - id: min_mu_percent
    type:
      - 'null'
      - float
    doc: Local backgrounds smaller than this percentile among all peaks will be 
      replaced.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-mu-percent
  - id: model
    type:
      - 'null'
      - string
    doc: Statistical model for testing the significance of peaks.
    default: ZIP
    inputBinding:
      position: 101
      prefix: --model
  - id: peak_distance
    type:
      - 'null'
      - int
    doc: Required minimal horizontal distance (>= 1) in samples between 
      neighbouring peaks.
    default: 1
    inputBinding:
      position: 101
      prefix: --peak-distance
  - id: peak_width
    type:
      - 'null'
      - int
    doc: Required width of peaks in samples.
    default: None
    inputBinding:
      position: 101
      prefix: --peak-width
  - id: relaxed_fdr_target
    type:
      - 'null'
      - float
    doc: Relaxed FDR cutoff for TREs overlap with epigenomic annotations
    default: 0.2
    inputBinding:
      position: 101
      prefix: --relaxed-fdr-target
  - id: remove_sticks
    type:
      - 'null'
      - boolean
    doc: Set this switch to remove stick-like peaks (signal on a single 
      position)
    default: true
    inputBinding:
      position: 101
      prefix: --remove-sticks
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Set this switch if reads in this library represent the reverse 
      complement of RNAs, like PROseq
    default: false
    inputBinding:
      position: 101
      prefix: --reverse-complement
  - id: save_to
    type:
      - 'null'
      - Directory
    doc: save peaks to this path (a folder), by default, current folder
    default: .
    inputBinding:
      position: 101
      prefix: --save-to
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Set this switch to enable more sensitive peak calling
    default: false
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: small_peak_threshold
    type:
      - 'null'
      - int
    doc: Threshold for small peaks, peaks with width smaller than this value 
      will be required to run extra test
    default: 5
    inputBinding:
      position: 101
      prefix: --small-peak-threshold
  - id: strict_qc
    type:
      - 'null'
      - boolean
    doc: Raise exceptions if PINTS detects abnormalities during on-the-fly 
      quality control; otherwise, PINTS prints warning messages.
    default: false
    inputBinding:
      position: 101
      prefix: --strict-qc
  - id: stringent_pairs_only
    type:
      - 'null'
      - boolean
    doc: Only consider elements as bidirectional when both of the two peaks are 
      significant according to their p-values
    default: false
    inputBinding:
      position: 101
      prefix: --stringent-pairs-only
  - id: summit_dist_min
    type:
      - 'null'
      - int
    doc: Min dist between two summit
    default: 0
    inputBinding:
      position: 101
      prefix: --summit-dist-min
  - id: thread_n
    type:
      - 'null'
      - int
    doc: Max number of threads PINTS can create
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: top_peak_threshold
    type:
      - 'null'
      - float
    doc: For very short peaks (smaller than --small-peak- threshold), we use the
      quantile threshold for peak densities as the background density
    default: 0.75
    inputBinding:
      position: 101
      prefix: --top-peak-threshold
  - id: tss_extension
    type:
      - 'null'
      - int
    doc: BPs to be extended from annotated TSSs, these extended regions will be 
      used to minimize overlaps between called peaks.
    default: 200
    inputBinding:
      position: 101
      prefix: --tss-extension
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show program's version number and exit
    inputBinding:
      position: 101
      prefix: -v
  - id: window_size_threshold
    type:
      - 'null'
      - int
    doc: max size of divergent windows
    default: 2000
    inputBinding:
      position: 101
      prefix: --max-window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0
stdout: pypints_pints_caller.out
