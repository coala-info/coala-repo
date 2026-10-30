cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - join_attr
label: pygtftk_join_attr
doc: "Join attributes from a tabulated file.\n\nTool homepage: http://github.com/dputhier/pygtftk"
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
  - id: key_to_join
    type: string
    doc: "The name of the key used to join (e.g transcript_id)."
    inputBinding:
      position: 101
      prefix: --key-to-join
  - id: join_file
    type: File
    doc: "A two columns file with (i) the value for joining (e.g value for transcript_id), (ii) the value for novel key (e.g the coding potential computed value)."
    inputBinding:
      position: 101
      prefix: --join-file
  - id: has_header
    type: ['null', boolean]
    doc: "Indicates that the 'join-file' has a header."
    inputBinding:
      position: 101
      prefix: --has-header
  - id: matrix
    type: ['null', boolean]
    doc: "'join-file' expect a matrix with row names as target keys column names as novel key and each cell as value."
    inputBinding:
      position: 101
      prefix: --matrix
  - id: new_key
    type: ['null', string]
    doc: "The name of the novel key. Mutually exclusive with --matrix."
    inputBinding:
      position: 101
      prefix: --new-key
  - id: target_feature
    type: ['null', string]
    doc: "The name(s) of the target feature(s). comma-separated."
    inputBinding:
      position: 101
      prefix: --target-feature
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
