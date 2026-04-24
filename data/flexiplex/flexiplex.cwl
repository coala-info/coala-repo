cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexiplex
label: flexiplex
doc: "A versatile demultiplexer and search tool for omics data, used for searching
  and reporting barcodes, UMIs, and flanking sequences in sequencing reads.\n\nTool
  homepage: https://github.com/DavidsonGroup/flexiplex/"
inputs:
  - id: reads_input
    type:
      - 'null'
      - File
    doc: A .fastq or .fasta file. Will read from stdin if empty.
    inputBinding:
      position: 1
  - id: barcode_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: Append the barcode pattern to search for. The order of these options matters.
    inputBinding:
      position: 102
      prefix: -b
  - id: chimeric_suffix
    type:
      - 'null'
      - boolean
    doc: Add a _C suffix to the read identifier of any chimeric reads.
    inputBinding:
      position: 102
      prefix: -c
  - id: flanking_sequence
    type:
      - 'null'
      - type: array
        items: string
    doc: Append flanking sequence to search for. The order of these options matters.
    inputBinding:
      position: 102
      prefix: -x
  - id: known_list
    type:
      - 'null'
      - string
    doc: Either 1) a text file of expected barcodes in the first column, one row per
      barcode, or 2) a comma separate string of barcodes. Without this option, flexiplex
      will search and report possible barcodes.
    inputBinding:
      position: 102
      prefix: -k
  - id: max_edit_distance_barcode
    type:
      - 'null'
      - int
    doc: Maximum edit distance to barcode.
    inputBinding:
      position: 102
      prefix: -e
  - id: max_edit_distance_primer
    type:
      - 'null'
      - int
    doc: Maximum edit distance to primer+polyT.
    inputBinding:
      position: 102
      prefix: -f
  - id: predefined_scheme
    type:
      - 'null'
      - string
    doc: Predefined search schemes (e.g., 10x3v2, 10x3v3, 10x5v2, grep).
    inputBinding:
      position: 102
      prefix: -d
  - id: replace_read_id
    type:
      - 'null'
      - boolean
    doc: Replace read ID with barcodes+UMI, remove search strings including flanking
      sequenence and split read if multiple barcodes found.
    inputBinding:
      position: 102
      prefix: -i
  - id: sort_reads
    type:
      - 'null'
      - boolean
    doc: Sort reads into separate files by barcode.
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 102
      prefix: -p
  - id: umi_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: Append the UMI pattern to search for. The order of these options matters.
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output filenames.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
