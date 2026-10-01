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
      prefix: -M
  - id: indel_penalty
    type:
      - 'null'
      - int
    doc: insertions and deletions are penalised this number of times more 
      heavily than mismatches
    inputBinding:
      position: 103
      prefix: -n
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: use json format for the output file
    inputBinding:
      position: 103
      prefix: -j
  - id: minimum_allele_count
    type:
      - 'null'
      - int
    doc: minimum count per allele
    inputBinding:
      position: 103
      prefix: -a
  - id: mismatches_per_nucleotide
    type:
      - 'null'
      - float
    doc: mismatches per nucleotide
    inputBinding:
      position: 103
      prefix: -m
  - id: output_directory
    type:
      - 'null'
      - string
    doc: output directory
    inputBinding:
      position: 103
      prefix: -d
  - id: report_file
    type:
      - 'null'
      - string
    doc: name of the report file
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tssv:1.1.2--py312h0fa9677_6
stdout: tssv.out
