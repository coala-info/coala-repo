cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fusion_report
  - run
label: fusion-report_run
doc: "Run application: merge the outputs of several fusion detection tools, annotate them with fusion databases and write an HTML report.\n\nTool homepage: https://github.com/matq007/fusion-report"
inputs:
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output directory
    inputBinding:
      position: 2
  - id: db_path
    type: Directory
    doc: Path to folder where all databases are stored.
    inputBinding:
      position: 3
  - id: ericscript
    type:
      - 'null'
      - File
    doc: EricScript output file
    inputBinding:
      position: 101
      prefix: --ericscript
  - id: ericscript_weight
    type:
      - 'null'
      - float
    doc: 'EricScript weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --ericscript_weight
  - id: fusioncatcher
    type:
      - 'null'
      - File
    doc: Fusioncatcher output file
    inputBinding:
      position: 101
      prefix: --fusioncatcher
  - id: fusioncatcher_weight
    type:
      - 'null'
      - float
    doc: 'Fusioncatcher weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --fusioncatcher_weight
  - id: starfusion
    type:
      - 'null'
      - File
    doc: STAR-Fusion output file
    inputBinding:
      position: 101
      prefix: --starfusion
  - id: starfusion_weight
    type:
      - 'null'
      - float
    doc: 'STAR-Fusion weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --starfusion_weight
  - id: pizzly
    type:
      - 'null'
      - File
    doc: Pizzly output file
    inputBinding:
      position: 101
      prefix: --pizzly
  - id: pizzly_weight
    type:
      - 'null'
      - float
    doc: 'Pizzly weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --pizzly_weight
  - id: squid
    type:
      - 'null'
      - File
    doc: Squid output file
    inputBinding:
      position: 101
      prefix: --squid
  - id: squid_weight
    type:
      - 'null'
      - float
    doc: 'Squid weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --squid_weight
  - id: dragen
    type:
      - 'null'
      - File
    doc: Illumina Dragen Bio-IT Platform output file
    inputBinding:
      position: 101
      prefix: --dragen
  - id: dragen_weight
    type:
      - 'null'
      - float
    doc: 'Illumina Dragen Bio-IT Platform weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --dragen_weight
  - id: arriba
    type:
      - 'null'
      - File
    doc: Arriba output file
    inputBinding:
      position: 101
      prefix: --arriba
  - id: arriba_weight
    type:
      - 'null'
      - float
    doc: 'Arriba weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --arriba_weight
  - id: jaffa
    type:
      - 'null'
      - File
    doc: Jaffa output file
    inputBinding:
      position: 101
      prefix: --jaffa
  - id: jaffa_weight
    type:
      - 'null'
      - float
    doc: 'Jaffa weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --jaffa_weight
  - id: ctat_lr_fusion
    type:
      - 'null'
      - File
    doc: CTAT-LR-Fusion output file
    inputBinding:
      position: 101
      prefix: --ctat_lr_fusion
  - id: ctat_lr_fusion_weight
    type:
      - 'null'
      - float
    doc: 'CTAT-LR-Fusion weight (default is 100 divided by the number of supported tools)'
    inputBinding:
      position: 101
      prefix: --ctat_lr_fusion_weight
  - id: allow_multiple_gene_symbols
    type:
      - 'null'
      - boolean
    doc: "Case when fusion gene symbol can't be determined and multiple fusion options are provided. By default provide the fist proposed fusion."
    inputBinding:
      position: 101
      prefix: --allow-multiple-gene-symbols
  - id: config
    type:
      - 'null'
      - File
    doc: Input config file
    inputBinding:
      position: 101
      prefix: --config
  - id: tool_cutoff
    type:
      - 'null'
      - int
    doc: Number of tools required to detect a fusion
    inputBinding:
      position: 101
      prefix: --tool-cutoff
  - id: export
    type:
      - 'null'
      - string
    doc: "Export fusions in different formats. Currently supported: json, csv."
    inputBinding:
      position: 101
      prefix: --export
  - id: no_cosmic
    type:
      - 'null'
      - boolean
    doc: Do not download cosmic fusion database
    inputBinding:
      position: 101
      prefix: --no-cosmic
  - id: no_fusiongdb2
    type:
      - 'null'
      - boolean
    doc: Do not download fusiongdb2 fusion database
    inputBinding:
      position: 101
      prefix: --no-fusiongdb2
  - id: no_mitelman
    type:
      - 'null'
      - boolean
    doc: Do not download mitelman fusion database
    inputBinding:
      position: 101
      prefix: --no-mitelman
outputs:
  - id: output_dir
    type: Directory
    doc: "Report directory (index.html, fusions.tsv and per-fusion pages)"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
