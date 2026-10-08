cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genomad
  - score-calibration
label: genomad_score-calibration
doc: "Performs score calibration of the sequences in the INPUT file (FASTA format) using the batch correction method and write the results to the OUTPUT directory. This module requires that at least one of the classification modules was executed previously (marker-classification, nn-classification, aggregated-classification).\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: input
    type: File
    doc: "Input FASTA file."
    inputBinding:
      position: 1
  - id: previous_dir
    type: Directory
    doc: "Output directory of previous geNomad runs on the same INPUT (at least one classification module). It is copied to the OUTPUT directory (named by 'output') before this module runs, because this module reads the earlier results from there."
  - id: output
    type: string
    doc: "Output directory."
    inputBinding:
      position: 2
  - id: composition
    type:
      - 'null'
      - type: enum
        name: composition_symbols
        symbols:
          - auto
          - metagenome
          - virome
    doc: "Method for estimating sample composition. Allowed values: auto, metagenome, virome."
    inputBinding:
      position: 103
      prefix: --composition
  - id: force_auto
    type:
      - 'null'
      - boolean
    doc: "Force automatic composition estimation regardless of the sample size."
    inputBinding:
      position: 103
      prefix: --force-auto
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_output
    type: Directory
    doc: "Output directory."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.previous_dir)
        entryname: $(inputs.output)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
