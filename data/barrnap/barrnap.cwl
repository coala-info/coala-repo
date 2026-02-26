cwlVersion: v1.2
class: CommandLineTool
baseCommand: barrnap
label: barrnap
doc: "Finds and annotates ribosomal RNA genes in genome sequences.\n\nTool homepage:
  https://github.com/tseemann/barrnap"
inputs:
  - id: genome_file
    type: File
    doc: Genome sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff for nhmmer
    default: '1e-06'
    inputBinding:
      position: 102
      prefix: --evalue
  - id: kingdom
    type:
      - 'null'
      - string
    doc: Kingdom to use for database search (e.g., bac, arc, euk, mito, chloro)
    default: bac
    inputBinding:
      position: 102
      prefix: --kingdom
  - id: min_length_ratio
    type:
      - 'null'
      - float
    doc: Tag genes < this ratio of expected length
    default: 0.8
    inputBinding:
      position: 102
      prefix: --minlength
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reject_length_ratio
    type:
      - 'null'
      - float
    doc: Reject genes < this ratio of expected length
    default: 0.25
    inputBinding:
      position: 102
      prefix: --reject
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: outseq
    type:
      - 'null'
      - File
    doc: Write sequences with rRNA genes to this file
    outputBinding:
      glob: $(inputs.outseq)
  - id: out
    type:
      - 'null'
      - File
    doc: 'Write annotations to this file (default: stdout)'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap:0.9--1
