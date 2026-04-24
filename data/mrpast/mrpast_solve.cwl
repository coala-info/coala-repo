cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast_solve
label: mrpast_solve
doc: "The solver input JSON files. The output filenames will be derived from the input
  filenames.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: solver_inputs
    type:
      type: array
      items: File
    doc: The solver input JSON files. The output filenames will be derived from 
      the input filenames.
    inputBinding:
      position: 1
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use. Defaults to 1.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed.
    inputBinding:
      position: 102
      prefix: --seed
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds. Solver returns the current best result upon 
      timeout.
    inputBinding:
      position: 102
      prefix: --timeout
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output, including timing information.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_solve.out
