cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit accession2fasta
label: cdskit_accession2fasta
doc: "Convert NCBI accession numbers to FASTA sequences.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: accession_file
    type:
      - 'null'
      - File
    doc: PATH to the accession-per-line text file.
    inputBinding:
      position: 101
      prefix: --accession_file
  - id: email
    type:
      - 'null'
      - string
    doc: "Your email address. This is passed to the NCBI's E-utilities. For details,
      see here:\n                        https://biopython.org/docs/1.75/api/Bio.Entrez.html"
    inputBinding:
      position: 101
      prefix: --email
  - id: extract_cds
    type:
      - 'null'
      - string
    doc: Whether to extract the CDS feature.
    inputBinding:
      position: 101
      prefix: --extract_cds
  - id: list_seqname_keys
    type:
      - 'null'
      - string
    doc: Listing the keys (and values) available for --seqnamefmt.
    inputBinding:
      position: 101
      prefix: --list_seqname_keys
  - id: ncbi_database
    type:
      - 'null'
      - string
    doc: NCBI database to search.
    inputBinding:
      position: 101
      prefix: --ncbi_database
  - id: outseqformat
    type:
      - 'null'
      - string
    doc: "Output sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    inputBinding:
      position: 101
      prefix: --outseqformat
  - id: seqnamefmt
    type:
      - 'null'
      - string
    doc: "Underline-separated list of output sequence name elements. Try\n       \
      \                 --list_seqname_keys to check available values."
    inputBinding:
      position: 101
      prefix: --seqnamefmt
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output sequence file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
