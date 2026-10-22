cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - head
label: tksm_head
doc: "Prints the first n molecules of an MDF file (read from standard input)\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: input_file
    type: File
    doc: "MDF file, read from standard input"
  - id: count
    type:
      - 'null'
      - int
    doc: "Number of items to be printed (default: 10)"
    inputBinding:
      position: 1
      prefix: --count
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
  - id: first_molecules
    type: stdout
    doc: The first n molecules (MDF)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdin: $(inputs.input_file.path)
stdout: tksm_head.mdf
