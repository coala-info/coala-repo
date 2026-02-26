cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - get_example
label: pygtftk_gtftk get_example
doc: "Print example files including GTF.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: Add 'chr' to chromosome names before printing output.
    default: false
    inputBinding:
      position: 101
      prefix: --add-chr
  - id: all_dataset
    type:
      - 'null'
      - boolean
    doc: Get the list of all datasets.
    default: false
    inputBinding:
      position: 101
      prefix: --all-dataset
  - id: dataset
    type:
      - 'null'
      - string
    doc: Select a dataset.
    default: simple
    inputBinding:
      position: 101
      prefix: --dataset
  - id: format
    type:
      - 'null'
      - string
    doc: The dataset format.
    default: gtf
    inputBinding:
      position: 101
      prefix: --format
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Try to keep all temporary files even if process does not terminate 
      normally.
    default: false
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: list
    type:
      - 'null'
      - boolean
    doc: Only list files of a dataset.
    default: false
    inputBinding:
      position: 101
      prefix: --list
  - id: logger_file
    type:
      - 'null'
      - File
    doc: Stores the arguments passed to the command into a file.
    inputBinding:
      position: 101
      prefix: --logger-file
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: Do not add date to output file names.
    default: false
    inputBinding:
      position: 101
      prefix: --no-date
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't write any message when copying files.
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Keep all temporary files into this folder.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set output verbosity ([0-3]).
    default: 0
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: write_message_to_file
    type:
      - 'null'
      - File
    doc: Store all message into a file.
    inputBinding:
      position: 101
      prefix: --write-message-to-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
