cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane tag
label: vembrane_tag
doc: "Flag records by adding a tag to their FILTER field based on one or more expressions.
  This is a non-destructive alternative to `filter`, as it keeps all records.\n\n\
  Tool homepage: https://github.com/vembrane/vembrane"
inputs:
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Path to the VCF/BCF file to be filtered. Defaults to '-' for stdin.
    inputBinding:
      position: 1
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: The INFO key for the annotation field. This defaults to 'ANN', but 
      tools might use other field names. For example, default VEP annotations 
      can be parsed by setting 'CSQ' here.
    inputBinding:
      position: 102
      prefix: --annotation-key
  - id: aux_files
    type:
      - 'null'
      - type: array
        items: string
    doc: Path to an auxiliary file containing a set of symbols
    inputBinding:
      position: 102
      prefix: --aux
  - id: backend
    type:
      - 'null'
      - string
    doc: Set the backend library.
    inputBinding:
      position: 102
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
      position: 102
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
      position: 102
      prefix: --context-file
  - id: ontology
    type:
      - 'null'
      - File
    doc: Path to an ontology in OBO format. May be compressed with gzip, bzip2 
      and xz. Defaults to built-in ontology (from sequenceontology.org).
    inputBinding:
      position: 102
      prefix: --ontology
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format.
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: overwrite_number_format
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Overwrite the number specification for FORMAT fields given in the VCF header.
      Example: `--overwrite-number- format DP=2`'
    inputBinding:
      position: 102
      prefix: --overwrite-number-format
  - id: overwrite_number_info
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Overwrite the number specification for INFO fields given in the VCF header.
      Example: `--overwrite-number cosmic_CNT=.`'
    inputBinding:
      position: 102
      prefix: --overwrite-number-info
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: "Tag records using the FILTER field. Note: tag names cannot contain `;` or
      whitespace and must not be '0'. Example: `--tag q_above_30=\"not (QUAL<=30)\"\
      `"
    inputBinding:
      position: 102
      prefix: --tag
  - id: tag_mode
    type:
      - 'null'
      - string
    doc: Set, whether to tag records that pass the tag expression(s), or records
      that fail them.By default, vembrane tags records for which the tag 
      expression(s) pass. This allows for descriptive tag names such as 
      `q_at_least_30`, which would correspond to an expression `QUAL >= 30`. 
      However, the VCF specification (`v4.4`) defines tags to be set when a 
      filter expression is failed, so vembrane also offers the `fail` mode.
    inputBinding:
      position: 102
      prefix: --tag-mode
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, if not specified, output is written to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
