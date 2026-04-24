cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromap
label: chromap
doc: "Fast alignment and preprocessing of chromatin profiles\n\nTool homepage: https://github.com/haowenz/chromap"
inputs:
  - id: BED
    type:
      - 'null'
      - boolean
    doc: Output mappings in BED/BEDPE format
    inputBinding:
      position: 101
      prefix: --BED
  - id: SAM
    type:
      - 'null'
      - boolean
    doc: Output mappings in SAM format
    inputBinding:
      position: 101
      prefix: --SAM
  - id: TagAlign
    type:
      - 'null'
      - boolean
    doc: Output mappings in TagAlign/PairedTagAlign format
    inputBinding:
      position: 101
      prefix: --TagAlign
  - id: barcode
    type:
      - 'null'
      - File
    doc: Cell barcode files
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_translate
    type:
      - 'null'
      - File
    doc: Convert barcode to the specified sequences during output
    inputBinding:
      position: 101
      prefix: --barcode-translate
  - id: barcode_whitelist
    type:
      - 'null'
      - File
    doc: Cell barcode whitelist file
    inputBinding:
      position: 101
      prefix: --barcode-whitelist
  - id: bc_error_threshold
    type:
      - 'null'
      - int
    doc: Max Hamming distance allowed to correct a barcode
    inputBinding:
      position: 101
      prefix: --bc-error-threshold
  - id: bc_probability_threshold
    type:
      - 'null'
      - float
    doc: Min probability to correct a barcode
    inputBinding:
      position: 101
      prefix: --bc-probability-threshold
  - id: build_index
    type:
      - 'null'
      - boolean
    doc: Build index
    inputBinding:
      position: 101
      prefix: --build-index
  - id: chr_order
    type:
      - 'null'
      - File
    doc: Custom chromosome order file. If not specified, the order of reference 
      sequences will be used
    inputBinding:
      position: 101
      prefix: --chr-order
  - id: error_threshold
    type:
      - 'null'
      - int
    doc: 'Max # errors allowed to map a read'
    inputBinding:
      position: 101
      prefix: --error-threshold
  - id: frip_est_params
    type:
      - 'null'
      - string
    doc: coefficients used for frip est calculation, separated by semi-colons
    inputBinding:
      position: 101
      prefix: --frip-est-params
  - id: index
    type:
      - 'null'
      - File
    doc: Index file
    inputBinding:
      position: 101
      prefix: --index
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer length
    inputBinding:
      position: 101
      prefix: --kmer
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Use low memory mode
    inputBinding:
      position: 101
      prefix: --low-mem
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: Min MAPQ in range [0, 60] for mappings to be output
    inputBinding:
      position: 101
      prefix: --MAPQ-threshold
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Max insert size, only for paired-end read mapping
    inputBinding:
      position: 101
      prefix: --max-insert-size
  - id: max_seed_frequencies
    type:
      - 'null'
      - type: array
        items: int
    doc: Max seed frequencies for a seed to be selected
      - 500
      - 1000
    inputBinding:
      position: 101
      prefix: --max-seed-frequencies
  - id: min_frag_length
    type:
      - 'null'
      - int
    doc: Min fragment length for choosing k and w automatically
    inputBinding:
      position: 101
      prefix: --min-frag-length
  - id: min_num_seeds
    type:
      - 'null'
      - int
    doc: 'Min # seeds to try to map a read'
    inputBinding:
      position: 101
      prefix: --min-num-seeds
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Min read length
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: num_threads
    type:
      - 'null'
      - int
    doc: '# threads for mapping'
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: output_mappings_not_in_whitelist
    type:
      - 'null'
      - boolean
    doc: Output mappings with barcode not in the whitelist
    inputBinding:
      position: 101
      prefix: --output-mappings-not-in-whitelist
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: Output mappings in pairs format (defined by 4DN for HiC data)
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pairs_natural_chr_order
    type:
      - 'null'
      - File
    doc: Custom chromosome order file for pairs flipping. If not specified, the 
      custom chromosome order will be used
    inputBinding:
      position: 101
      prefix: --pairs-natural-chr-order
  - id: preset
    type:
      - 'null'
      - string
    doc: Preset parameters for mapping reads (always applied before other 
      options)
    inputBinding:
      position: 101
      prefix: --preset
  - id: read1
    type:
      - 'null'
      - File
    doc: Single-end read files or paired-end read files 1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Paired-end read files 2
    inputBinding:
      position: 101
      prefix: --read2
  - id: read_format
    type:
      - 'null'
      - string
    doc: Format for read files and barcode files
    inputBinding:
      position: 101
      prefix: --read-format
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference file
    inputBinding:
      position: 101
      prefix: --ref
  - id: remove_pcr_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove PCR duplicates
    inputBinding:
      position: 101
      prefix: --remove-pcr-duplicates
  - id: remove_pcr_duplicates_at_bulk_level
    type:
      - 'null'
      - boolean
    doc: Remove PCR duplicates at bulk level for single cell data
    inputBinding:
      position: 101
      prefix: --remove-pcr-duplicates-at-bulk-level
  - id: remove_pcr_duplicates_at_cell_level
    type:
      - 'null'
      - boolean
    doc: Remove PCR duplicates at cell level for single cell data
    inputBinding:
      position: 101
      prefix: --remove-pcr-duplicates-at-cell-level
  - id: split_alignment
    type:
      - 'null'
      - boolean
    doc: Allow split alignments
    inputBinding:
      position: 101
      prefix: --split-alignment
  - id: summary
    type:
      - 'null'
      - File
    doc: Summarize the mapping statistics at bulk or barcode level
    inputBinding:
      position: 101
      prefix: --summary
  - id: tn5_shift
    type:
      - 'null'
      - boolean
    doc: Perform Tn5 shift
    inputBinding:
      position: 101
      prefix: --Tn5-shift
  - id: trim_adapters
    type:
      - 'null'
      - boolean
    doc: Try to trim adapters on 3'
    inputBinding:
      position: 101
      prefix: --trim-adapters
  - id: turn_off_num_uniq_cache_slots
    type:
      - 'null'
      - boolean
    doc: turn off the output of number of cache slots in summary file
    inputBinding:
      position: 101
      prefix: --turn-off-num-uniq-cache-slots
  - id: window
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromap:0.3.2--h077b44d_0
