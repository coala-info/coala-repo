cwlVersion: v1.2
class: CommandLineTool
baseCommand: argnorm
label: argnorm_deeparg
doc: "argNorm normalizes ARG annotation results from different tools and databases
  to the same ontology, namely ARO (Antibiotic Resistance Ontology).\n\nTool homepage:
  https://github.com/BigDataBiology/argNorm"
inputs:
  - id: tool
    type: string
    doc: 'The bioinformatics tool used for ARG annotation. Options: {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}'
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: 'The database used alongside the ARG annotation tool. This is only required
      if abricate or groot is used as a tool. Options: {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}'
    inputBinding:
      position: 102
      prefix: --db
  - id: hamronization_skip_unsupported_tool
    type:
      - 'null'
      - boolean
    doc: skip rows with unsupported tools for hamronization outputs. argNorm be default
      will raise an exception if unsupported tool is found in hamronization. Use this
      if you only want argNorm to raise a warning.
    inputBinding:
      position: 102
      prefix: --hamronization_skip_unsupported_tool
  - id: input
    type: File
    doc: The path to the ARG annotation result which needs to be normalized.
    inputBinding:
      position: 102
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
