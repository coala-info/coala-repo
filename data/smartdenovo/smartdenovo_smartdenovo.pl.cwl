cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo.pl
label: smartdenovo_smartdenovo.pl
doc: "Generate a Makefile for the SMARTdenovo assembly pipeline (long reads, ultra-fast de novo assembler).\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: reads_fa
    type: File
    doc: Input FASTA file of reads
    inputBinding:
      position: 103
  - id: engine
    type:
      - 'null'
      - string
    doc: engine of overlaper, compressed kmer overlapper(zmo), dot matrix 
      overlapper(dmo)
    inputBinding:
      position: 101
      prefix: -e
  - id: generate_consensus
    type:
      - 'null'
      - int
    doc: generate consensus
    inputBinding:
      position: 101
      prefix: -c
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length for overlapping
    inputBinding:
      position: 101
      prefix: -k
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: min read length
    inputBinding:
      position: 101
      prefix: -J
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Makefile text for the assembly pipeline (smartdenovo.pl prints it to 
      standard output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_smartdenovo.pl.out
