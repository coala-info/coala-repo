cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - assess
label: thapbi-pict_assess
doc: "Assess accuracy of marker sequence classification.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "TSV filenames named `*.<method>.tsv`, and `*.<known>.tsv`."
    inputBinding:
      position: 101
      prefix: -i
  - id: ignore_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more filename prefixes to ignore, default Undetermined_ unknown_"
    inputBinding:
      position: 101
      prefix: --ignore-prefixes
  - id: known
    type:
      - 'null'
      - string
    doc: "Replaces the string used in filenames for the truth against which the method is assessed, default is 'known'."
    inputBinding:
      position: 101
      prefix: --known
  - id: database
    type:
      - 'null'
      - File
    doc: "Marker database to use, default '-' for bundled DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: marker
    type:
      - 'null'
      - string
    doc: "Which amplicon marker from the DB wanted? Default all."
    inputBinding:
      position: 101
      prefix: --marker
  - id: method
    type:
      - 'null'
      - string
    doc: "Classify method (to infer filenames), default 'onebp'."
    inputBinding:
      position: 101
      prefix: -m
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum abundance to require before considering a classification. Default is one."
    inputBinding:
      position: 101
      prefix: -a
  - id: output
    type:
      - 'null'
      - string
    doc: "File to write species level classification assessment table to. Default is '-' meaning to stdout."
    inputBinding:
      position: 101
      prefix: -o
  - id: table
    type:
      - 'null'
      - string
    doc: "File to write expected-to-predicted mapping tally table to. Can use '-' meaning to stdout."
    inputBinding:
      position: 101
      prefix: -t
  - id: confusion
    type:
      - 'null'
      - string
    doc: "File to write species level confusion matrix to. Can use '-' meaning to stdout."
    inputBinding:
      position: 101
      prefix: -c
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Assessment table"
    outputBinding:
      glob: $(inputs.output)
  - id: table_file
    type:
      - 'null'
      - File
    doc: "Mapping tally table"
    outputBinding:
      glob: $(inputs.table)
  - id: confusion_file
    type:
      - 'null'
      - File
    doc: "Confusion matrix"
    outputBinding:
      glob: $(inputs.confusion)
  - id: log
    type: stdout
    doc: "Standard output when no output file is given"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_assess.out
