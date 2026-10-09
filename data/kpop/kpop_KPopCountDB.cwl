cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopCountDB
label: kpop_KPopCountDB
doc: "Manipulates databases of k-mer spectra: builds them from k-mer tables, adds metadata, combines or deletes spectra, computes distances and writes tables. The actions run in a fixed order: load or empty database, metadata, k-mer files, settings, selection actions, summary and distances, database output, table output.\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent computing threads to be spawned.
    inputBinding:
      position: 1
      prefix: '-T'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose execution.
    inputBinding:
      position: 2
      prefix: '-v'
  - id: empty
    type:
      - 'null'
      - boolean
    doc: Put an empty database into the register.
    inputBinding:
      position: 10
      prefix: '-e'
  - id: input_db
    type:
      - 'null'
      - File
    doc: Database (file with extension .KPopCounter) to load into the register.
    inputBinding:
      position: 11
      prefix: '-i'
      valueFrom: '${ return self.path.replace(/\.KPopCounter$/, ""); }'
  - id: metadata
    type:
      - 'null'
      - File
    doc: Metadata table file to add to the database in the register.
    inputBinding:
      position: 20
      prefix: '-m'
  - id: kmer_files
    type:
      - 'null'
      - type: array
        items: File
    doc: k-mer table files (made by KPopCount) to add to the database in the
      register.
    inputBinding:
      position: 30
      prefix: '-k'
      itemSeparator: ','
  - id: distance_function
    type:
      - 'null'
      - string
    doc: "Function used to compute distances: euclidean or
      minkowski(<non_negative_float>) (default euclidean)."
    inputBinding:
      position: 40
      prefix: '--distance'
  - id: distance_normalize
    type:
      - 'null'
      - boolean
    doc: Whether spectra are normalized before computing distances.
    inputBinding:
      position: 41
      prefix: '--distance-normalize'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: table_output_row_names
    type:
      - 'null'
      - boolean
    doc: Whether to output row names when writing the database as a table
      (default true).
    inputBinding:
      position: 42
      prefix: '--table-output-row-names'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: table_output_col_names
    type:
      - 'null'
      - boolean
    doc: Whether to output column names when writing the database as a table
      (default true).
    inputBinding:
      position: 43
      prefix: '--table-output-col-names'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: table_output_metadata
    type:
      - 'null'
      - boolean
    doc: Whether to output metadata when writing the database as a table
      (default false).
    inputBinding:
      position: 44
      prefix: '--table-output-metadata'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: table_transpose
    type:
      - 'null'
      - boolean
    doc: Whether to transpose the database before writing it as a table
      (default false).
    inputBinding:
      position: 45
      prefix: '--table-transpose'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: table_threshold
    type:
      - 'null'
      - float
    doc: Set to zero all counts that are less than this threshold before
      transforming and outputting them (default 1).
    inputBinding:
      position: 46
      prefix: '--table-threshold'
  - id: table_power
    type:
      - 'null'
      - float
    doc: Raise counts to this power before transforming and outputting them
      (default 1).
    inputBinding:
      position: 47
      prefix: '--table-power'
  - id: table_transform
    type:
      - 'null'
      - string
    doc: "Transformation applied to table elements: binary, power, pseudocounts
      or clr (default power)."
    inputBinding:
      position: 48
      prefix: '--table-transform'
  - id: table_output_zero_rows
    type:
      - 'null'
      - boolean
    doc: Whether to output rows whose elements are all zero when writing the
      table (default false).
    inputBinding:
      position: 49
      prefix: '--table-output-zero-rows'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: table_precision
    type:
      - 'null'
      - int
    doc: Number of precision digits used when outputting counts (default 15).
    inputBinding:
      position: 50
      prefix: '--table-precision'
  - id: combination_criterion
    type:
      - 'null'
      - string
    doc: "Criterion used to combine the k-mer frequencies of selected spectra:
      mean or median (default mean)."
    inputBinding:
      position: 51
      prefix: '--selection-combination-criterion'
  - id: selection_from_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Spectrum labels to put into the selection register.
    inputBinding:
      position: 52
      prefix: '-L'
      itemSeparator: ','
  - id: selection_from_regexps
    type:
      - 'null'
      - type: array
        items: string
    doc: Selectors <metadata_field>~<regexp> that put the labels of the
      matching spectra into the selection register.
    inputBinding:
      position: 53
      prefix: '-R'
      itemSeparator: ','
  - id: selection_negate
    type:
      - 'null'
      - boolean
    doc: Negate the labels that are present in the selection register.
    inputBinding:
      position: 54
      prefix: '-N'
  - id: selection_print
    type:
      - 'null'
      - boolean
    doc: Print the labels that are present in the selection register.
    inputBinding:
      position: 55
      prefix: '-P'
  - id: add_combined_selection
    type:
      - 'null'
      - string
    doc: Combine the selected spectra and add the result to the database under
      this label.
    inputBinding:
      position: 56
      prefix: '-A'
  - id: selection_delete
    type:
      - 'null'
      - boolean
    doc: Drop the spectra whose labels are in the selection register from the
      database.
    inputBinding:
      position: 57
      prefix: '-D'
  - id: selection_to_table_filter
    type:
      - 'null'
      - boolean
    doc: Filter out spectra whose labels are in the selection register when
      writing the table.
    inputBinding:
      position: 58
      prefix: '-F'
  - id: selection_clear
    type:
      - 'null'
      - boolean
    doc: Purge the selection register.
    inputBinding:
      position: 59
      prefix: '-C'
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print a summary of the database in the register.
    inputBinding:
      position: 70
      prefix: '--summary'
  - id: compute_distances
    type:
      - 'null'
      - type: array
        items: string
    doc: "Three values: two selectors <metadata_field>~<regexp> and the output
      prefix of the distance matrix (written with extension .KPopDMatrix)."
    inputBinding:
      position: 71
      prefix: '-d'
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the file the database in the register is dumped to (written
      with extension .KPopCounter).
    inputBinding:
      position: 80
      prefix: '-o'
  - id: table_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the tab-separated table file written from the database
      (extension .KPopCounter.txt).
    inputBinding:
      position: 81
      prefix: '-t'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (summary and selection printouts)
  - id: output_db
    type:
      - 'null'
      - File
    doc: Database written with -o
    outputBinding:
      glob: '$(inputs.output_prefix).KPopCounter'
  - id: output_table
    type:
      - 'null'
      - File
    doc: Tab-separated table written with -t
    outputBinding:
      glob: '$(inputs.table_prefix).KPopCounter.txt'
  - id: distance_matrix
    type:
      - 'null'
      - File
    doc: Distance matrix written with -d
    outputBinding:
      glob: '$(inputs.compute_distances ? inputs.compute_distances[2] + ".KPopDMatrix" : "__none__")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopCountDB.out
