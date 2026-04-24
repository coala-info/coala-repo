cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonkit reformat2
label: taxonkit_reformat2
doc: "Reformat lineage in chosen ranks, allowing more ranks than 'reformat'\n\nTool
  homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 101
  - id: format
    type:
      - 'null'
      - string
    doc: output format, placeholders of rank are needed
    inputBinding:
      position: 101
      prefix: --format
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
  - id: miss_rank_repl
    type:
      - 'null'
      - string
    doc: replacement string for missing rank
    inputBinding:
      position: 101
      prefix: --miss-rank-repl
  - id: miss_taxid_repl
    type:
      - 'null'
      - string
    doc: replacement string for missing taxid
    inputBinding:
      position: 101
      prefix: --miss-taxid-repl
  - id: no_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: rank names of no-rank. A lineage might have many "no rank" ranks, we 
      only keep the last one below known ranks
    inputBinding:
      position: 101
      prefix: --no-ranks
  - id: show_lineage_taxids
    type:
      - 'null'
      - boolean
    doc: show corresponding taxids of reformated lineage
    inputBinding:
      position: 101
      prefix: --show-lineage-taxids
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: field index of taxid. input data should be tab-separated. it overrides 
      -i/--lineage-field
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - boolean
    doc: do not replace missing ranks lower than the rank of the current node
    inputBinding:
      position: 101
      prefix: --trim
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
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
