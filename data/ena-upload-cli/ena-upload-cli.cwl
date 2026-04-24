cwlVersion: v1.2
class: CommandLineTool
baseCommand: ena-upoad-cli
label: ena-upload-cli
doc: "The program makes submission of data and respective metadata to European Nucleotide
  Archive (ENA) easy. The metadata can be provided in a xlsx spreadsheet or tsv tables.\n\
  \nTool homepage: https://github.com/usegalaxy-eu/ena-upload-cli"
inputs:
  - id: action
    type: string
    doc: "add: add an object to the archive\n                         modify: modify
      an object in the archive\n                         cancel: cancel a private
      object and its dependent objects\n                         release: release
      a private object immediately to public"
    inputBinding:
      position: 101
      prefix: --action
  - id: auto_action
    type:
      - 'null'
      - boolean
    doc: "BETA: detect automatically which action (add or\n                      \
      \  modify) to apply when the action column is not given"
    inputBinding:
      position: 101
      prefix: --auto_action
  - id: center_name
    type: string
    doc: specific to your Webin account
    inputBinding:
      position: 101
      prefix: --center
  - id: checklist
    type:
      - 'null'
      - string
    doc: "specify the sample checklist with following pattern:\n                 \
      \       ERC0000XX, Default: ERC000011"
    inputBinding:
      position: 101
      prefix: --checklist
  - id: data
    type:
      - 'null'
      - type: array
        items: File
    doc: data for submission, this can be a list of files
    inputBinding:
      position: 101
      prefix: --data
  - id: dev
    type:
      - 'null'
      - boolean
    doc: flag to use the dev/sandbox endpoint of ENA
    inputBinding:
      position: 101
      prefix: --dev
  - id: draft
    type:
      - 'null'
      - boolean
    doc: indicate if no submission should be performed
    inputBinding:
      position: 101
      prefix: --draft
  - id: experiment
    type:
      - 'null'
      - string
    doc: table of EXPERIMENT object
    inputBinding:
      position: 101
      prefix: --experiment
  - id: isa_assay_stream
    type:
      - 'null'
      - type: array
        items: string
    doc: "BETA: specify the assay stream(s) that holds the ENA\n                 \
      \       information, this can be a list of assay streams"
    inputBinding:
      position: 101
      prefix: --isa_assay_stream
  - id: isa_json
    type:
      - 'null'
      - string
    doc: 'BETA: ISA json describing describing the ENA objects'
    inputBinding:
      position: 101
      prefix: --isa_json
  - id: no_data_upload
    type:
      - 'null'
      - boolean
    doc: "indicate if no upload should be performed and you like\n               \
      \         to submit a RUN object (e.g. if uploaded was done\n              \
      \          separately)."
    inputBinding:
      position: 101
      prefix: --no_data_upload
  - id: run
    type:
      - 'null'
      - string
    doc: table of RUN object
    inputBinding:
      position: 101
      prefix: --run
  - id: sample
    type:
      - 'null'
      - string
    doc: table of SAMPLE object
    inputBinding:
      position: 101
      prefix: --sample
  - id: secret
    type: File
    doc: ".secret.yml file containing the password and Webin ID\n                \
      \        of your ENA account"
    inputBinding:
      position: 101
      prefix: --secret
  - id: study
    type:
      - 'null'
      - string
    doc: table of STUDY object
    inputBinding:
      position: 101
      prefix: --study
  - id: tool_name
    type:
      - 'null'
      - string
    doc: "specify the name of the tool this submission is done\n                 \
      \       with. Default: ena-upload-cli"
    inputBinding:
      position: 101
      prefix: --tool
  - id: tool_version
    type:
      - 'null'
      - string
    doc: "specify the version of the tool this submission is\n                   \
      \     done with"
    inputBinding:
      position: 101
      prefix: --tool_version
  - id: xlsx
    type:
      - 'null'
      - File
    doc: filled in excel template with metadata
    inputBinding:
      position: 101
      prefix: --xlsx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ena-upload-cli:0.9.0--pyhdfd78af_0
stdout: ena-upload-cli.out
