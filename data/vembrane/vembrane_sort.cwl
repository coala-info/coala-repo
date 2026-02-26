cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane sort
label: vembrane_sort
doc: "Sort VCF/BCF records by one or multiple Python expressions that encode keys
  for the desired order. This feature is primarily meant to prioritizing records for
  the human eye. For large unfiltered VCF/BCF files, the only relevant sorting is
  usually by position, which is better done with e.g. bcftools (and usually the standard
  sorting that variant callers output). Expects the VCF/BCF file to be single-allelic,
  i.e., one ALT allele per record.\n\nTool homepage: https://github.com/vembrane/vembrane"
inputs:
  - id: expression
    type: string
    doc: Python expression (or tuple of expressions) returning orderable values 
      (keys) to sort the VCF/BCF records by. By default keys are considered in 
      ascending order. To sort by descending order, use `desc(<expression>)` on 
      the entire expression or on individual items of the tuple. If multiple 
      expressions are provided as a tuple, they are prioritized from left to 
      right with lowest priority on the right. NA/NaN values are always sorted 
      to the end. Expressions on annotation entries (there can be multiple 
      annotations per record) will cause the annotation with the minimum key 
      value (or maximum if descending) to be considered to sort the record.
    inputBinding:
      position: 1
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: The VCF/BCF file containing the variants. If not specified, reads from 
      STDIN.
    default: '-'
    inputBinding:
      position: 2
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: The INFO key for the annotation field. This defaults to 'ANN', but 
      tools might use other field names. For example, default VEP annotations 
      can be parsed by setting 'CSQ' here.
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
  - id: max_in_mem_records
    type:
      - 'null'
      - int
    doc: Number of VCF/BCF records to sort in memory. If the VCF/BCF file 
      exceeds this number of records, external sorting is used.
    default: 100000
    inputBinding:
      position: 103
      prefix: --max-in-mem-records
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
    doc: 'Overwrite the number specification for FORMAT fields given in the VCF header.
      Example: `--overwrite-number- format DP=2`'
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
  - id: preserve_annotation_order
    type:
      - 'null'
      - boolean
    doc: If set, annotations are not sorted within the records, but kept in the 
      same order as in the input VCF/BCF file. If not set (default), annotations
      are sorted within the record according to the given keys if any of the 
      sort keys given in the python expression refers to an annotation.
    inputBinding:
      position: 103
      prefix: --preserve-annotation-order
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
