cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - filterdb
label: mmseqs2_filterdb
doc: 'DB filtering by given conditions.


  By Clovis Galiez & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: result_db
    type: Directory
    doc: Input result database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: add_self_matches
    type:
      - 'null'
      - int
    doc: Artificially add entries of queries with themselves (for clustering) (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: Specify a mathematical expression to filter lines
    inputBinding:
      position: 104
      prefix: --filter-expression
  - id: filter_column
    type:
      - 'null'
      - int
    doc: column
    inputBinding:
      position: 104
      prefix: --filter-column
  - id: column_to_take
    type:
      - 'null'
      - int
    doc: column to take in join mode. If -1, the whole line is taken
    inputBinding:
      position: 104
      prefix: --column-to-take
  - id: filter_regex
    type:
      - 'null'
      - string
    doc: 'Regex to select column (example float: [0-9]*(.[0-9]+)? int:[1-9]{1}[0-9])'
    inputBinding:
      position: 104
      prefix: --filter-regex
  - id: positive_filter
    type:
      - 'null'
      - int
    doc: Used in conjunction with --filter-file. If true, out  = in \intersect filter ; if
      false, out = in - filter (0 or 1)
    inputBinding:
      position: 104
      prefix: --positive-filter
  - id: filter_file
    type:
      - 'null'
      - File
    doc: Specify a file that contains the filtering elements
    inputBinding:
      position: 104
      prefix: --filter-file
  - id: beats_first
    type:
      - 'null'
      - int
    doc: Filter by comparing each entry to the first entry (0 or 1)
    inputBinding:
      position: 104
      prefix: --beats-first
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: Specify a file that translates the keys of a DB to new keys, TSV format
    inputBinding:
      position: 104
      prefix: --mapping-file
  - id: weights
    type:
      - 'null'
      - string
    doc: Weights used for cluster priorization
    inputBinding:
      position: 104
      prefix: --weights
  - id: trim_to_one_column
    type:
      - 'null'
      - int
    doc: Output only the column specified by --filter-column (0 or 1)
    inputBinding:
      position: 104
      prefix: --trim-to-one-column
  - id: extract_lines
    type:
      - 'null'
      - int
    doc: Extract n lines of each entry
    inputBinding:
      position: 104
      prefix: --extract-lines
  - id: comparison_operator
    type:
      - 'null'
      - string
    doc: Filter by comparing each entry row numerically by using the le) less-than-equal,
      ge) greater-than-equal or e) equal operator
    inputBinding:
      position: 104
      prefix: --comparison-operator
  - id: comparison_value
    type:
      - 'null'
      - float
    doc: Filter by comparing each entry to this value
    inputBinding:
      position: 104
      prefix: --comparison-value
  - id: sort_entries
    type:
      - 'null'
      - int
    doc: 'Sort column set by --filter-column, by 0: no sorting, 1: increasing, 2: decreasing,
      3: random shuffle, 4: priority'
    inputBinding:
      position: 104
      prefix: --sort-entries
  - id: join_db
    type:
      - 'null'
      - Directory
    doc: Join another database entry with respect to the database identifier in the chosen
      column (database directory; give join_db_name too)
    inputBinding:
      position: 104
      prefix: --join-db
      valueFrom: '$(self === null ? null : self.path + "/" + inputs.join_db_name)'
  - id: join_db_name
    type:
      - 'null'
      - string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the filtered database
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for l in out_db/*; do if [ -L "$l" ]; then t=`readlink -f "$l"`; rm "$l";
      cp -r "$t" "$l"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
