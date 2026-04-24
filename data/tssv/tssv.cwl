cwlVersion: v1.2
class: CommandLineTool
baseCommand: tssv
label: tssv
doc: "Targeted characterisation of short structural variation.\n\nTool homepage: The
  package home page"
inputs:
  - id: input
    type: File
    doc: a FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: library
    type: string
    doc: library of flanking sequences
    inputBinding:
      position: 2
  - id: fixed_mismatches
    type:
      - 'null'
      - int
    doc: fixed number of mismatches, overrides -m
    inputBinding:
      position: 103
      prefix: --fixed_mismatches
  - id: indel_penalty
    type:
      - 'null'
      - int
    doc: insertions and deletions are penalised this number of times more 
      heavily than mismatches
    inputBinding:
      position: 103
      prefix: --indel_penalty
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: use json format for the output file
    inputBinding:
      position: 103
      prefix: --json_output
  - id: minimum_allele_count
    type:
      - 'null'
      - int
    doc: minimum count per allele
    inputBinding:
      position: 103
      prefix: --minimum_allele_count
  - id: mismatches_per_nucleotide
    type:
      - 'null'
      - float
    doc: mismatches per nucleotide
    inputBinding:
      position: 103
      prefix: --mismatches_per_nucleotide
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 103
      prefix: --output_directory
  - id: report_file
    type:
      - 'null'
      - string
    doc: name of the report file
    inputBinding:
      position: 103
      prefix: --report_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tssv:1.1.2--py312h0fa9677_6
stdout: tssv.out
