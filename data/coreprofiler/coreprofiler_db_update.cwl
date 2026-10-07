cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coreprofiler
  - db
  - update
label: coreprofiler_db_update
doc: "Locally update a scheme.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: scheme
    type: string
    doc: Scheme name to consider.
    inputBinding:
      position: 101
      prefix: --scheme
  - id: consumer_key
    type:
      - 'null'
      - string
    doc: Consumer key for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --consumer_key
  - id: consumer_secret
    type:
      - 'null'
      - string
    doc: Consumer secret for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --consumer_secret
  - id: access_token
    type:
      - 'null'
      - string
    doc: Access token for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --access_token
  - id: access_secret
    type:
      - 'null'
      - string
    doc: Access token secret for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --access_secret
  - id: local_scheme_path
    type: Directory
    doc: Local path to scheme directory (staged writable; updated in place).
    inputBinding:
      position: 101
      prefix: --local_scheme_path
      valueFrom: $(self.basename)
  - id: update_log_path
    type: string
    doc: Path of the directory to write output logs.
    inputBinding:
      position: 101
      prefix: --update_log_path
outputs:
  - id: updated_scheme
    type: Directory
    doc: The updated local scheme directory.
    outputBinding:
      glob: $(inputs.local_scheme_path.basename)
  - id: update_logs
    type: Directory
    doc: Directory with the update logs.
    outputBinding:
      glob: $(inputs.update_log_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.local_scheme_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
