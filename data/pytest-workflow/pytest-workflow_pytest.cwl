cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-workflow_pytest
doc: "pytest: a plugin for pytest to manage workflows. Runs the workflow tests that are described in pytest-workflow YAML files.\n\nTool homepage: https://github.com/LUMC/pytest-workflow"
inputs:
  - id: test_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Workflow test files (test*.yml) or Python test files to run
    inputBinding:
      position: 1
  - id: basetemp
    type:
      - 'null'
      - string
    doc: Base temporary directory for this test run (warning - this directory is removed if it exists). Must not be inside pytest's rootdir.
    inputBinding:
      position: 101
      prefix: --basetemp
  - id: keep_workflow_wd
    type:
      - 'null'
      - boolean
    doc: Keep temporary directories where workflows are run for debugging purposes. This also triggers saving of stdout and stderr in the workflow directory.
    inputBinding:
      position: 102
      prefix: --keep-workflow-wd
  - id: keep_workflow_wd_on_fail
    type:
      - 'null'
      - boolean
    doc: 'Similar to --keep-workflow-wd, but only keeps the temporary directories if there are test failures.'
    inputBinding:
      position: 102
      prefix: --keep-workflow-wd-on-fail
  - id: workflow_threads
    type:
      - 'null'
      - int
    doc: The number of workflows to run simultaneously.
    inputBinding:
      position: 102
      prefix: --workflow-threads
  - id: workflow_tags
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tag
    doc: Run only workflows with this tag (repeat for several tags).
    inputBinding:
      position: 102
  - id: expression
    type:
      - 'null'
      - string
    doc: Only run tests which match the given substring expression.
    inputBinding:
      position: 102
      prefix: -k
  - id: markexpr
    type:
      - 'null'
      - string
    doc: 'Only run tests matching given mark expression, e.g. ''mark1 and not mark2''.'
    inputBinding:
      position: 102
      prefix: -m
  - id: exitfirst
    type:
      - 'null'
      - boolean
    doc: Exit instantly on first error or failed test.
    inputBinding:
      position: 102
      prefix: --exitfirst
  - id: maxfail
    type:
      - 'null'
      - int
    doc: Exit after first num failures or errors.
    inputBinding:
      position: 102
      prefix: --maxfail
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Marks not registered in configuration file raise errors.
    inputBinding:
      position: 102
      prefix: --strict
  - id: config_file
    type:
      - 'null'
      - File
    doc: Load configuration from file instead of trying to locate one of the implicit configuration files.
    inputBinding:
      position: 102
      prefix: -c
  - id: continue_on_collection_errors
    type:
      - 'null'
      - boolean
    doc: Force test execution even if collection errors occur.
    inputBinding:
      position: 102
      prefix: --continue-on-collection-errors
  - id: rootdir
    type:
      - 'null'
      - string
    doc: Define root directory for tests.
    inputBinding:
      position: 102
      prefix: --rootdir
  - id: import_mode
    type:
      - 'null'
      - string
    doc: 'prepend/append to sys.path when importing test modules, default is to prepend (prepend or append).'
    inputBinding:
      position: 102
      prefix: --import-mode
  - id: capture
    type:
      - 'null'
      - string
    doc: 'Per-test capturing method: one of fd|sys|no.'
    inputBinding:
      position: 102
      prefix: --capture
  - id: no_capture
    type:
      - 'null'
      - boolean
    doc: Shortcut for --capture=no.
    inputBinding:
      position: 102
      prefix: -s
  - id: runxfail
    type:
      - 'null'
      - boolean
    doc: Run tests even if they are marked xfail.
    inputBinding:
      position: 102
      prefix: --runxfail
  - id: last_failed
    type:
      - 'null'
      - boolean
    doc: Rerun only the tests that failed at the last run (or all if none failed).
    inputBinding:
      position: 102
      prefix: --last-failed
  - id: failed_first
    type:
      - 'null'
      - boolean
    doc: Run all tests but run the last failures first.
    inputBinding:
      position: 102
      prefix: --failed-first
  - id: new_first
    type:
      - 'null'
      - boolean
    doc: 'Run tests from new files first, then the rest of the tests sorted by file mtime.'
    inputBinding:
      position: 102
      prefix: --new-first
  - id: cache_clear
    type:
      - 'null'
      - boolean
    doc: Remove all cache contents at start of test run.
    inputBinding:
      position: 102
      prefix: --cache-clear
  - id: last_failed_no_failures
    type:
      - 'null'
      - string
    doc: Change the behavior when no test failed in the last run or no information about the last failures was found in the cache (all or none).
    inputBinding:
      position: 102
      prefix: --last-failed-no-failures
  - id: stepwise
    type:
      - 'null'
      - boolean
    doc: Exit on test failure and continue from last failing test next time.
    inputBinding:
      position: 102
      prefix: --stepwise
  - id: stepwise_skip
    type:
      - 'null'
      - boolean
    doc: Ignore the first failing test but stop on the next failing test.
    inputBinding:
      position: 102
      prefix: --stepwise-skip
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity.
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: report_chars
    type:
      - 'null'
      - string
    doc: 'Show extra test summary info as specified by chars: (f)ailed, (E)error, (s)skipped, (x)failed, (X)passed, (p)passed, (P)passed with output, (a)all except pP.'
    inputBinding:
      position: 102
      prefix: -r
  - id: disable_warnings
    type:
      - 'null'
      - boolean
    doc: Disable warnings summary.
    inputBinding:
      position: 102
      prefix: --disable-warnings
  - id: showlocals
    type:
      - 'null'
      - boolean
    doc: Show locals in tracebacks (disabled by default).
    inputBinding:
      position: 102
      prefix: --showlocals
  - id: tb_style
    type:
      - 'null'
      - string
    doc: Traceback print mode (auto/long/short/line/native/no).
    inputBinding:
      position: 102
      prefix: --tb
  - id: show_capture
    type:
      - 'null'
      - string
    doc: 'Controls how captured stdout/stderr/log is shown on failed tests: no, stdout, stderr, log or all (default).'
    inputBinding:
      position: 102
      prefix: --show-capture
  - id: full_trace
    type:
      - 'null'
      - boolean
    doc: Do not cut any tracebacks (default is to cut).
    inputBinding:
      position: 102
      prefix: --full-trace
  - id: color
    type:
      - 'null'
      - string
    doc: Color terminal output (yes/no/auto).
    inputBinding:
      position: 102
      prefix: --color
  - id: durations
    type:
      - 'null'
      - int
    doc: Show N slowest setup/test durations (N=0 for all).
    inputBinding:
      position: 102
      prefix: --durations
  - id: junit_prefix
    type:
      - 'null'
      - string
    doc: Prepend prefix to classnames in junit-xml output.
    inputBinding:
      position: 102
      prefix: --junit-prefix
  - id: collect_only
    type:
      - 'null'
      - boolean
    doc: 'Only collect tests, do not execute them.'
    inputBinding:
      position: 102
      prefix: --collect-only
  - id: ignore
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --ignore
    doc: Ignore path during collection (multi-allowed).
    inputBinding:
      position: 102
  - id: ignore_glob
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ignore-glob
    doc: Ignore path pattern during collection (multi-allowed).
    inputBinding:
      position: 102
  - id: deselect
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --deselect
    doc: Deselect item during collection (multi-allowed).
    inputBinding:
      position: 102
  - id: confcutdir
    type:
      - 'null'
      - string
    doc: 'Only load conftest.py''s relative to specified dir.'
    inputBinding:
      position: 102
      prefix: --confcutdir
  - id: noconftest
    type:
      - 'null'
      - boolean
    doc: Do not load any conftest.py files.
    inputBinding:
      position: 102
      prefix: --noconftest
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Keep duplicate tests.
    inputBinding:
      position: 102
      prefix: --keep-duplicates
  - id: collect_in_virtualenv
    type:
      - 'null'
      - boolean
    doc: Do not ignore tests in a local virtualenv directory.
    inputBinding:
      position: 102
      prefix: --collect-in-virtualenv
  - id: doctest_modules
    type:
      - 'null'
      - boolean
    doc: Run doctests in all .py modules.
    inputBinding:
      position: 102
      prefix: --doctest-modules
  - id: doctest_report
    type:
      - 'null'
      - string
    doc: 'Choose another output format for diffs on doctest failure (none, cdiff, ndiff, udiff, only_first_failure).'
    inputBinding:
      position: 102
      prefix: --doctest-report
  - id: doctest_glob
    type:
      - 'null'
      - string
    doc: 'Doctests file matching pattern, default: test*.txt.'
    inputBinding:
      position: 102
      prefix: --doctest-glob
  - id: doctest_ignore_import_errors
    type:
      - 'null'
      - boolean
    doc: Ignore doctest ImportErrors.
    inputBinding:
      position: 102
      prefix: --doctest-ignore-import-errors
  - id: doctest_continue_on_failure
    type:
      - 'null'
      - boolean
    doc: 'For a given doctest, continue to run after the first failure.'
    inputBinding:
      position: 102
      prefix: --doctest-continue-on-failure
  - id: plugin
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -p
    doc: 'Early-load given plugin module name or entry point (multi-allowed); use the no: prefix to avoid loading a plugin.'
    inputBinding:
      position: 102
  - id: override_ini
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -o
    doc: Override ini option with option=value style (multi-allowed).
    inputBinding:
      position: 102
  - id: assert_mode
    type:
      - 'null'
      - string
    doc: 'Control assertion debugging tools: plain or rewrite (default).'
    inputBinding:
      position: 102
      prefix: --assert
  - id: pythonwarnings
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -W
    doc: 'Set which warnings to report, see -W option of python itself.'
    inputBinding:
      position: 102
  - id: no_print_logs
    type:
      - 'null'
      - boolean
    doc: Disable printing caught logs on failed tests.
    inputBinding:
      position: 102
      prefix: --no-print-logs
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: log_format
    type:
      - 'null'
      - string
    doc: Log format as used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-format
  - id: log_date_format
    type:
      - 'null'
      - string
    doc: Log date format as used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-date-format
  - id: log_cli_level
    type:
      - 'null'
      - string
    doc: CLI logging level.
    inputBinding:
      position: 102
      prefix: --log-cli-level
  - id: log_cli_format
    type:
      - 'null'
      - string
    doc: Log format as used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-cli-format
  - id: log_cli_date_format
    type:
      - 'null'
      - string
    doc: Log date format as used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-cli-date-format
  - id: log_file_level
    type:
      - 'null'
      - string
    doc: Log file logging level.
    inputBinding:
      position: 102
      prefix: --log-file-level
  - id: log_file_format
    type:
      - 'null'
      - string
    doc: Log format as used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-file-format
  - id: log_file_date_format
    type:
      - 'null'
      - string
    doc: Log date format as used by the logging module.
    inputBinding:
      position: 102
      prefix: --log-file-date-format
  - id: junit_xml_path
    type:
      - 'null'
      - string
    doc: Create junit-xml style report file at given path.
    inputBinding:
      position: 103
      prefix: --junit-xml
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: Path to a file when logging will be written to.
    inputBinding:
      position: 103
      prefix: --log-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: junit_xml
    type:
      - 'null'
      - File
    doc: Create junit-xml style report file at given path.
    outputBinding:
      glob: $(inputs.junit_xml_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to a file when logging will be written to.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-workflow:1.2.0--py_0
stdout: pytest-workflow_pytest.out
