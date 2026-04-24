cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopCountDB
label: kpop_KPopCountDB
doc: "KPopCountDB version 41 (18-Mar-2024)\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: add_combined_selection
    type:
      - 'null'
      - string
    doc: combine the spectra whose labels are in the selection register and add 
      the result (or replace it if a spectrum named <spectrum_label> already 
      exists) to the database present in the database register
    inputBinding:
      position: 101
      prefix: --add-combined-selection
  - id: add_kmer_files
    type:
      - 'null'
      - type: array
        items: string
    doc: add to the database present in the register k-mers from the specified 
      files
    inputBinding:
      position: 101
      prefix: --add-kmer-files
  - id: add_kmers
    type:
      - 'null'
      - type: array
        items: string
    doc: add to the database present in the register k-mers from the specified 
      files
    inputBinding:
      position: 101
      prefix: --add-kmers
  - id: add_metadata
    type:
      - 'null'
      - File
    doc: add to the database present in the register metadata from the specified
      file. Metadata field names and values must not contain double quote " 
      characters
    inputBinding:
      position: 101
      prefix: --add-metadata
  - id: combination_criterion
    type:
      - 'null'
      - string
    doc: set the criterion used to combine the k-mer frequencies of selected 
      spectra. To avoid rounding issues, each k-mer frequency is also rescaled 
      by the largest normalization across spectra ('mean' averages frequencies 
      across spectra; 'median' computes the median across spectra)
    inputBinding:
      position: 101
      prefix: --selection-combination-criterion
  - id: combination_criterion
    type:
      - 'null'
      - string
    doc: set the criterion used to combine the k-mer frequencies of selected 
      spectra. To avoid rounding issues, each k-mer frequency is also rescaled 
      by the largest normalization across spectra ('mean' averages frequencies 
      across spectra; 'median' computes the median across spectra)
    inputBinding:
      position: 101
      prefix: --combination-criterion
  - id: compute_distances
    type:
      - 'null'
      - type: array
        items: string
    doc: select two sets of spectra from the register and compute and output 
      distances between all possible pairs (metadata fields must match the 
      regexps specified in the selector; an empty metadata field makes the 
      regexp match labels. The result will have extension .KPopDMatrix)
    inputBinding:
      position: 101
      prefix: --distances
  - id: compute_distances
    type:
      - 'null'
      - type: array
        items: string
    doc: select two sets of spectra from the register and compute and output 
      distances between all possible pairs (metadata fields must match the 
      regexps specified in the selector; an empty metadata field makes the 
      regexp match labels. The result will have extension .KPopDMatrix)
    inputBinding:
      position: 101
      prefix: --compute-distances
  - id: compute_spectral_distances
    type:
      - 'null'
      - type: array
        items: string
    doc: select two sets of spectra from the register and compute and output 
      distances between all possible pairs (metadata fields must match the 
      regexps specified in the selector; an empty metadata field makes the 
      regexp match labels. The result will have extension .KPopDMatrix)
    inputBinding:
      position: 101
      prefix: --compute-spectral-distances
  - id: delete
    type:
      - 'null'
      - boolean
    doc: drop the spectra whose labels are in the selection register from the 
      database present in the register
    inputBinding:
      position: 101
      prefix: --delete
  - id: distance_function
    type:
      - 'null'
      - string
    doc: set the function to be used when computing distances. The parameter for
      'minkowski()' is the power (default='euclidean')
    inputBinding:
      position: 101
      prefix: --distance
  - id: distance_function
    type:
      - 'null'
      - string
    doc: set the function to be used when computing distances. The parameter for
      'minkowski()' is the power (default='euclidean')
    inputBinding:
      position: 101
      prefix: --distance-function
  - id: empty
    type:
      - 'null'
      - boolean
    doc: put an empty database into the register
    inputBinding:
      position: 101
      prefix: --empty
  - id: input_file
    type:
      - 'null'
      - File
    doc: load into the register the database present in the specified file 
      (which must have extension .KPopCounter)
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_table_file_name
    type:
      - 'null'
      - type: array
        items: string
    doc: add to the database present in the register k-mers from the specified 
      files
    inputBinding:
      position: 101
      prefix: --kmers
  - id: metadata_table_file_name
    type:
      - 'null'
      - File
    doc: add to the database present in the register metadata from the specified
      file. Metadata field names and values must not contain double quote " 
      characters
    inputBinding:
      position: 101
      prefix: --metadata
  - id: normalize_distances
    type:
      - 'null'
      - boolean
    doc: whether spectra should be normalized prior to computing distances
    inputBinding:
      position: 101
      prefix: --distance-normalize
  - id: normalize_distances
    type:
      - 'null'
      - boolean
    doc: whether spectra should be normalized prior to computing distances
    inputBinding:
      position: 101
      prefix: --normalize-distances
  - id: normalize_distances
    type:
      - 'null'
      - boolean
    doc: whether spectra should be normalized prior to computing distances
    inputBinding:
      position: 101
      prefix: --distance-normalization
  - id: selection_clear
    type:
      - 'null'
      - boolean
    doc: purge the selection register
    inputBinding:
      position: 101
      prefix: --selection-clear
  - id: selection_combine_and_add
    type:
      - 'null'
      - string
    doc: combine the spectra whose labels are in the selection register and add 
      the result (or replace it if a spectrum named <spectrum_label> already 
      exists) to the database present in the database register
    inputBinding:
      position: 101
      prefix: --selection-combine-and-add
  - id: selection_delete
    type:
      - 'null'
      - boolean
    doc: drop the spectra whose labels are in the selection register from the 
      database present in the register
    inputBinding:
      position: 101
      prefix: --selection-delete
  - id: selection_from_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: put into the selection register the specified labels
    inputBinding:
      position: 101
      prefix: --selection-from-labels
  - id: selection_from_regexps
    type:
      - 'null'
      - type: array
        items: string
    doc: put into the selection register the labels of the spectra whose 
      metadata fields match the specified regexps and where regexps are defined 
      according to <https://ocaml.org/api/Str.html>. An empty metadata field 
      makes the regexp match labels
    inputBinding:
      position: 101
      prefix: --regexps
  - id: selection_from_regexps
    type:
      - 'null'
      - type: array
        items: string
    doc: put into the selection register the labels of the spectra whose 
      metadata fields match the specified regexps and where regexps are defined 
      according to <https://ocaml.org/api/Str.html>. An empty metadata field 
      makes the regexp match labels
    inputBinding:
      position: 101
      prefix: --selection-from-regexps
  - id: selection_negate
    type:
      - 'null'
      - boolean
    doc: negate the labels that are present in the selection register
    inputBinding:
      position: 101
      prefix: --selection-negate
  - id: selection_print
    type:
      - 'null'
      - boolean
    doc: print the labels that are present in the selection register
    inputBinding:
      position: 101
      prefix: --selection-print
  - id: selection_to_table_filter
    type:
      - 'null'
      - boolean
    doc: filter out spectra whose labels are present in the selection register 
      when writing the database as a tab-separated file
    inputBinding:
      position: 101
      prefix: --selection-to-table-filter
  - id: spectrum_label
    type:
      - 'null'
      - type: array
        items: string
    doc: put into the selection register the specified labels
    inputBinding:
      position: 101
      prefix: --labels
  - id: summary
    type:
      - 'null'
      - boolean
    doc: print a summary of the database present in the register
    inputBinding:
      position: 101
      prefix: --summary
  - id: table_output_col_names
    type:
      - 'null'
      - boolean
    doc: whether to output column names for the database present in the register
      when writing it as a tab-separated file
    inputBinding:
      position: 101
      prefix: --table-output-col-names
  - id: table_output_file
    type:
      - 'null'
      - File
    doc: write the database present in the register as a tab-separated file 
      (rows are k-mer names, columns are spectrum names; the file will be given 
      extension .KPopCounter.txt)
    inputBinding:
      position: 101
      prefix: --table
  - id: table_output_metadata
    type:
      - 'null'
      - boolean
    doc: whether to output metadata for the database present in the register 
      when writing it as a tab-separated file
    inputBinding:
      position: 101
      prefix: --table-output-metadata
  - id: table_output_row_names
    type:
      - 'null'
      - boolean
    doc: whether to output row names for the database present in the register 
      when writing it as a tab-separated file
    inputBinding:
      position: 101
      prefix: --table-output-row-names
  - id: table_output_zero_rows
    type:
      - 'null'
      - boolean
    doc: whether to output rows whose elements are all zero when writing the 
      database as a tab-separated file
    inputBinding:
      position: 101
      prefix: --table-output-zero-rows
  - id: table_power
    type:
      - 'null'
      - float
    doc: raise counts to this power before transforming and outputting them. A 
      power of 0 when the 'pseudocounts' method is used performs a logarithmic 
      transformation
    inputBinding:
      position: 101
      prefix: --table-power
  - id: table_precision
    type:
      - 'null'
      - int
    doc: set the number of precision digits to be used when outputting counts
    inputBinding:
      position: 101
      prefix: --table-precision
  - id: table_threshold
    type:
      - 'null'
      - float
    doc: set to zero all counts that are less than this threshold before 
      transforming and outputting them. A fractional threshold between 0. and 1.
      is taken as a relative one with respect to the sum of all counts in the 
      spectrum
    inputBinding:
      position: 101
      prefix: --table-threshold
  - id: table_transform
    type:
      - 'null'
      - string
    doc: transformation to apply to table elements before outputting them
    inputBinding:
      position: 101
      prefix: --table-transform
  - id: table_transform
    type:
      - 'null'
      - string
    doc: transformation to apply to table elements before outputting them
    inputBinding:
      position: 101
      prefix: --table-transformation
  - id: table_transpose
    type:
      - 'null'
      - boolean
    doc: "whether to transpose the database present in the register before writing
      it as a tab-separated file (if 'true': rows are spectrum names, columns [metadata
      and] k-mer names; if 'false': rows are [metadata and] k-mer names, columns spectrum
      names)"
    inputBinding:
      position: 101
      prefix: --table-transpose
  - id: threads
    type:
      - 'null'
      - int
    doc: number of concurrent computing threads to be spawned (default 
      automatically detected from your configuration)
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbose execution
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: dump the database present in the register to the specified file (which 
      will be given extension .KPopCounter)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
