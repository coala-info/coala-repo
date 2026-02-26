cwlVersion: v1.2
class: CommandLineTool
baseCommand: lima
label: lima
doc: "Lima, Demultiplex Barcoded PacBio Data and Clip Barcodes\n\nTool homepage: https://github.com/PacificBiosciences/barcoding"
inputs:
  - id: input_file
    type: File
    doc: Subread or CCS BAM, SubreadSet or ConsensusReadSet XML, CCS FASTA/FASTQ
      [.gz]
    inputBinding:
      position: 1
  - id: barcodes_file
    type: File
    doc: Barcode FASTA or BarcodeSet XML
    inputBinding:
      position: 2
  - id: output_file
    type: File
    doc: Subread or CCS BAM, SubreadSet or ConsensusReadSet XML, CCS FASTA/FASTQ
      [.gz]
    inputBinding:
      position: 3
  - id: bad_adapter_ratio
    type:
      - 'null'
      - float
    doc: Maximum ratio of bad adapter.
    default: 0
    inputBinding:
      position: 104
      prefix: --bad-adapter-ratio
  - id: biosample_csv
    type:
      - 'null'
      - string
    doc: CSV file, barcode pairs with associated biosample names.
    inputBinding:
      position: 104
      prefix: --biosample-csv
  - id: branch_penalty
    type:
      - 'null'
      - int
    doc: Branch penalty.
    default: 4
    inputBinding:
      position: 104
      prefix: --branch-penalty
  - id: ccs_mode
    type:
      - 'null'
      - boolean
    doc: CCS mode, use optimal alignment options -A 1 -B 4 -D 3 -I 3 -X 4.
    inputBinding:
      position: 104
      prefix: --ccs
  - id: deletion_penalty
    type:
      - 'null'
      - int
    doc: Deletions penalty.
    default: 7
    inputBinding:
      position: 104
      prefix: --deletion-penalty
  - id: different_barcodes
    type:
      - 'null'
      - boolean
    doc: Only keep different barcodes in a pair in output. Enforces --min-passes
      ≥ 1.
    inputBinding:
      position: 104
      prefix: --different
  - id: dump_clips
    type:
      - 'null'
      - boolean
    doc: Dump clipped regions in a separate output file <prefix>.lima.clips
    inputBinding:
      position: 104
      prefix: --dump-clips
  - id: fail_reads_only
    type:
      - 'null'
      - boolean
    doc: Only process fail_reads.bam files from the input dataset XML
    inputBinding:
      position: 104
      prefix: --fail-reads-only
  - id: files_per_directory
    type:
      - 'null'
      - int
    doc: Group maximum numbers of split barcode output files per directory; 0 
      means deactivated.
    default: 0
    inputBinding:
      position: 104
      prefix: --files-per-directory
  - id: guess
    type:
      - 'null'
      - int
    doc: Try to guess the used barcodes, using the provided mean score 
      threshold; 0 means guessing deactivated.
    default: 0
    inputBinding:
      position: 104
      prefix: --guess
  - id: guess_min_count
    type:
      - 'null'
      - int
    doc: Minimum number of ZMWs observed to whitelist barcodes.
    default: 0
    inputBinding:
      position: 104
      prefix: --guess-min-count
  - id: hifi_preset
    type:
      - 'null'
      - string
    doc: Recommended settings. See below for preset parameter details.
    default: NONE
    inputBinding:
      position: 104
      prefix: --hifi-preset
  - id: ignore_missing_adapters
    type:
      - 'null'
      - boolean
    doc: Ignore flanks of consensus reads labeled as missing adapter.
    inputBinding:
      position: 104
      prefix: --ignore-missing-adapters
  - id: ignore_xml_biosamples
    type:
      - 'null'
      - boolean
    doc: Ignore <BioSamples> from XML input.
    inputBinding:
      position: 104
      prefix: --ignore-xml-biosamples
  - id: insertion_penalty
    type:
      - 'null'
      - int
    doc: Insertion penalty.
    default: 7
    inputBinding:
      position: 104
      prefix: --insertion-penalty
  - id: isoseq
    type:
      - 'null'
      - boolean
    doc: Activate specialized IsoSeq mode.
    inputBinding:
      position: 104
      prefix: --isoseq
  - id: keep_split_idx_order
    type:
      - 'null'
      - boolean
    doc: Keep identified order of barcode pair indices in split output names; 
      CCS only.
    inputBinding:
      position: 104
      prefix: --keep-split-idx-order
  - id: keep_tag_idx_order
    type:
      - 'null'
      - boolean
    doc: Keep identified order of barcode pair indices in BC tag; CCS only.
    inputBinding:
      position: 104
      prefix: --keep-tag-idx-order
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 104
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    default: WARN
    inputBinding:
      position: 104
      prefix: --log-level
  - id: match_score
    type:
      - 'null'
      - int
    doc: Score for a sequence match.
    default: 4
    inputBinding:
      position: 104
      prefix: --match-score
  - id: max_input_length
    type:
      - 'null'
      - int
    doc: Maximum input sequence length, 0 means deactivated.
    default: 0
    inputBinding:
      position: 104
      prefix: --max-input-length
  - id: max_scored_adapters
    type:
      - 'null'
      - int
    doc: Analyze at maximum the provided number of adapters per ZMW; 0 means 
      deactivated.
    default: 0
    inputBinding:
      position: 104
      prefix: --max-scored-adapters
  - id: max_scored_barcode_pairs
    type:
      - 'null'
      - int
    doc: Only use up to N barcode pair regions to find the barcode, 0 means use 
      all.
    default: 0
    inputBinding:
      position: 104
      prefix: --max-scored-barcode-pairs
  - id: max_scored_barcodes
    type:
      - 'null'
      - int
    doc: Analyze at maximum the provided number of barcodes per ZMW; 0 means 
      deactivated.
    default: 0
    inputBinding:
      position: 104
      prefix: --max-scored-barcodes
  - id: min_end_score
    type:
      - 'null'
      - int
    doc: Minimum end barcode score threshold is applied to the individual 
      leading and trailing ends.
    default: 0
    inputBinding:
      position: 104
      prefix: --min-end-score
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length after clipping.
    default: 50
    inputBinding:
      position: 104
      prefix: --min-length
  - id: min_passes
    type:
      - 'null'
      - int
    doc: Minimal number of full passes.
    default: 0
    inputBinding:
      position: 104
      prefix: --min-passes
  - id: min_ref_span
    type:
      - 'null'
      - float
    doc: Minimum reference span relative to the barcode length.
    default: 0.5
    inputBinding:
      position: 104
      prefix: --min-ref-span
  - id: min_score
    type:
      - 'null'
      - int
    doc: Reads with scores less than or equal to the minimum barcode score are 
      removed from downstream analysis.
    default: 0
    inputBinding:
      position: 104
      prefix: --min-score
  - id: min_score_lead
    type:
      - 'null'
      - int
    doc: The minimal score lead required to call a barcode pair significant.
    default: 10
    inputBinding:
      position: 104
      prefix: --min-score-lead
  - id: min_scoring_regions
    type:
      - 'null'
      - int
    doc: Minimum number of barcode regions with sufficient relative span to the 
      barcode length.
    default: 1
    inputBinding:
      position: 104
      prefix: --min-scoring-regions
  - id: min_signal_increase
    type:
      - 'null'
      - int
    doc: The minimal score difference, between first and combined, required to 
      call a barcode pair different.
    default: 10
    inputBinding:
      position: 104
      prefix: --min-signal-increase
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a mismatch.
    default: 13
    inputBinding:
      position: 104
      prefix: --mismatch-penalty
  - id: neighbor_barcodes
    type:
      - 'null'
      - boolean
    doc: Only output barcode pairs that are neighbors in barcode file.
    inputBinding:
      position: 104
      prefix: --neighbors
  - id: no_clip
    type:
      - 'null'
      - boolean
    doc: Call barcodes, but do not clip them from read sequences.
    inputBinding:
      position: 104
      prefix: --no-clip
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Do not generate demultiplexed output.
    inputBinding:
      position: 104
      prefix: --no-output
  - id: no_reports
    type:
      - 'null'
      - boolean
    doc: Do not generate reports.
    inputBinding:
      position: 104
      prefix: --no-reports
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 104
      prefix: --num-threads
  - id: omit_barcode_infix
    type:
      - 'null'
      - boolean
    doc: Omit barcode infix in file names.
    inputBinding:
      position: 104
      prefix: --omit-barcode-infix
  - id: output_handles
    type:
      - 'null'
      - int
    doc: Maximum number of open output files.
    default: 500
    inputBinding:
      position: 104
      prefix: --output-handles
  - id: output_missing_pairs
    type:
      - 'null'
      - boolean
    doc: Output all barcode pairs from biosamples, irrespective of presence.
    inputBinding:
      position: 104
      prefix: --output-missing-pairs
  - id: overwrite_biosample_names
    type:
      - 'null'
      - boolean
    doc: In isoseq mode, overwrite existing sample names in the SM tag
    inputBinding:
      position: 104
      prefix: --overwrite-biosample-names
  - id: peek
    type:
      - 'null'
      - int
    doc: Demux the first N ZMWs and return the mean score; 0 means peeking 
      deactivated.
    default: 0
    inputBinding:
      position: 104
      prefix: --peek
  - id: peek_guess
    type:
      - 'null'
      - boolean
    doc: Try to infer the used barcodes subset.
    inputBinding:
      position: 104
      prefix: --peek-guess
  - id: per_read
    type:
      - 'null'
      - boolean
    doc: Do not tag per ZMW, but per read.
    inputBinding:
      position: 104
      prefix: --per-read
  - id: reuse_biosample_uuids
    type:
      - 'null'
      - boolean
    doc: Use UUIDs from BioSamples, must be used with output BAM splitting.
    inputBinding:
      position: 104
      prefix: --reuse-biosample-uuids
  - id: reuse_source_uuid
    type:
      - 'null'
      - boolean
    doc: Use UUID from input dataset XML.
    inputBinding:
      position: 104
      prefix: --reuse-source-uuid
  - id: same_barcodes
    type:
      - 'null'
      - boolean
    doc: Only keep same barcodes in a pair in output.
    inputBinding:
      position: 104
      prefix: --same
  - id: score_full_pass
    type:
      - 'null'
      - boolean
    doc: Only use subreads flanked by adapters for barcode identification.
    inputBinding:
      position: 104
      prefix: --score-full-pass
  - id: scored_adapter_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of scored vs sequenced adapters.
    default: 0.25
    inputBinding:
      position: 104
      prefix: --scored-adapter-ratio
  - id: shared_prefix
    type:
      - 'null'
      - boolean
    doc: Barcodes may be substrings of others.
    inputBinding:
      position: 104
      prefix: --shared-prefix
  - id: single_side
    type:
      - 'null'
      - boolean
    doc: Assign single side barcodes by score clustering.
    inputBinding:
      position: 104
      prefix: --single-side
  - id: split_named
    type:
      - 'null'
      - boolean
    doc: Split output by resolved barcode pair name.
    inputBinding:
      position: 104
      prefix: --split-named
  - id: split_output
    type:
      - 'null'
      - boolean
    doc: Split output by barcode pair.
    inputBinding:
      position: 104
      prefix: --split
  - id: split_subdirs
    type:
      - 'null'
      - boolean
    doc: Output each barcode into its own sub-directory, only works with output 
      splitting.
    inputBinding:
      position: 104
      prefix: --split-subdirs
  - id: store_unbarcoded
    type:
      - 'null'
      - boolean
    doc: Store unbarcoded reads to <prefix>.removed.SUFFIX
    inputBinding:
      position: 104
      prefix: --store-unbarcoded
  - id: window_size
    type:
      - 'null'
      - int
    doc: The candidate region size in bp. If set, --window-size-mult will be 
      ignored.
    default: 0
    inputBinding:
      position: 104
      prefix: --window-size
  - id: window_size_multi
    type:
      - 'null'
      - float
    doc: 'The candidate region size multiplier: barcode_length * multiplier.'
    default: 3
    inputBinding:
      position: 104
      prefix: --window-size-multi
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lima:2.13.0--h9ee0642_0
stdout: lima.out
