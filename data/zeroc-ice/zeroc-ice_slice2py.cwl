cwlVersion: v1.2
class: CommandLineTool
baseCommand: slice2py
label: zeroc-ice_slice2py
doc: "Convert Slice definitions to Python code\n\nTool homepage: https://github.com/zeroc-ice"
inputs:
  - id: slice_files
    type:
      type: array
      items: File
    doc: Slice files to process
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Generate code for Slice definitions in included files
    inputBinding:
      position: 102
      prefix: --all
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: Generate checksums for Slice definitions
    inputBinding:
      position: 102
      prefix: --checksum
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages
    inputBinding:
      position: 102
      prefix: --debug
  - id: define_name
    type:
      - 'null'
      - string
    doc: Define NAME as 1
    inputBinding:
      position: 102
      prefix: -D
  - id: define_name_equals_def
    type:
      - 'null'
      - string
    doc: Define NAME as DEF
    inputBinding:
      position: 102
      prefix: -D
  - id: depend
    type:
      - 'null'
      - boolean
    doc: Generate Makefile dependencies
    inputBinding:
      position: 102
      prefix: --depend
  - id: depend_file
    type:
      - 'null'
      - File
    doc: Write dependencies to FILE instead of standard output
    inputBinding:
      position: 102
      prefix: --depend-file
  - id: depend_xml
    type:
      - 'null'
      - boolean
    doc: Generate dependencies in XML format
    inputBinding:
      position: 102
      prefix: --depend-xml
  - id: include_dir
    type:
      - 'null'
      - Directory
    doc: Put DIR in the include file search path
    inputBinding:
      position: 102
      prefix: -I
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Create files in the directory DIR
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prepend filenames of Python modules with PREFIX
    inputBinding:
      position: 102
      prefix: --prefix
  - id: preprocess_stdout
    type:
      - 'null'
      - boolean
    doc: Print preprocessor output on stdout
    inputBinding:
      position: 102
      prefix: -E
  - id: undefine_name
    type:
      - 'null'
      - string
    doc: Remove any definition for NAME
    inputBinding:
      position: 102
      prefix: -U
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2py.out
