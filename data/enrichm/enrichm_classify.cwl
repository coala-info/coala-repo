cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - classify
label: enrichm_classify
doc: "Determine what pathways (KEGG modules) a genome encodes, from an annotation matrix.\n\nTool homepage: https://github.com/geronimp/enrichM"
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
  - id: genome_and_annotation_matrix
    type:
      - 'null'
      - File
    doc: "Path to file containing a genome annotation matrix"
    inputBinding:
      position: 1
      prefix: --genome_and_annotation_matrix
  - id: custom_modules
    type:
      - 'null'
      - File
    doc: "Tab separated file containing module name, definition as the columns"
    inputBinding:
      position: 1
      prefix: --custom_modules
  - id: module_rules_json
    type:
      - 'null'
      - File
    doc: "json file specifying rules to interpret the annotation and guide module annotation"
    inputBinding:
      position: 1
      prefix: --module_rules_json
  - id: gff_files
    type:
      - 'null'
      - File
    doc: "GFF files for the genomes being classified."
    inputBinding:
      position: 1
      prefix: --gff_files
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "Output only modules with greater than this percent of the requied KO groups (default = print all modules)"
    inputBinding:
      position: 1
      prefix: --cutoff
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: "Calculate the abundance of each pathway within each genome/sample (column)"
    inputBinding:
      position: 1
      prefix: --aggregate
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
      glob: classify.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
