cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - lineage
label: taxonkit_lineage
doc: "Query taxonomic lineage of given TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'File(s) with TaxIds, one per line or in a tab-separated column (see taxid_field)'
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'Field delimiter in lineage (default '';'')'
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: no_lineage
    type:
      - 'null'
      - boolean
    doc: 'Do not show lineage, when user just want names or/and ranks'
    inputBinding:
      position: 101
      prefix: --no-lineage
  - id: show_lineage_ranks
    type:
      - 'null'
      - boolean
    doc: 'Appending ranks of all levels'
    inputBinding:
      position: 101
      prefix: --show-lineage-ranks
  - id: show_lineage_taxids
    type:
      - 'null'
      - boolean
    doc: 'Appending lineage consisting of taxids'
    inputBinding:
      position: 101
      prefix: --show-lineage-taxids
  - id: show_name
    type:
      - 'null'
      - boolean
    doc: 'Appending scientific name'
    inputBinding:
      position: 101
      prefix: --show-name
  - id: show_rank
    type:
      - 'null'
      - boolean
    doc: 'Appending rank of taxids'
    inputBinding:
      position: 101
      prefix: --show-rank
  - id: show_status_code
    type:
      - 'null'
      - boolean
    doc: 'Show status code before lineage'
    inputBinding:
      position: 101
      prefix: --show-status-code
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: 'Field index of taxid. Input data should be tab-separated (default 1)'
    inputBinding:
      position: 101
      prefix: --taxid-field
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
