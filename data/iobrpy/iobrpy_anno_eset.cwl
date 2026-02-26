cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy anno_eset
label: iobrpy_anno_eset
doc: "Annotates an expression set with gene/probe information.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: annotation
    type: string
    doc: Annotation key to use (ignored if --annotation-file is provided)
    inputBinding:
      position: 101
      prefix: --annotation
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: Path to external annotation file (pkl/csv/tsv/xlsx). Overrides built-in
      annotation if provided.
    inputBinding:
      position: 101
      prefix: --annotation-file
  - id: annotation_key
    type:
      - 'null'
      - string
    doc: If external pkl contains multiple dataframes (a dict), select which key
      to use.
    inputBinding:
      position: 101
      prefix: --annotation-key
  - id: input_path
    type: File
    doc: Path to input expression set
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: Dup handling method
    default: mean
    inputBinding:
      position: 101
      prefix: --method
  - id: probe
    type:
      - 'null'
      - string
    doc: Annotation probe column
    inputBinding:
      position: 101
      prefix: --probe
  - id: remove_version
    type:
      - 'null'
      - boolean
    doc: Remove version suffix from gene IDs before annotation
    inputBinding:
      position: 101
      prefix: --remove_version
  - id: symbol
    type:
      - 'null'
      - string
    doc: Annotation symbol column
    inputBinding:
      position: 101
      prefix: --symbol
outputs:
  - id: output_path
    type: File
    doc: Path to save annotated expression set
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
