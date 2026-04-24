cwlVersion: v1.2
class: CommandLineTool
baseCommand: cython
label: setuptools_cython
doc: "Cython is a compiler for code written in the Cython language. Cython is based
  on Pyrex by Greg Ewing.\n\nTool homepage: https://github.com/Technologicat/setup-template-cython"
inputs:
  - id: source_files
    type:
      type: array
      items: File
    doc: Source files (.pyx or .py) to compile
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Produce a colorized HTML version of the source.
    inputBinding:
      position: 102
      prefix: --annotate
  - id: annotate_coverage
    type:
      - 'null'
      - File
    doc: Annotate and include coverage information from cov.xml.
    inputBinding:
      position: 102
      prefix: --annotate-coverage
  - id: capi_reexport_cincludes
    type:
      - 'null'
      - boolean
    doc: Add cincluded headers to any auto-generated header files.
    inputBinding:
      position: 102
      prefix: --capi-reexport-cincludes
  - id: cleanup_level
    type:
      - 'null'
      - int
    doc: Release interned objects on python exit, for memory debugging. Level 
      indicates aggressiveness, default 0 releases nothing.
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: compiler_directives
    type:
      - 'null'
      - type: array
        items: string
    doc: Overrides a compiler directive
    inputBinding:
      position: 102
      prefix: --directive
  - id: cplus
    type:
      - 'null'
      - boolean
    doc: Output a C++ rather than C file.
    inputBinding:
      position: 102
      prefix: --cplus
  - id: create_listing
    type:
      - 'null'
      - boolean
    doc: Write error messages to a listing file
    inputBinding:
      position: 102
      prefix: --create-listing
  - id: embed
    type:
      - 'null'
      - string
    doc: Generate a main() function that embeds the Python interpreter.
    inputBinding:
      position: 102
      prefix: --embed
  - id: embed_positions
    type:
      - 'null'
      - boolean
    doc: If specified, the positions in Cython files of each function definition
      is embedded in its docstring.
    inputBinding:
      position: 102
      prefix: --embed-positions
  - id: fast_fail
    type:
      - 'null'
      - boolean
    doc: Abort the compilation on the first error
    inputBinding:
      position: 102
      prefix: --fast-fail
  - id: force
    type:
      - 'null'
      - boolean
    doc: Compile all source files (overrides implied -t)
    inputBinding:
      position: 102
      prefix: --force
  - id: gdb
    type:
      - 'null'
      - boolean
    doc: Output debug information for cygdb
    inputBinding:
      position: 102
      prefix: --gdb
  - id: gdb_outdir
    type:
      - 'null'
      - Directory
    doc: Specify gdb debug information output directory. Implies --gdb.
    inputBinding:
      position: 102
      prefix: --gdb-outdir
  - id: include_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Search for include files in named directory (multiple include 
      directories are allowed).
    inputBinding:
      position: 102
      prefix: --include-dir
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Change some compile time errors to runtime errors to improve Python 
      compatibility
    inputBinding:
      position: 102
      prefix: --lenient
  - id: line_directives
    type:
      - 'null'
      - boolean
    doc: 'Produce #line directives pointing to the .pyx source'
    inputBinding:
      position: 102
      prefix: --line-directives
  - id: no_docstrings
    type:
      - 'null'
      - boolean
    doc: Strip docstrings from the compiled module.
    inputBinding:
      position: 102
      prefix: --no-docstrings
  - id: python2_syntax
    type:
      - 'null'
      - boolean
    doc: Compile based on Python-2 syntax and code semantics.
    inputBinding:
      position: 102
      prefix: '-2'
  - id: python3_syntax
    type:
      - 'null'
      - boolean
    doc: Compile based on Python-3 syntax and code semantics.
    inputBinding:
      position: 102
      prefix: '-3'
  - id: timestamps
    type:
      - 'null'
      - boolean
    doc: Only compile newer source files
    inputBinding:
      position: 102
      prefix: --timestamps
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose, print file names on multiple compilation
    inputBinding:
      position: 102
      prefix: --verbose
  - id: warning_errors
    type:
      - 'null'
      - boolean
    doc: Make all warnings into errors
    inputBinding:
      position: 102
      prefix: --warning-errors
  - id: warning_extra
    type:
      - 'null'
      - boolean
    doc: Enable extra warnings
    inputBinding:
      position: 102
      prefix: --warning-extra
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: Sets the working directory for Cython (the directory modules are 
      searched from)
    inputBinding:
      position: 102
      prefix: --working
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify name of generated C file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setuptools_cython:0.2.1--py27_1
