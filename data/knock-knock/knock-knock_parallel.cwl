cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock parallel
label: knock-knock_parallel
doc: "Run knock-knock in parallel across multiple samples.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: base_dir
    type: Directory
    doc: the base directory to store input data, reference annotations, and 
      analysis output for a project
    inputBinding:
      position: 1
  - id: max_procs
    type: int
    doc: maximum number of samples to process at once
    inputBinding:
      position: 2
  - id: batch
    type:
      - 'null'
      - string
    doc: if specified, the single batch name to process; if not specified, all 
      batches will be processed
    inputBinding:
      position: 103
      prefix: --batch
  - id: conditions
    type:
      - 'null'
      - string
    doc: if specified, conditions that samples must satisfy to be processed, 
      given as yaml; if not specified, all samples will be processed
    inputBinding:
      position: 103
      prefix: --conditions
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress bars
    inputBinding:
      position: 103
      prefix: --progress
  - id: stages
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --stages
  - id: use_logger_thread
    type:
      - 'null'
      - boolean
    doc: write a consolidated log
    inputBinding:
      position: 103
      prefix: --use_logger_thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_parallel.out
