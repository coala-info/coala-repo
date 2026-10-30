cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - tabulate
label: pygtftk_tabulate
doc: "Convert a GTF to tabulated format. By default tabulate discards any line for which one of the selected key is not defined; use --accept-undef to print them. 'all' or '*' are special keys that convert the whole GTF into a tabulated file.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: accept_undef
    type:
      - 'null'
      - boolean
    doc: "Print line for which the key is undefined (i.e, '?', does not exists)."
    inputBinding:
      position: 1
      prefix: --accept-undef
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "Path to the GTF file. Default to STDIN."
    inputBinding:
      position: 1
      prefix: --inputfile
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: "Try to keep all temporary files even if process does not terminate normally."
    inputBinding:
      position: 1
      prefix: --keep-all
  - id: key
    type:
      - 'null'
      - string
    doc: "A comma-separated list of key names."
    inputBinding:
      position: 1
      prefix: --key
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
  - id: no_basic
    type:
      - 'null'
      - boolean
    doc: "In case key is set to 'all' or '*', don't write basic attributes."
    inputBinding:
      position: 1
      prefix: --no-basic
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: "Do not add date to output file names."
    inputBinding:
      position: 1
      prefix: --no-date
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: "Don't print the header line."
    inputBinding:
      position: 1
      prefix: --no-header
  - id: no_unset
    type:
      - 'null'
      - boolean
    doc: "Don't print lines containing '.' (unset values)."
    inputBinding:
      position: 1
      prefix: --no-unset
  - id: outputfile
    type: string
    default: "out.txt"
    doc: "Output file (TXT)."
    inputBinding:
      position: 1
      prefix: --outputfile
  - id: select_exon_ids
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k exon_ids\"."
    inputBinding:
      position: 1
      prefix: --select-exon-ids
  - id: select_gene_ids
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k gene_id\"."
    inputBinding:
      position: 1
      prefix: --select-gene_ids
  - id: select_gene_names
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k gene_name\"."
    inputBinding:
      position: 1
      prefix: --select-gene-names
  - id: select_transcript_ids
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k transcript_id\"."
    inputBinding:
      position: 1
      prefix: --select-transcript-ids
  - id: separator
    type:
      - 'null'
      - string
    doc: "The output field separator."
    inputBinding:
      position: 1
      prefix: --separator
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: unique
    type:
      - 'null'
      - boolean
    doc: "Print a non redondant list of lines."
    inputBinding:
      position: 1
      prefix: --unique
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Set output verbosity ([0-3])."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: write_message_to_file
    type:
      - 'null'
      - string
    doc: "Store all message into a file."
    inputBinding:
      position: 1
      prefix: --write-message-to-file
outputs:
  - id: result
    type: File
    doc: "Output file (TXT)."
    outputBinding:
      glob: "$(inputs.outputfile)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
