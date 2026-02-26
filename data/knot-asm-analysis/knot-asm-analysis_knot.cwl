cwlVersion: v1.2
class: CommandLineTool
baseCommand: KNOT
label: knot-asm-analysis_knot
doc: "KNOT is a tool for analyzing contigs and their assembly graphs.\n\nTool homepage:
  https://github.com/natir/knot"
inputs:
  - id: contig_min_length
    type:
      - 'null'
      - int
    doc: contig with size lower this parameter are ignored
    inputBinding:
      position: 101
      prefix: --contig-min-length
  - id: contigs
    type: File
    doc: fasta file than contains contigs
    inputBinding:
      position: 101
      prefix: --contigs
  - id: contigs_graph
    type:
      - 'null'
      - File
    doc: contigs graph
    inputBinding:
      position: 101
      prefix: --contigs_graph
  - id: correct_reads
    type:
      - 'null'
      - File
    doc: read used for assembly
    inputBinding:
      position: 101
      prefix: --correct-reads
  - id: help_all
    type:
      - 'null'
      - boolean
    doc: show knot help and snakemake help
    inputBinding:
      position: 101
      prefix: --help-all
  - id: output
    type: string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: raw_reads
    type:
      - 'null'
      - File
    doc: read used for assembly
    inputBinding:
      position: 101
      prefix: --raw-reads
  - id: read_type
    type:
      - 'null'
      - string
    doc: type of input read, default pb
    default: pb
    inputBinding:
      position: 101
      prefix: --read-type
  - id: search_mode
    type:
      - 'null'
      - string
    doc: what path search optimize, number of base or number of node
    inputBinding:
      position: 101
      prefix: --search-mode
  - id: self_lookup
    type:
      - 'null'
      - boolean
    doc: if it set knot search path between extremity of same contig
    inputBinding:
      position: 101
      prefix: --self-lookup
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
stdout: knot-asm-analysis_knot.out
