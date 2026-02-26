cwlVersion: v1.2
class: CommandLineTool
baseCommand: siann.py
label: siann_siann.py
doc: "Please contact git@signaturescience.com with questions about this tool (C) 2020,
  Signature Science, LLC\n\nTool homepage: https://github.com/signaturescience/siann/wiki"
inputs:
  - id: db
    type:
      - 'null'
      - string
    doc: database of reference genomes to use
    inputBinding:
      position: 101
      prefix: --db
  - id: keep_sam
    type:
      - 'null'
      - boolean
    doc: retain the aligned reads in SAM format
    inputBinding:
      position: 101
      prefix: --keep_sam
  - id: out
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --out
  - id: paired
    type:
      - 'null'
      - string
    doc: second set of reads in pair (if any)
    inputBinding:
      position: 101
      prefix: --paired
  - id: reads
    type: File
    doc: Set of reads (FASTQ/FASTA) to be processed
    inputBinding:
      position: 101
      prefix: --reads
  - id: reads_out
    type:
      - 'null'
      - boolean
    doc: turn on the output of species- and strain-specific reads
    inputBinding:
      position: 101
      prefix: --reads_out
  - id: report
    type:
      - 'null'
      - boolean
    doc: turn off the generation of a report
    inputBinding:
      position: 101
      prefix: --report
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for alignment (all by default)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/siann:1.3--hdfd78af_0
stdout: siann_siann.py.out
