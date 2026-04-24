cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vembrane
  - structured
label: vembrane_structured
doc: "Create structured output from a VCF/BCF and a YTE template.\n\nTool homepage:
  https://github.com/vembrane/vembrane"
inputs:
  - id: template
    type: File
    doc: File containing a YTE template with the desired structure per record 
      and expressions that retrieve data from the VCF/BCF record.
    inputBinding:
      position: 1
  - id: vcf
    type:
      - 'null'
      - File
    doc: Path to the VCF/BCF file to be filtered. Defaults to '-' for stdin.
    inputBinding:
      position: 2
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: The INFO key for the annotation field. This defaults to 'ANN', but 
      tools might use other field names. For example, default VEP annotations 
      can be parsed by setting 'CSQ' here.
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
    inputBinding:
      position: 103
      prefix: --backend
  - id: context
    type:
      - 'null'
      - string
    doc: Python statement defining a context for given Python expressions. 
      Extends eventual definitions given via --context-file. Any global 
      variables (or functions) become available in the Python expressions. Note 
      that the code you pass here is not sandboxed and should be trusted. 
      Carefully review any code you get from the internet or AI.
    inputBinding:
      position: 103
      prefix: --context
  - id: context_file
    type:
      - 'null'
      - File
    doc: Path to Python script defining a context for given Python expressions. 
      Any global variables (or functions) become available in the Python 
      expressions. Note that the code you pass here is not sandboxed and should 
      be trusted. Carefully review any code you get from the internet or AI.
    inputBinding:
      position: 103
      prefix: --context-file
  - id: ontology
    type:
      - 'null'
      - File
    doc: Path to an ontology in OBO format. May be compressed with gzip, bzip2 
      and xz. Defaults to built-in ontology (from sequenceontology.org).
    inputBinding:
      position: 103
      prefix: --ontology
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Output format. If not specified, can be automatically determined from 
      the --output file extension.
    inputBinding:
      position: 103
      prefix: --output-fmt
  - id: overwrite_number_format
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Overwrite the number specification for FORMAT fields given in the VCF header.
      Example: `--overwrite-number-format DP=2`'
    inputBinding:
      position: 103
      prefix: --overwrite-number-format
  - id: overwrite_number_info
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Overwrite the number specification for INFO fields given in the VCF header.
      Example: `--overwrite-number cosmic_CNT=.`'
    inputBinding:
      position: 103
      prefix: --overwrite-number-info
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file, if not specified, output is written to STDOUT.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
