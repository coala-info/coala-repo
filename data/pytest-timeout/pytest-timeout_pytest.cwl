cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-timeout_pytest
doc: "pytest is a Python testing framework that enables simple and scalable testing.
  It is used for developing and executing tests for Python applications.\n\nTool homepage:
  https://github.com/pytest-dev/pytest-timeout"
inputs:
  - id: files_or_dirs
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to test files or directories
    inputBinding:
      position: 1
  - id: assert_mode
    type:
      - 'null'
      - string
    doc: Control assertion debugging tools. 'plain' performs no assertion 
      debugging. 'rewrite' (the default) rewrites assert statements in test 
      modules on import to provide assert expression information.
    inputBinding:
      position: 102
      prefix: --assert
  - id: basetemp
    type:
      - 'null'
      - Directory
    doc: base temporary directory for this test run.
    inputBinding:
      position: 102
      prefix: --basetemp
  - id: cache_clear
    type:
      - 'null'
      - boolean
    doc: remove all cache contents at start of test run.
    inputBinding:
      position: 102
      prefix: --cache-clear
  - id: cache_show
    type:
      - 'null'
      - boolean
    doc: show cache contents, don't perform collection or tests
    inputBinding:
      position: 102
      prefix: --cache-show
  - id: capture
    type:
      - 'null'
      - string
    doc: 'per-test capturing method: one of fd|sys|no.'
    inputBinding:
      position: 102
      prefix: --capture
  - id: collect_only
    type:
      - 'null'
      - boolean
    doc: only collect tests, don't execute them.
    inputBinding:
      position: 102
      prefix: --collect-only
  - id: color
    type:
      - 'null'
      - string
    doc: color terminal output (yes/no/auto).
    inputBinding:
      position: 102
      prefix: --color
  - id: confcutdir
    type:
      - 'null'
      - Directory
    doc: only load conftest.py's relative to specified dir.
    inputBinding:
      position: 102
      prefix: --confcutdir
  - id: config_file
    type:
      - 'null'
      - File
    doc: load configuration from `file` instead of trying to locate one of the 
      implicit configuration files.
    inputBinding:
      position: 102
      prefix: --config-file
  - id: continue_on_collection_errors
    type:
      - 'null'
      - boolean
    doc: Force test execution even if collection errors occur.
    inputBinding:
      position: 102
      prefix: --continue-on-collection-errors
  - id: debug
    type:
      - 'null'
      - boolean
    doc: store internal tracing debug information in 'pytestdebug.log'.
    inputBinding:
      position: 102
      prefix: --debug
  - id: disable_pytest_warnings
    type:
      - 'null'
      - boolean
    doc: disable warnings summary, overrides -r w flag
    inputBinding:
      position: 102
      prefix: --disable-pytest-warnings
  - id: doctest_glob
    type:
      - 'null'
      - string
    doc: 'doctests file matching pattern, default: test*.txt'
    inputBinding:
      position: 102
      prefix: --doctest-glob
  - id: doctest_ignore_import_errors
    type:
      - 'null'
      - boolean
    doc: ignore doctest ImportErrors
    inputBinding:
      position: 102
      prefix: --doctest-ignore-import-errors
  - id: doctest_modules
    type:
      - 'null'
      - boolean
    doc: run doctests in all .py modules
    inputBinding:
      position: 102
      prefix: --doctest-modules
  - id: doctest_report
    type:
      - 'null'
      - string
    doc: choose another output format for diffs on doctest failure
    inputBinding:
      position: 102
      prefix: --doctest-report
  - id: durations
    type:
      - 'null'
      - int
    doc: show N slowest setup/test durations (N=0 for all).
    inputBinding:
      position: 102
      prefix: --durations
  - id: exitfirst
    type:
      - 'null'
      - boolean
    doc: exit instantly on first error or failed test.
    inputBinding:
      position: 102
      prefix: --exitfirst
  - id: expression
    type:
      - 'null'
      - string
    doc: "only run tests which match the given substring expression. An expression
      is a python evaluatable expression where all names are substring-matched against
      test names and their parent classes. Example: -k 'test_method or test other'
      matches all test functions and classes whose name contains 'test_method' or
      'test_other'. Additionally keywords are matched to classes and functions containing
      extra names in their 'extra_keyword_matches' set, as well as functions which
      have names assigned directly to them."
    inputBinding:
      position: 102
      prefix: --expression
  - id: failed_first
    type:
      - 'null'
      - boolean
    doc: run all tests but run the last failures first. This may re-order tests 
      and thus lead to repeated fixture setup/teardown
    inputBinding:
      position: 102
      prefix: --failed-first
  - id: full_trace
    type:
      - 'null'
      - boolean
    doc: don't cut any tracebacks (default is to cut).
    inputBinding:
      position: 102
      prefix: --full-trace
  - id: ignore
    type:
      - 'null'
      - type: array
        items: File
    doc: ignore path during collection (multi-allowed).
    inputBinding:
      position: 102
      prefix: --ignore
  - id: import_mode
    type:
      - 'null'
      - string
    doc: prepend/append to sys.path when importing test modules, default is to 
      prepend.
    inputBinding:
      position: 102
      prefix: --import-mode
  - id: junit_prefix
    type:
      - 'null'
      - string
    doc: prepend prefix to classnames in junit-xml output
    inputBinding:
      position: 102
      prefix: --junit-prefix
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Keep duplicate tests.
    inputBinding:
      position: 102
      prefix: --keep-duplicates
  - id: last_failed
    type:
      - 'null'
      - boolean
    doc: rerun only the tests that failed at the last run (or all if none 
      failed)
    inputBinding:
      position: 102
      prefix: --last-failed
  - id: load_plugin
    type:
      - 'null'
      - type: array
        items: string
    doc: early-load given plugin (multi-allowed). To avoid loading of plugins, 
      use the `no:` prefix, e.g. `no:doctest`.
    inputBinding:
      position: 102
      prefix: --load-plugin
  - id: markexpr
    type:
      - 'null'
      - string
    doc: "only run tests matching given mark expression. example: -m 'mark1 and not
      mark2'."
    inputBinding:
      position: 102
      prefix: --markexpr
  - id: maxfail
    type:
      - 'null'
      - int
    doc: exit after first num failures or errors.
    inputBinding:
      position: 102
      prefix: --maxfail
  - id: no_capture
    type:
      - 'null'
      - boolean
    doc: shortcut for --capture=no.
    inputBinding:
      position: 102
      prefix: -s
  - id: noconftest
    type:
      - 'null'
      - boolean
    doc: Don't load any conftest.py files.
    inputBinding:
      position: 102
      prefix: --noconftest
  - id: override_ini
    type:
      - 'null'
      - type: array
        items: string
    doc: override config option, e.g. `-o xfail_strict=True`.
    inputBinding:
      position: 102
      prefix: --override-ini
  - id: pastebin
    type:
      - 'null'
      - string
    doc: send failed|all info to bpaste.net pastebin service.
    inputBinding:
      position: 102
      prefix: --pastebin
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: start the interactive Python debugger on errors.
    inputBinding:
      position: 102
      prefix: --pdb
  - id: pdbcls
    type:
      - 'null'
      - string
    doc: 'start a custom interactive Python debugger on errors. For example: --pdbcls=IPython.terminal.debugger:TerminalPdb'
    inputBinding:
      position: 102
      prefix: --pdbcls
  - id: pyargs
    type:
      - 'null'
      - boolean
    doc: try to interpret all arguments as python packages.
    inputBinding:
      position: 102
      prefix: --pyargs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: decrease verbosity.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: report_chars
    type:
      - 'null'
      - string
    doc: show extra test summary info as specified by chars (f)ailed, (E)error, 
      (s)skipped, (x)failed, (X)passed, (p)passed, (P)passed with output, (a)all
      except pP. The pytest warnings are displayed at all times except when 
      --disable-pytest-warnings is set
    inputBinding:
      position: 102
      prefix: --report-chars
  - id: runxfail
    type:
      - 'null'
      - boolean
    doc: run tests even if they are marked xfail
    inputBinding:
      position: 102
      prefix: --runxfail
  - id: setup_only
    type:
      - 'null'
      - boolean
    doc: only setup fixtures, don't execute the tests.
    inputBinding:
      position: 102
      prefix: --setup-only
  - id: setup_plan
    type:
      - 'null'
      - boolean
    doc: show what fixtures and tests would be executed but don't execute 
      anything.
    inputBinding:
      position: 102
      prefix: --setup-plan
  - id: setup_show
    type:
      - 'null'
      - boolean
    doc: show setup fixtures while executing the tests.
    inputBinding:
      position: 102
      prefix: --setup-show
  - id: show_fixtures
    type:
      - 'null'
      - boolean
    doc: show available fixtures, sorted by plugin appearance
    inputBinding:
      position: 102
      prefix: --fixtures
  - id: show_fixtures_per_test
    type:
      - 'null'
      - boolean
    doc: show fixtures per test
    inputBinding:
      position: 102
      prefix: --fixtures-per-test
  - id: show_funcargs
    type:
      - 'null'
      - boolean
    doc: show available fixtures, sorted by plugin appearance
    inputBinding:
      position: 102
      prefix: --funcargs
  - id: show_markers
    type:
      - 'null'
      - boolean
    doc: show markers (builtin, plugin and per-project ones).
    inputBinding:
      position: 102
      prefix: --markers
  - id: showlocals
    type:
      - 'null'
      - boolean
    doc: show locals in tracebacks (disabled by default).
    inputBinding:
      position: 102
      prefix: --showlocals
  - id: strict
    type:
      - 'null'
      - boolean
    doc: run pytest in strict mode, warnings become errors.
    inputBinding:
      position: 102
      prefix: --strict
  - id: tb_style
    type:
      - 'null'
      - string
    doc: traceback print mode (auto/long/short/line/native/no).
    inputBinding:
      position: 102
      prefix: --tb
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds before dumping the stacks. Default is 0 which means 
      no timeout.
    inputBinding:
      position: 102
      prefix: --timeout
  - id: timeout_method
    type:
      - 'null'
      - string
    doc: Timeout mechanism to use. 'signal' uses SIGALRM if available, 'thread' 
      uses a timer thread. The default is to use 'signal' and fall back to 
      'thread'.
    inputBinding:
      position: 102
      prefix: --timeout-method
  - id: timeout_method_deprecated
    type:
      - 'null'
      - string
    doc: Depreacted, use --timeout-method
    inputBinding:
      position: 102
      prefix: --timeout_method
  - id: trace_config
    type:
      - 'null'
      - boolean
    doc: trace considerations of conftest.py files.
    inputBinding:
      position: 102
      prefix: --trace-config
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: junit_xml
    type:
      - 'null'
      - File
    doc: create junit-xml style report file at given path.
    outputBinding:
      glob: $(inputs.junit_xml)
  - id: result_log
    type:
      - 'null'
      - File
    doc: DEPRECATED path for machine-readable result log.
    outputBinding:
      glob: $(inputs.result_log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-timeout:1.0.0--py35_0
