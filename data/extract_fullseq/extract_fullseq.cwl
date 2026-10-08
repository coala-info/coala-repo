cwlVersion: v1.2
class: CommandLineTool
baseCommand: [extract_fullseq]
label: extract_fullseq
doc: "Extract (keep) or remove sequences listed in an id list from a FASTA or FASTQ file (from NCBI bmtools); the result is written to standard output.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/pub/agarwala/bmtagger/"
inputs:
  - id: id_list
    type: File
    doc: File with the sequence ids to keep or remove.
    inputBinding:
      position: 1
  - id: action
    type:
      type: enum
      symbols:
        - keep
        - remove
    doc: Keep the listed sequences, or remove them.
    inputBinding:
      position: 2
      valueFrom: -$(self)
  - id: format
    type:
      type: enum
      symbols:
        - fasta
        - fastq
    doc: Format of the sequence file.
    inputBinding:
      position: 3
      valueFrom: -$(self)
  - id: read_type
    type:
      type: enum
      symbols:
        - single
        - mate1
        - mate2
    doc: Single reads, or first or second mate of paired reads.
    inputBinding:
      position: 4
      valueFrom: -$(self)
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: Sequence file (large file); standard input is read when not given.
    inputBinding:
      position: 5
outputs:
  - id: extracted_sequences
    type: stdout
    doc: Extracted sequences (standard output).
stdout: extracted_sequences.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_fullseq:3.101--h9948957_6
