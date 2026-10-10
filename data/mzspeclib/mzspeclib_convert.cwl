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
  - id: outpath
    type: string
    doc: Output file path or '-' for STDOUT
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (text, json or msp)
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
        items: library_attribute_pair
        inputBinding:
          prefix: --library-attribute
    doc: Specify an attribute (name and value) to add to the library metadata section.
      May be repeated.
    inputBinding:
      position: 102
outputs:
  - id: converted
    type:
      - 'null'
      - File
    doc: Converted library (not written when outpath is '-')
    outputBinding:
      glob: $(inputs.outpath)
  - id: stdout
    type: stdout
    doc: Library text when outpath is '-'
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: library_attribute_pair
        type: record
        fields:
          - name: attribute_name
            type: string
            inputBinding:
              position: 1
          - name: attribute_value
            type: string
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
stdout: mzspeclib_convert.out
