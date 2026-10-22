cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - lca
label: taxonkit_lca
doc: "Compute lowest common ancestor (LCA) for TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'File(s) with TaxIds separated by the separator, one query per line'
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: 'Size of line buffer, supported unit: K, M, G (default 1M)'
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: keep_invalid
    type:
      - 'null'
      - boolean
    doc: 'Print the query even if no single valid taxid left'
    inputBinding:
      position: 101
      prefix: --keep-invalid
  - id: separator
    type:
      - 'null'
      - string
    doc: 'Separator for TaxIds (default a space)'
    inputBinding:
      position: 101
      prefix: --separator
  - id: skip_deleted
    type:
      - 'null'
      - boolean
    doc: 'Skip deleted TaxIds and compute with left ones'
    inputBinding:
      position: 101
      prefix: --skip-deleted
  - id: skip_unfound
    type:
      - 'null'
      - boolean
    doc: 'Skip unfound TaxIds and compute with left ones'
    inputBinding:
      position: 101
      prefix: --skip-unfound
  - id: taxids_field
    type:
      - 'null'
      - int
    doc: 'Field index of TaxIds. Input data should be tab-separated (default 1)'
    inputBinding:
      position: 101
      prefix: --taxids-field
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
