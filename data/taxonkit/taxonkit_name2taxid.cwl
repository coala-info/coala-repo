cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonkit name2taxid
label: taxonkit_name2taxid
doc: "Convert taxon names to TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: fuzzy
    type:
      - 'null'
      - boolean
    doc: allow fuzzy match
    inputBinding:
      position: 101
      prefix: --fuzzy
  - id: fuzzy_top_n
    type:
      - 'null'
      - int
    doc: choose top n matches in fuzzy search
    inputBinding:
      position: 101
      prefix: --fuzzy-top-n
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: name_field
    type:
      - 'null'
      - int
    doc: field index of name. data should be tab-separated
    inputBinding:
      position: 101
      prefix: --name-field
  - id: scientific_names_only
    type:
      - 'null'
      - boolean
    doc: only searching scientific names
    inputBinding:
      position: 101
      prefix: --sci-name
  - id: show_rank
    type:
      - 'null'
      - boolean
    doc: show rank
    inputBinding:
      position: 101
      prefix: --show-rank
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
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
  - id: output_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
