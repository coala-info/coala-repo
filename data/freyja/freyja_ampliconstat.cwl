cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - ampliconstat
label: freyja_ampliconstat
doc: "Provides a summary of amplicon dropouts based on the provided primer file.\n\
  \nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: primer
    type: File
    doc: 'Primer bed file used for amplicon sequencing. Primer name format example:
      SARS-CoV-2_1_RIGHT. Primer sequence must be included in the bed file.'
    inputBinding:
      position: 1
      prefix: --primer
  - id: input_depth
    type: File
    doc: Depths file of reads aligned to the reference
    inputBinding:
      position: 2
      prefix: --input_depth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum coverage depth to define amplicon dropout
    inputBinding:
      position: 3
      prefix: --min_depth
  - id: output_plot
    type:
      - 'null'
      - string
    doc: 'Output name for the amplicon dropout plots [default: amplicon_dropout_plot.png]'
    inputBinding:
      position: 4
      prefix: --output_plot
  - id: output_csv
    type:
      - 'null'
      - string
    doc: 'Output name for the amplicon dropout CSV file [default: amplicon_dropout.csv]'
    inputBinding:
      position: 5
      prefix: --output_csv
outputs:
  - id: plot
    type: File
    doc: Amplicon dropout plot
    outputBinding:
      glob: '${ return inputs.output_plot ? inputs.output_plot : ''amplicon_dropout_plot.png'';
        }'
  - id: csv
    type: File
    doc: Amplicon dropout table
    outputBinding:
      glob: '${ return inputs.output_csv ? inputs.output_csv : ''amplicon_dropout.csv'';
        }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
