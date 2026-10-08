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
      - string
    doc: output (filename/stderr/stdout) [stderr]
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
  - id: log_output
    type:
      - 'null'
      - File
    doc: Benchmark log written to the file given by log_file
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galitime:0.2.0--pyhdfd78af_0
stdout: galitime.out
