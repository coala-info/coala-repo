cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-correct
label: lordec_lordec-correct
doc: "Corrects long reads using short reads.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: long_reads
    type: File
    doc: long read FASTA/Q file
    inputBinding:
      position: 101
      prefix: -i
  - id: short_reads
    type:
      type: array
      items: File
    doc: short read FASTA/Q file(s)
    inputBinding:
      position: 102
      prefix: '-2'
  - id: kmer_len
    type: int
    doc: k-mer size
    inputBinding:
      position: 103
      prefix: -k
  - id: corrected_read_file_path
    type: string
    doc: output reads file
    inputBinding:
      position: 104
      prefix: -o
  - id: solid_threshold
    type: int
    doc: solid k-mer abundance threshold
    inputBinding:
      position: 105
      prefix: -s
  - id: trials
    type:
      - 'null'
      - int
    doc: number of paths to try from a k-mer
    inputBinding:
      position: 106
      prefix: -t
  - id: branch
    type:
      - 'null'
      - int
    doc: maximum number of branches to explore
    inputBinding:
      position: 107
      prefix: -b
  - id: errorrate
    type:
      - 'null'
      - float
    doc: maximum error rate
    inputBinding:
      position: 108
      prefix: -e
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 109
      prefix: -T
  - id: stat_file_path
    type:
      - 'null'
      - string
    doc: out statistics file
    inputBinding:
      position: 110
      prefix: -S
  - id: complete_search
    type:
      - 'null'
      - boolean
    doc: Perform a complete search
    inputBinding:
      position: 111
      prefix: -c
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: abundance max threshold for k-mers
    inputBinding:
      position: 112
      prefix: -a
  - id: out_tmp
    type:
      - 'null'
      - string
    doc: GATB graph creation temporary files directory
    inputBinding:
      position: 113
      prefix: -O
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress
    inputBinding:
      position: 114
      prefix: -p
  - id: graph_named_like_output
    type:
      - 'null'
      - boolean
    doc: Name the graph file like the output file
    inputBinding:
      position: 115
      prefix: -g
outputs:
  - id: corrected_read_file
    type: File
    doc: output reads file
    outputBinding:
      glob: $(inputs.corrected_read_file_path)
  - id: stat_file
    type:
      - 'null'
      - File
    doc: out statistics file
    outputBinding:
      glob: $(inputs.stat_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
