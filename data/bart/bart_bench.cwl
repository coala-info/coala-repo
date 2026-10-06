cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, bench]
requirements:
  - class: InlineJavascriptRequirement
label: bart_bench
doc: "Performs a series of micro-benchmarks.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: output
    type:
      - 'null'
      - string
    doc: Output file
    inputBinding:
      position: 10
  - id: select_benchmarks
    type:
      - 'null'
      - int
    doc: select benchmarks
    inputBinding:
      position: 1
      prefix: -s
  - id: varying_problem_size
    type:
      - 'null'
      - boolean
    doc: varying problem size
    inputBinding:
      position: 1
      prefix: -S
  - id: varying_threads
    type:
      - 'null'
      - boolean
    doc: varying number of threads
    inputBinding:
      position: 1
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_bench.out
