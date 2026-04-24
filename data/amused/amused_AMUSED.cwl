cwlVersion: v1.2
class: CommandLineTool
baseCommand: AMUSED
label: amused_AMUSED
doc: "AMUSED: A tool for sequence analysis, likely for motif discovery or n-mer enrichment
  analysis comparing query sequences against background or randomized sequences.\n\
  \nTool homepage: https://github.com/Carldeboer/AMUSED"
inputs:
  - id: background_pseudocount
    type:
      - 'null'
      - float
    doc: pseudocount to add to background
    inputBinding:
      position: 101
      prefix: -bp
  - id: background_sequences
    type:
      - 'null'
      - File
    doc: compare seqs to these background seqs
    inputBinding:
      position: 101
      prefix: -b
  - id: base_content
    type:
      - 'null'
      - boolean
    doc: add lines to output for base content
    inputBinding:
      position: 101
      prefix: -bc
  - id: descriptive_output
    type:
      - 'null'
      - boolean
    doc: 'descriptive output: lots of intermediate values also output (but many columns)'
    inputBinding:
      position: 101
      prefix: -do
  - id: double_stranded
    type:
      - 'null'
      - boolean
    doc: double stranded (reverse complement sequences too)
    inputBinding:
      position: 101
      prefix: -ds
  - id: max_tree_size
    type:
      - 'null'
      - int
    doc: max n-mer to consider
    inputBinding:
      position: 101
      prefix: -s
  - id: no_gaps
    type:
      - 'null'
      - boolean
    doc: no inserting gaps
    inputBinding:
      position: 101
      prefix: -ng
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: don't sort
    inputBinding:
      position: 101
      prefix: -ns
  - id: no_super_zs
    type:
      - 'null'
      - boolean
    doc: don't calculate super Zs
    inputBinding:
      position: 101
      prefix: -nsz
  - id: no_upper_case
    type:
      - 'null'
      - boolean
    doc: no changing to upper case before scan (non ATGC bases are discarded)
    inputBinding:
      position: 101
      prefix: -nu
  - id: not_fasta_format
    type:
      - 'null'
      - boolean
    doc: 'sequences not in fasta format: each line is a full sequence'
    inputBinding:
      position: 101
      prefix: -1p
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of CPU threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: query_sequences
    type: File
    doc: query sequences
    inputBinding:
      position: 101
      prefix: -q
  - id: sub_z_cutoff
    type:
      - 'null'
      - float
    doc: minimum absolute Sub-Z-score
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amused:1.0--1
