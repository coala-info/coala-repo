cwlVersion: v1.2
class: CommandLineTool
baseCommand: scale_metagenome.py
label: picrust_scale_metagenome.py
doc: "Scale a BIOM table of trait counts by the sequencing depth of each sample.\n\nTool homepage: https://github.com/picrust/picrust"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_seq_depth_file
    type: File
    doc: 'tab-delimited table with samples as the first column and an integer sequencing depth as the second'
    inputBinding:
      position: 101
      prefix: --input_seq_depth_file
  - id: input_count_table
    type: File
    doc: 'the input trait counts on per otu basis in biom format (can be gzipped)'
    inputBinding:
      position: 101
      prefix: --input_count_table
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print information during execution'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_metagenome_table_path
    type: string
    doc: 'the output file for the scaled metagenome'
    inputBinding:
      position: 102
      prefix: --output_metagenome_table
outputs:
  - id: output_metagenome_table
    type: File
    doc: 'the scaled metagenome'
    outputBinding:
      glob: $(inputs.output_metagenome_table_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
