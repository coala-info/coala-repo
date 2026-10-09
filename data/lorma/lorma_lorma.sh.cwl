cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorma.sh
label: lorma_lorma.sh
doc: "Runs the LoRDEC iterations and the LoRMA step to correct long reads in a FASTA file. The corrected reads are written to final.fasta.\n\nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/"
inputs:
  - id: save_intermediate_data
    type:
      - 'null'
      - boolean
    doc: saves the sequence data of intermediate LoRDEC steps
    inputBinding:
      position: 1
      prefix: -s
  - id: skip_lordec_steps
    type:
      - 'null'
      - boolean
    doc: skips LoRDEC steps
    inputBinding:
      position: 2
      prefix: -n
  - id: start
    type:
      - 'null'
      - int
    doc: First k-mer size of the LoRDEC iterations [default 19]
    inputBinding:
      position: 3
      prefix: -start
  - id: end
    type:
      - 'null'
      - int
    doc: Last k-mer size of the LoRDEC iterations [default 61]
    inputBinding:
      position: 4
      prefix: -end
  - id: step
    type:
      - 'null'
      - int
    doc: Step between the k-mer sizes of the LoRDEC iterations [default 21]
    inputBinding:
      position: 5
      prefix: -step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [default 6]
    inputBinding:
      position: 6
      prefix: -threads
  - id: friends
    type:
      - 'null'
      - int
    doc: Number of friends [default 7]
    inputBinding:
      position: 7
      prefix: -friends
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer size of the LoRMA step [default 19]
    inputBinding:
      position: 8
      prefix: -k
  - id: fasta_file
    type: File
    doc: Input long reads in FASTA format
    inputBinding:
      position: 9
outputs:
  - id: final_reads
    type: File
    doc: Corrected reads
    outputBinding:
      glob: final.fasta
  - id: intermediate_reads
    type:
      type: array
      items: File
    doc: Intermediate LoRDEC read files and logs (reads-k*.fasta, lordec-*.log, trim.fasta)
    outputBinding:
      glob: ['reads-k*.fasta', 'lordec-*.log', 'trim.fasta', 'discarded.fasta']
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorma:0.4--2
