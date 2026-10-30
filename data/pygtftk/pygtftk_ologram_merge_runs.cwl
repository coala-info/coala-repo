cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - ologram_merge_runs
label: pygtftk_ologram_merge_runs
doc: "Merge a set of OLOGRAM runs into a single run and recalculates statistics based on it. This treats each run as a \"superbatch\". The command takes as input the list of paths of all the results' TSV you wish to merge. It also takes as input the number of shuffles originally performed in the individual runs (by default, is assumed to be 200).\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: inputfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: "Complete paths to the OLOGRAM output text files."
    inputBinding:
      position: 1
      prefix: --inputfiles
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
  - id: ori_shuffles
    type:
      - 'null'
      - int
    doc: "How many shuffles were performed in the individual runs that will be merged?"
    inputBinding:
      position: 1
      prefix: --ori-shuffles
  - id: output
    type: string
    doc: "Destination path for the merged output file."
    inputBinding:
      position: 1
      prefix: --output
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
    doc: "Destination path for the merged output file."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
