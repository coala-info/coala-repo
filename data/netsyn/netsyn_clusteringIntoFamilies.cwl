cwlVersion: v1.2
class: CommandLineTool
baseCommand: [netsyn_clusteringIntoFamilies]
label: netsyn_clusteringIntoFamilies
doc: "Group the proteins into families with MMseqs2.\n\nTool homepage: https://github.com/labgem/netsyn"
inputs:
  - id: fasta_file
    type: File
    doc: Fasta file with all protein sequences from ParseINSDCFiles_GetTaxonomy.
    inputBinding:
      position: 1
      prefix: --FastaFile
  - id: input_proteins
    type: File
    doc: JSON protein table from ParseINSDCFiles_GetTaxonomy.
    inputBinding:
      position: 2
      prefix: --inputProteins
  - id: output_name
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 3
      prefix: --outputName
  - id: identity
    type:
      - 'null'
      - double
    doc: Sequence identity (default 0.3).
    inputBinding:
      position: 4
      prefix: --Identity
  - id: coverage
    type:
      - 'null'
      - double
    doc: Minimal coverage (default 0.8).
    inputBinding:
      position: 5
      prefix: --Coverage
  - id: mmseqs_advanced_settings
    type:
      - 'null'
      - File
    doc: YAML file with advanced MMseqs2 settings.
    inputBinding:
      position: 6
      prefix: --MMseqsAdvancedSettings
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols: [ERROR, error, WARNING, warning, INFO, info, DEBUG, debug]
        name: clusteringIntoFamilies_log_level
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
    doc: Protein families JSON table and report.
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
