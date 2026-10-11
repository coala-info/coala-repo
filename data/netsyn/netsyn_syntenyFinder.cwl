cwlVersion: v1.2
class: CommandLineTool
baseCommand: [netsyn_syntenyFinder]
label: netsyn_syntenyFinder
doc: "Find conserved syntenies between the genomic contexts of the target proteins.\n\nTool homepage: https://github.com/labgem/netsyn"
inputs:
  - id: input_proteins
    type: File
    doc: Protein table from ClusteringIntoFamilies.
    inputBinding:
      position: 1
      prefix: --inputProteins
  - id: input_targets
    type: File
    doc: Target table from ParseINSDCFiles_GetTaxonomy.
    inputBinding:
      position: 2
      prefix: --inputTargets
  - id: output_name
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 3
      prefix: --outputName
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size of the genomic contexts (3, 5, 7, 9 or 11; default 11).
    inputBinding:
      position: 4
      prefix: --WindowSize
  - id: synteny_gap
    type:
      - 'null'
      - int
    doc: Genes allowed between two genes in synteny (default 3).
    inputBinding:
      position: 5
      prefix: --SyntenyGap
  - id: synteny_score_cutoff
    type:
      - 'null'
      - double
    doc: Minimum synteny score to be conserved (default 3.0).
    inputBinding:
      position: 6
      prefix: --SyntenyScoreCutoff
  - id: clustering_advanced_settings
    type:
      - 'null'
      - File
    doc: YAML file with advanced clustering settings.
    inputBinding:
      position: 7
      prefix: --ClusteringAdvancedSettings
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols: [ERROR, error, WARNING, warning, INFO, info, DEBUG, debug]
        name: syntenyFinder_log_level
    doc: Log level.
    inputBinding:
      position: 90
      prefix: --logLevel
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file (stderr by default).
    inputBinding:
      position: 91
      prefix: --logFile
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Synteny nodes, edges and report files.
    outputBinding:
      glob: $(inputs.output_name)*
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file, when log_file is given.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : null; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
