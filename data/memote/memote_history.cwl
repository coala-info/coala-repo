cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - memote
  - history
label: memote_history
doc: "Re-compute test results for the git branch history.\n\nTool homepage: https://memote.readthedocs.io/"
inputs:
  - id: model
    type: File
    doc: The path to the model file.
    inputBinding:
      position: 1
  - id: message
    type: string
    doc: A commit message in case results were modified or added.
    inputBinding:
      position: 2
  - id: commits
    type:
      - 'null'
      - type: array
        items: string
    doc: It is possible to list out individual commits that should be 
      re-computed or supply a range <oldest commit>..<newest commit>
    inputBinding:
      position: 3
  - id: deployment
    type:
      - 'null'
      - string
    doc: Results will be read from and committed to the given branch.
    default: gh-pages
    inputBinding:
      position: 104
      prefix: --deployment
  - id: exclusive_test
    type:
      - 'null'
      - type: array
        items: string
    doc: The name of a test or test module to be run exclusively. All other 
      tests are skipped. This option can be used multiple times and takes 
      precedence over '--skip'.
    inputBinding:
      position: 104
      prefix: --exclusive
  - id: location
    type:
      - 'null'
      - string
    doc: Location of test results. Can either by a directory or an rfc1738 
      compatible database URL.
    inputBinding:
      position: 104
      prefix: --location
  - id: no_rewrite
    type:
      - 'null'
      - boolean
    doc: Whether to overwrite existing results.
    inputBinding:
      position: 104
      prefix: --no-rewrite
  - id: pytest_args
    type:
      - 'null'
      - string
    doc: Any additional arguments you want to pass to pytest. Should be given as
      one continuous string.
    inputBinding:
      position: 104
      prefix: --pytest-args
  - id: rewrite
    type:
      - 'null'
      - boolean
    doc: Whether to overwrite existing results.
    inputBinding:
      position: 104
      prefix: --rewrite
  - id: skip_test
    type:
      - 'null'
      - type: array
        items: string
    doc: The name of a test or test module to be skipped. This option can be 
      used multiple times.
    inputBinding:
      position: 104
      prefix: --skip
  - id: solver
    type:
      - 'null'
      - string
    doc: Set the solver to be used.
    default: glpk
    inputBinding:
      position: 104
      prefix: --solver
  - id: solver_timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds to set on the mathematical optimization solver.
    inputBinding:
      position: 104
      prefix: --solver-timeout
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
stdout: memote_history.out
