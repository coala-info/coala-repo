cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexiplex
label: flexiplex
doc: "A versatile demultiplexer and search tool for omics data, used for searching
  and reporting barcodes, UMIs, and flanking sequences in sequencing reads.\n\nTool
  homepage: https://github.com/DavidsonGroup/flexiplex/"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: flexiplex_search_element
        type: record
        fields:
          - name: kind
            type:
              type: enum
              name: flexiplex_search_kind
              symbols:
                - x
                - b
                - u
            doc: 'x = flanking sequence, b = barcode pattern, u = UMI pattern'
            inputBinding:
              position: 1
              valueFrom: $("-" + self)
          - name: sequence
            type: string
            doc: Sequence or pattern ('?' is a wildcard)
            inputBinding:
              position: 2
inputs:
  - id: reads_input
    type:
      - 'null'
      - File
    doc: A .fastq or .fasta file. Will read from stdin if empty.
    inputBinding:
      position: 3
  - id: known_list
    type:
      - 'null'
      - File
      - string
    doc: Either 1) a text file of expected barcodes in the first column, one row per
      barcode, or 2) a comma separate string of barcodes. Without this option, flexiplex
      will search and report possible barcodes.
    inputBinding:
      position: 102
      prefix: -k
  - id: replace_read_id
    type:
      - 'null'
      - boolean
    doc: Replace read ID with barcodes+UMI, remove search strings including flanking
      sequence and split read if multiple barcodes found (default true).
    inputBinding:
      position: 102
      prefix: -i
      valueFrom: "$(self === null ? null : (self ? 'true' : 'false'))"
  - id: sort_reads
    type:
      - 'null'
      - boolean
    doc: Sort reads into separate files by barcode (default false).
    inputBinding:
      position: 102
      prefix: -s
      valueFrom: "$(self === null ? null : (self ? 'true' : 'false'))"
  - id: chimeric_suffix
    type:
      - 'null'
      - boolean
    doc: Add a _C suffix to the read identifier of any chimeric reads (default false).
    inputBinding:
      position: 102
      prefix: -c
      valueFrom: "$(self === null ? null : (self ? 'true' : 'false'))"
  - id: output_prefix_path
    type:
      - 'null'
      - string
    doc: Prefix for output filenames.
    inputBinding:
      position: 102
      prefix: -n
  - id: max_edit_distance_barcode
    type:
      - 'null'
      - int
    doc: Maximum edit distance to barcode (default 2).
    inputBinding:
      position: 102
      prefix: -e
  - id: max_edit_distance_primer
    type:
      - 'null'
      - int
    doc: Maximum edit distance to primer+polyT (default 8).
    inputBinding:
      position: 102
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1).
    inputBinding:
      position: 102
      prefix: -p
  - id: predefined_scheme
    type:
      - 'null'
      - string
    doc: Predefined search scheme (10x3v2, 10x3v3, 10x5v2, grep).
    inputBinding:
      position: 102
      prefix: -d
  - id: search_elements
    type:
      - 'null'
      - type: array
        items: flexiplex_search_element
    doc: Ordered search structure. Each element is a flanking sequence (x), a barcode
      pattern (b) or a UMI pattern (u). The order of the elements matters. Without
      elements and without a predefined scheme, the default 10x pattern is used.
    inputBinding:
      position: 101
outputs:
  - id: reads
    type: stdout
    doc: Reads with barcode and UMI in the read identifier (FASTQ or FASTA)
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Barcode assignment, barcode count and per-barcode read files
    outputBinding:
      glob: "$(inputs.output_prefix_path ? inputs.output_prefix_path : 'flexiplex')*"
stdout: flx_reads.fastq
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
