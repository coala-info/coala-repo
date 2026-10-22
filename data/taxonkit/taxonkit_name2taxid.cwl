cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - name2taxid
label: taxonkit_name2taxid
doc: "Convert taxon names to TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'File(s) with taxon names, one per line or in a tab-separated column (see name_field)'
    inputBinding:
      position: 1
  - id: fuzzy
    type:
      - 'null'
      - boolean
    doc: 'Allow fuzzy match'
    inputBinding:
      position: 101
      prefix: --fuzzy
  - id: fuzzy_top_n
    type:
      - 'null'
      - int
    doc: 'Choose top n matches in fuzzy search (default 1)'
    inputBinding:
      position: 101
      prefix: --fuzzy-top-n
  - id: name_field
    type:
      - 'null'
      - int
    doc: 'Field index of name. Data should be tab-separated (default 1)'
    inputBinding:
      position: 101
      prefix: --name-field
  - id: sci_name
    type:
      - 'null'
      - boolean
    doc: 'Only searching scientific names'
    inputBinding:
      position: 101
      prefix: --sci-name
  - id: show_rank
    type:
      - 'null'
      - boolean
    doc: 'Show rank'
    inputBinding:
      position: 101
      prefix: --show-rank
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing nodes.dmp and names.dmp (NCBI taxdump files)'
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: 'Use line buffering on output, i.e., immediately writing to stdin/file for every line of output'
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. 4 is enough'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print verbose information'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_file_path
    type: string
    doc: 'Output file name (suffix .gz for gzipped output)'
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
