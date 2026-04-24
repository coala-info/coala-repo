cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmsi query
label: fmsi_query
doc: "Query an FMSI index.\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: index_prefix
    type: string
    doc: Prefix of the FMSI index files
    inputBinding:
      position: 1
  - id: demasking_function
    type:
      - 'null'
      - string
    doc: 'Demasking function to determine k-mer presence; recognized functions: or,
      all, and, xor, INT-INT'
    inputBinding:
      position: 102
      prefix: -f
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers
    inputBinding:
      position: 102
      prefix: -k
  - id: queries_file
    type:
      - 'null'
      - File
    doc: Path to FASTA/FASTQ with queries
    inputBinding:
      position: 102
      prefix: -q
  - id: use_klcp
    type:
      - 'null'
      - boolean
    doc: Use kLCP array for streamed queries (increases memory consumption)
    inputBinding:
      position: 102
      prefix: -S
  - id: use_max_one_masked_superstrings
    type:
      - 'null'
      - boolean
    doc: FMSI uses properties of max-one masked superstrings to speed up 
      queries. Use only if a masked superstring with maximum number of ones is 
      indexed.
    inputBinding:
      position: 102
      prefix: -O
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi_query.out
