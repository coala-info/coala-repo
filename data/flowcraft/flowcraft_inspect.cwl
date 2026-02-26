cwlVersion: v1.2
class: CommandLineTool
baseCommand: flowcraft inspect
label: flowcraft_inspect
doc: "Inspect Nextflow runs\n\nTool homepage: https://github.com/assemblerflow/flowcraft"
inputs:
  - id: mode
    type:
      - 'null'
      - string
    doc: Specify the inspection run mode.
    inputBinding:
      position: 101
      prefix: --mode
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: Pretty inspection mode that removes usual reporting processes.
    inputBinding:
      position: 101
      prefix: --pretty
  - id: refresh_rate
    type:
      - 'null'
      - float
    doc: Set the refresh frequency for the continuous inspect functions
    inputBinding:
      position: 101
      prefix: -r
  - id: trace_file
    type:
      - 'null'
      - File
    doc: Specify the nextflow trace file.
    inputBinding:
      position: 101
      prefix: -i
  - id: url
    type:
      - 'null'
      - string
    doc: Specify the URL to where the data should be broadcast
    inputBinding:
      position: 101
      prefix: --url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flowcraft:1.4.1--py_1
stdout: flowcraft_inspect.out
