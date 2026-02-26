cwlVersion: v1.2
class: CommandLineTool
baseCommand: bench
label: bart_bench
doc: "Performs a series of micro-benchmarks.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: output
    type:
      - 'null'
      - string
    doc: Output file
    inputBinding:
      position: 1
  - id: select_benchmarks
    type:
      - 'null'
      - string
    doc: select benchmarks
    inputBinding:
      position: 102
      prefix: -s
  - id: varying_problem_size
    type:
      - 'null'
      - boolean
    doc: varying problem size
    inputBinding:
      position: 102
      prefix: -S
  - id: varying_threads
    type:
      - 'null'
      - boolean
    doc: varying number of threads
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_bench.out
