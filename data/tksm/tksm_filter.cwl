cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - filter
label: tksm_filter
doc: "Splits the input MDF to 2 files with respect to a condition\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: input
    type: File
    doc: "input mdf file"
    inputBinding:
      position: 1
      prefix: --input
  - id: true_output
    type: string
    doc: "output mdf file for molecules that pass the condition"
    inputBinding:
      position: 1
      prefix: --true-output
  - id: false_output
    type: string
    doc: "output mdf file for molecules that fail the condition"
    inputBinding:
      position: 1
      prefix: --false-output
  - id: condition
    type:
      - 'null'
      - string[]
    doc: "Conditions to filter (and-ed together), comma separated: info <tag>, size <op><n>, locus <chr[:start[-end]]>"
    inputBinding:
      position: 1
      prefix: --condition
      itemSeparator: ','
  - id: negate
    type:
      - 'null'
      - boolean
    doc: "Negate the conjunction of the condition(s)"
    inputBinding:
      position: 1
      prefix: --negate
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed (default: 42)"
    inputBinding:
      position: 1
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Verbosity level to choose from [DEBUG, ERROR, INFO, OFF, WARN] (default: INFO)"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Log file to write the logs (or stderr/stdout) (default: stderr)"
    inputBinding:
      position: 1
      prefix: --log-file
outputs:
  - id: true_file
    type: File
    doc: "Molecules that pass the filter (MDF)"
    outputBinding:
      glob: "$(inputs.true_output)"
  - id: false_file
    type: File
    doc: "Molecules that fail the filter (MDF)"
    outputBinding:
      glob: "$(inputs.false_output)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_filter.out
