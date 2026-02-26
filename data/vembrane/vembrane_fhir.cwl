cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane fhir
label: vembrane_fhir
doc: "Generate FHIR records from VCF/BCF files.\n\nTool homepage: https://github.com/vembrane/vembrane"
inputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Path to the VCF/BCF file to be filtered. Defaults to\n                 \
      \       '-' for stdin."
    default: '-'
    inputBinding:
      position: 1
  - id: sample
    type: string
    doc: The sample to use for generating FHIR output.
    inputBinding:
      position: 2
  - id: reference_assembly
    type: string
    doc: The reference assembly used for read mapping.
    inputBinding:
      position: 3
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: "The INFO key for the annotation field. This defaults\n                 \
      \       to 'ANN', but tools might use other field names. For\n             \
      \           example, default VEP annotations can be parsed by\n            \
      \            setting 'CSQ' here."
    default: ANN
    inputBinding:
      position: 104
      prefix: --annotation-key
  - id: aux
    type:
      - 'null'
      - type: array
        items: string
    doc: Path to an auxiliary file containing a set of symbols
    inputBinding:
      position: 104
      prefix: --aux
  - id: backend
    type:
      - 'null'
      - string
    doc: Set the backend library.
    default: cyvcf2
    inputBinding:
      position: 104
      prefix: --backend
  - id: confidence_status
    type:
      - 'null'
      - string
    doc: "Python expression for calculating the variants\n                       \
      \ confidence status being High, Intermediate or Low.\n                     \
      \   E.g. \"'High' if QUAL >= 20 else ('Intermediate' if\n                  \
      \      QUAL >= 10 else 'Low')\""
    inputBinding:
      position: 104
      prefix: --confidence-status
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
      position: 104
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
      position: 104
      prefix: --context-file
  - id: detection_limit
    type:
      - 'null'
      - float
    doc: "Detection limit / sensitivity of the analysis in\n                     \
      \   percent (e.g. 95)."
    inputBinding:
      position: 104
      prefix: --detection-limit
  - id: genomic_source_class
    type:
      - 'null'
      - string
    doc: "The genomic source class of the given variants as\n                    \
      \    defined by LOINC: https://loinc.org/48002-0. Either\n                 \
      \       provide the name as a string or a Python expression\n              \
      \          that evaluates to the name, e.g., for Varlociraptor\n           \
      \             '\"Somatic\" if INFO[\"PROB_SOMATIC\"] > 0.95 else ...'."
    inputBinding:
      position: 104
      prefix: --genomic-source-class
  - id: id_source
    type:
      - 'null'
      - string
    doc: "URL to the source of IDs found in the ID column of the\n               \
      \         VCF/BCF file. IDs are only used if this is given."
    inputBinding:
      position: 104
      prefix: --id-source
  - id: ontology
    type:
      - 'null'
      - File
    doc: "Path to an ontology in OBO format. May be compressed\n                 \
      \       with gzip, bzip2 and xz. Defaults to built-in ontology\n           \
      \             (from sequenceontology.org)."
    inputBinding:
      position: 104
      prefix: --ontology
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: "Output format. If not specified, can be automatically\n                \
      \        determined from the --output file extension."
    inputBinding:
      position: 104
      prefix: --output-fmt
  - id: overwrite_number_format
    type:
      - 'null'
      - type: array
        items: string
    doc: "Overwrite the number specification for FORMAT fields\n                 \
      \       in the VCF header. Example: `--overwrite-number-\n                 \
      \       format DP=2`"
    inputBinding:
      position: 104
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
      position: 104
      prefix: --overwrite-number-info
  - id: profile
    type: string
    doc: "The FHIR profile to use for generating the output, see\n               \
      \         https://github.com/vembrane/vembrane/tree/main/vembran\n         \
      \               e/modules/assets/fhir/profiles for available profiles\n    \
      \                    and the degree of support."
    inputBinding:
      position: 104
      prefix: --profile
  - id: sample_allelic_frequency
    type:
      - 'null'
      - string
    doc: "Python expression calculating the the samples allelic\n                \
      \        frequencyas percentage. E.g. \"FORMAT['AF'][sample][0]\n          \
      \              * 100\""
    inputBinding:
      position: 104
      prefix: --sample-allelic-frequency
  - id: sample_allelic_read_depth
    type:
      - 'null'
      - string
    doc: "Python expression accessing the the samples allelic\n                  \
      \      read depth.Default is: \"FORMAT['AD'][sample][1]\""
    default: FORMAT['AD'][sample][1]
    inputBinding:
      position: 104
      prefix: --sample-allelic-read-depth
  - id: status
    type:
      - 'null'
      - string
    doc: Status of findings. E.g. final, preliminary, ...
    inputBinding:
      position: 104
      prefix: --status
  - id: url
    type:
      - 'null'
      - string
    doc: "Generic url used as identifier by FHIR e.g.\n                        http://<institute>/<department>/VCF"
    inputBinding:
      position: 104
      prefix: --url
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
