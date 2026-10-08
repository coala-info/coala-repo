cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqe
label: fastqe
doc: "Read one or more FASTQ files and output emoji summaries of sequence quality.\n\
  \nTool homepage: https://github.com/lonsbio/fastqe"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ file(s)
    inputBinding:
      position: 2
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length sequence to include in stats (default 0)
    inputBinding:
      position: 1
      prefix: --minlen
  - id: scale
    type:
      - 'null'
      - boolean
    doc: show relevant scale in output
    inputBinding:
      position: 1
      prefix: --scale
  - id: mean
    type:
      - 'null'
      - boolean
    doc: show mean quality per position (DEFAULT)
    inputBinding:
      position: 1
      prefix: --mean
  - id: custom
    type:
      - 'null'
      - File
    doc: use a mapping of custom emoji to quality in CUSTOM_DICT
    inputBinding:
      position: 1
      prefix: --custom
  - id: bin
    type:
      - 'null'
      - boolean
    doc: use binned scores
    inputBinding:
      position: 1
      prefix: --bin
  - id: noemoji
    type:
      - 'null'
      - boolean
    doc: use mapping without emoji
    inputBinding:
      position: 1
      prefix: --noemoji
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: Hide the header before sample output
    inputBinding:
      position: 1
      prefix: --noheader
  - id: html
    type:
      - 'null'
      - string
    doc: output an additional HTML report in HTML_FILE
    inputBinding:
      position: 1
      prefix: --html
  - id: window
    type:
      - 'null'
      - int
    doc: Window length to summarise reads in HTML report (default 1)
    inputBinding:
      position: 1
      prefix: --window
  - id: html_escape
    type:
      - 'null'
      - boolean
    doc: escape html within output, e.g. for Galaxy parsing
    inputBinding:
      position: 1
      prefix: --html_escape
  - id: min
    type:
      - 'null'
      - boolean
    doc: show minimum quality per position
    inputBinding:
      position: 1
      prefix: --min
  - id: max
    type:
      - 'null'
      - boolean
    doc: show maximum quality per position
    inputBinding:
      position: 1
      prefix: --max
  - id: output_path
    type:
      - 'null'
      - string
    doc: write output to OUTPUT_FILE instead of stdout
    inputBinding:
      position: 1
      prefix: --output
  - id: long
    type:
      - 'null'
      - int
    doc: set initial arrays to be READ_LENGTH bp for long reads
    inputBinding:
      position: 1
      prefix: --long
  - id: log
    type:
      - 'null'
      - string
    doc: record program progress in LOG_FILE
    inputBinding:
      position: 1
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Emoji quality summary (empty when an output file is given)
  - id: output
    type:
      - 'null'
      - File
    doc: Output file (default is stdout)
    outputBinding:
      glob: $(inputs.output_path)
  - id: html_report
    type:
      - 'null'
      - File
    doc: HTML report
    outputBinding:
      glob: $(inputs.html)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Progress log
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqe:0.5.2--pyhdfd78af_0
stdout: fastqe.out
