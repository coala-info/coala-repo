cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - list
label: taxonkit_list
doc: "List taxonomic subtrees of given TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'File(s) with TaxIds, one per line (alternative to ids)'
    inputBinding:
      position: 1
  - id: ids
    type:
      - 'null'
      - string
    doc: 'TaxId(s), multiple values should be separated by comma'
    inputBinding:
      position: 101
      prefix: --ids
  - id: indent
    type:
      - 'null'
      - string
    doc: 'Indent (default two spaces)'
    inputBinding:
      position: 101
      prefix: --indent
  - id: json
    type:
      - 'null'
      - boolean
    doc: 'Output in JSON format'
    inputBinding:
      position: 101
      prefix: --json
  - id: show_name
    type:
      - 'null'
      - boolean
    doc: 'Output scientific name'
    inputBinding:
      position: 101
      prefix: --show-name
  - id: show_rank
    type:
      - 'null'
      - boolean
    doc: 'Output rank'
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
