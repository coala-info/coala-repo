cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-tool-test
label: ephemeris_galaxy-tool-test
doc: "Script to quickly run a tool test against a running Galaxy instance.\n\nTool
  homepage: https://github.com/galaxyproject/ephemeris"
inputs:
  - id: admin_key
    type:
      - 'null'
      - string
    doc: Galaxy Admin API Key
    inputBinding:
      position: 101
      prefix: --admin-key
  - id: append
    type:
      - 'null'
      - boolean
    doc: Extend a test record json (created with --output-json) with additional 
      tests.
    inputBinding:
      position: 101
      prefix: --append
  - id: client_test_config
    type:
      - 'null'
      - File
    doc: Test config YAML to help with client testing
    inputBinding:
      position: 101
      prefix: --client-test-config
  - id: download_attempts
    type:
      - 'null'
      - int
    doc: Galaxy may return a transient 500 status code for download if test 
      results are written but not yet accessible.
    inputBinding:
      position: 101
      prefix: --download-attempts
  - id: download_sleep
    type:
      - 'null'
      - float
    doc: If download attempts is greater than 1, the amount to sleep between 
      download attempts.
    inputBinding:
      position: 101
      prefix: --download-sleep
  - id: force_path_paste
    type:
      - 'null'
      - boolean
    doc: This requires Galaxy-side config option "allow_path_paste" enabled. 
      Allows for fetching test data locally. Only for admins.
    inputBinding:
      position: 101
      prefix: --force_path_paste
  - id: galaxy_url
    type:
      - 'null'
      - string
    doc: Galaxy URL
    inputBinding:
      position: 101
      prefix: --galaxy-url
  - id: history_name
    type:
      - 'null'
      - string
    doc: Override default history name
    inputBinding:
      position: 101
      prefix: --history-name
  - id: history_per_suite
    type:
      - 'null'
      - boolean
    doc: Create new history per test suite (all tests in same history).
    inputBinding:
      position: 101
      prefix: --history-per-suite
  - id: history_per_test_case
    type:
      - 'null'
      - boolean
    doc: Create new history per test case.
    inputBinding:
      position: 101
      prefix: --history-per-test-case
  - id: key
    type:
      - 'null'
      - string
    doc: Galaxy User API Key
    inputBinding:
      position: 101
      prefix: --key
  - id: no_history_cleanup
    type:
      - 'null'
      - boolean
    doc: Perserve histories created for testing.
    inputBinding:
      position: 101
      prefix: --no-history-cleanup
  - id: no_history_reuse
    type:
      - 'null'
      - boolean
    doc: Do not reuse histories if a matching one already exists.
    inputBinding:
      position: 101
      prefix: --no-history-reuse
  - id: output_json
    type:
      - 'null'
      - File
    doc: output metadata json
    inputBinding:
      position: 101
      prefix: --output-json
  - id: page_number
    type:
      - 'null'
      - int
    doc: If page size is used, run this 'page' of tests - starts with 0.
    inputBinding:
      position: 101
      prefix: --page-number
  - id: page_size
    type:
      - 'null'
      - int
    doc: If positive, use pagination and just run one 'page' to tool tests.
    inputBinding:
      position: 101
      prefix: --page-size
  - id: parallel_tests
    type:
      - 'null'
      - int
    doc: Parallel tests.
    inputBinding:
      position: 101
      prefix: --parallel-tests
  - id: publish_history
    type:
      - 'null'
      - boolean
    doc: Publish test history. Useful for CI testing.
    inputBinding:
      position: 101
      prefix: --publish-history
  - id: retries
    type:
      - 'null'
      - int
    doc: Retry failed tests.
    inputBinding:
      position: 101
      prefix: --retries
  - id: skip_previously_executed
    type:
      - 'null'
      - boolean
    doc: When used with --append, skip any test previously executed.
    inputBinding:
      position: 101
      prefix: --skip-previously-executed
  - id: skip_previously_successful
    type:
      - 'null'
      - boolean
    doc: When used with --append, skip any test previously executed 
      successfully.
    inputBinding:
      position: 101
      prefix: --skip-previously-successful
  - id: skip_with_reference_data
    type:
      - 'null'
      - boolean
    doc: Skip tests the Galaxy server believes use data tables or loc files.
    inputBinding:
      position: 101
      prefix: --skip-with-reference-data
  - id: suite_name
    type:
      - 'null'
      - string
    doc: Suite name for tool test output
    inputBinding:
      position: 101
      prefix: --suite-name
  - id: test_data
    type:
      - 'null'
      - Directory
    doc: Add local test data path to search for missing test data
    inputBinding:
      position: 101
      prefix: --test-data
  - id: test_index
    type:
      - 'null'
      - int
    doc: Tool Test Index (starting at 0) - by default all tests will run.
    inputBinding:
      position: 101
      prefix: --test-index
  - id: tool_id
    type:
      - 'null'
      - string
    doc: Tool ID
    inputBinding:
      position: 101
      prefix: --tool-id
  - id: tool_version
    type:
      - 'null'
      - string
    doc: Tool Version (if tool id supplied). Defaults to just latest version, 
      use * to test all versions
    inputBinding:
      position: 101
      prefix: --tool-version
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: with_reference_data
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --with-reference-data
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: directory to dump outputs to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
