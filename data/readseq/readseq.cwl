cwlVersion: v1.2
class: CommandLineTool
baseCommand: readseq
label: readseq
doc: "Read and reformat biosequences, Java command-line version. Converts between sequence formats (fasta, genbank, embl, phylip, nexus, msf, clustal and more), with options for case, reverse complement, translation, feature extraction and pretty printing.

Tool homepage: http://iubio.bio.indiana.edu/soft/molbio/readseq/java/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input sequence file(s)
    inputBinding:
      position: 200
  - id: output_file_path
    type: string
    doc: "Output file name. Without it readseq tries to write next to the input file, which fails for staged inputs"
    inputBinding:
      position: 100
      prefix: -output=
      separate: false
  - id: all_sequences
    type:
      - 'null'
      - boolean
    doc: "Select all sequences"
    inputBinding:
      position: 1
      prefix: -all
  - id: case_lower
    type:
      - 'null'
      - boolean
    doc: "Change to lower case"
    inputBinding:
      position: 2
      prefix: -caselower
  - id: case_upper
    type:
      - 'null'
      - boolean
    doc: "Change to UPPER CASE"
    inputBinding:
      position: 3
      prefix: -CASEUPPER
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: "Calculate and print the checksum of sequences"
    inputBinding:
      position: 4
      prefix: -checksum
  - id: degap
    type:
      - 'null'
      - string
    doc: "Remove gap symbols; the value is the gap symbol (for example -)"
    inputBinding:
      position: 5
      prefix: -degap=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Format number or format name for the output (for example fasta, genbank, phylip, nexus, msf, clustal, pir, embl, gff, 8)"
    inputBinding:
      position: 6
      prefix: -format=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Input format number or name; assume the input data is this format"
    inputBinding:
      position: 7
      prefix: -informat=
      separate: false
  - id: item_numbers
    type:
      - 'null'
      - string
    doc: "Select item number(s) from several, for example 2,3,4"
    inputBinding:
      position: 8
      prefix: -item=
      separate: false
  - id: list_sequences
    type:
      - 'null'
      - boolean
    doc: "List sequences only"
    inputBinding:
      position: 9
      prefix: -list
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: "Pipe mode (command line, stdin to stdout)"
    inputBinding:
      position: 10
      prefix: -pipe
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: "Reverse-complement of the input sequence"
    inputBinding:
      position: 11
      prefix: -reverse
  - id: translate_symbols
    type:
      - 'null'
      - string
    doc: "Translate input symbol i to output symbol o, given as io (for example tu)"
    inputBinding:
      position: 12
      prefix: -translate=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose progress"
    inputBinding:
      position: 13
      prefix: -verbose
  - id: compare
    type:
      - 'null'
      - string
    doc: "Compare two sequence files, reporting differences (flags=nodoc,noid,nolen,nocrc)"
    inputBinding:
      position: 14
      prefix: -compare=
      separate: false
  - id: amino_translate
    type:
      - 'null'
      - boolean
    doc: "Translate DNA to amino acids"
    inputBinding:
      position: 15
      prefix: -aminotranslate
  - id: features
    type:
      - 'null'
      - string
    doc: "Extract the sequence of selected features, for example exon,CDS"
    inputBinding:
      position: 16
      prefix: -features=
      separate: false
  - id: no_features
    type:
      - 'null'
      - string
    doc: "Remove the sequence of selected features, for example repeat_region,intron"
    inputBinding:
      position: 17
      prefix: -nofeatures=
      separate: false
  - id: fields
    type:
      - 'null'
      - string
    doc: "Include selected document fields in the output, for example AC,ID"
    inputBinding:
      position: 18
      prefix: -field=
      separate: false
  - id: no_fields
    type:
      - 'null'
      - string
    doc: "Remove selected document fields from the output, for example COMMENT"
    inputBinding:
      position: 19
      prefix: -nofield=
      separate: false
  - id: extract_range
    type:
      - 'null'
      - string
    doc: "Extract all features and sequence from a base range, for example 1000..9999"
    inputBinding:
      position: 20
      prefix: -extract=
      separate: false
  - id: subrange
    type:
      - 'null'
      - string
    doc: "Extract a subrange of the sequence for feature locations, for example 1..end"
    inputBinding:
      position: 21
      prefix: -subrange=
      separate: false
  - id: pair_features
    type:
      - 'null'
      - string
    doc: "Combine feature (fff, gff) and sequence files into one output"
    inputBinding:
      position: 22
      prefix: -pair=
      separate: false
  - id: unpair_features
    type:
      - 'null'
      - string
    doc: "Split features and sequence from one input into two files"
    inputBinding:
      position: 23
      prefix: -unpair=
      separate: false
  - id: width
    type:
      - 'null'
      - int
    doc: "Sequence line width (pretty format options)"
    inputBinding:
      position: 24
      prefix: -width=
      separate: false
  - id: tab
    type:
      - 'null'
      - int
    doc: "Left indent"
    inputBinding:
      position: 25
      prefix: -tab=
      separate: false
  - id: column_space
    type:
      - 'null'
      - int
    doc: "Column space within a sequence line on output"
    inputBinding:
      position: 26
      prefix: -colspace=
      separate: false
  - id: gap_count
    type:
      - 'null'
      - boolean
    doc: "Count gap characters in sequence numbers"
    inputBinding:
      position: 27
      prefix: -gapcount
  - id: name_left
    type:
      - 'null'
      - boolean
    doc: "Name on the left side"
    inputBinding:
      position: 28
      prefix: -nameleft
  - id: name_right
    type:
      - 'null'
      - string
    doc: "Name on the right side, with width"
    inputBinding:
      position: 29
      prefix: -nameright=
      separate: false
  - id: name_top
    type:
      - 'null'
      - boolean
    doc: "Name at top and bottom"
    inputBinding:
      position: 30
      prefix: -nametop
  - id: num_left
    type:
      - 'null'
      - boolean
    doc: "Sequence index on the left side"
    inputBinding:
      position: 31
      prefix: -numleft
  - id: num_right
    type:
      - 'null'
      - boolean
    doc: "Sequence index on the right side"
    inputBinding:
      position: 32
      prefix: -numright
  - id: num_top
    type:
      - 'null'
      - boolean
    doc: "Index on the top side"
    inputBinding:
      position: 33
      prefix: -numtop
  - id: num_bottom
    type:
      - 'null'
      - boolean
    doc: "Index on the bottom side"
    inputBinding:
      position: 34
      prefix: -numbot
  - id: match_base
    type:
      - 'null'
      - string
    doc: "Use a match base for species 2..n, for example ."
    inputBinding:
      position: 35
      prefix: -match=
      separate: false
  - id: interline
    type:
      - 'null'
      - int
    doc: "Blank lines between sequence blocks"
    inputBinding:
      position: 36
      prefix: -interline=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (messages, or results of -list, -checksum and -compare)
  - id: output_file
    type: File
    doc: Converted sequences written to output_file_path
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readseq:2.1.30--1
stdout: readseq.out
