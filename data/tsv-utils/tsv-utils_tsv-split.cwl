cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-split
label: tsv-utils_tsv-split
doc: "Split input lines into multiple output files: fixed number of lines per file, random assignment, or random assignment by key.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Input files have a header line. Write the header to each output file."
    inputBinding:
      position: 101
      prefix: -H
  - id: header_in_only
    type:
      - 'null'
      - boolean
    doc: "Input files have a header line. Do not write the header to output files."
    inputBinding:
      position: 101
      prefix: -I
  - id: lines_per_file
    type:
      - 'null'
      - int
    doc: "Number of lines to write to each output file (excluding the header line)."
    inputBinding:
      position: 101
      prefix: -l
  - id: num_files
    type:
      - 'null'
      - int
    doc: "Number of output files to generate."
    inputBinding:
      position: 101
      prefix: -n
  - id: key_fields
    type:
      - 'null'
      - string
    doc: "Fields to use as key. Lines with the same key are written to the same output file. Use 0 to use the entire line as the key."
    inputBinding:
      position: 101
      prefix: -k
  - id: dir
    type:
      - 'null'
      - string
    doc: "Directory to write to. Default: Current working directory."
    inputBinding:
      position: 101
      prefix: --dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Filename prefix. Default: 'part_'"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Filename suffix. Default: First input file extension. None for standard input."
    inputBinding:
      position: 101
      prefix: --suffix
  - id: digit_width
    type:
      - 'null'
      - int
    doc: "Number of digits in filename numeric portion."
    inputBinding:
      position: 101
      prefix: -w
  - id: append
    type:
      - 'null'
      - boolean
    doc: "Append to existing files."
    inputBinding:
      position: 101
      prefix: -a
  - id: static_seed
    type:
      - 'null'
      - boolean
    doc: "Use the same random seed every run."
    inputBinding:
      position: 101
      prefix: -s
  - id: seed_value
    type:
      - 'null'
      - int
    doc: "Sets the random seed. Use a non-zero, 32 bit positive integer. Zero is a no-op."
    inputBinding:
      position: 101
      prefix: -v
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter."
    inputBinding:
      position: 101
      prefix: -d
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: "Maximum open file handles to use. Min of 5 required."
    inputBinding:
      position: 101
      prefix: --max-open-files
outputs:
  - id: part_files
    type:
      type: array
      items: File
    doc: Output files (default names part_NNN<suffix>, inside --dir when given)
    outputBinding:
      glob: "$((inputs.dir ? inputs.dir + '/' : '') + (inputs.prefix ? inputs.prefix : 'part_') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
