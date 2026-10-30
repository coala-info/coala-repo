cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - ologram_modl_treeify
label: pygtftk_ologram_modl_treeify
doc: "Turns a result of OLOGRAM-MODL multiple overlap (tsv file) in a tree for easier visualisation.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: inputfile
    type: File
    doc: "Complete path to the OLOGRAM output file."
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
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
  - id: min_inheritance
    type:
      - 'null'
      - float
    doc: "Optional. A combination will be added to a shorter parent in the tree only if it represents at least a proportion MH of its true base pairs (between 0 and 1)."
    inputBinding:
      position: 1
      prefix: --min_inheritance
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: "Do not add date to output file names."
    inputBinding:
      position: 1
      prefix: --no-date
  - id: output
    type: string
    doc: "Pdf file name."
    inputBinding:
      position: 1
      prefix: --output
  - id: query_label
    type:
      - 'null'
      - string
    doc: "Name of the query for display."
    inputBinding:
      position: 1
      prefix: --query-label
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: top_s
    type:
      - 'null'
      - int
    doc: "Optional. Only the top t combinations sorted by total basepairs in real data will be displayed."
    inputBinding:
      position: 1
      prefix: --top-s
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
    doc: "Pdf file name."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
