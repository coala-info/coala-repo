cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - krepp
  - inspect
label: krepp_inspect
doc: "Display statistics and information for a given index.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: index_dir
    type: Directory
    doc: "Directory containing the reference index"
    inputBinding:
      position: 101
      prefix: --index-dir
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use in OpenMP-based parallelism [1]"
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed for the LSH and other parts that require randomness [0]"
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: "Disable increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --no-verbose
outputs:
  - id: stdout_out
    type: stdout
    doc: "Index statistics"
stdout: krepp_inspect.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
