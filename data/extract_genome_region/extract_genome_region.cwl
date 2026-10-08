cwlVersion: v1.2
class: CommandLineTool
baseCommand: [extract_genome_region]
label: extract_genome_region
doc: "Given a CSV file of variable information defining the regions of interest along with input and output fasta file paths, write a file that contains a fasta-formatted representation of these regions.\n\nThe regions CSV has the columns record_name, scaffold, start, stop, left_bfr and right_bfr.\n\nTool homepage: https://github.com/xguse/extract-genome-region"
inputs:
  - id: regions
    type: File
    doc: CSV file defining the regions of interest (record_name, scaffold, start,
      stop, left_bfr, right_bfr).
    inputBinding:
      position: 1
  - id: in_fasta
    type: File
    doc: Input fasta file with the source sequences.
    inputBinding:
      position: 2
  - id: out_fasta
    type: string
    doc: Output fasta file name.
    inputBinding:
      position: 3
  - id: naming
    type:
      - 'null'
      - type: enum
        symbols:
          - csv
          - seq_range
          - csv_seq_range
    doc: How each new fasta record is named (csv, seq_range or csv_seq_range).
      Default is csv.
    inputBinding:
      position: 0
      prefix: --naming
outputs:
  - id: output_fasta
    type: File
    doc: Fasta file with the extracted regions.
    outputBinding:
      glob: $(inputs.out_fasta)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_genome_region:0.0.3--py_2
