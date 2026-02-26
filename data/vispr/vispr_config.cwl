cwlVersion: v1.2
class: CommandLineTool
baseCommand: vispr_config
label: vispr_config
doc: "Example VISPR config. Save this config to a file and edit according to your
  needs.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: set the assembly
    inputBinding:
      position: 101
  - id: experiment
    type:
      - 'null'
      - string
    doc: Provide a reasonable name for your experiment
    inputBinding:
      position: 101
  - id: fastqc_sample1_data
    type:
      - 'null'
      - type: array
        items: File
    doc: fastqc output for sample1
    inputBinding:
      position: 101
  - id: fastqc_sample2_data
    type:
      - 'null'
      - type: array
        items: File
    doc: fastqc output for sample2
    inputBinding:
      position: 101
  - id: sgrnas_annotation
    type:
      - 'null'
      - File
    doc: position and score (e.g. efficiency score) for each sgRNA
    inputBinding:
      position: 101
  - id: sgrnas_counts
    type:
      - 'null'
      - File
    doc: normalized read counts (can be obtained from mageck count)
    inputBinding:
      position: 101
  - id: sgrnas_mapstats
    type:
      - 'null'
      - File
    doc: mapping statistics (can be obtained from mageck count)
    inputBinding:
      position: 101
  - id: species
    type:
      - 'null'
      - string
    doc: set the species (any identifier accepted by ensembl.org)
    inputBinding:
      position: 101
  - id: targets_controls
    type:
      - 'null'
      - File
    doc: list of targets to hide per default
    inputBinding:
      position: 101
  - id: targets_genes
    type:
      - 'null'
      - boolean
    doc: specify if targets are genes (enabling various link-outs)
    inputBinding:
      position: 101
  - id: targets_results
    type:
      - 'null'
      - File
    doc: per gene results (can be obtained from "mageck test" or "mageck mle")
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr_config.out
