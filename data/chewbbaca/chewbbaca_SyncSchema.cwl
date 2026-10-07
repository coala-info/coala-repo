cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - SyncSchema
label: chewbbaca_SyncSchema
doc: "Synchronize a schema with its remote version in Chewie-NS.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: schema_directory
    type: Directory
    doc: "Path to the directory with the schema to be synced. Staged writable because the process updates it in place."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: nomenclature_server
    type:
      - 'null'
      - string
    doc: "The base URL for the Chewie-NS instance. Default: the base URL from the schema's URI."
    inputBinding:
      position: 1
      prefix: --nomenclature-server
  - id: blast_path
    type:
      - 'null'
      - Directory
    doc: "Path to the directory that contains the BLAST executables."
    inputBinding:
      position: 1
      prefix: --blast-path
  - id: submit
    type:
      - 'null'
      - boolean
    doc: "If the process should identify new alleles in the local schema and send them to the Chewie-NS instance (only authorized users can submit new alleles)."
    inputBinding:
      position: 1
      prefix: --submit
outputs:
  - id: synced_schema
    type: Directory
    doc: "The synchronized schema directory."
    outputBinding:
      glob: $(inputs.schema_directory.basename)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.schema_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
