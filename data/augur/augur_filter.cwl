cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur filter
label: augur_filter
doc: "Filter and subsample a sequence set. SeqKit is used behind the scenes to handle
  FASTA files, but this should be considered an implementation detail that may change
  in the future. The CLI program seqkit must be available. If it's not on PATH (or
  you want to use a version different from what's on PATH), set the SEQKIT environment
  variable to path of the desired seqkit executable. VCFtools is used behind the scenes
  to handle VCF files, but this should be considered an implementation detail that
  may change in the future. The CLI program vcftools must be available on PATH.\n\n\
  Tool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: empty_output_reporting
    type:
      - 'null'
      - string
    doc: How should empty outputs be reported when no strains pass filtering 
      and/or subsampling.
    inputBinding:
      position: 101
      prefix: --empty-output-reporting
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: File(s) with list of strains to exclude.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: exclude_all
    type:
      - 'null'
      - boolean
    doc: Exclude all strains by default. Use this with the include arguments to 
      select a specific subset of strains.
    inputBinding:
      position: 101
      prefix: --exclude-all
  - id: exclude_ambiguous_dates_by
    type:
      - 'null'
      - string
    doc: Exclude ambiguous dates by day (e.g., 2020-09-XX), month (e.g., 
      2020-XX-XX), year (e.g., 200X-10-01), or any date fields. An ambiguous 
      year makes the corresponding month and day ambiguous, too, even if those 
      fields have unambiguous values (e.g., "201X-10-01"). Similarly, an 
      ambiguous month makes the corresponding day ambiguous (e.g., 
      "2010-XX-01").
    inputBinding:
      position: 101
      prefix: --exclude-ambiguous-dates-by
  - id: exclude_where
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Exclude sequences matching these conditions. Ex: "host=rat" or "host!=rat".
      Multiple values are processed as OR (matching any of those specified will be
      excluded), not AND.'
    inputBinding:
      position: 101
      prefix: --exclude-where
  - id: group_by
    type:
      - 'null'
      - type: array
        items: string
    doc: "Grouping columns for subsampling. Notes: (1) Grouping by ['month', 'week',
      'year'] is only supported when there is a 'date' column in the metadata. (2)
      'week' uses the ISO week numbering system, where a week starts on a Monday and
      ends on a Sunday. (3) 'month' and 'week' grouping cannot be used together. (4)
      Custom columns ['month', 'week', 'year'] in the metadata are ignored for grouping.
      Please rename them if you want to use their values for grouping."
    inputBinding:
      position: 101
      prefix: --group-by
  - id: group_by_weights
    type:
      - 'null'
      - File
    doc: "TSV file defining weights for grouping. Requirements: (1) Lines starting
      with '#' are treated as comment lines. (2) The first non-comment line must be
      a header row. (3) There must be a numeric ``weight`` column (weights can take
      on any non-negative values). (4) Other columns must be a subset of grouping
      columns, with combinations of values covering all combinations present in the
      metadata. (5) This option only applies when grouping columns and a total sample
      size are provided. (6) This option can only be used when probabilistic sampling
      is allowed. Notes: (1) Any grouping columns absent from this file will be given
      equal weighting across all values *within* groups defined by the other weighted
      columns. (2) An entry with the value ``default`` under all columns will be treated
      as the default weight for specific groups present in the metadata but missing
      from the weights file. If there is no default weight and the metadata contains
      rows that are not covered by the given weights, augur filter will exit with
      an error."
    inputBinding:
      position: 101
      prefix: --group-by-weights
  - id: include
    type:
      - 'null'
      - type: array
        items: File
    doc: File(s) with list of strains to include regardless of priorites, 
      subsampling, or absence of an entry in sequences.
    inputBinding:
      position: 101
      prefix: --include
  - id: include_where
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Include sequences with these values. ex: host=rat. Multiple values are processed
      as OR (having any of those specified will be included), not AND. This rule is
      applied last and ensures any strains matching these rules will be included regardless
      of priorities, subsampling, or absence of an entry in sequences.'
    inputBinding:
      position: 101
      prefix: --include-where
  - id: max_date
    type:
      - 'null'
      - string
    doc: "Maximal cutoff for date (inclusive). Supported formats: 1. an Augur-style
      numeric date with the year as the integer part (e.g. 2020.42) or 2. a date in
      ISO 8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04') or 3. a backwards-looking
      relative date in ISO 8601 duration format with optional P prefix (e.g. '1W',
      'P1W')"
    inputBinding:
      position: 101
      prefix: --max-date
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length of the sequences, only counting standard nucleotide 
      characters A, C, G, or T (case-insensitive).
    inputBinding:
      position: 101
      prefix: --max-length
  - id: metadata
    type: File
    doc: sequence metadata
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_chunk_size
    type:
      - 'null'
      - int
    doc: maximum number of metadata records to read into memory at a time. 
      Increasing this number can speed up filtering at the cost of more memory 
      used.
    inputBinding:
      position: 101
      prefix: --metadata-chunk-size
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: delimiters to accept when reading a metadata file. Only one delimiter 
      will be inferred.
      - ','
      - "\t"
    inputBinding:
      position: 101
      prefix: --metadata-delimiters
  - id: metadata_id_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: names of possible metadata columns containing identifier information, 
      ordered by priority. Only one ID column will be inferred.
      - strain
      - name
    inputBinding:
      position: 101
      prefix: --metadata-id-columns
  - id: min_date
    type:
      - 'null'
      - string
    doc: "Minimal cutoff for date (inclusive). Supported formats: 1. an Augur-style
      numeric date with the year as the integer part (e.g. 2020.42) or 2. a date in
      ISO 8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04') or 3. a backwards-looking
      relative date in ISO 8601 duration format with optional P prefix (e.g. '1W',
      'P1W')"
    inputBinding:
      position: 101
      prefix: --min-date
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimal length of the sequences, only counting standard nucleotide 
      characters A, C, G, or T (case-insensitive).
    inputBinding:
      position: 101
      prefix: --min-length
  - id: no_probabilistic_sampling
    type:
      - 'null'
      - boolean
    doc: Disables probabilistic sampling.
    inputBinding:
      position: 101
      prefix: --no-probabilistic-sampling
  - id: non_nucleotide
    type:
      - 'null'
      - boolean
    doc: Exclude sequences that contain illegal characters.
    inputBinding:
      position: 101
      prefix: --non-nucleotide
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of CPUs/cores/threads/jobs to utilize at once.
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: priority
    type:
      - 'null'
      - File
    doc: tab-delimited file with list of priority scores for strains (e.g., 
      "<strain>\t<priority>") and no header. When scores are provided, Augur 
      converts scores to floating point values, sorts strains within each 
      subsampling group from highest to lowest priority, and selects the top N 
      strains per group where N is the calculated or requested number of strains
      per group. Higher numbers indicate higher priority. Since priorities 
      represent relative values between strains, these values can be arbitrary.
    inputBinding:
      position: 101
      prefix: --priority
  - id: probabilistic_sampling
    type:
      - 'null'
      - boolean
    doc: Allow probabilistic sampling during subsampling. This is useful when 
      there are more groups than requested sequences. This option only applies 
      when a total sample size is provided.
    inputBinding:
      position: 101
      prefix: --probabilistic-sampling
  - id: query
    type:
      - 'null'
      - string
    doc: Filter sequences by attribute. Uses `Pandas DataFrame query syntax`__. 
      (e.g., "country == 'Colombia'" or "(country == 'USA' & (division == 
      'Washington'))") __ 
      https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#indexing-query
    inputBinding:
      position: 101
      prefix: --query
  - id: query_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: "Use alongside query to specify columns and data types in the format 'column:type',
      where type is one of (bool,float,int,str). Automatic type inference will be
      attempted on all unspecified columns used in the query. Example: region:str
      coverage:float."
    inputBinding:
      position: 101
      prefix: --query-columns
  - id: sequence_index
    type:
      - 'null'
      - File
    doc: sequence composition report generated by augur index. If not provided, 
      an index will be created on the fly. This should be generated from the 
      same file as --sequences.
    inputBinding:
      position: 101
      prefix: --sequence-index
  - id: sequences
    type:
      - 'null'
      - File
    doc: sequences in FASTA or VCF format. For large inputs, consider using 
      --sequence-index in addition to this option.
    inputBinding:
      position: 101
      prefix: --sequences
  - id: sequences_per_group
    type:
      - 'null'
      - int
    doc: Select no more than this number of sequences per category.
    inputBinding:
      position: 101
      prefix: --sequences-per-group
  - id: skip_checks
    type:
      - 'null'
      - boolean
    doc: use this option to skip checking for duplicates in sequences and 
      whether ids in metadata have a sequence entry. Can improve performance on 
      large files. Note that this should only be used if you are sure there are 
      no duplicate sequences or mismatched ids since they can lead to errors in 
      downstream Augur commands.
    inputBinding:
      position: 101
      prefix: --skip-checks
  - id: subsample_max_sequences
    type:
      - 'null'
      - int
    doc: Select no more than this number of sequences (i.e. total sample size). 
      Can be used without grouping columns.
    inputBinding:
      position: 101
      prefix: --subsample-max-sequences
  - id: subsample_seed
    type:
      - 'null'
      - int
    doc: random number generator seed to allow reproducible subsampling (with 
      same input data).
    inputBinding:
      position: 101
      prefix: --subsample-seed
outputs:
  - id: output_sequences
    type:
      - 'null'
      - File
    doc: filtered sequences in FASTA format
    outputBinding:
      glob: $(inputs.output_sequences)
  - id: output_metadata
    type:
      - 'null'
      - File
    doc: metadata for strains that passed filters
    outputBinding:
      glob: $(inputs.output_metadata)
  - id: output_strains
    type:
      - 'null'
      - File
    doc: list of strains that passed filters (no header)
    outputBinding:
      glob: $(inputs.output_strains)
  - id: output_log
    type:
      - 'null'
      - File
    doc: tab-delimited file with one row for each filtered strain and the reason
      it was filtered. Keyword arguments used for a given filter are reported in
      JSON format in a `kwargs` column.
    outputBinding:
      glob: $(inputs.output_log)
  - id: output_group_by_sizes
    type:
      - 'null'
      - File
    doc: tab-delimited file one row per group with target size.
    outputBinding:
      glob: $(inputs.output_group_by_sizes)
  - id: output
    type:
      - 'null'
      - File
    doc: alias to --output-sequences
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
