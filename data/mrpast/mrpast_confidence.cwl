cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast confidence
label: mrpast_confidence
doc: "Solve for all bootstrapped samples instead of using GIM (theoretical).\n\nTool
  homepage: https://aprilweilab.github.io/"
inputs:
  - id: solved_result
    type: File
    doc: A JSON file output by the solver.
    inputBinding:
      position: 1
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Solve for all bootstrapped samples instead of using GIM (theoretical).
    inputBinding:
      position: 102
      prefix: --bootstrap
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use. Defaults to 1.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of solver replications to perform per bootstrap sample. Defaults
      to 10 * num_epochs.
    inputBinding:
      position: 102
      prefix: --replicates
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed.
    inputBinding:
      position: 102
      prefix: --seed
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
stdout: mrpast_confidence.out
