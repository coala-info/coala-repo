cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_merge_next_seq_gzip_files
label: phyluce_phyluce_utilities_merge_next_seq_gzip_files
doc: "Given a config file and inputs, merge multiple read files output by the NextSeq into one\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The path to a directory containing the reads to merge."
    inputBinding:
      position: 1
      prefix: --input
  - id: config
    type: File
    doc: "The path to the config file to use for merging."
    inputBinding:
      position: 1
      prefix: --config
  - id: output
    type: string
    doc: "The path to a directory in which to store the output."
    inputBinding:
      position: 1
      prefix: --output
  - id: section
    type:
      - 'null'
      - string
    doc: "The section holding the merge info."
    inputBinding:
      position: 1
      prefix: --section
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use (INFO, WARN or CRITICAL)."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory must already exist."
    inputBinding:
      position: 1
      prefix: --log-path
  - id: se
    type:
      - 'null'
      - boolean
    doc: "Run is single-end."
    inputBinding:
      position: 1
      prefix: --se
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the merged read files"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_merge_next_seq_gzip_files.out
