cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - select_by_go
label: pygtftk_select_by_go
doc: "Select lines/genes from a GTF file using a Gene Ontology ID (e.g GO:0097194).\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: go_id
    type:
      - 'null'
      - string
    doc: "The GO ID (with or without \"GO:\" prefix)."
    inputBinding:
      position: 1
      prefix: --go-id
  - id: http_proxy
    type:
      - 'null'
      - string
    doc: "Use this http proxy (not tested/experimental)."
    inputBinding:
      position: 1
      prefix: --http-proxy
  - id: https_proxy
    type:
      - 'null'
      - string
    doc: "Use this https proxy (not tested/experimental)."
    inputBinding:
      position: 1
      prefix: --https-proxy
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
    doc: "Not/invert match."
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
  - id: list_datasets
    type:
      - 'null'
      - boolean
    doc: "Do not select lines. Only get a list of available datasets/species."
    inputBinding:
      position: 1
      prefix: --list-datasets
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
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
    doc: "Output file."
    inputBinding:
      position: 1
      prefix: --outputfile
  - id: species
    type:
      - 'null'
      - string
    doc: "The dataset/species."
    inputBinding:
      position: 1
      prefix: --species
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 1
      prefix: --tmp-dir
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
    doc: "Output file."
    outputBinding:
      glob: "$(inputs.outputfile)"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
