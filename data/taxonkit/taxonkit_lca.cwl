cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - lca
label: taxonkit_lca
doc: "Compute lowest common ancestor (LCA) for TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: 'size of line buffer, supported unit: K, M, G. You need to increase the value
      when "bufio.Scanner: token too long" error occured'
    default: 1M
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: data_dir
    type:
      - 'null'
      - string
    doc: directory containing nodes.dmp and names.dmp
    default: /root/.taxonkit
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: keep_invalid
    type:
      - 'null'
      - boolean
    doc: print the query even if no single valid taxid left
    inputBinding:
      position: 101
      prefix: --keep-invalid
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: separater
    type:
      - 'null'
      - string
    doc: separater for TaxIds. This flag is same to --separator.
    default: ' '
    inputBinding:
      position: 101
      prefix: --separater
  - id: separator
    type:
      - 'null'
      - string
    doc: separator for TaxIds
    default: ' '
    inputBinding:
      position: 101
      prefix: --separator
  - id: skip_deleted
    type:
      - 'null'
      - boolean
    doc: skip deleted TaxIds and compute with left ones
    inputBinding:
      position: 101
      prefix: --skip-deleted
  - id: skip_unfound
    type:
      - 'null'
      - boolean
    doc: skip unfound TaxIds and compute with left ones
    inputBinding:
      position: 101
      prefix: --skip-unfound
  - id: taxids_field
    type:
      - 'null'
      - int
    doc: field index of TaxIds. Input data should be tab-separated
    default: 1
    inputBinding:
      position: 101
      prefix: --taxids-field
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
