cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqmagick
  - convert
label: seqmagick_convert
doc: "Convert between sequence formats\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs:
  - id: source_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: dest_file
    type: File
    doc: Output file
    inputBinding:
      position: 2
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Input alphabet. Required for writing NEXUS.
    inputBinding:
      position: 103
      prefix: --alphabet
  - id: apply_function
    type:
      - 'null'
      - string
    doc: Specify a custom function to apply to the input sequences, specified as
      /path/to/file.py:function_name. Function should accept an iterable of 
      Bio.SeqRecord objects, and yield SeqRecords. If the parameter is 
      specified, it will be passed as a string as the second argument to the 
      function. Specify more than one to chain.
    inputBinding:
      position: 103
      prefix: --apply-function
  - id: cut
    type:
      - 'null'
      - string
    doc: 'Keep only the residues within the 1-indexed start and end positions specified,
      : separated. Includes last item. Start or end can be left unspecified to indicate
      start/end of sequence. A negative start may be provided to indicate an offset
      from the end of the sequence. Note that to prevent negative numbers being interpreted
      as flags, this should be written with an equals sign between `--cut` and the
      argument, e.g.: `--cut=-10:`'
    inputBinding:
      position: 103
      prefix: --cut
  - id: dash_gap
    type:
      - 'null'
      - boolean
    doc: Replace any of the characters "?:~" with a "-" for all sequences
    inputBinding:
      position: 103
      prefix: --dash-gap
  - id: deduplicate_sequences
    type:
      - 'null'
      - boolean
    doc: Remove any duplicate sequences by sequence content, keep the first 
      instance seen
    inputBinding:
      position: 103
      prefix: --deduplicate-sequences
  - id: deduplicate_taxa
    type:
      - 'null'
      - boolean
    doc: Remove any duplicate sequences by ID, keep the first instance seen
    inputBinding:
      position: 103
      prefix: --deduplicate-taxa
  - id: deduplicated_sequences_file
    type:
      - 'null'
      - File
    doc: Write all of the deduplicated sequences to a file
    inputBinding:
      position: 103
      prefix: --deduplicated-sequences-file
  - id: drop
    type:
      - 'null'
      - string
    doc: Remove the residues at the specified indices. Same format as `--cut`.
    inputBinding:
      position: 103
      prefix: --drop
  - id: exclude_from_file
    type:
      - 'null'
      - File
    doc: Filter sequences, removing those sequence IDs in the specified file
    inputBinding:
      position: 103
      prefix: --exclude-from-file
  - id: first_name
    type:
      - 'null'
      - boolean
    doc: Take only the first whitespace-delimited word as the name of the 
      sequence
    inputBinding:
      position: 103
      prefix: --first-name
  - id: head
    type:
      - 'null'
      - int
    doc: Trim down to top N sequences. With the leading `-', print all but the 
      last N sequences.
    inputBinding:
      position: 103
      prefix: --head
  - id: include_from_file
    type:
      - 'null'
      - File
    doc: Filter sequences, keeping only those sequence IDs in the specified file
    inputBinding:
      position: 103
      prefix: --include-from-file
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input file format (default: determine from extension)'
    inputBinding:
      position: 103
      prefix: --input-format
  - id: line_wrap
    type:
      - 'null'
      - int
    doc: Adjust line wrap for sequence strings. When N is 0, all line breaks are
      removed. Only fasta files are supported for the output format.
    inputBinding:
      position: 103
      prefix: --line-wrap
  - id: lower
    type:
      - 'null'
      - boolean
    doc: Translate the sequences to lower case
    inputBinding:
      position: 103
      prefix: --lower
  - id: mask
    type:
      - 'null'
      - string
    doc: Replace residues in 1-indexed slice with gap- characters. If 
      --relative-to is also specified, coordinates are relative to the sequence 
      ID provided.
    inputBinding:
      position: 103
      prefix: --mask
  - id: max_length
    type:
      - 'null'
      - int
    doc: Discard any sequences beyond the specified maximum length. This 
      operation occurs *before* all length-changing options such as cut and 
      squeeze.
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Discard any sequences less than the specified minimum length. This 
      operation occurs *before* cut and squeeze.
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_ungapped_length
    type:
      - 'null'
      - int
    doc: Discard any sequences less than the specified minimum length, excluding
      gaps. This operation occurs *before* cut and squeeze.
    inputBinding:
      position: 103
      prefix: --min-ungapped-length
  - id: name_prefix
    type:
      - 'null'
      - string
    doc: Insert a prefix for all IDs.
    inputBinding:
      position: 103
      prefix: --name-prefix
  - id: name_suffix
    type:
      - 'null'
      - string
    doc: Append a suffix to all IDs.
    inputBinding:
      position: 103
      prefix: --name-suffix
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output file format (default: determine from extension)'
    inputBinding:
      position: 103
      prefix: --output-format
  - id: pattern_exclude
    type:
      - 'null'
      - string
    doc: Filter the sequences by regular expression in ID or description
    inputBinding:
      position: 103
      prefix: --pattern-exclude
  - id: pattern_include
    type:
      - 'null'
      - string
    doc: Filter the sequences by regular expression in ID or description
    inputBinding:
      position: 103
      prefix: --pattern-include
  - id: pattern_replace
    type:
      - 'null'
      - type: array
        items: string
    doc: Replace regex pattern "search_pattern" with "replace_pattern" in 
      sequence ID and description
    inputBinding:
      position: 103
      prefix: --pattern-replace
  - id: prune_empty
    type:
      - 'null'
      - boolean
    doc: Prune sequences containing only gaps ('-')
    inputBinding:
      position: 103
      prefix: --prune-empty
  - id: relative_to
    type:
      - 'null'
      - string
    doc: Apply --cut relative to the indexes of non-gap residues in sequence 
      identified by ID
    inputBinding:
      position: 103
      prefix: --relative-to
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse the order of sites in sequences
    inputBinding:
      position: 103
      prefix: --reverse
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Convert sequences into reverse complements
    inputBinding:
      position: 103
      prefix: --reverse-complement
  - id: sample
    type:
      - 'null'
      - int
    doc: Select a random sampling of sequences
    inputBinding:
      position: 103
      prefix: --sample
  - id: sample_seed
    type:
      - 'null'
      - int
    doc: Set random seed for sampling of sequences
    inputBinding:
      position: 103
      prefix: --sample-seed
  - id: seq_pattern_exclude
    type:
      - 'null'
      - string
    doc: Filter the sequences by regular expression in sequence
    inputBinding:
      position: 103
      prefix: --seq-pattern-exclude
  - id: seq_pattern_include
    type:
      - 'null'
      - string
    doc: Filter the sequences by regular expression in sequence
    inputBinding:
      position: 103
      prefix: --seq-pattern-include
  - id: sort
    type:
      - 'null'
      - string
    doc: Perform sorting by length or name, ascending or descending. ASCII 
      sorting is performed for names
    inputBinding:
      position: 103
      prefix: --sort
  - id: squeeze
    type:
      - 'null'
      - boolean
    doc: Remove any gaps that are present in the same position across all 
      sequences in an alignment (equivalent to --squeeze-threshold=1.0)
    inputBinding:
      position: 103
      prefix: --squeeze
  - id: squeeze_threshold
    type:
      - 'null'
      - string
    doc: Trim columns from an alignment which have gaps in least the specified 
      proportion of sequences.
    inputBinding:
      position: 103
      prefix: --squeeze-threshold
  - id: strip_range
    type:
      - 'null'
      - boolean
    doc: Strip ranges from sequences IDs, matching </x-y>
    inputBinding:
      position: 103
      prefix: --strip-range
  - id: tail
    type:
      - 'null'
      - int
    doc: Trim down to bottom N sequences. Use +N to output sequences starting 
      with the Nth.
    inputBinding:
      position: 103
      prefix: --tail
  - id: transcribe
    type:
      - 'null'
      - string
    doc: Transcription and back transcription for generic DNA and RNA. Source 
      sequences must be the correct alphabet or this action will likely produce 
      incorrect results.
    inputBinding:
      position: 103
      prefix: --transcribe
  - id: translate
    type:
      - 'null'
      - string
    doc: Translate from generic DNA/RNA to proteins. Options with "stop" suffix 
      will NOT translate through stop codons . Source sequences must be the 
      correct alphabet or this action will likely produce incorrect results.
    inputBinding:
      position: 103
      prefix: --translate
  - id: ungap
    type:
      - 'null'
      - boolean
    doc: Remove gaps in the sequence alignment
    inputBinding:
      position: 103
      prefix: --ungap
  - id: upper
    type:
      - 'null'
      - boolean
    doc: Translate the sequences to upper case
    inputBinding:
      position: 103
      prefix: --upper
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
stdout: seqmagick_convert.out
