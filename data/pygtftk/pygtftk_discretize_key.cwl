cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - discretize_key
label: pygtftk_discretize_key
doc: "Create a new key by discretizing a numeric key. This can be helpful to create new classes on the fly that can be used subsequently.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the GTF file. Default to STDIN"
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: src_key
    type: string
    doc: "The name of the source key"
    inputBinding:
      position: 101
      prefix: --src-key
  - id: dest_key
    type: string
    doc: "The name of the target key."
    inputBinding:
      position: 101
      prefix: --dest-key
  - id: nb_levels
    type: ['null', int]
    doc: "The number of levels/classes to create."
    inputBinding:
      position: 101
      prefix: --nb-levels
  - id: labels
    type: ['null', string]
    doc: "A comma-separated list of labels of size --nb-levels."
    inputBinding:
      position: 101
      prefix: --labels
  - id: percentiles
    type: ['null', boolean]
    doc: "Compute --nb-levels classes using percentiles."
    inputBinding:
      position: 101
      prefix: --percentiles
  - id: log
    type: ['null', boolean]
    doc: "Compute breaks based on log-scale."
    inputBinding:
      position: 101
      prefix: --log
  - id: percentiles_of_uniq
    type: ['null', boolean]
    doc: "Compute percentiles based on non-redondant values."
    inputBinding:
      position: 101
      prefix: --percentiles-of-uniq
  - id: precision
    type: ['null', int]
    doc: "The precision used in naming intervals."
    inputBinding:
      position: 101
      prefix: --precision
  - id: verbosity
    type: ['null', int]
    doc: "Set output verbosity ([0-3])."
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: no_date
    type: ['null', boolean]
    doc: "Do not add date to output file names."
    inputBinding:
      position: 101
      prefix: --no-date
  - id: add_chr
    type: ['null', boolean]
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 101
      prefix: --add-chr
  - id: tmp_dir
    type: ['null', string]
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: keep_all
    type: ['null', boolean]
    doc: "Try to keep all temporary files even if process does not terminate normally."
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: logger_file
    type: ['null', string]
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 101
      prefix: --logger-file
  - id: write_message_to_file
    type: ['null', string]
    doc: "Store all message into a file."
    inputBinding:
      position: 101
      prefix: --write-message-to-file
outputs:
  - id: outputfile
    type: File
    doc: "Output file."
    outputBinding:
      glob: $(inputs.outputfile_path)
  - id: logger_file_out
    type: ['null', File]
    doc: "Stores the arguments passed to the command into a file."
    outputBinding:
      glob: $(inputs.logger_file)
  - id: write_message_to_file_out
    type: ['null', File]
    doc: "Store all message into a file."
    outputBinding:
      glob: $(inputs.write_message_to_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
