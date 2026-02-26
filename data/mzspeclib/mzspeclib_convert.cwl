cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mzspeclib
  - convert
label: mzspeclib_convert
doc: "Convert a spectral library from one format to another. If `outpath` is `-`,
  instead of writing to file, data will instead be sent to STDOUT.\n\nTool homepage:
  https://github.com/HUPO-PSI/mzSpecLib"
inputs:
  - id: inpath
    type: File
    doc: Input file path
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 102
      prefix: --format
  - id: header_file
    type:
      - 'null'
      - File
    doc: Specify a file to read name-value pairs from. May be JSON or 
      TAB-separated
    inputBinding:
      position: 102
      prefix: --header-file
  - id: input_format
    type:
      - 'null'
      - string
    doc: The file format of the input file. If omitted, will attempt to infer 
      automatically.
    inputBinding:
      position: 102
      prefix: --input-format
  - id: library_attribute
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify an attribute to add to the library metadata section. May be 
      repeated.
    inputBinding:
      position: 102
      prefix: --library-attribute
outputs:
  - id: outpath
    type: File
    doc: Output file path or '-' for STDOUT
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
