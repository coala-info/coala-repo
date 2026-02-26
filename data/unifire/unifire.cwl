cwlVersion: v1.2
class: CommandLineTool
baseCommand: unifire
label: unifire
doc: "UniProt Functional annotation Inference Rule Engine\n\nTool homepage: https://github.com/cmatKhan/unifire/"
inputs:
  - id: chunksize
    type:
      - 'null'
      - int
    doc: "Chunk size (number of proteins) to be batch processed\n                \
      \                            simultaneously"
    default: 1000
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: input_file
    type: File
    doc: "Input file (path) containing the proteins to annotate\n                \
      \                            and required data, in the format specified by the
      -s\n                                            option."
    inputBinding:
      position: 101
      prefix: --input
  - id: input_source
    type:
      - 'null'
      - string
    doc: "Input source type. Supported input sources are:\n                      \
      \                      - InterProScan (InterProScan Output XML)\n          \
      \                                  - UniParc (UniParc XML)\n               \
      \                             - XML (Input Fact XML)"
    default: InterProScan
    inputBinding:
      position: 101
      prefix: --input-source
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Max size of the memory allocation pool in MB (JVM -Xmx)
    default: 4096 MB
    inputBinding:
      position: 101
      prefix: -m
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output file format. Supported formats are:\n                           \
      \                 - TSV (Tab-Separated Values)\n                           \
      \                 - XML (URML Fact XML)"
    default: TSV
    inputBinding:
      position: 101
      prefix: --output-format
  - id: rules
    type: File
    doc: "Rule base file (path) provided by UniProt (e.g UniRule\n               \
      \                             or ARBA) (format: URML)."
    inputBinding:
      position: 101
      prefix: --rules
  - id: templates
    type:
      - 'null'
      - File
    doc: "UniRule template sequence matches, provided by UniProt\n               \
      \                             (format: Fact Model XML)."
    inputBinding:
      position: 101
      prefix: --templates
outputs:
  - id: output_file
    type: File
    doc: "Output file (path) containing predictions in the format\n              \
      \                              specified in the -f option."
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifire:1.0.1--hdfd78af_0
