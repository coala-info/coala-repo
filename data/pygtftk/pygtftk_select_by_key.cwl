cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - select_by_key
label: pygtftk_select_by_key
doc: "Select lines from a GTF file based on attributes and associated values.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: bed_format
    type:
      - 'null'
      - boolean
    doc: "Ask for bed format output."
    inputBinding:
      position: 1
      prefix: --bed-format
  - id: col
    type:
      - 'null'
      - int
    doc: "The column number (one-based) that contains the values in the file. File is tab-delimited."
    inputBinding:
      position: 1
      prefix: --col
  - id: file_with_values
    type:
      - 'null'
      - File
    doc: "A file containing values as a single column."
    inputBinding:
      position: 1
      prefix: --file-with-values
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "Path to the GTF file. Default to STDIN."
    inputBinding:
      position: 1
      prefix: --inputfile
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "Not/invert match. Select lines whose selected key is not associated with the selected values."
    inputBinding:
      position: 1
      prefix: --invert-match
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
    doc: "The key name."
    inputBinding:
      position: 1
      prefix: --key
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Print some statistics about selected features. To be used in conjunction with -V 1/2."
    inputBinding:
      position: 1
      prefix: --log
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
  - id: names
    type:
      - 'null'
      - string
    doc: "If Bed output. The key(s) that should be used as name."
    inputBinding:
      position: 1
      prefix: --names
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: "Do not add date to output file names."
    inputBinding:
      position: 1
      prefix: --no-date
  - id: outputfile
    type: string
    default: "out.gtf"
    doc: "Output file (GTF, or BED with --bed-format)."
    inputBinding:
      position: 1
      prefix: --outputfile
  - id: select_cds
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k feature -v CDS\"."
    inputBinding:
      position: 1
      prefix: --select-cds
  - id: select_exons
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k feature -v exon\"."
    inputBinding:
      position: 1
      prefix: --select-exons
  - id: select_genes
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k feature -v gene\"."
    inputBinding:
      position: 1
      prefix: --select-genes
  - id: select_start_codon
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k feature -v start_codon\"."
    inputBinding:
      position: 1
      prefix: --select-start-codon
  - id: select_transcripts
    type:
      - 'null'
      - boolean
    doc: "A shortcuts for \"-k feature -v transcript\"."
    inputBinding:
      position: 1
      prefix: --select-transcripts
  - id: separator
    type:
      - 'null'
      - string
    doc: "If Bed output. The separator to be used for separating name elements."
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
  - id: value
    type:
      - 'null'
      - string
    doc: "A comma-separated list of values."
    inputBinding:
      position: 1
      prefix: --value
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
    doc: "Output file (GTF, or BED with --bed-format)."
    outputBinding:
      glob: "$(inputs.outputfile)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
