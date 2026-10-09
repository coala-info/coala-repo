cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot
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
  - id: aag
    type:
      - 'null'
      - File
    doc: assembly-assembly graph written as <output>_AAG.csv
    outputBinding:
      glob: $(inputs.output)_AAG.csv
  - id: knot_dir
    type:
      - 'null'
      - Directory
    doc: intermediate files written to <output>_knot
    outputBinding:
      glob: $(inputs.output)_knot
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
stdout: knot-asm-analysis_knot.out
