cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_get_match_counts
label: phyluce_phyluce_assembly_get_match_counts
doc: "Given an SQL database of UCE loci and a taxon-set file, output those taxa and
  those loci in complete and incomplete data matrices.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: extend_locus_db
    type:
      - 'null'
      - File
    doc: An SQLlite database file holding probe matches to other targeted loci
    inputBinding:
      position: 101
      prefix: --extend-locus-db
  - id: incomplete_matrix
    type:
      - 'null'
      - boolean
    doc: Generate an incomplete matrix of data.
    inputBinding:
      position: 101
      prefix: --incomplete-matrix
  - id: keep_counts
    type:
      - 'null'
      - boolean
    doc: Keep counts.
    inputBinding:
      position: 101
      prefix: --keep-counts
  - id: locus_db
    type: File
    doc: The SQL database file holding probe matches to targeted loci (usually 
      "lastz/probe.matches.sqlite".)
    inputBinding:
      position: 101
      prefix: --locus-db
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    inputBinding:
      position: 101
      prefix: --log-path
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Return optimum groups of probes by enumeration (default) or sampling.
    inputBinding:
      position: 101
      prefix: --optimize
  - id: random
    type:
      - 'null'
      - boolean
    doc: Optimize by sampling.
    inputBinding:
      position: 101
      prefix: --random
  - id: sample_size
    type:
      - 'null'
      - int
    doc: The group size of samples.
    inputBinding:
      position: 101
      prefix: --sample-size
  - id: samples
    type:
      - 'null'
      - int
    doc: The number of samples to take.
    inputBinding:
      position: 101
      prefix: --samples
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Don't print probe names.
    inputBinding:
      position: 101
      prefix: --silent
  - id: taxon_group
    type: string
    doc: The [group] in the config file whose specific data matrix you want to 
      create.
    inputBinding:
      position: 101
      prefix: --taxon-group
  - id: taxon_list_config
    type: File
    doc: The config file containing lists of the taxa you want to include in 
      matrices.
    inputBinding:
      position: 101
      prefix: --taxon-list-config
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The logging level to use.
    default: INFO
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output
    type: File
    doc: The path to the output file you want to create.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
