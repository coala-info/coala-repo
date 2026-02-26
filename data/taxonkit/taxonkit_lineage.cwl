cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonkit lineage
label: taxonkit_lineage
doc: "Query taxonomic lineage of given TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: List of TaxIds, one TaxId per line, or tab-delimited format. Supporting
      (gzipped) file or STDIN.
    inputBinding:
      position: 1
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    default: /root/.taxonkit
    inputBinding:
      position: 102
      prefix: --data-dir
  - id: delimiter
    type:
      - 'null'
      - string
    doc: field delimiter in lineage
    default: ;
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 102
      prefix: --line-buffered
  - id: no_lineage
    type:
      - 'null'
      - boolean
    doc: do not show lineage, when user just want names or/and ranks
    inputBinding:
      position: 102
      prefix: --no-lineage
  - id: show_lineage_ranks
    type:
      - 'null'
      - boolean
    doc: appending ranks of all levels
    inputBinding:
      position: 102
      prefix: --show-lineage-ranks
  - id: show_lineage_taxids
    type:
      - 'null'
      - boolean
    doc: appending lineage consisting of taxids
    inputBinding:
      position: 102
      prefix: --show-lineage-taxids
  - id: show_name
    type:
      - 'null'
      - boolean
    doc: appending scientific name
    inputBinding:
      position: 102
      prefix: --show-name
  - id: show_rank
    type:
      - 'null'
      - boolean
    doc: appending rank of taxids
    inputBinding:
      position: 102
      prefix: --show-rank
  - id: show_status_code
    type:
      - 'null'
      - boolean
    doc: show status code before lineage
    inputBinding:
      position: 102
      prefix: --show-status-code
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: field index of taxid. input data should be tab-separated
    default: 1
    inputBinding:
      position: 102
      prefix: --taxid-field
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 102
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
