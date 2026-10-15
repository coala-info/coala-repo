cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_merge_multiple_gzip_files
label: phyluce_phyluce_utilities_merge_multiple_gzip_files
doc: "Given a config file and inputs, merge multiple gz files into one\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "${ var l = []; if (inputs.read_files) { l = l.concat(inputs.read_files); } if (inputs.read_dirs) { l = l.concat(inputs.read_dirs); } return l; }"
inputs:
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
  - id: trimmed
    type:
      - 'null'
      - boolean
    doc: "If the reads have already been trimmed."
    inputBinding:
      position: 1
      prefix: --trimmed
  - id: read_files
    type:
      - 'null'
      - {"type": "array", "items": "File"}
    doc: "Read files named in the configuration file. They are staged in the working directory, so use relative paths (the file name) in the configuration file."
  - id: read_dirs
    type:
      - 'null'
      - {"type": "array", "items": "Directory"}
    doc: "Directories of reads named in the configuration file. They are staged in the working directory, so use relative paths (the directory name) in the configuration file."
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the merged files"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_merge_multiple_gzip_files.out
