cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - go
  - test
label: go_test
doc: "Build and test Go packages\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: build_test_flags_packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Build/test flags, packages, or build/test flags & test binary flags
    inputBinding:
      position: 1
  - id: benchmark_memory_stats
    type:
      - 'null'
      - boolean
    doc: Print memory allocation statistics for benchmarks.
    inputBinding:
      position: 102
      prefix: -benchmem
  - id: benchmark_time
    type:
      - 'null'
      - string
    doc: Run enough iterations of each benchmark to take t, specified as a 
      time.Duration (for example, -benchtime 1h30s).
    inputBinding:
      position: 102
      prefix: -benchtime
  - id: block_profile_rate
    type:
      - 'null'
      - int
    doc: Control the detail provided in goroutine blocking profiles by calling 
      runtime.SetBlockProfileRate with n.
    inputBinding:
      position: 102
      prefix: -blockprofilerate
  - id: compile_test_binary_only
    type:
      - 'null'
      - boolean
    doc: Compile the test binary to pkg.test but do not run it
    inputBinding:
      position: 102
      prefix: -c
  - id: coverage_mode
    type:
      - 'null'
      - string
    doc: Set the mode for coverage analysis for the package[s] being tested.
    default: set
    inputBinding:
      position: 102
      prefix: -covermode
  - id: coverage_packages
    type:
      - 'null'
      - string
    doc: Apply coverage analysis in each test to packages matching the patterns.
    inputBinding:
      position: 102
      prefix: -coverpkg
  - id: cpu_list
    type:
      - 'null'
      - string
    doc: Specify a list of GOMAXPROCS values for which the tests or benchmarks 
      should be executed.
    inputBinding:
      position: 102
      prefix: -cpu
  - id: enable_coverage
    type:
      - 'null'
      - boolean
    doc: Enable coverage analysis.
    inputBinding:
      position: 102
      prefix: -cover
  - id: exec_program
    type:
      - 'null'
      - string
    doc: Run the test binary using xprog. The behavior is the same as in 'go 
      run'.
    inputBinding:
      position: 102
      prefix: -exec
  - id: fail_fast
    type:
      - 'null'
      - boolean
    doc: Do not start new tests after the first test failure.
    inputBinding:
      position: 102
      prefix: -failfast
  - id: install_dependencies
    type:
      - 'null'
      - boolean
    doc: Install packages that are dependencies of the test. Do not run the 
      test.
    inputBinding:
      position: 102
      prefix: -i
  - id: list_matching
    type:
      - 'null'
      - string
    doc: List tests, benchmarks, or examples matching the regular expression.
    inputBinding:
      position: 102
      prefix: -list
  - id: memory_profile_rate
    type:
      - 'null'
      - int
    doc: Enable more precise (and expensive) memory allocation profiles by 
      setting runtime.MemProfileRate.
    inputBinding:
      position: 102
      prefix: -memprofilerate
  - id: mutex_profile_fraction
    type:
      - 'null'
      - int
    doc: Sample 1 in n stack traces of goroutines holding a contended mutex.
    inputBinding:
      position: 102
      prefix: -mutexprofilefraction
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Place output files from profiling in the specified directory, by 
      default the directory in which "go test" is running.
    inputBinding:
      position: 102
      prefix: -outputdir
  - id: output_file
    type:
      - 'null'
      - File
    doc: Compile the test binary to the named file.
    inputBinding:
      position: 102
      prefix: -o
  - id: output_json
    type:
      - 'null'
      - boolean
    doc: Convert test output to JSON suitable for automated processing.
    inputBinding:
      position: 102
      prefix: -json
  - id: parallel_tests
    type:
      - 'null'
      - int
    doc: Allow parallel execution of test functions that call t.Parallel.
    inputBinding:
      position: 102
      prefix: -parallel
  - id: pass_remainder_to_test
    type:
      - 'null'
      - boolean
    doc: Pass the remainder of the command line (everything after -args) to the 
      test binary, uninterpreted and unchanged.
    inputBinding:
      position: 102
      prefix: -args
  - id: run_benchmarks
    type:
      - 'null'
      - string
    doc: Run only those benchmarks matching a regular expression.
    inputBinding:
      position: 102
      prefix: -bench
  - id: run_count
    type:
      - 'null'
      - int
    doc: Run each test and benchmark n times (default 1).
    default: 1
    inputBinding:
      position: 102
      prefix: -count
  - id: run_tests
    type:
      - 'null'
      - string
    doc: Run only those tests and examples matching the regular expression.
    inputBinding:
      position: 102
      prefix: -run
  - id: short_run
    type:
      - 'null'
      - boolean
    doc: Tell long-running tests to shorten their run time.
    inputBinding:
      position: 102
      prefix: -short
  - id: timeout_duration
    type:
      - 'null'
      - string
    doc: If a test binary runs longer than duration d, panic.
    default: 10m
    inputBinding:
      position: 102
      prefix: -timeout
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose output: log all tests as they are run.'
    inputBinding:
      position: 102
      prefix: -v
  - id: vet_checks
    type:
      - 'null'
      - string
    doc: Configure the invocation of "go vet" during "go test" to use the 
      comma-separated list of vet checks.
    inputBinding:
      position: 102
      prefix: -vet
outputs:
  - id: block_profile_file
    type:
      - 'null'
      - File
    doc: Write a goroutine blocking profile to the specified file when all tests
      are complete.
    outputBinding:
      glob: $(inputs.block_profile_file)
  - id: coverage_profile_file
    type:
      - 'null'
      - File
    doc: Write a coverage profile to the file after all tests have passed.
    outputBinding:
      glob: $(inputs.coverage_profile_file)
  - id: cpu_profile_file
    type:
      - 'null'
      - File
    doc: Write a CPU profile to the specified file before exiting.
    outputBinding:
      glob: $(inputs.cpu_profile_file)
  - id: memory_profile_file
    type:
      - 'null'
      - File
    doc: Write an allocation profile to the file after all tests have passed.
    outputBinding:
      glob: $(inputs.memory_profile_file)
  - id: mutex_profile_file
    type:
      - 'null'
      - File
    doc: Write a mutex contention profile to the specified file when all tests 
      are complete.
    outputBinding:
      glob: $(inputs.mutex_profile_file)
  - id: trace_file
    type:
      - 'null'
      - File
    doc: Write an execution trace to the specified file before exiting.
    outputBinding:
      glob: $(inputs.trace_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
