cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck-vispr annotate-library
label: mageck-vispr_annotate-library
doc: "MAGeCK-VISPR is a comprehensive quality control, analysis and visualization
  pipeline for CRISPR/Cas9 screens.\n\nTool homepage: https://bitbucket.org/liulab/mageck-vispr"
inputs:
  - id: library
    type: File
    doc: Path to sgRNA library design file (comma separated, columns identifier,
      sequence, gene).
    inputBinding:
      position: 1
  - id: annotation_table
    type:
      - 'null'
      - File
    doc: As an alternative to specifying the sgrna length and assembly, a path 
      to an annotation table can be provided (tab separated, no header; with 
      columns chromosome, start, end, gene, score, strand, sequence). This can 
      also be a URL. See https://bitbucket.org/liulab/mageck-vispr/downloads for
      precomputed tables.
    inputBinding:
      position: 102
      prefix: --annotation-table
  - id: annotation_table_folder
    type:
      - 'null'
      - Directory
    doc: After specifying the sgrna length and assembly, instead of downloading 
      directly from bitbucket, search in the folder for corresponding annotation
      table.
    inputBinding:
      position: 102
      prefix: --annotation-table-folder
  - id: assembly
    type:
      - 'null'
      - string
    doc: Assembly to use.
    inputBinding:
      position: 102
      prefix: --assembly
  - id: bedvalue
    type:
      - 'null'
      - File
    doc: Instead of providing an efficiency value in the output bed file, use 
      the values provided in a given txt file.The txt file must be tab 
      separated, with header.The first column must be sgRNA ID that matches the 
      identifier in sgRNA library design file.
    inputBinding:
      position: 102
      prefix: --bedvalue
  - id: bedvalue_column
    type:
      - 'null'
      - string
    doc: Provide a column name in the file in --bedvalue option as the column to
      fill in. For example, the 'LFC' column in sgrna_summary.txt in MAGeCK RRA 
      represents the log fold change value.
    inputBinding:
      position: 102
      prefix: --bedvalue-column
  - id: sgrna_len
    type:
      - 'null'
      - string
    doc: Length of sgrnas in library file.
    default: AUTO
    inputBinding:
      position: 102
      prefix: --sgrna-len
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
stdout: mageck-vispr_annotate-library.out
