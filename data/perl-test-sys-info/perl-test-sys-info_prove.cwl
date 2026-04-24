cwlVersion: v1.2
class: CommandLineTool
baseCommand: prove
label: perl-test-sys-info_prove
doc: "Run tests using the prove test runner.\n\nTool homepage: http://metacpan.org/pod/Test::Sys::Info"
inputs:
  - id: files_or_directories
    type:
      - 'null'
      - type: array
        items: string
    doc: Files or directories to test
    inputBinding:
      position: 1
  - id: QUIET
    type:
      - 'null'
      - boolean
    doc: Only print summary results.
    inputBinding:
      position: 102
      prefix: --QUIET
  - id: blib
    type:
      - 'null'
      - boolean
    doc: Add 'blib/lib' and 'blib/arch' to the path for your tests
    inputBinding:
      position: 102
      prefix: --blib
  - id: color
    type:
      - 'null'
      - boolean
    doc: Colored test output (default).
    inputBinding:
      position: 102
      prefix: --color
  - id: comments
    type:
      - 'null'
      - boolean
    doc: Show comments.
    inputBinding:
      position: 102
      prefix: --comments
  - id: count
    type:
      - 'null'
      - boolean
    doc: Show the X/Y test count when not verbose (default)
    inputBinding:
      position: 102
      prefix: --count
  - id: directives
    type:
      - 'null'
      - boolean
    doc: Only show results with TODO or SKIP directives.
    inputBinding:
      position: 102
      prefix: --directives
  - id: dry
    type:
      - 'null'
      - boolean
    doc: Dry run. Show test that would have run.
    inputBinding:
      position: 102
      prefix: --dry
  - id: exec
    type:
      - 'null'
      - string
    doc: Interpreter to run the tests ('' for compiled tests.)
    inputBinding:
      position: 102
      prefix: --exec
  - id: failures
    type:
      - 'null'
      - boolean
    doc: Show failed tests.
    inputBinding:
      position: 102
      prefix: --failures
  - id: fatal_warnings
    type:
      - 'null'
      - boolean
    doc: Enable fatal warnings.
    inputBinding:
      position: 102
      prefix: -W
  - id: formatter
    type:
      - 'null'
      - string
    doc: Result formatter to use. See FORMATTERS.
    inputBinding:
      position: 102
      prefix: --formatter
  - id: harness
    type:
      - 'null'
      - string
    doc: Define test harness to use. See TAP::Harness.
    inputBinding:
      position: 102
      prefix: --harness
  - id: ignore_exit
    type:
      - 'null'
      - boolean
    doc: Ignore exit status from test scripts.
    inputBinding:
      position: 102
      prefix: --ignore-exit
  - id: jobs
    type:
      - 'null'
      - int
    doc: Run N test jobs in parallel (try 9.)
    inputBinding:
      position: 102
      prefix: --jobs
  - id: lib
    type:
      - 'null'
      - boolean
    doc: Add 'lib' to the path for your tests (-Ilib).
    inputBinding:
      position: 102
      prefix: --lib
  - id: library_paths
    type:
      - 'null'
      - type: array
        items: string
    doc: Library paths to include.
    inputBinding:
      position: 102
      prefix: -I
  - id: load_module
    type:
      - 'null'
      - string
    doc: Load a module.
    inputBinding:
      position: 102
      prefix: -M
  - id: load_plugin
    type:
      - 'null'
      - string
    doc: Load plugin (searches App::Prove::Plugin::*.)
    inputBinding:
      position: 102
      prefix: -P
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge test scripts' STDERR with their STDOUT.
    inputBinding:
      position: 102
      prefix: --merge
  - id: nocolor
    type:
      - 'null'
      - boolean
    doc: Do not color test output.
    inputBinding:
      position: 102
      prefix: --nocolor
  - id: nocount
    type:
      - 'null'
      - boolean
    doc: Disable the X/Y test count.
    inputBinding:
      position: 102
      prefix: --nocount
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize TAP output in verbose output
    inputBinding:
      position: 102
      prefix: --normalize
  - id: parse
    type:
      - 'null'
      - boolean
    doc: Show full list of TAP parse errors, if any.
    inputBinding:
      position: 102
      prefix: --parse
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress some test output while running tests.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rcfile
    type:
      - 'null'
      - File
    doc: Process options from rcfile
    inputBinding:
      position: 102
      prefix: --rc
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recursively descend into directories.
    inputBinding:
      position: 102
      prefix: --recurse
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Run the tests in reverse order.
    inputBinding:
      position: 102
      prefix: --reverse
  - id: rules
    type:
      - 'null'
      - string
    doc: Rules for parallel vs sequential processing.
    inputBinding:
      position: 102
      prefix: --rules
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Run the tests in random order.
    inputBinding:
      position: 102
      prefix: --shuffle
  - id: source
    type:
      - 'null'
      - string
    doc: Load and/or configure a SourceHandler. See SOURCE HANDLERS.
    inputBinding:
      position: 102
      prefix: --source
  - id: state
    type:
      - 'null'
      - string
    doc: Control prove's persistent state.
    inputBinding:
      position: 102
      prefix: --state
  - id: tainting_checks
    type:
      - 'null'
      - boolean
    doc: Enable tainting checks.
    inputBinding:
      position: 102
      prefix: -T
  - id: tainting_warnings
    type:
      - 'null'
      - boolean
    doc: Enable tainting warnings.
    inputBinding:
      position: 102
      prefix: -t
  - id: test_extension
    type:
      - 'null'
      - string
    doc: Set the extension for tests (default '.t')
    inputBinding:
      position: 102
      prefix: --ext
  - id: timer
    type:
      - 'null'
      - boolean
    doc: Print elapsed time after each test.
    inputBinding:
      position: 102
      prefix: --timer
  - id: trap
    type:
      - 'null'
      - boolean
    doc: Trap Ctrl-C and print summary on interrupt.
    inputBinding:
      position: 102
      prefix: --trap
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print all test lines.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: Enable warnings.
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: archive_output
    type:
      - 'null'
      - File
    doc: Store the resulting TAP in an archive file.
    outputBinding:
      glob: $(inputs.archive_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-sys-info:0.23--pl526_0
