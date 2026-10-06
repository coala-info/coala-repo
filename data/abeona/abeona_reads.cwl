cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abeona
  - reads
label: abeona_reads
doc: "Assign reads to cortex graphs. For each graph in graph_list, writes the reads\
  \ that share a k-mer with it to <prefix>.1.fa.gz (and <prefix>.2.fa.gz for pairs).\
  \ Graph paths in graph_list are read relative to the working directory; pass the\
  \ graph files in 'graphs' so they are staged there under their own names.\n\nTool\
  \ homepage: https://github.com/winni2k/abeona"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.graphs)
inputs:
  - id: graph_list
    type: File
    doc: "Tab delimited text file with two columns (prefix, graph) and optional\
      \ header line. All lines starting with '#' are ignored. For example:\n#\
      \ prefix\tgraph\nout_dir/g1\tg1.ctx\nout_dir/g2\tg2.ctx"
    inputBinding:
      position: 1
  - id: graphs
    type:
      - 'null'
      - type: array
        items: File
    doc: Cortex graph files named in graph_list (staged in the working directory)
  - id: forward
    type: File
    doc: Forward reads file in FASTA or FASTQ format.
    inputBinding:
      position: 2
  - id: reverse
    type:
      - 'null'
      - File
    doc: 'Reverse reads file in FASTA or FASTQ format. Only specified if reads are paired'
    inputBinding:
      position: 102
      prefix: --reverse
  - id: format
    type:
      type: enum
      symbols:
        - fasta
        - fastq
    doc: File format of input reads.
    inputBinding:
      position: 102
      prefix: --format
  - id: record_buffer_size
    type:
      - 'null'
      - int
    doc: 'Flush all reads to disk after this many records have been assigned'
    inputBinding:
      position: 102
      prefix: --record-buffer-size
outputs:
  - id: assigned_reads
    type: File[]
    doc: Reads assigned to each graph (<prefix>.1.fa.gz, <prefix>.2.fa.gz)
    outputBinding:
      glob:
        - '*.fa.gz'
        - '*/*.fa.gz'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abeona:0.45.0--py36_0
