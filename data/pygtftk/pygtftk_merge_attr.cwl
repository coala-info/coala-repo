cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - merge_attr
label: pygtftk_merge_attr
doc: "Merge a set of attributes into a destination attribute. Can be useful, for instance, to merge gene_name and gene_id values into a new key to prepare the GTF for RNA-seq quantification.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: dest_key
    type: string
    doc: "The target key name."
    inputBinding:
      position: 1
      prefix: --dest-key
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
  - id: separator
    type:
      - 'null'
      - string
    doc: "The separator for the concatenated values."
    inputBinding:
      position: 1
      prefix: --separator
  - id: src_key
    type: string
    doc: "comma-separated list of keys to join."
    inputBinding:
      position: 1
      prefix: --src-key
  - id: target_feature
    type:
      - 'null'
      - string
    doc: "The name of the target feature."
    inputBinding:
      position: 1
      prefix: --target-feature
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
