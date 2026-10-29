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
      position: 100
  - id: all
    type:
      - 'null'
      - boolean
    doc: Generate code for Slice definitions in included files
    inputBinding:
      position: 1
      prefix: --all
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: Generate checksums for Slice definitions
    inputBinding:
      position: 1
      prefix: --checksum
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages
    inputBinding:
      position: 1
      prefix: --debug
  - id: define
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -D
          separate: false
    doc: Define NAME as 1 (NAME) or as DEF (NAME=DEF)
    inputBinding:
      position: 1
  - id: depend
    type:
      - 'null'
      - boolean
    doc: Generate Makefile dependencies
    inputBinding:
      position: 1
      prefix: --depend
  - id: depend_file_path
    type:
      - 'null'
      - string
    doc: Write dependencies to FILE instead of standard output
    inputBinding:
      position: 1
      prefix: --depend-file
  - id: depend_xml
    type:
      - 'null'
      - boolean
    doc: Generate dependencies in XML format
    inputBinding:
      position: 1
      prefix: --depend-xml
  - id: include_dir
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: -I
          separate: false
    doc: Put DIR in the include file search path
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    default: slice_out
    doc: Create files in the directory DIR
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prepend filenames of Python modules with PREFIX
    inputBinding:
      position: 1
      prefix: --prefix
  - id: preprocess_stdout
    type:
      - 'null'
      - boolean
    doc: Print preprocessor output on stdout
    inputBinding:
      position: 1
      prefix: -E
  - id: undefine
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -U
          separate: false
    doc: Remove any definition for NAME
    inputBinding:
      position: 1
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the generated Python modules
    outputBinding:
      glob: $(inputs.output_dir)
  - id: depend_file
    type:
      - 'null'
      - File
    doc: Dependency file written with --depend-file
    outputBinding:
      glob: |-
        ${ return inputs.depend_file_path ? inputs.depend_file_path : []; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '${ return {"class": "Directory", "basename": inputs.output_dir, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2py.out
