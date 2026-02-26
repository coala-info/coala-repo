cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutadapt
label: cutadapt
doc: "Cutadapt removes adapter sequences from high-throughput sequencing reads.\n\n\
  Tool homepage: https://cutadapt.readthedocs.io/"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: input_fastq_r2
    type:
      - 'null'
      - File
    doc: Second input FASTQ file for paired-end reads
    inputBinding:
      position: 2
  - id: action
    type:
      - 'null'
      - string
    doc: "What to do if a match was found. trim: trim adapter and up- or downstream
      sequence; retain: trim, but retain adapter; mask: replace with 'N' characters;
      lowercase: convert to lowercase; crop: trim up and downstream sequence; none:
      leave unchanged."
    default: trim
    inputBinding:
      position: 103
      prefix: --action
  - id: adapter_a
    type:
      - 'null'
      - string
    doc: "Sequence of an adapter ligated to the 3' end (paired data: of the first
      read). The adapter and subsequent bases are trimmed. If a '$' character is appended
      ('anchoring'), the adapter is only found if it is a suffix of the read."
    inputBinding:
      position: 103
      prefix: --adapter
  - id: adapter_a_r2
    type:
      - 'null'
      - string
    doc: 3' adapter to be removed from R2
    inputBinding:
      position: 103
      prefix: -A
  - id: adapter_b
    type:
      - 'null'
      - string
    doc: "Sequence of an adapter that may be ligated to the 5' or 3' end (paired data:
      of the first read). Both types of matches as described under -a and -g are allowed.
      If the first base of the read is part of the match, the behavior is as with
      -g, otherwise as with -a. This option is mostly for rescuing failed library
      preparations - do not use if you know which end your adapter was ligated to!"
    inputBinding:
      position: 103
      prefix: --anywhere
  - id: adapter_b_r2
    type:
      - 'null'
      - string
    doc: 5'/3 adapter to be removed from R2
    inputBinding:
      position: 103
      prefix: -B
  - id: adapter_g
    type:
      - 'null'
      - string
    doc: "Sequence of an adapter ligated to the 5' end (paired data: of the first
      read). The adapter and any preceding bases are trimmed. Partial matches at the
      5' end are allowed. If a '^' character is prepended ('anchoring'), the adapter
      is only found if it is a prefix of the read."
    inputBinding:
      position: 103
      prefix: --front
  - id: adapter_g_r2
    type:
      - 'null'
      - string
    doc: 5' adapter to be removed from R2
    inputBinding:
      position: 103
      prefix: -G
  - id: compression_level
    type:
      - 'null'
      - int
    doc: 'Compression level for compressed output files. Default: 1'
    default: 1
    inputBinding:
      position: 103
      prefix: --compression-level
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use. Use 0 to auto-detect.
    default: 1
    inputBinding:
      position: 103
      prefix: --cores
  - id: cut
    type:
      - 'null'
      - int
    doc: Remove LEN bases from each read (or R1 if paired; use -U option for 
      R2). If LEN is positive, remove bases from the beginning. If LEN is 
      negative, remove bases from the end. Can be used twice if LENs have 
      different signs. Applied *before* adapter trimming.
    inputBinding:
      position: 103
      prefix: --cut
  - id: cut_r2
    type:
      - 'null'
      - int
    doc: Remove LENGTH bases from R2
    inputBinding:
      position: 103
      prefix: -U
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug log. Use twice to also print DP matrices
    inputBinding:
      position: 103
      prefix: --debug
  - id: discard
    type:
      - 'null'
      - boolean
    doc: Discard reads that contain an adapter. Use also -O to avoid discarding 
      too many randomly matching reads.
    inputBinding:
      position: 103
      prefix: --discard
  - id: discard_casava
    type:
      - 'null'
      - boolean
    doc: Discard reads that did not pass CASAVA filtering (header has :Y:).
    inputBinding:
      position: 103
      prefix: --discard-casava
  - id: discard_trimmed
    type:
      - 'null'
      - boolean
    doc: Discard reads that contain an adapter. Use also -O to avoid discarding 
      too many randomly matching reads.
    inputBinding:
      position: 103
      prefix: --discard-trimmed
  - id: discard_untrimmed
    type:
      - 'null'
      - boolean
    doc: Discard reads that do not contain an adapter.
    inputBinding:
      position: 103
      prefix: --discard-untrimmed
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Maximum allowed error rate (if 0 <= E < 1), or absolute number of 
      errors for full-length adapter match (if E is an integer >= 1). Error rate
      = no. of errors divided by length of matching region.
    default: 0.1
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: errors
    type:
      - 'null'
      - int
    doc: Maximum allowed error rate (if 0 <= E < 1), or absolute number of 
      errors for full-length adapter match (if E is an integer >= 1). Error rate
      = no. of errors divided by length of matching region.
    default: 0
    inputBinding:
      position: 103
      prefix: --errors
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Output FASTA to standard output even on FASTQ input.
    inputBinding:
      position: 103
      prefix: --fasta
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Read and/or write interleaved paired-end reads.
    inputBinding:
      position: 103
      prefix: --interleaved
  - id: length
    type:
      - 'null'
      - int
    doc: Shorten reads to LENGTH. Positive values remove bases at the end while 
      negative ones remove bases at the beginning. This and the following 
      modifications are applied after adapter trimming.
    inputBinding:
      position: 103
      prefix: --length
  - id: length_r2
    type:
      - 'null'
      - int
    doc: 'Shorten R2 to LENGTH. Default: same as for R1'
    inputBinding:
      position: 103
      prefix: -L
  - id: length_tag
    type:
      - 'null'
      - string
    doc: Search for TAG followed by a decimal number in the description field of
      the read. Replace the decimal number with the correct length of the 
      trimmed read. For example, use --length-tag 'length=' to correct fields 
      like 'length=123'.
    inputBinding:
      position: 103
      prefix: --length-tag
  - id: match_read_wildcards
    type:
      - 'null'
      - boolean
    doc: 'Interpret IUPAC wildcards in reads. Default: False'
    default: false
    inputBinding:
      position: 103
      prefix: --match-read-wildcards
  - id: max_aer
    type:
      - 'null'
      - float
    doc: as --max-expected-errors (see above), but divided by length to account 
      for reads of varying length.
    inputBinding:
      position: 103
      prefix: --max-aer
  - id: max_average_error_rate
    type:
      - 'null'
      - float
    doc: as --max-expected-errors (see above), but divided by length to account 
      for reads of varying length.
    inputBinding:
      position: 103
      prefix: --max-average-error-rate
  - id: max_ee
    type:
      - 'null'
      - float
    doc: Discard reads whose expected number of errors (computed from quality 
      values) exceeds ERRORS.
    inputBinding:
      position: 103
      prefix: --max-ee
  - id: max_expected_errors
    type:
      - 'null'
      - float
    doc: Discard reads whose expected number of errors (computed from quality 
      values) exceeds ERRORS.
    inputBinding:
      position: 103
      prefix: --max-expected-errors
  - id: max_n
    type:
      - 'null'
      - string
    doc: Discard reads with more than COUNT 'N' bases. If COUNT is a number 
      between 0 and 1, it is interpreted as a fraction of the read length.
    inputBinding:
      position: 103
      prefix: --max-n
  - id: maximum_length
    type:
      - 'null'
      - string
    doc: 'Discard reads longer than LEN. Default: no limit'
    inputBinding:
      position: 103
      prefix: --maximum-length
  - id: minimum_length
    type:
      - 'null'
      - string
    doc: 'Discard reads shorter than LEN. Default: 0'
    default: '0'
    inputBinding:
      position: 103
      prefix: --minimum-length
  - id: nextseq_trim
    type:
      - 'null'
      - int
    doc: NextSeq-specific quality trimming (each read). Trims also dark cycles 
      appearing as high-quality G bases.
    inputBinding:
      position: 103
      prefix: --nextseq-trim
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: 'Allow only mismatches in alignments. Default: allow both mismatches and
      indels'
    inputBinding:
      position: 103
      prefix: --no-indels
  - id: no_match_adapter_wildcards
    type:
      - 'null'
      - boolean
    doc: Do not interpret IUPAC wildcards in adapters.
    inputBinding:
      position: 103
      prefix: --no-match-adapter-wildcards
  - id: overlap
    type:
      - 'null'
      - int
    doc: Require MINLENGTH overlap between read and adapter for an adapter to be
      found.
    default: 3
    inputBinding:
      position: 103
      prefix: --overlap
  - id: pair_adapters
    type:
      - 'null'
      - boolean
    doc: Treat adapters given with -a/-A etc. as pairs. Either both or none are 
      removed from each read pair.
    inputBinding:
      position: 103
      prefix: --pair-adapters
  - id: pair_filter
    type:
      - 'null'
      - string
    doc: 'Which of the reads in a paired-end read have to match the filtering criterion
      in order for the pair to be filtered. Default: any'
    default: any
    inputBinding:
      position: 103
      prefix: --pair-filter
  - id: poly_a
    type:
      - 'null'
      - boolean
    doc: Trim poly-A tails
    inputBinding:
      position: 103
      prefix: --poly-a
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add this prefix to read names. Use {name} to insert the name of the 
      matching adapter.
    inputBinding:
      position: 103
      prefix: --prefix
  - id: quality_base
    type:
      - 'null'
      - int
    doc: 'Assume that quality values in FASTQ are encoded as ascii(quality + N). This
      needs to be set to 64 for some old Illumina FASTQ files. Default: 33'
    default: 33
    inputBinding:
      position: 103
      prefix: --quality-base
  - id: quality_cutoff
    type:
      - 'null'
      - string
    doc: Trim low-quality bases from 5' and/or 3' ends of each read before 
      adapter removal. Applied to both reads if data is paired. If one value is 
      given, only the 3' end is trimmed. If two comma-separated cutoffs are 
      given, the 5' end is trimmed with the first cutoff, the 3' end with the 
      second.
    inputBinding:
      position: 103
      prefix: --quality-cutoff
  - id: quality_cutoff_r2
    type:
      - 'null'
      - string
    doc: 'Quality-trimming cutoff for R2. Default: same as for R1'
    inputBinding:
      position: 103
      prefix: -Q
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Print only error messages.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: rename
    type:
      - 'null'
      - string
    doc: Rename reads using TEMPLATE containing variables such as {id}, 
      {adapter_name} etc. (see documentation)
    inputBinding:
      position: 103
      prefix: --rename
  - id: report
    type:
      - 'null'
      - string
    doc: "Which type of report to print: 'full' or 'minimal'."
    default: full
    inputBinding:
      position: 103
      prefix: --report
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: 'Check both the read and its reverse complement for adapter matches. If match
      is on reverse-complemented version, output that one. Default: check only read'
    inputBinding:
      position: 103
      prefix: --revcomp
  - id: strip_suffix
    type:
      - 'null'
      - type: array
        items: string
    doc: Remove this suffix from read names if present. Can be given multiple 
      times.
    inputBinding:
      position: 103
      prefix: --strip-suffix
  - id: suffix
    type:
      - 'null'
      - string
    doc: Add this suffix to read names; can also include {name}
    inputBinding:
      position: 103
      prefix: --suffix
  - id: times
    type:
      - 'null'
      - int
    doc: Remove up to COUNT adapters from each read.
    default: 1
    inputBinding:
      position: 103
      prefix: --times
  - id: trim_n
    type:
      - 'null'
      - boolean
    doc: Trim N's on ends of reads.
    inputBinding:
      position: 103
      prefix: --trim-n
  - id: trimmed_only
    type:
      - 'null'
      - boolean
    doc: Discard reads that do not contain an adapter.
    inputBinding:
      position: 103
      prefix: --trimmed-only
  - id: zero_cap
    type:
      - 'null'
      - boolean
    doc: Change negative quality values to zero.
    inputBinding:
      position: 103
      prefix: --zero-cap
outputs:
  - id: json
    type:
      - 'null'
      - File
    doc: Dump report in JSON format to FILE
    outputBinding:
      glob: $(inputs.json)
  - id: output
    type:
      - 'null'
      - File
    doc: "Write trimmed reads to FILE. FASTQ or FASTA format is chosen depending on
      input. Summary report is sent to standard output. Use '{name}' for demultiplexing
      (see docs). Default: write to standard output"
    outputBinding:
      glob: $(inputs.output)
  - id: info_file
    type:
      - 'null'
      - File
    doc: Write information about each read and its adapter matches into FILE. 
      See the documentation for the file format.
    outputBinding:
      glob: $(inputs.info_file)
  - id: rest_file
    type:
      - 'null'
      - File
    doc: When the adapter matches in the middle of a read, write the rest (after
      the adapter) to FILE.
    outputBinding:
      glob: $(inputs.rest_file)
  - id: wildcard_file
    type:
      - 'null'
      - File
    doc: When the adapter has N wildcard bases, write adapter bases matching 
      wildcard positions to FILE. (Inaccurate with indels.)
    outputBinding:
      glob: $(inputs.wildcard_file)
  - id: too_short_output
    type:
      - 'null'
      - File
    doc: 'Write reads that are too short (according to length specified by -m) to
      FILE. Default: discard reads'
    outputBinding:
      glob: $(inputs.too_short_output)
  - id: too_long_output
    type:
      - 'null'
      - File
    doc: 'Write reads that are too long (according to length specified by -M) to FILE.
      Default: discard reads'
    outputBinding:
      glob: $(inputs.too_long_output)
  - id: untrimmed_output
    type:
      - 'null'
      - File
    doc: 'Write reads that do not contain any adapter to FILE. Default: output to
      same file as trimmed reads'
    outputBinding:
      glob: $(inputs.untrimmed_output)
  - id: paired_output
    type:
      - 'null'
      - File
    doc: Write R2 to FILE.
    outputBinding:
      glob: $(inputs.paired_output)
  - id: info_file_paired
    type:
      - 'null'
      - File
    doc: Write info about R2 to FILE (see --info-file)
    outputBinding:
      glob: $(inputs.info_file_paired)
  - id: untrimmed_paired_output
    type:
      - 'null'
      - File
    doc: 'Write second read in a pair to this FILE when no adapter was found. Use
      with --untrimmed-output. Default: output to same file as trimmed reads'
    outputBinding:
      glob: $(inputs.untrimmed_paired_output)
  - id: too_short_paired_output
    type:
      - 'null'
      - File
    doc: Write second read in a pair to this file if pair is too short.
    outputBinding:
      glob: $(inputs.too_short_paired_output)
  - id: too_long_paired_output
    type:
      - 'null'
      - File
    doc: Write second read in a pair to this file if pair is too long.
    outputBinding:
      glob: $(inputs.too_long_paired_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutadapt:5.2--py311haab0aaa_0
