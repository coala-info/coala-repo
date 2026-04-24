cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - memote
  - run
label: memote_run
doc: "Run the test suite on a single model and collect results.\n\nTool homepage:
  https://memote.readthedocs.io/"
inputs:
  - id: model
    type: File
    doc: Path to model file. Can also be supplied via the environment variable 
      MEMOTE_MODEL or configured in 'setup.cfg' or 'memote.ini'.
    inputBinding:
      position: 1
  - id: collect
    type:
      - 'null'
      - boolean
    doc: Whether or not to collect test data needed for generating a report.
    inputBinding:
      position: 102
      prefix: --collect
  - id: custom_tests
    type:
      - 'null'
      - type: array
        items: Directory
    doc: A path to a directory containing custom test modules. Please refer to 
      the documentation for more information on how to write custom tests 
      (memote.readthedocs.io). This option can be specified multiple times.
    inputBinding:
      position: 102
      prefix: --custom-tests
  - id: deployment
    type:
      - 'null'
      - string
    doc: Results will be read from and committed to the given branch.
    inputBinding:
      position: 102
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
      position: 102
      prefix: --exclusive
  - id: experimental
    type:
      - 'null'
      - File
    doc: Define additional tests using experimental data.
    inputBinding:
      position: 102
      prefix: --experimental
  - id: ignore_git
    type:
      - 'null'
      - boolean
    doc: Avoid checking the git repository status.
    inputBinding:
      position: 102
      prefix: --ignore-git
  - id: location
    type:
      - 'null'
      - string
    doc: If invoked inside a git repository, try to interpret the string as an 
      rfc1738 compatible database URL which will be used to store the test 
      results. Otherwise write to this directory using the commit hash as the 
      filename.
    inputBinding:
      position: 102
      prefix: --location
  - id: no_collect
    type:
      - 'null'
      - boolean
    doc: Whether or not to collect test data needed for generating a report.
    inputBinding:
      position: 102
      prefix: --no-collect
  - id: pytest_args
    type:
      - 'null'
      - string
    doc: Any additional arguments you want to pass to pytest. Should be given as
      one continuous string in quotes.
    inputBinding:
      position: 102
      prefix: --pytest-args
  - id: skip_test
    type:
      - 'null'
      - type: array
        items: string
    doc: The name of a test or test module to be skipped. This option can be 
      used multiple times.
    inputBinding:
      position: 102
      prefix: --skip
  - id: skip_unchanged
    type:
      - 'null'
      - boolean
    doc: Skip memote run on commits where the model was not changed.
    inputBinding:
      position: 102
      prefix: --skip-unchanged
  - id: solver
    type:
      - 'null'
      - string
    doc: Set the solver to be used.
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
outputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: Path for the collected results as JSON. Ignored when working with a git
      repository.
    outputBinding:
      glob: $(inputs.filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
