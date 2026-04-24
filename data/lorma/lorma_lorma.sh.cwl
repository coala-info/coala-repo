cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/lorma_lorma.sh
label: lorma_lorma.sh
doc: "Processes FASTA files with LoRDEC steps.\n\nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: end
    type:
      - 'null'
      - int
    doc: End value for processing
    inputBinding:
      position: 102
  - id: friends
    type:
      - 'null'
      - int
    doc: Number of friends
    inputBinding:
      position: 102
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer size
    inputBinding:
      position: 102
  - id: save_intermediate_data
    type:
      - 'null'
      - boolean
    doc: saves the sequence data of intermediate LoRDEC steps
    inputBinding:
      position: 102
      prefix: -s
  - id: skip_lordec_steps
    type:
      - 'null'
      - boolean
    doc: skips LoRDEC steps
    inputBinding:
      position: 102
      prefix: -n
  - id: start
    type:
      - 'null'
      - int
    doc: Start value for processing
    inputBinding:
      position: 102
  - id: step
    type:
      - 'null'
      - int
    doc: Step size for processing
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorma:0.4--2
stdout: lorma_lorma.sh.out
