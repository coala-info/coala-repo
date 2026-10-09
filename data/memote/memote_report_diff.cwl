cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - memote
  - report
  - diff
label: memote_report_diff
doc: "Take a snapshot of all the supplied models and generate a diff report.\n\nTool homepage: https://memote.readthedocs.io/"
inputs:
  - id: models
    type:
      type: array
      items: File
    doc: List of paths to two or more model files.
    inputBinding:
      position: 1
  - id: exclusive_test
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclusive
          separate: true
    doc: The name of a test or test module to be run exclusively. All other 
      tests are skipped. This option can be used multiple times and takes 
      precedence over '--skip'.
    inputBinding:
      position: 102
  - id: skip_test
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --skip
          separate: true
    doc: The name of a test or test module to be skipped. This option can be 
      used multiple times.
    inputBinding:
      position: 102
  - id: pytest_args
    type:
      - 'null'
      - string
    doc: Any additional arguments you want to pass to pytest. Should be given as
      one continuous string.
    inputBinding:
      position: 102
      prefix: --pytest-args
  - id: solver
    type:
      - 'null'
      - string
    doc: Set the solver to be used (glpk, cplex, gurobi, glpk_exact or hybrid).
    inputBinding:
      position: 102
      prefix: --solver
  - id: solver_timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds to set on the mathematical optimization solver.
    inputBinding:
      position: 102
      prefix: --solver-timeout
  - id: experimental
    type:
      - 'null'
      - File
    doc: Define additional tests using experimental data.
    inputBinding:
      position: 102
      prefix: --experimental
  - id: custom_tests
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: --custom-tests
          separate: true
    doc: A path to a directory containing custom test modules. This option can 
      be specified multiple times.
    inputBinding:
      position: 102
  - id: custom_config
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --custom-config
          separate: true
    doc: A path to a report configuration file that will be merged into the 
      default configuration. This option can be specified multiple times.
    inputBinding:
      position: 102
  - id: filename_path
    type: string
    doc: Path for the HTML report output.
    inputBinding:
      position: 103
      prefix: --filename
outputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: The HTML report.
    outputBinding:
      glob: $(inputs.filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
