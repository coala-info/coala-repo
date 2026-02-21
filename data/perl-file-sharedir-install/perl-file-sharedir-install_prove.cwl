cwlVersion: v1.2
class: CommandLineTool
baseCommand: prove
label: perl-file-sharedir-install_prove
doc: "Run tests through a TAP harness.\n\nTool homepage: https://github.com/Perl-Toolchain-Gang/File-ShareDir-Install"
inputs:
  - id: files_or_directories
    type:
      - 'null'
      - type: array
        items: string
    doc: Files or directories to run tests from
    inputBinding:
      position: 1
  - id: QUIET_summary
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
  - id: extension
    type:
      - 'null'
      - string
    doc: Set the extension for tests (default '.t')
    default: .t
    inputBinding:
      position: 102
      prefix: --ext
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
  - id: include_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Library paths to include.
    inputBinding:
      position: 102
      prefix: -I
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
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge test scripts' STDERR with their STDOUT.
    inputBinding:
      position: 102
      prefix: --merge
  - id: module
    type:
      - 'null'
      - type: array
        items: string
    doc: Load a module.
    inputBinding:
      position: 102
      prefix: -M
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
  - id: norc
    type:
      - 'null'
      - boolean
    doc: Don't process default .proverc
    inputBinding:
      position: 102
      prefix: --norc
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
  - id: plugin
    type:
      - 'null'
      - type: array
        items: string
    doc: Load plugin (searches App::Prove::Plugin::*.)
    inputBinding:
      position: 102
      prefix: -P
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress some test output while running tests.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rc
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
  - id: statefile
    type:
      - 'null'
      - File
    doc: Use `file` instead of `.prove` for state
    inputBinding:
      position: 102
      prefix: --statefile
  - id: taint_checks
    type:
      - 'null'
      - boolean
    doc: Enable tainting checks.
    inputBinding:
      position: 102
      prefix: -T
  - id: taint_warnings
    type:
      - 'null'
      - boolean
    doc: Enable tainting warnings.
    inputBinding:
      position: 102
      prefix: -t
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
  - id: archive
    type:
      - 'null'
      - File
    doc: Store the resulting TAP in an archive file.
    outputBinding:
      glob: $(inputs.archive)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-sharedir-install:0.14--pl5321hdfd78af_0
