cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_barcode_splitter.pl
label: fastx_toolkit_fastx_barcode_splitter
doc: "Split a FASTA/FASTQ file into several smaller files, based on barcode matching. Reads the sequences from STDIN, writes one file per barcode plus an 'unmatched' file, and prints a summary to STDOUT.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: barcode_file
    type: File
    doc: "Barcodes file name. Each line holds an identifier and a barcode (A/C/G/T) separated by a TAB. Lines starting with # are comments."
    inputBinding:
      position: 101
      prefix: --bcfile
  - id: bol
    type:
      - 'null'
      - boolean
    doc: "Try to match barcodes at the BEGINNING of sequences (5' end). One of --bol, --eol must be specified, but not both."
    inputBinding:
      position: 101
      prefix: --bol
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print lots of useless debug information to STDERR."
    inputBinding:
      position: 101
      prefix: --debug
  - id: eol
    type:
      - 'null'
      - boolean
    doc: "Try to match barcodes at the END of sequences (3' end). One of --bol, --eol must be specified, but not both."
    inputBinding:
      position: 101
      prefix: --eol
  - id: exact
    type:
      - 'null'
      - boolean
    doc: "Same as '--mismatches 0'. If both --exact and --mismatches are specified, '--exact' takes precedence."
    inputBinding:
      position: 101
      prefix: --exact
  - id: input_file
    type: File
    doc: "FASTA/FASTQ input file (read from STDIN; the format is auto-detected)."
  - id: mismatches
    type:
      - 'null'
      - int
    doc: "Max. number of mismatches allowed. Default is 1."
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: partial
    type:
      - 'null'
      - int
    doc: "Allow partial overlap of barcodes: the number of allowed non-overlapping bases. Default is no partial matching."
    inputBinding:
      position: 101
      prefix: --partial
  - id: prefix
    type: string
    doc: "File prefix. Will be added to the output files. Can be used to specify output directories."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not print counts and summary at the end of the run."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: suffix
    type:
      - 'null'
      - string
    doc: "File suffix (optional). Can be used to specify file extensions."
    inputBinding:
      position: 101
      prefix: --suffix
stdin: $(inputs.input_file.path)
stdout: fastx_barcode_splitter_summary.txt
outputs:
  - id: summary
    type: stdout
  - id: split_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Split FASTA/Q files, one per barcode plus the 'unmatched' file (named PREFIX + barcode id + SUFFIX)."
    outputBinding:
      glob: $(inputs.prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
