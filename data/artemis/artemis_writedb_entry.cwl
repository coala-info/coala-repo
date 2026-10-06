cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - writedb_entry
label: artemis_writedb_entry
doc: "Read entries from a Chado database and write them out as EMBL or GFF files.\n\
  \nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs:
  - id: flatten
    type:
      - 'null'
      - string
    doc: flatten the gene model, default is y [y|n]
    inputBinding:
      position: 1
      prefix: -f
  - id: ignore_qualifiers
    type:
      - 'null'
      - string[]
    doc: space separated list of qualifiers to ignore (GFF only)
    inputBinding:
      position: 1
      prefix: -flt
  - id: ignore_obsolete
    type:
      - 'null'
      - string
    doc: ignore obsolete features, default is y [y|n]
    inputBinding:
      position: 1
      prefix: -i
  - id: sequences
    type:
      - 'null'
      - string[]
    doc: space separated list of sequences to read and write out
    inputBinding:
      position: 1
      prefix: -s
  - id: output_format
    type:
      - 'null'
      - string
    doc: '[EMBL|GFF] output format, default is EMBL'
    inputBinding:
      position: 1
      prefix: -o
  - id: mapping_files_location
    type:
      - 'null'
      - Directory
    doc: location of EMBL mapping files (qualifier_mapping and key_mapping)
    inputBinding:
      position: 1
      prefix: -l
  - id: gzip_output
    type:
      - 'null'
      - string
    doc: gzip output, default is y [y|n]
    inputBinding:
      position: 1
      prefix: -z
  - id: non_submission_format
    type:
      - 'null'
      - string
    doc: for EMBL submission format change to n, default is y [y|n]
    inputBinding:
      position: 1
      prefix: -a
  - id: polypeptide_domains
    type:
      - 'null'
      - string
    doc: read polypeptide domain features, default is n [y|n]
    inputBinding:
      position: 1
      prefix: -pp
  - id: remove_pseudogene_product
    type:
      - 'null'
      - string
    doc: remove product qualifiers from pseudogene (only for EMBL submission format),
      default is n [y|n]
    inputBinding:
      position: 1
      prefix: -r
  - id: chado_url
    type:
      - 'null'
      - string
    doc: the URL for your Chado database e.g. server_name:port/database_name?user
      (if not using default)
    inputBinding:
      position: 1
      prefix: -c
  - id: ui_mode
    type:
      - 'null'
      - string
    doc: '[swing|console|script] the UI mode; script mode makes all choices default
      to continue with all parameters passed on the command line'
    inputBinding:
      position: 1
      prefix: -u
    default: script
  - id: password
    type:
      - 'null'
      - string
    doc: the password for connecting to the Chado database
    inputBinding:
      position: 1
      prefix: -p
  - id: file_path
    type:
      - 'null'
      - string
    doc: the file path (the folder you want to save the files in)
    inputBinding:
      position: 1
      prefix: -fp
  - id: no_private_qualifiers
    type:
      - 'null'
      - string
    doc: do not write out private qualifiers, default is y [y|n]
    inputBinding:
      position: 1
      prefix: -np
outputs:
  - id: entries
    type: File[]
    doc: EMBL or GFF files written to the working directory.
    outputBinding:
      glob:
        - '*.embl'
        - '*.embl.gz'
        - '*.gff'
        - '*.gff.gz'
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: The folder given with -fp, holding the written files.
    outputBinding:
      glob: $(inputs.file_path)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
