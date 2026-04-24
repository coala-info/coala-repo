cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo.pl
label: smartdenovo_smartdenovo.pl
doc: "Smartdenovo is a de novo assembler for long reads.\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: reads_fa
    type: File
    doc: Input FASTA file of reads
    inputBinding:
      position: 1
  - id: engine
    type:
      - 'null'
      - string
    doc: engine of overlaper, compressed kmer overlapper(zmo), dot matrix 
      overlapper(dmo)
    inputBinding:
      position: 102
      prefix: -e
  - id: generate_consensus
    type:
      - 'null'
      - int
    doc: generate consensus
    inputBinding:
      position: 102
      prefix: -c
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length for overlapping
    inputBinding:
      position: 102
      prefix: -k
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: min read length
    inputBinding:
      position: 102
      prefix: -J
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 102
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_smartdenovo.pl.out
