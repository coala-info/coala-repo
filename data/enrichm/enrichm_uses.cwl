cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - uses
label: enrichm_uses
doc: "Count or tally the genomes in which compounds are used, from an annotation matrix.\n\nTool homepage: https://github.com/geronimp/enrichM"
inputs:
  - id: log
    type:
      - 'null'
      - string
    doc: "Output logging information to this file."
    inputBinding:
      position: 1
      prefix: --log
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of verbosity (1 - 5 - default = 4) 5 = Very verbose, 1 = Silent"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: output
    type:
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite previous run"
    inputBinding:
      position: 1
      prefix: --force
  - id: annotation_matrix
    type: File
    doc: "Input annotate output"
    inputBinding:
      position: 1
      prefix: --annotation_matrix
  - id: metadata
    type: File
    doc: "Metadata file with two columns, the first with the genome name, the second with the groupings to compare."
    inputBinding:
      position: 1
      prefix: --metadata
  - id: compounds_list
    type: File
    doc: "Metadata file with two columns, the first with the genome name, the second with the groupings to compare."
    inputBinding:
      position: 1
      prefix: --compounds_list
  - id: count
    type: boolean
    doc: "Count rather than tally."
    inputBinding:
      position: 1
      prefix: --count
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written by the tool (named after the subcommand)
    outputBinding:
      glob: uses.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
