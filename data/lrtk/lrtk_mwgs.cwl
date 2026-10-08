cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - MWGS
label: lrtk_mwgs
doc: "Run the metagenome linked-read sequencing analysis pipeline (alignment, assembly, variant detection, phasing and report).\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sample_info
    type: File
    doc: 'The path to input sample information file. (sample_info Format: ID FQ1 FQ2 INDEX Linked_read_technology)'
    inputBinding:
      position: 1
      prefix: -SI
  - id: multi_info
    type:
      - 'null'
      - File
    doc: The path to multi sample information file.
    inputBinding:
      position: 1
      prefix: -MI
  - id: outdir
    type: string
    doc: The output directory
    inputBinding:
      position: 1
      prefix: -OD
  - id: database
    type: Directory
    doc: The default database containing reference genome and barcode whitelist file
    inputBinding:
      position: 1
      prefix: -DB
  - id: read_group
    type:
      - 'null'
      - string
    doc: 'Full read group string (e.g. @RG ID:foo SM:bar).'
    inputBinding:
      position: 1
      prefix: -RG
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, this determines the number of threads used for alignment and variant detection and phasing.
    inputBinding:
      position: 1
      prefix: -T
outputs:
  - id: output_directory
    type: Directory
    doc: Pipeline output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
