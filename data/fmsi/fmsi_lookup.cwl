cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fmsi
  - lookup
label: fmsi_lookup
doc: "Look up sequences in an FMSI index.\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: index_prefix
    type: File
    secondaryFiles:
      - .fmsi.ac
      - .fmsi.ac_gt
      - .fmsi.gt
      - .fmsi.mask
      - .fmsi.misc
      - .fmsi.klcp?
    doc: Masked superstring file that was indexed with fmsi index (the index files sit beside it as <file>.fmsi.*)
    inputBinding:
      position: 200
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers
    inputBinding:
      position: 102
      prefix: -k
  - id: query_file
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
    doc: Use kLCP array for streamed queries (increses memory consumption)
    inputBinding:
      position: 102
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi_lookup.out
