cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-correct
label: lordec_lordec-correct
doc: "Corrects long reads using short reads.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: abundance max threshold for k-mers
    inputBinding:
      position: 101
      prefix: --abundance-max
  - id: branch
    type:
      - 'null'
      - int
    doc: maximum number of branches to explore
    inputBinding:
      position: 101
      prefix: --branch
  - id: complete_search
    type:
      - 'null'
      - boolean
    doc: Perform a complete search
    inputBinding:
      position: 101
      prefix: --complete_search
  - id: errorrate
    type:
      - 'null'
      - float
    doc: maximum error rate
    inputBinding:
      position: 101
      prefix: --errorrate
  - id: graph_named_like_output
    type:
      - 'null'
      - boolean
    doc: Name the graph file like the output file
    inputBinding:
      position: 101
      prefix: --graph_named_like_output
  - id: kmer_len
    type: int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: --kmer_len
  - id: long_reads
    type: File
    doc: long read FASTA/Q file
    inputBinding:
      position: 101
      prefix: --long_reads
  - id: out_tmp
    type:
      - 'null'
      - Directory
    doc: GATB graph creation temporary files directory
    inputBinding:
      position: 101
      prefix: --out-tmp
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress
    inputBinding:
      position: 101
      prefix: --progress
  - id: short_reads
    type:
      type: array
      items: File
    doc: short read FASTA/Q file(s)
    inputBinding:
      position: 101
      prefix: --short_reads
  - id: solid_threshold
    type: int
    doc: solid k-mer abundance threshold
    inputBinding:
      position: 101
      prefix: --solid_threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: trials
    type:
      - 'null'
      - int
    doc: number of paths to try from a k-mer
    inputBinding:
      position: 101
      prefix: --trials
outputs:
  - id: corrected_read_file
    type: File
    doc: output reads file
    outputBinding:
      glob: $(inputs.corrected_read_file)
  - id: stat_file
    type:
      - 'null'
      - File
    doc: out statistics file
    outputBinding:
      glob: $(inputs.stat_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
