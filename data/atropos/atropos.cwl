cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atropos
  - trim
label: atropos
doc: "Trim adapters and low-quality bases from high-throughput sequencing reads 
  (atropos trim).\n\nTool homepage: https://github.com/jdidion/atropos"
inputs:
  - id: single_input
    type:
      - 'null'
      - File
    doc: A single-end read file.
    inputBinding:
      position: 101
      prefix: --single-input
  - id: input1
    type:
      - 'null'
      - File
    doc: The first input file (paired-end).
    inputBinding:
      position: 101
      prefix: --input1
  - id: input2
    type:
      - 'null'
      - File
    doc: The second input file (paired-end).
    inputBinding:
      position: 101
      prefix: --input2
  - id: interleaved_input
    type:
      - 'null'
      - File
    doc: Interleaved input file.
    inputBinding:
      position: 101
      prefix: --interleaved-input
  - id: format
    type:
      - 'null'
      - string
    doc: Input file format (fasta, fastq, sra-fastq, sam, bam). Auto-detected 
      from the file name extension by default.
    inputBinding:
      position: 101
      prefix: --format
  - id: quality_base
    type:
      - 'null'
      - int
    doc: Quality encoding offset of FASTQ input (33).
    inputBinding:
      position: 101
      prefix: --quality-base
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Optional sample ID. Added to the summary output.
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: adapter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --adapter
    doc: Sequence of an adapter ligated to the 3' end (paired data, first 
      read). Can be given several times.
    inputBinding:
      position: 101
  - id: front
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --front
    doc: Sequence of an adapter ligated to the 5' end (paired data, first 
      read).
    inputBinding:
      position: 101
  - id: anywhere
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --anywhere
    doc: Sequence of an adapter that may be ligated to the 5' or 3' end.
    inputBinding:
      position: 101
  - id: adapter2
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --adapter2
    doc: 3' adapter to be removed from the second read in a pair.
    inputBinding:
      position: 101
  - id: front2
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --front2
    doc: 5' adapter to be removed from the second read in a pair.
    inputBinding:
      position: 101
  - id: known_adapters_file
    type:
      - 'null'
      - File
    doc: FASTA file containing known adapter sequences.
    inputBinding:
      position: 101
      prefix: --known-adapters-file
  - id: no_default_adapters
    type:
      - 'null'
      - boolean
    doc: Don't fetch the default adapter list (stored in GitHub).
    inputBinding:
      position: 101
      prefix: --no-default-adapters
  - id: no_cache_adapters
    type:
      - 'null'
      - boolean
    doc: Don't cache the adapters list as '.adapters' in the working directory.
    inputBinding:
      position: 101
      prefix: --no-cache-adapters
  - id: aligner
    type:
      - 'null'
      - string
    doc: Alignment algorithm for finding adapters (adapter or insert).
    inputBinding:
      position: 101
      prefix: --aligner
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Maximum allowed error rate for adapter match (0.1).
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: Allow only mismatches in alignments.
    inputBinding:
      position: 101
      prefix: --no-indels
  - id: times
    type:
      - 'null'
      - int
    doc: Remove up to COUNT adapters from each read (1).
    inputBinding:
      position: 101
      prefix: --times
  - id: overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between read and adapter for trimming (3).
    inputBinding:
      position: 101
      prefix: --overlap
  - id: match_read_wildcards
    type:
      - 'null'
      - boolean
    doc: Interpret IUPAC wildcards in reads.
    inputBinding:
      position: 101
      prefix: --match-read-wildcards
  - id: no_match_adapter_wildcards
    type:
      - 'null'
      - boolean
    doc: Do not interpret IUPAC wildcards in adapters.
    inputBinding:
      position: 101
      prefix: --no-match-adapter-wildcards
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Match and redirect reads as usual, but do not remove adapters.
    inputBinding:
      position: 101
      prefix: --no-trim
  - id: mask_adapter
    type:
      - 'null'
      - boolean
    doc: Mask adapters with 'N' characters instead of trimming them.
    inputBinding:
      position: 101
      prefix: --mask-adapter
  - id: cut
    type:
      - 'null'
      - int
    doc: Remove bases from each read (positive from the start, negative from 
      the end).
    inputBinding:
      position: 101
      prefix: --cut
  - id: cut2
    type:
      - 'null'
      - int
    doc: Remove bases from the second read in a pair.
    inputBinding:
      position: 101
      prefix: --cut2
  - id: quality_cutoff
    type:
      - 'null'
      - string
    doc: "Trim low-quality bases: [5'CUTOFF,]3'CUTOFF."
    inputBinding:
      position: 101
      prefix: --quality-cutoff
  - id: nextseq_trim
    type:
      - 'null'
      - int
    doc: NextSeq-specific quality trimming 3' cutoff.
    inputBinding:
      position: 101
      prefix: --nextseq-trim
  - id: trim_n
    type:
      - 'null'
      - boolean
    doc: Trim N's on ends of reads.
    inputBinding:
      position: 101
      prefix: --trim-n
  - id: discard_trimmed
    type:
      - 'null'
      - boolean
    doc: Discard reads that contain an adapter.
    inputBinding:
      position: 101
      prefix: --discard-trimmed
  - id: discard_untrimmed
    type:
      - 'null'
      - boolean
    doc: Discard reads that do not contain the adapter.
    inputBinding:
      position: 101
      prefix: --discard-untrimmed
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Discard trimmed reads that are shorter than LENGTH (0).
    inputBinding:
      position: 101
      prefix: --minimum-length
  - id: maximum_length
    type:
      - 'null'
      - int
    doc: Discard trimmed reads that are longer than LENGTH.
    inputBinding:
      position: 101
      prefix: --maximum-length
  - id: max_n
    type:
      - 'null'
      - float
    doc: Discard reads with too many N bases (count, or proportion if between 0
      and 1).
    inputBinding:
      position: 101
      prefix: --max-n
  - id: pair_filter
    type:
      - 'null'
      - string
    doc: Which reads in a pair must match the filter for the pair to be 
      filtered (any or both).
    inputBinding:
      position: 101
      prefix: --pair-filter
  - id: report_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Report type(s) to generate (txt, json, yaml, pickle).
    inputBinding:
      position: 101
      prefix: --report-formats
  - id: stats
    type:
      - 'null'
      - string
    doc: Which read-level statistics to compute (none, pre, post, both).
    inputBinding:
      position: 101
      prefix: --stats
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for read trimming.
    inputBinding:
      position: 101
      prefix: --threads
  - id: preserve_order
    type:
      - 'null'
      - boolean
    doc: Preserve order of reads in input files.
    inputBinding:
      position: 101
      prefix: --preserve-order
  - id: output_path
    type: string
    doc: Write trimmed reads to FILE (first read for paired data).
    inputBinding:
      position: 102
      prefix: --output
  - id: paired_output_path
    type:
      - 'null'
      - string
    doc: Write the second read in a pair to FILE.
    inputBinding:
      position: 102
      prefix: --paired-output
  - id: too_short_output_path
    type:
      - 'null'
      - string
    doc: Write reads that are too short (see --minimum-length) to FILE.
    inputBinding:
      position: 102
      prefix: --too-short-output
  - id: untrimmed_output_path
    type:
      - 'null'
      - string
    doc: Write reads that do not contain the adapter to FILE.
    inputBinding:
      position: 102
      prefix: --untrimmed-output
  - id: info_file_path
    type:
      - 'null'
      - string
    doc: Write information about each read and its adapter matches into FILE.
    inputBinding:
      position: 102
      prefix: --info-file
  - id: report_file_path
    type:
      - 'null'
      - string
    doc: Write the report to FILE rather than stdout.
    inputBinding:
      position: 102
      prefix: --report-file
outputs:
  - id: output
    type: File
    doc: Trimmed reads (first read for paired data).
    outputBinding:
      glob: $(inputs.output_path)
  - id: paired_output
    type:
      - 'null'
      - File
    doc: Trimmed second reads.
    outputBinding:
      glob: $(inputs.paired_output_path)
  - id: too_short_output
    type:
      - 'null'
      - File
    doc: Reads that are too short.
    outputBinding:
      glob: $(inputs.too_short_output_path)
  - id: untrimmed_output
    type:
      - 'null'
      - File
    doc: Reads without adapter.
    outputBinding:
      glob: $(inputs.untrimmed_output_path)
  - id: info_file
    type:
      - 'null'
      - File
    doc: Per-read adapter match information.
    outputBinding:
      glob: $(inputs.info_file_path)
  - id: report_files
    type:
      type: array
      items: File
    doc: Report file(s); with several report formats the report file name is 
      used as a prefix.
    outputBinding:
      glob: '$(inputs.report_file_path ? inputs.report_file_path + "*" : [])'
  - id: stdout
    type: stdout
    doc: Summary report when no report file is given.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atropos:1.1.32--py312h0fa9677_4
stdout: atropos.out
