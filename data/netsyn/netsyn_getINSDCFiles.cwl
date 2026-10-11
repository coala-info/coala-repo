cwlVersion: v1.2
class: CommandLineTool
baseCommand: [netsyn_getINSDCFiles]
label: netsyn_getINSDCFiles
doc: "Download the INSDC files and build the correspondences file for a list of UniProt accessions.\n\nTool homepage: https://github.com/labgem/netsyn"
inputs:
  - id: uniprot_ac_list
    type: File
    doc: Protein accession list (one column labelled UniProt_AC).
    inputBinding:
      position: 1
      prefix: --UniProtACList
  - id: output_name
    type: string
    doc: Name of the correspondences file.
    inputBinding:
      position: 2
      prefix: --OutputName
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols: [ERROR, error, WARNING, warning, INFO, info, DEBUG, debug]
        name: getINSDCFiles_log_level
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
    doc: The correspondences file and downloaded INSDC files.
    outputBinding:
      glob: $(inputs.output_name)*
  - id: downloaded_insdc
    type:
      - 'null'
      - Directory
    doc: Folder GetINSDCFiles with the downloaded INSDC files.
    outputBinding:
      glob: GetINSDCFiles
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
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
