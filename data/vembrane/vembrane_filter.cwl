cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane filter
label: vembrane_filter
doc: "Filter VCF/BCF records and annotations based on a user-defined Python\nexpression.Only
  records for which the expression evaluates to True are kept.\n\nTool homepage: https://github.com/vembrane/vembrane"
inputs:
  - id: expression
    type: string
    doc: "A python expression to filter variants. The expression\nmust evaluate to
      bool. All VCF/BCF fields can be\naccessed. Additionally, annotation fields can
      be\naccessed, see `--annotation-key`. If all annotations\nof a record are filtered
      out, the entire record is\nremoved."
    inputBinding:
      position: 1
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: "Path to the VCF/BCF file to be filtered. Defaults to\n'-' for stdin."
    default: '-'
    inputBinding:
      position: 2
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: "The INFO key for the annotation field. This defaults\nto 'ANN', but tools
      might use other field names. For\nexample, default VEP annotations can be parsed
      by\nsetting 'CSQ' here."
    default: ANN
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
    doc: Set the backend library.
    default: cyvcf2
    inputBinding:
      position: 103
      prefix: --backend
  - id: context
    type:
      - 'null'
      - string
    doc: "Python statement defining a context for given Python\nexpressions. Extends
      eventual definitions given via\n--context-file. Any global variables (or functions)\n\
      become available in the Python expressions. Note that\nthe code you pass here
      is not sandboxed and should be\ntrusted. Carefully review any code you get from
      the\ninternet or AI."
    inputBinding:
      position: 103
      prefix: --context
  - id: context_file
    type:
      - 'null'
      - File
    doc: "Path to Python script defining a context for given\nPython expressions.
      Any global variables (or\nfunctions) become available in the Python expressions.\n\
      Note that the code you pass here is not sandboxed and\nshould be trusted. Carefully
      review any code you get\nfrom the internet or AI."
    inputBinding:
      position: 103
      prefix: --context-file
  - id: keep_unmatched
    type:
      - 'null'
      - boolean
    doc: "Keep all annotations of a variant if at least one of\nthem passes the expression."
    inputBinding:
      position: 103
      prefix: --keep-unmatched
  - id: ontology
    type:
      - 'null'
      - File
    doc: "Path to an ontology in OBO format. May be compressed\nwith gzip, bzip2 and
      xz. Defaults to built-in ontology\n(from sequenceontology.org)."
    inputBinding:
      position: 103
      prefix: --ontology
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Output format.
    default: vcf
    inputBinding:
      position: 103
      prefix: --output-fmt
  - id: overwrite_number_format
    type:
      - 'null'
      - type: array
        items: string
    doc: "Overwrite the number specification for FORMAT fields\ngiven in the VCF header.
      Example: `--overwrite-number-\nformat DP=2`"
    inputBinding:
      position: 103
      prefix: --overwrite-number-format
  - id: overwrite_number_info
    type:
      - 'null'
      - type: array
        items: string
    doc: "Overwrite the number specification for INFO fields\ngiven in the VCF header.
      Example: `--overwrite-number\ncosmic_CNT=.`"
    inputBinding:
      position: 103
      prefix: --overwrite-number-info
  - id: preserve_order
    type:
      - 'null'
      - boolean
    doc: "Ensures that the order of the output matches that of\nthe input. This is
      only useful if the input contains\nbreakends (BNDs) since the order of all other
      variants\nis preserved anyway."
    inputBinding:
      position: 103
      prefix: --preserve-order
  - id: statistics
    type:
      - 'null'
      - File
    doc: Write statistics to this file.
    inputBinding:
      position: 103
      prefix: --statistics
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output file, if not specified, output is written to\nSTDOUT."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
