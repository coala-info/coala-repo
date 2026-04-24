cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane_table
label: vembrane_table
doc: "Convert VCF/BCF records to tabular format.\n\nTool homepage: https://github.com/vembrane/vembrane"
inputs:
  - id: expression
    type: string
    doc: A comma-separated tuple of expressions that define the table column 
      contents. Use ALL to output all fields.
    inputBinding:
      position: 1
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Path to the VCF/BCF file to be filtered. Defaults to\n                 \
      \       '-' for stdin."
    inputBinding:
      position: 2
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: "The INFO key for the annotation field. This defaults\n                 \
      \       to 'ANN', but tools might use other field names. For\n             \
      \           example, default VEP annotations can be parsed by\n            \
      \            setting 'CSQ' here."
    inputBinding:
      position: 103
      prefix: --annotation-key
  - id: aux
    type:
      - 'null'
      - type: array
        items: string
    doc: Path to an auxiliary file containing a set of symbols
    inputBinding:
      position: 103
      prefix: --aux
  - id: backend
    type:
      - 'null'
      - string
    doc: 'Set the backend library. (default: cyvcf2)'
    inputBinding:
      position: 103
      prefix: --backend
  - id: context
    type:
      - 'null'
      - string
    doc: "Python statement defining a context for given Python\n                 \
      \       expressions. Extends eventual definitions given via\n              \
      \          --context-file. Any global variables (or functions)\n           \
      \             become available in the Python expressions. Note that\n      \
      \                  the code you pass here is not sandboxed and should be\n \
      \                       trusted. Carefully review any code you get from the\n\
      \                        internet or AI."
    inputBinding:
      position: 103
      prefix: --context
  - id: context_file
    type:
      - 'null'
      - File
    doc: "Path to Python script defining a context for given\n                   \
      \     Python expressions. Any global variables (or\n                       \
      \ functions) become available in the Python expressions. Note that\n       \
      \                 the code you pass here is not sandboxed and should be\n  \
      \                      trusted. Carefully review any code you get from the\n\
      \                        internet or AI."
    inputBinding:
      position: 103
      prefix: --context-file
  - id: header
    type:
      - 'null'
      - string
    doc: "Override the automatically generated header. Provide\n                 \
      \       \"auto\" (default) to automatically generate the header\n          \
      \              from the expression. Provide a comma separated string\n     \
      \                   to manually set the header. Provide \"none\" to disable\n\
      \                        any header output."
    inputBinding:
      position: 103
      prefix: --header
  - id: long
    type:
      - 'null'
      - string
    doc: "Long format is now the default. For wide format, use\n                 \
      \       `--wide` instead."
    inputBinding:
      position: 103
      prefix: --long
  - id: naming_convention
    type:
      - 'null'
      - string
    doc: "The naming convention to use for column names when\n                   \
      \     generating the header for the ALL expression."
    inputBinding:
      position: 103
      prefix: --naming-convention
  - id: ontology
    type:
      - 'null'
      - File
    doc: "Path to an ontology in OBO format. May be compressed\n                 \
      \       with gzip, bzip2 and xz. Defaults to built-in ontology\n           \
      \             (from sequenceontology.org)."
    inputBinding:
      position: 103
      prefix: --ontology
  - id: overwrite_number_format
    type:
      - 'null'
      - type: array
        items: string
    doc: "Overwrite the number specification for FORMAT fields\n                 \
      \       given in the VCF header. Example: `--overwrite-number-\n           \
      \             format DP=2`"
    inputBinding:
      position: 103
      prefix: --overwrite-number-format
  - id: overwrite_number_info
    type:
      - 'null'
      - type: array
        items: string
    doc: "Overwrite the number specification for INFO fields\n                   \
      \     given in the VCF header. Example: `--overwrite-number\n              \
      \          cosmic_CNT=.`"
    inputBinding:
      position: 103
      prefix: --overwrite-number-info
  - id: separator
    type:
      - 'null'
      - string
    doc: "Define the field separator (default: \t)."
    inputBinding:
      position: 103
      prefix: --separator
  - id: wide
    type:
      - 'null'
      - boolean
    doc: "Instead of using long format with a special SAMPLE\n                   \
      \     column, generate multiple columns per sample with the\n              \
      \          `for_each_sample` utility function."
    inputBinding:
      position: 103
      prefix: --wide
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output file, if not specified, output is written to\n                  \
      \      STDOUT."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
