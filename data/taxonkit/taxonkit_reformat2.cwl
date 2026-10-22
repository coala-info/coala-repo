cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - reformat2
label: taxonkit_reformat2
doc: "Reformat lineage in chosen ranks, allowing more ranks than 'reformat'\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'File(s) with TaxIds in a tab-separated column (see taxid_field)'
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format, placeholders of rank are needed (default ''{domain|acellular root|superkingdom};{phylum};{class};{order};{family};{genus};{species}'')'
    inputBinding:
      position: 101
      prefix: --format
  - id: miss_rank_repl
    type:
      - 'null'
      - string
    doc: 'Replacement string for missing rank'
    inputBinding:
      position: 101
      prefix: --miss-rank-repl
  - id: miss_taxid_repl
    type:
      - 'null'
      - string
    doc: 'Replacement string for missing taxid'
    inputBinding:
      position: 101
      prefix: --miss-taxid-repl
  - id: no_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Rank names of no-rank. A lineage might have many ''no rank'' ranks, only the last one below known ranks is kept (default ''no rank'' and ''clade'')'
    inputBinding:
      position: 101
      prefix: --no-ranks
      itemSeparator: ','
  - id: show_lineage_taxids
    type:
      - 'null'
      - boolean
    doc: 'Show corresponding taxids of reformatted lineage'
    inputBinding:
      position: 101
      prefix: --show-lineage-taxids
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: 'Field index of taxid. Input data should be tab-separated (default 1)'
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: trim
    type:
      - 'null'
      - boolean
    doc: 'Do not replace missing ranks lower than the rank of the current node'
    inputBinding:
      position: 101
      prefix: --trim
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
