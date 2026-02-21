cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - argnorm
  - argsoap
label: argnorm_argsoap
doc: "argNorm normalizes ARG annotation results from different tools and databases
  to the same ontology, namely ARO (Antibiotic Resistance Ontology).\n\nTool homepage:
  https://github.com/BigDataBiology/argNorm"
inputs:
  - id: db
    type:
      - 'null'
      - string
    doc: The database used alongside the ARG annotation tool. This is only required
      if abricate or groot is used as a tool.
    inputBinding:
      position: 101
      prefix: --db
  - id: hamronization_skip_unsupported_tool
    type:
      - 'null'
      - boolean
    doc: skip rows with unsupported tools for hamronization outputs. argNorm be default
      will raise an exception if unsupported tool is found in hamronization. Use this
      if you only want argNorm to raise a warning.
    inputBinding:
      position: 101
      prefix: --hamronization_skip_unsupported_tool
  - id: input
    type: File
    doc: The path to the ARG annotation result which needs to be normalized.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: The path to the output file where you would like to store argNorm's results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
