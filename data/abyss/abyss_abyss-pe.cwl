cwlVersion: v1.2
class: CommandLineTool
baseCommand: make
label: abyss_abyss-pe
doc: "A tool to control the generation of executables and other non-source files of
  a program from the program's source files.\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs:
  - id: target
    type:
      - 'null'
      - type: array
        items: string
    doc: Targets to make
    inputBinding:
      position: 1
  - id: always_make
    type:
      - 'null'
      - boolean
    doc: Unconditionally make all targets.
    inputBinding:
      position: 102
      prefix: --always-make
  - id: check_symlink_times
    type:
      - 'null'
      - boolean
    doc: Use the latest mtime between symlinks and target.
    inputBinding:
      position: 102
      prefix: --check-symlink-times
  - id: debug_flags
    type:
      - 'null'
      - string
    doc: Print various types of debugging information.
    inputBinding:
      position: 102
      prefix: --debug
  - id: debug_info
    type:
      - 'null'
      - boolean
    doc: Print lots of debugging information.
    inputBinding:
      position: 102
      prefix: -d
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Change to DIRECTORY before doing anything.
    inputBinding:
      position: 102
      prefix: --directory
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't actually run any recipe; just print them.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: environment_overrides
    type:
      - 'null'
      - boolean
    doc: Environment variables override makefiles.
    inputBinding:
      position: 102
      prefix: --environment-overrides
  - id: eval
    type:
      - 'null'
      - string
    doc: Evaluate STRING as a makefile statement.
    inputBinding:
      position: 102
      prefix: --eval
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: Ignore errors from recipes.
    inputBinding:
      position: 102
      prefix: --ignore-errors
  - id: ignored_compatibility
    type:
      - 'null'
      - boolean
    doc: Ignored for compatibility.
    inputBinding:
      position: 102
      prefix: -b
  - id: include_dir
    type:
      - 'null'
      - Directory
    doc: Search DIRECTORY for included makefiles.
    inputBinding:
      position: 102
      prefix: --include-dir
  - id: jobs
    type:
      - 'null'
      - int
    doc: Allow N jobs at once; infinite jobs with no arg.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: jobserver_style
    type:
      - 'null'
      - string
    doc: Select the style of jobserver to use.
    inputBinding:
      position: 102
      prefix: --jobserver-style
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: Keep going when some targets can't be made.
    inputBinding:
      position: 102
      prefix: --keep-going
  - id: load_average
    type:
      - 'null'
      - float
    doc: Don't start multiple jobs unless load is below N.
    inputBinding:
      position: 102
      prefix: --load-average
  - id: makefile
    type:
      - 'null'
      - File
    doc: Read FILE as a makefile.
    inputBinding:
      position: 102
      prefix: --file
  - id: no_builtin_rules
    type:
      - 'null'
      - boolean
    doc: Disable the built-in implicit rules.
    inputBinding:
      position: 102
      prefix: --no-builtin-rules
  - id: no_builtin_variables
    type:
      - 'null'
      - boolean
    doc: Disable the built-in variable settings.
    inputBinding:
      position: 102
      prefix: --no-builtin-variables
  - id: no_print_directory
    type:
      - 'null'
      - boolean
    doc: Turn off -w, even if it was turned on implicitly.
    inputBinding:
      position: 102
      prefix: --no-print-directory
  - id: no_silent
    type:
      - 'null'
      - boolean
    doc: Echo recipes (disable --silent mode).
    inputBinding:
      position: 102
      prefix: --no-silent
  - id: old_file
    type:
      - 'null'
      - File
    doc: Consider FILE to be very old and don't remake it.
    inputBinding:
      position: 102
      prefix: --old-file
  - id: output_sync
    type:
      - 'null'
      - string
    doc: Synchronize output of parallel jobs by TYPE.
    inputBinding:
      position: 102
      prefix: --output-sync
  - id: print_data_base
    type:
      - 'null'
      - boolean
    doc: Print make's internal database.
    inputBinding:
      position: 102
      prefix: --print-data-base
  - id: print_directory
    type:
      - 'null'
      - boolean
    doc: Print the current directory.
    inputBinding:
      position: 102
      prefix: --print-directory
  - id: question
    type:
      - 'null'
      - boolean
    doc: Run no recipe; exit status says if up to date.
    inputBinding:
      position: 102
      prefix: --question
  - id: shuffle
    type:
      - 'null'
      - string
    doc: Perform shuffle of prerequisites and goals.
    inputBinding:
      position: 102
      prefix: --shuffle
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Don't echo recipes.
    inputBinding:
      position: 102
      prefix: --silent
  - id: stop
    type:
      - 'null'
      - boolean
    doc: Turns off -k.
    inputBinding:
      position: 102
      prefix: --stop
  - id: touch
    type:
      - 'null'
      - boolean
    doc: Touch targets instead of remaking them.
    inputBinding:
      position: 102
      prefix: --touch
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Print tracing information.
    inputBinding:
      position: 102
      prefix: --trace
  - id: warn_undefined_variables
    type:
      - 'null'
      - boolean
    doc: Warn when an undefined variable is referenced.
    inputBinding:
      position: 102
      prefix: --warn-undefined-variables
  - id: what_if
    type:
      - 'null'
      - File
    doc: Consider FILE to be infinitely new.
    inputBinding:
      position: 102
      prefix: --what-if
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_abyss-pe.out
