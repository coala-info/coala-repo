cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwltest
label: cwltest
doc: "Common Workflow Language testing framework\n\nTool homepage: https://github.com/common-workflow-language/cwltest"
inputs:
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: arguments to pass first to tool runner
    inputBinding:
      position: 1
  - id: badgedir
    type:
      - 'null'
      - Directory
    doc: Directory that stores JSON files for badges.
    inputBinding:
      position: 102
      prefix: --badgedir
  - id: basedir
    type:
      - 'null'
      - Directory
    doc: Basedir to use for tests
    inputBinding:
      position: 102
      prefix: --basedir
  - id: classname
    type:
      - 'null'
      - string
    doc: Specify classname for the Test Suite.
    inputBinding:
      position: 102
      prefix: --classname
  - id: exclude_tests_by_number
    type:
      - 'null'
      - string
    doc: Exclude specific tests by number, format is 1,3-6,9
    inputBinding:
      position: 102
      prefix: -N
  - id: exclude_tests_by_short_name
    type:
      - 'null'
      - string
    doc: Exclude specific tests by short names separated by comma
    inputBinding:
      position: 102
      prefix: -S
  - id: junit_verbose
    type:
      - 'null'
      - boolean
    doc: Store more verbose output to JUnit xml file
    inputBinding:
      position: 102
      prefix: --junit-verbose
  - id: list_tests
    type:
      - 'null'
      - boolean
    doc: List tests then exit
    inputBinding:
      position: 102
      prefix: -l
  - id: only_tools
    type:
      - 'null'
      - boolean
    doc: Only test CommandLineTools
    inputBinding:
      position: 102
      prefix: --only-tools
  - id: parallel_tests
    type:
      - 'null'
      - int
    doc: Specifies the number of tests to run simultaneously (defaults to one).
    inputBinding:
      position: 102
      prefix: -j
  - id: run_specific_tests_by_number
    type:
      - 'null'
      - string
    doc: Run specific tests, format is 1,3-6,9
    inputBinding:
      position: 102
      prefix: -n
  - id: run_specific_tests_by_short_name
    type:
      - 'null'
      - string
    doc: Run specific tests using their short names separated by comma
    inputBinding:
      position: 102
      prefix: -s
  - id: show_tags
    type:
      - 'null'
      - boolean
    doc: Show all Tags.
    inputBinding:
      position: 102
      prefix: --show-tags
  - id: tags
    type:
      - 'null'
      - string
    doc: Tags to be tested
    inputBinding:
      position: 102
      prefix: --tags
  - id: test
    type: File
    doc: YAML file describing test cases
    inputBinding:
      position: 102
      prefix: --test
  - id: test_arg_cache_equals_cache_dir
    type:
      - 'null'
      - string
    doc: Additional argument given in test cases and required prefix for tool 
      runner.
    inputBinding:
      position: 102
      prefix: --test-arg
  - id: timeout
    type:
      - 'null'
      - int
    doc: Time of execution in seconds after which the test will be skipped. 
      Defaults to 600 seconds (10.0 minutes).
    inputBinding:
      position: 102
      prefix: --timeout
  - id: tool
    type:
      - 'null'
      - string
    doc: CWL runner executable to use (default 'cwl-runner'
    inputBinding:
      position: 102
      prefix: --tool
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More verbose output during test run.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: junit_xml
    type:
      - 'null'
      - File
    doc: Path to JUnit xml file
    outputBinding:
      glob: $(inputs.junit_xml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwltest:2.2.20220521103021--pyhdfd78af_0
