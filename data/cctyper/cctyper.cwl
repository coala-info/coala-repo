cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctyper
label: cctyper
doc: "CRISPRCasTyper version 1.8.0\n\nTool homepage: https://github.com/Russel88/CRISPRCasTyper"
inputs:
  - id: input
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Prefix for output directory
    inputBinding:
      position: 2
  - id: ccd
    type:
      - 'null'
      - int
    doc: Distance (bp) threshold to connect Cas operons and CRISPR arrays
    inputBinding:
      position: 103
      prefix: --ccd
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Input should be treated as circular.
    inputBinding:
      position: 103
      prefix: --circular
  - id: custom_hmm
    type:
      - 'null'
      - File
    doc: 'Path to custom HMM database to decorate plot. Warning: This overwrites plotting
      of low-quality matches to Cas HMMs'
    inputBinding:
      position: 103
      prefix: --custom_hmm
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to database. Only needed if CCTYPER_DB environment variable is not
      set.
    inputBinding:
      position: 103
      prefix: --db
  - id: dist
    type:
      - 'null'
      - int
    doc: Max allowed number of unknown genes between cas genes in operon
    inputBinding:
      position: 103
      prefix: --dist
  - id: exact_stats
    type:
      - 'null'
      - boolean
    doc: Repeat and spacer identity is exact (slow for large CRISPR) in contrast
      to approximate (default, fast, based on sample of repeats/spacers).
    inputBinding:
      position: 103
      prefix: --exact_stats
  - id: expand
    type:
      - 'null'
      - int
    doc: Expand operons with un-annotated genes. The value determines by how 
      many bp in each end to expand. 0 only fills gaps
    inputBinding:
      position: 103
      prefix: --expand
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files (prodigal, hmmer, minced).
    inputBinding:
      position: 103
      prefix: --keep_tmp
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size. Has to match training kmer size!
    inputBinding:
      position: 103
      prefix: --kmer
  - id: log_lvl
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 103
      prefix: --log_lvl
  - id: maxrl
    type:
      - 'null'
      - int
    doc: MinCED option - Maximum repeat length
    inputBinding:
      position: 103
      prefix: --maxRL
  - id: maxsl
    type:
      - 'null'
      - int
    doc: MinCED option - Maximum spacer length
    inputBinding:
      position: 103
      prefix: --maxSL
  - id: minnr
    type:
      - 'null'
      - int
    doc: MinCED option - Minimum number of repeats
    inputBinding:
      position: 103
      prefix: --minNR
  - id: minrl
    type:
      - 'null'
      - int
    doc: MinCED option - Minimum repeat length
    inputBinding:
      position: 103
      prefix: --minRL
  - id: minsl
    type:
      - 'null'
      - int
    doc: MinCED option - Minimum spacer length
    inputBinding:
      position: 103
      prefix: --minSL
  - id: no_grid
    type:
      - 'null'
      - boolean
    doc: Do not add grid to plot.
    inputBinding:
      position: 103
      prefix: --no_grid
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Do not draw a map of CRISPR-Cas.
    inputBinding:
      position: 103
      prefix: --no_plot
  - id: overall_cov_hmm
    type:
      - 'null'
      - float
    doc: Overall HMM coverage threshold
    inputBinding:
      position: 103
      prefix: --overall_cov_hmm
  - id: overall_cov_seq
    type:
      - 'null'
      - float
    doc: Overall sequence coverage threshold
    inputBinding:
      position: 103
      prefix: --overall_cov_seq
  - id: overall_eval
    type:
      - 'null'
      - float
    doc: Overall E-value threshold
    inputBinding:
      position: 103
      prefix: --overall_eval
  - id: pred_prob
    type:
      - 'null'
      - float
    doc: Prediction probability cut-off for assigning subtype to CRISPR repeats
    inputBinding:
      position: 103
      prefix: --pred_prob
  - id: prodigal
    type:
      - 'null'
      - string
    doc: Which mode to run prodigal in
    inputBinding:
      position: 103
      prefix: --prodigal
  - id: redo_typing
    type:
      - 'null'
      - boolean
    doc: Redo the typing. Skip prodigal and HMMER and load the hmmer.tab from 
      the output dir.
    inputBinding:
      position: 103
      prefix: --redo_typing
  - id: repeat_id
    type:
      - 'null'
      - int
    doc: Minimum average sequence identity between repeats for trusted arrays
    inputBinding:
      position: 103
      prefix: --repeat_id
  - id: searchwl
    type:
      - 'null'
      - int
    doc: 'MinCED option - Length of search window. Range: 6-9'
    inputBinding:
      position: 103
      prefix: --searchWL
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for sampling when estimating CRISPR stats (see argument above)
    inputBinding:
      position: 103
      prefix: --seed
  - id: simplelog
    type:
      - 'null'
      - boolean
    doc: No color or progress bar in log.
    inputBinding:
      position: 103
      prefix: --simplelog
  - id: skip_blast
    type:
      - 'null'
      - boolean
    doc: Disable BLAST search of CRISPRs near cas operons.
    inputBinding:
      position: 103
      prefix: --skip_blast
  - id: spacer_id
    type:
      - 'null'
      - int
    doc: Maximum average sequence identity between spacers for trusted arrays
    inputBinding:
      position: 103
      prefix: --spacer_id
  - id: spacer_sem
    type:
      - 'null'
      - float
    doc: Maximum spacer length standard error of the mean for trusted arrays
    inputBinding:
      position: 103
      prefix: --spacer_sem
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel processes
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctyper:1.8.0--pyhdfd78af_1
stdout: cctyper.out
