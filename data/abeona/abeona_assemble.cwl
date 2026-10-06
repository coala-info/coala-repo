cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abeona
  - assemble
label: abeona_assemble
doc: "Run abeona assembly pipeline (Nextflow): build a cortex De Bruijn graph from\
  \ reads, split it into subgraphs, create candidate transcripts and filter them with\
  \ kallisto. Give either fastx_forward + fastx_reverse, or fastx_single.\n\nTool\
  \ homepage: https://github.com/winni2k/abeona"
requirements:
  - class: ShellCommandRequirement
arguments:
  # abeona links <out_dir>/assemble.nf to the copy inside the image; the link is
  # broken outside the container and breaks collecting output_dir, so drop it
  - position: 1000
    shellQuote: false
    valueFrom: '&& rm -f $(inputs.out_dir)/assemble.nf'
inputs:
  - id: out_dir
    type: string
    default: abeona_out
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'Number of jobs to schedule concurrently (default: 2)'
    inputBinding:
      position: 102
      prefix: --jobs
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size to use to construct the De Bruijn graph (default: 47)'
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: memory
    type:
      - 'null'
      - int
    doc: 'Maximum memory to use in giga bytes (default: 3)'
    inputBinding:
      position: 102
      prefix: --memory
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Quiet output'
    inputBinding:
      position: 102
      prefix: --quiet
  - id: resume
    type:
      - 'null'
      - boolean
    doc: 'Resume a previous Nextflow run'
    inputBinding:
      position: 102
      prefix: --resume
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: 'Keep the intermediate folders in the output directory'
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: with_report
    type:
      - 'null'
      - boolean
    doc: 'Create nextflow report file at nexttflow_report.html in output directory (default: False)'
    inputBinding:
      position: 102
      prefix: --with-report
  - id: with_dag
    type:
      - 'null'
      - boolean
    doc: 'Create flowchart of workflow at flowchart.png in output directory (default: False)'
    inputBinding:
      position: 102
      prefix: --with-dag
  - id: fastx_forward
    type:
      - 'null'
      - File
    doc: 'Forward sequences in FASTA/FASTQ format. Use with fastx_reverse.'
    inputBinding:
      position: 102
      prefix: --fastx-forward
  - id: fastx_reverse
    type:
      - 'null'
      - File
    doc: 'Reverse sequences in FASTA/FASTQ format. Use with fastx_forward.'
    inputBinding:
      position: 102
      prefix: --fastx-reverse
  - id: fastx_single
    type:
      - 'null'
      - File
    doc: 'Single-end sequences in FASTA/FASTQ format. Needs kallisto_fragment_length and kallisto_sd.'
    inputBinding:
      position: 102
      prefix: --fastx-single
  - id: initial_contigs
    type:
      - 'null'
      - File
    doc: 'Only start assembly from contigs in this FASTA'
    inputBinding:
      position: 102
      prefix: --initial-contigs
  - id: extra_start_kmer
    type:
      - 'null'
      - string
    doc: 'Disconnect this k-mer from incoming k-mers before candidate transcript creation. This may be useful when assembling circular genomes. Best used with --initial-contigs to make sure the k-mer exists in the consistent cortexpy graph.'
    inputBinding:
      position: 102
      prefix: --extra-start-kmer
  - id: min_tip_length
    type:
      - 'null'
      - int
    doc: 'Prune tips shorter than this value. A value of -1 sets the min tip length to the value of --kmer-size (default: -1)'
    inputBinding:
      position: 102
      prefix: --min-tip-length
  - id: min_unitig_coverage
    type:
      - 'null'
      - int
    doc: 'Prune unitigs with mean coverage below this value (default: 4)'
    inputBinding:
      position: 102
      prefix: --min-unitig-coverage
  - id: no_prune_tips_with_mccortex
    type:
      - 'null'
      - boolean
    doc: 'Instead of Mccortex use cortexpy to prune unitigs. This is slower and not recommended at this time. (default: False)'
    inputBinding:
      position: 102
      prefix: --no-prune-tips-with-mccortex
  - id: prune_tips_with_mccortex
    type:
      - 'null'
      - boolean
    doc: 'Prune tips with Mccortex (the default when neither prune option is given)'
    inputBinding:
      position: 102
      prefix: --prune-tips-with-mccortex
  - id: prune_tips_iteratively
    type:
      - 'null'
      - boolean
    doc: 'Prune the graph of tip lengths x = 2^n while x is less than --min-tip-length. Finally, prune graph of tips shorter than --min-tip-length. Currently only works when pruning with Mccortex. (default: False)'
    inputBinding:
      position: 102
      prefix: --prune-tips-iteratively
  - id: max_paths_per_subgraph
    type:
      - 'null'
      - int
    doc: 'Ignore graphs that have more than this number of paths (default: 0)'
    inputBinding:
      position: 102
      prefix: --max-paths-per-subgraph
  - id: no_links
    type:
      - 'null'
      - boolean
    doc: 'Do not use links in candidate transcript creation (default: False)'
    inputBinding:
      position: 102
      prefix: --no-links
  - id: report_unassembled_reads
    type:
      - 'null'
      - boolean
    doc: 'Store reads from ignored graphs in unassembled_reads (default: False)'
    inputBinding:
      position: 102
      prefix: --report-unassembled-reads
  - id: assemble_unassembled_reads_with_transabyss
    type:
      - 'null'
      - boolean
    doc: 'Try and assemble reads from ignored graphs with transabyss (default: False)'
    inputBinding:
      position: 102
      prefix: --assemble-unassembled-reads-with-transabyss
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: 'Number of kallisto bootstrap samples (default: 100)'
    inputBinding:
      position: 102
      prefix: --bootstrap-samples
  - id: kallisto_fragment_length
    type:
      - 'null'
      - float
    doc: 'kallisto estimated average fragment length. Required with fastx_single.'
    inputBinding:
      position: 102
      prefix: --kallisto-fragment-length
  - id: kallisto_sd
    type:
      - 'null'
      - float
    doc: 'kallisto estimated standard deviation of fragment length. Required with fastx_single.'
    inputBinding:
      position: 102
      prefix: --kallisto-sd
  - id: kallisto_threads
    type:
      - 'null'
      - int
    doc: 'Number of logical cores to assign to a single kallisto quant job. Needs to be less than or equal to --jobs (default: 2)'
    inputBinding:
      position: 102
      prefix: --kallisto-threads
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: 'Length of longest read in data. Remove candidate subgraphs that do not have at least one candidate transcript greater than this length. If not specified, abeona estimates it from the head of the reads.'
    inputBinding:
      position: 102
      prefix: --max-read-length
  - id: estimated_count_threshold
    type:
      - 'null'
      - float
    doc: 'Threshold over which the estimated transcript count from kallisto is counted towards keeping a transcript (default: 1)'
    inputBinding:
      position: 102
      prefix: --estimated-count-threshold
  - id: bootstrap_proportion_threshold
    type:
      - 'null'
      - float
    doc: 'Proportion of bootstrap iterations for which a transcript''s estimated counts must be above the --estimated-count-threshold (default: 0.95)'
    inputBinding:
      position: 102
      prefix: --bootstrap-proportion-threshold
  - id: record_buffer_size
    type:
      - 'null'
      - int
    doc: 'Number of reads to buffer in memory when assigning reads to subgraphs (default: -1)'
    inputBinding:
      position: 102
      prefix: --record-buffer-size
  - id: max_junctions
    type:
      - 'null'
      - int
    doc: 'The max junctions argument can be used to quickly ignore large subgraphs with too many junctions to process effectively. (default: 0)'
    inputBinding:
      position: 102
      prefix: --max-junctions
outputs:
  - id: transcripts
    type: File
    doc: Assembled transcripts (transcripts.fa; empty when nothing was assembled)
    outputBinding:
      glob: $(inputs.out_dir)/transcripts.fa
  - id: unassembled_reads
    type: Directory?
    doc: Reads from ignored subgraphs (with report_unassembled_reads)
    outputBinding:
      glob: $(inputs.out_dir)/unassembled_reads
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abeona:0.45.0--py36_0
