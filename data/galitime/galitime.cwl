cwlVersion: v1.2
class: CommandLineTool
baseCommand: galitime
label: galitime
doc: "benchmarking of computational experiments using GNU time\n\nTool homepage: https://github.com/karel-brinda/galitime"
inputs:
  - id: command
    type: string
    doc: the command to be benchmarked
    inputBinding:
      position: 1
  - id: gtime
    type:
      - 'null'
      - boolean
    doc: call gtime instead of time
    inputBinding:
      position: 102
      prefix: --gtime
  - id: log_file
    type:
      - 'null'
      - File
    doc: output (filename/stderr/stdout)
    inputBinding:
      position: 102
      prefix: --log
  - id: name
    type:
      - 'null'
      - string
    doc: name of the experiment
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galitime:0.2.0--pyhdfd78af_0
stdout: galitime.out
