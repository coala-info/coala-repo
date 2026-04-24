cwlVersion: v1.2
class: CommandLineTool
baseCommand: runner.py
label: kegalign-full_runner.py
doc: "Runner script for kegalign-full\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug messages
    inputBinding:
      position: 101
      prefix: --debug
  - id: diagonal_partition
    type:
      - 'null'
      - boolean
    doc: run diagonal partition optimization
    inputBinding:
      position: 101
      prefix: --diagonal-partition
  - id: markend
    type:
      - 'null'
      - boolean
    doc: write a marker line just before completion
    inputBinding:
      position: 101
      prefix: --markend
  - id: nogapped
    type:
      - 'null'
      - boolean
    doc: don't perform gapped extension stage
    inputBinding:
      position: 101
      prefix: --nogapped
  - id: num_cpu
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --num-cpu
  - id: num_gpu
    type:
      - 'null'
      - int
    doc: number of GPUs to use
    inputBinding:
      position: 101
      prefix: --num-gpu
  - id: output_file
    type: string
    doc: output pathname
    inputBinding:
      position: 101
      prefix: --output-file
  - id: output_type
    type:
      - 'null'
      - string
    doc: output type
    inputBinding:
      position: 101
      prefix: --output-type
  - id: tool_directory
    type: Directory
    doc: tool directory
    inputBinding:
      position: 101
      prefix: --tool_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_runner.py.out
