cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mashpit
  - update
label: mashpit_update
doc: "Update a mashpit database. A taxon database is updated to the latest Pathogen
  Detection version; an accession database gets new metadata columns from a csv
  file. Needs network access to NCBI for taxon databases.\n\nTool homepage: https://github.com/tongzhouxu/mashpit"
inputs:
  - id: database
    type: Directory
    doc: path for the database folder (staged writable and returned updated)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: name
    type: string
    doc: database name
    inputBinding:
      position: 2
  - id: metadata
    type:
      - 'null'
      - File
    doc: metadata file in csv format (needs a biosample_acc column)
    inputBinding:
      position: 101
      prefix: --metadata
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable logs
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: updated_database
    type: Directory
    doc: The updated database folder
    outputBinding:
      glob: $(inputs.database.basename)
  - id: log
    type:
      - 'null'
      - type: array
        items: File
    doc: Log file written by mashpit
    outputBinding:
      glob: mashpit-*.log
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: SSL_CERT_FILE
        envValue: /usr/local/ssl/cacert.pem
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
