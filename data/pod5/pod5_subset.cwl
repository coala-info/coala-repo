cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5 subset
label: pod5_subset
doc: "Given one or more pod5 input files, take subsets of reads into one or more pod5
  output files by a user-supplied mapping.\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Pod5 filepaths to use as inputs
    inputBinding:
      position: 1
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of --summary / --table columns to subset on
    inputBinding:
      position: 102
      prefix: --columns
  - id: csv
    type:
      - 'null'
      - File
    doc: CSV file mapping output filename to read ids
    inputBinding:
      position: 102
      prefix: --csv
  - id: duplicate_ok
    type:
      - 'null'
      - boolean
    doc: Allow duplicate read_ids
    inputBinding:
      position: 102
      prefix: --duplicate-ok
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: ignore_incomplete_template
    type:
      - 'null'
      - boolean
    doc: Suppress the exception raised if the --template string does not contain
      every --columns key
    inputBinding:
      position: 102
      prefix: --ignore-incomplete-template
  - id: missing_ok
    type:
      - 'null'
      - boolean
    doc: Allow missing read_ids
    inputBinding:
      position: 102
      prefix: --missing-ok
  - id: output
    type:
      - 'null'
      - Directory
    doc: Destination directory to write outputs
    inputBinding:
      position: 102
      prefix: --output
  - id: read_id_column
    type:
      - 'null'
      - string
    doc: Name of the read_id column in the summary
    inputBinding:
      position: 102
      prefix: --read-id-column
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    inputBinding:
      position: 102
      prefix: --recursive
  - id: summary
    type:
      - 'null'
      - File
    doc: Table filepath (csv or tsv)
    inputBinding:
      position: 102
      prefix: --summary
  - id: table
    type:
      - 'null'
      - File
    doc: Table filepath (csv or tsv)
    inputBinding:
      position: 102
      prefix: --table
  - id: template
    type:
      - 'null'
      - string
    doc: template string to generate output filenames (e.g. 
      "mux-{mux}_barcode-{barcode}.pod5"). default is to concatenate all columns
      to values as shown in the example.
    inputBinding:
      position: 102
      prefix: --template
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of subsetting workers
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_subset.out
