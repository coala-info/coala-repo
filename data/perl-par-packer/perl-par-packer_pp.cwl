cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp
label: perl-par-packer_pp
doc: "pp creates standalone executables from Perl programs, using the compressed packager provided by PAR, and dependency detection heuristics offered by Module::ScanDeps\n\nTool homepage: https://github.com/rschupp/PAR-Packer"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Perl scripts to pack, or a .par file (use together with the eval option instead for a one-liner)"
    inputBinding:
      position: 200
  - id: output
    type:
      - 'null'
      - string
    doc: "File name for the final packaged executable"
    inputBinding:
      position: 101
      prefix: -o
  - id: par
    type:
      - 'null'
      - boolean
    doc: "Create PAR archives only; do not package to a standalone binary"
    inputBinding:
      position: 101
      prefix: -p
  - id: perlscript
    type:
      - 'null'
      - boolean
    doc: "Create stand-alone perl script; do not package to a standalone binary"
    inputBinding:
      position: 101
      prefix: -P
  - id: bundle
    type:
      - 'null'
      - boolean
    doc: "Bundle core modules in the resulting package"
    inputBinding:
      position: 101
      prefix: -B
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "Clean up temporary files extracted from the application at runtime"
    inputBinding:
      position: 101
      prefix: -C
  - id: compile
    type:
      - 'null'
      - boolean
    doc: "Run perl -c on the input file to determine additional run-time dependencies"
    inputBinding:
      position: 101
      prefix: -c
  - id: cachedeps
    type:
      - 'null'
      - string
    doc: "File used to cache detected dependencies; created unless present"
    inputBinding:
      position: 101
      prefix: -cd
  - id: dependent
    type:
      - 'null'
      - boolean
    doc: "Reduce the executable size by not including a copy of the perl interpreter"
    inputBinding:
      position: 101
      prefix: -d
  - id: eval
    type:
      - 'null'
      - string
    doc: "Package a one-liner, much the same as perl -e"
    inputBinding:
      position: 101
      prefix: -e
  - id: evalfeature
    type:
      - 'null'
      - string
    doc: "Like eval, but enables all optional features"
    inputBinding:
      position: 101
      prefix: -E
  - id: execute
    type:
      - 'null'
      - boolean
    doc: "Run perl on the input file to determine additional run-time dependencies"
    inputBinding:
      position: 101
      prefix: -x
  - id: xargs
    type:
      - 'null'
      - string
    doc: "If execute is given, arguments passed as @ARGV when running the input file"
    inputBinding:
      position: 101
      prefix: --xargs
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -X
    doc: "Exclude the given module from the dependency search path and from the package"
    inputBinding:
      position: 101
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -f
    doc: "Filter source script(s) with a PAR::Filter subclass"
    inputBinding:
      position: 101
  - id: modfilter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -F
    doc: "Filter included perl module(s) with a PAR::Filter subclass (FILTER[=REGEX])"
    inputBinding:
      position: 101
  - id: lib
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: -I
    doc: "Add the given directory to the perl library file search path"
    inputBinding:
      position: 101
  - id: link
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -l
    doc: "Add the given shared library into the packed file"
    inputBinding:
      position: 101
  - id: log
    type:
      - 'null'
      - string
    doc: "Log the output of packaging to a file rather than to stdout"
    inputBinding:
      position: 101
      prefix: -L
  - id: module
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -M
    doc: "Add the specified module into the package, along with its dependencies"
    inputBinding:
      position: 101
  - id: multiarch
    type:
      - 'null'
      - boolean
    doc: "Build a multi-architecture PAR file (implies par)"
    inputBinding:
      position: 101
      prefix: -m
  - id: noscan
    type:
      - 'null'
      - boolean
    doc: "Skip the default static scanning altogether"
    inputBinding:
      position: 101
      prefix: -n
  - id: namespace
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -N
    doc: "Add all modules in the namespace into the package, along with their dependencies"
    inputBinding:
      position: 101
  - id: add_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -a
    doc: "Add an extra file into the package"
    inputBinding:
      position: 101
  - id: add_dir
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: -a
    doc: "Add an extra directory into the package"
    inputBinding:
      position: 101
  - id: addlist
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -A
    doc: "Read a list of file/directory names from this file, adding them into the package"
    inputBinding:
      position: 101
  - id: reusable
    type:
      - 'null'
      - boolean
    doc: "Make the packaged executable reusable for running arbitrary external Perl scripts (experimental)"
    inputBinding:
      position: 101
      prefix: --reusable
  - id: save
    type:
      - 'null'
      - boolean
    doc: "Do not delete generated PAR file after packaging"
    inputBinding:
      position: 101
      prefix: -S
  - id: tempcache
    type:
      - 'null'
      - string
    doc: "Set the program unique part of the cache directory name"
    inputBinding:
      position: 101
      prefix: -T
  - id: unicode
    type:
      - 'null'
      - boolean
    doc: "Package Unicode support"
    inputBinding:
      position: 101
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Increase verbosity of output (1 to 3)"
    inputBinding:
      position: 101
      prefix: -v
  - id: compress
    type:
      - 'null'
      - int
    doc: "Set zip compression level (0 to 9)"
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Packed executable, script or PAR archive written with the output option
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-par-packer:1.036--pl5321h7b50bb2_6
stdout: perl-par-packer_pp.out
