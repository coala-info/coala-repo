cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec build
label: seqspec_build
doc: "Generate a complete seqspec with natural language.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: date
    type:
      - 'null'
      - string
    doc: Date (YYYY-MM-DD)
    inputBinding:
      position: 101
      prefix: --date
  - id: description
    type:
      - 'null'
      - string
    doc: Short description
    inputBinding:
      position: 101
      prefix: --description
  - id: doi
    type:
      - 'null'
      - string
    doc: DOI of the assay
    inputBinding:
      position: 101
      prefix: --doi
  - id: modalities
    type:
      type: array
      items: string
    doc: Comma-separated list of modalities (e.g. rna,atac)
    inputBinding:
      position: 101
      prefix: --modalities
  - id: name
    type: string
    doc: Assay name
    inputBinding:
      position: 101
      prefix: --name
  - id: trace_jsonl
    type:
      - 'null'
      - File
    doc: Write OpenTelemetry spans to this JSONL file for later viewing
    inputBinding:
      position: 101
      prefix: --trace
  - id: verbose
    type:
      - 'null'
      - string
    doc: "Enable console tracing. Default mode is 'simple' if no value is given. Modes:
      simple | extended | all"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output YAML (default stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
