cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - spec
label: riboseed_ribo_spec
doc: "Given an assembly graph from SPAdes, determine whether the number of rDNAs appears to match the reference.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: assembly_graph
    type: File
    doc: "fastg assembly graph from SPAdes"
    inputBinding:
      position: 101
      prefix: '--assembly_graph'
  - id: plot_graphs
    type:
      - 'null'
      - boolean
    doc: "draw the network graphs"
    inputBinding:
      position: 101
      prefix: '--plot_graphs'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: "Contigs under this length will be collapsed; default: 75"
    inputBinding:
      position: 101
      prefix: '--min_contig_len'
  - id: min_anchor_length
    type:
      - 'null'
      - int
    doc: "Paths must contain at least one node this long as an anchor; default: 500"
    inputBinding:
      position: 101
      prefix: '--min_anchor_length'
  - id: medium_length_threshold
    type:
      - 'null'
      - int
    doc: "Paths are simplified when contigs are greater than --min_contig_len but still short; default: 400"
    inputBinding:
      position: 101
      prefix: '--medium_length_threshold'
  - id: threshold
    type:
      - 'null'
      - int
    doc: "paths must be at least this long (bp) to be considered; default: 1500"
    inputBinding:
      position: 101
      prefix: '--threshold'
  - id: barrnap_length_threshold
    type:
      - 'null'
      - float
    doc: "passed to barrnap's --lencutoff argument; default: 0.75"
    inputBinding:
      position: 101
      prefix: '--barrnap_length_threshold'
  - id: barrnap_exe
    type:
      - 'null'
      - string
    doc: "Path to barrnap executable; default: barrnap"
    inputBinding:
      position: 101
      prefix: '--barrnap_exe'
  - id: cores
    type:
      - 'null'
      - int
    doc: "cores to be used; default: None"
    inputBinding:
      position: 101
      prefix: '--cores'
  - id: make_adjacency_matrix
    type:
      - 'null'
      - boolean
    doc: "generate and plot an adjacency matrix; default: False"
    inputBinding:
      position: 101
      prefix: '--MAKE_ADJACENCY_MATRIX'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_spec.out
