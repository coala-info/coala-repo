cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - polya
label: nanopolish_polya
doc: "Estimate the length of the poly-A tail on direct RNA reads\n\nTool homepage:
  https://github.com/jts/nanopolish"
inputs:
  - id: bam
    type: File
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: genome
    type: File
    doc: the reference genome assembly for the reads is in FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: reads
    type: File
    doc: the 1D ONT direct RNA reads are in fasta FILE
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - string
    doc: 'only compute the poly-A lengths for reads in window STR (format: ctg:start_id-end_id)'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_polya.out
